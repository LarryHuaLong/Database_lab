<?php
session_start();

// 连接数据库
$conn = new mysqli("localhost", "mymtime", "U201514477", "mymtime");
// Check connection
if ($conn->connect_error) {
    die("数据库连接失败: " . $conn->connect_error);
}

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
        echo 'alert("登录成功");auto_login("' . $row['U_name'] . '");';
    } else {
        echo "alert('密码错误')";
    }
} else {
    echo "alert('该邮箱未注册')";
}

//$conn->close();
?>