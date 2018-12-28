<?php
// 连接数据库
$conn = new mysqli("localhost", "mymtime", "U201514477", "mymtime");
// Check connection
if ($conn->connect_error) {
    die("数据库连接失败: " . $conn->connect_error);
}
$conn->set_charset("utf8");
?>