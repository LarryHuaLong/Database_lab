<?php

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

if (empty($email)) {
    echo "alert('邮箱不能为空')";
} else if (empty($password)) {
    echo "alert('密码不能为空')";
} else {
    if ($result->num_rows > 0) {
        echo "alert('邮箱已被注册')";
    } else {
        $sql1 = "insert into Users(U_name,U_email,U_password) values('" . $email . "','" . $email . "','" . $password . "')";
        $result = $conn->query($sql1);
        if ($result) {
            echo 'alert("注册成功");auto_login(" ' . $email . ' ");';
        } else {
            echo "alert('注册失败')";
        }
    }
}
$conn->close();
?>