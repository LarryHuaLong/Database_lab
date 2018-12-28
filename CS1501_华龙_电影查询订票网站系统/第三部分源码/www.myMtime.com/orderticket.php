<?php
session_start();
require_once("database.php");

$sid = $_POST['sid'];
$uid = $_SESSION['userinfo']['id'];

$sql_result = "SELECT * FROM tickets WHERE U_ID=$uid AND S_ID=$sid;";
$result = $conn->query($sql_result);
if ($result->num_rows > 0)
    die('alert("您已经预定了该场次的票,请勿重复订票");');
$sql_result = "SELECT S_tickets_left FROM `show` WHERE S_ID=$sid;";
$result = $conn->query($sql_result);
$row = $result->fetch_assoc();
if ($row['S_tickets_left'] <= 0)
    die('alert("余票不足");');

$sql = "CALL orderticket($uid,$sid);";
$result = $conn->query($sql);

if ($result) {
    $result = $conn->query($sql_result);

    if ($result->num_rows > 0)
        echo 'alert("订票成功");';
    else
        echo 'alert("订票失败，请刷新重试");';

} else
    echo 'alert("订票失败");';
?>