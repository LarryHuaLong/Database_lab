<?php
$dbservername = "localhost";
$dbusername = "mymtime";
$dbpassword = "2333";
$dbname = "mymtime";
 
// 创建连接
$conn = new mysqli($dbservername, $dbusername, $dbpassword, $dbname);
// Check connection
if ($conn->connect_error) {
    die("数据库连接失败: " . $conn->connect_error);
}
?>