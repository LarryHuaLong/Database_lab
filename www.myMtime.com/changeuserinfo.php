<?php
session_start();
$userid = $_SESSION['userinfo']['id'];
$username = $_SESSION['userinfo']['username'];
$email = $_SESSION['userinfo']['email'];

require_once("database.php");
$sql = "SELECT * FROM Users WHERE U_ID='$userid' AND U_email='$email' ";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    if ($_POST['action'] == 'changeusername') {
        $new_name = $_POST['newname'];
        $sql_changename = "UPDATE users SET U_name = '$new_name' WHERE users.U_ID = $userid ";
        $result_n = $conn->query($sql_changename);
        if ($result_n) {
            $_SESSION['userinfo']['username'] = $new_name;
            echo 'alert("修改成功");location.reload();';
        }
    } else if ($_POST['action'] == 'changepassword') {
        $old_pass = $_POST['oldpassword'];
        $new_pass = $_POST['newpassword'];
        if ($row['U_password'] == $old_pass) {
            $sql_changepass = "UPDATE users SET U_password = '$new_pass' WHERE users.U_ID = $userid ";
            $result_p = $conn->query($sql_changepass);
            if($result_p){
                session_unset();
                echo 'alert("成功修改密码");location.reload();';
            }
        } else
            echo "alert('原密码错误')";
    } else
        echo "alert('错误的请求')";
} else {
    echo "alert('该邮箱未注册')";
}
$conn->close();

?>