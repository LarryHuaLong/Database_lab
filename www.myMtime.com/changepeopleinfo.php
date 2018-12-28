<?php
session_start();
if (empty($_SESSION['admininfo']))
    die('alert("你没有修改权限");');
$adminname = $_SESSION['admininfo']['name'];
// 连接数据库
$conn = new mysqli("localhost", $adminname, "admin", "mymtime");
// Check connection
if ($conn->connect_error) {
    die("数据库连接失败: " . $conn->connect_error);
}
$conn->set_charset("utf8");

$p_id = $_POST['p_id'];
$gender = $_POST['gender'];
$birthday = $_POST['birthday'];
$height = $_POST['height'];
$weight = $_POST['weight'];
$position = $_POST['position'];

$sql = "UPDATE people SET P_gender = '$gender',P_birthday='$birthday',P_height=$height,P_weight=$weight,P_position='$position' WHERE P_ID = $p_id ";
$result = $conn->query($sql);
if ($result)
    echo 'alert("修改成功");';
else
    echo 'alert("修改失败");';

?>