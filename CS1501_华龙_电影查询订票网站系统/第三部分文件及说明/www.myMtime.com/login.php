<?php
session_start();

require_once("database.php");
$email = $_POST['email'];
$password = $_POST['password'];

$sql = "select * from Users where U_email='$email'";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    if ($row['U_password'] == $password) {
        $_SESSION["userinfo"] = [
            'id' => $row['U_ID'],
            'username' => $row['U_name'],
            'email' => $email,
        ];
        if ($row['isAdmin'] == "是") {
            $_SESSION['admininfo'] = [
                'id' => $row['U_ID'],
                'name' => $row['U_name']
            ];
        }
        echo 'auto_login("' . $row['U_name'] . '");';
    } else {
        echo "alert('密码错误')";
    }
} else {
    echo "alert('该邮箱未注册')";
}

$conn->close();
?>