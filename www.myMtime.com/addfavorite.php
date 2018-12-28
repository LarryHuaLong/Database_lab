<?php 
session_start();
$uid = $_SESSION['userinfo']['id'];
require_once("database.php");

$action = $_REQUEST['action'];

if ($action == 'addfavoritemovie') {
    $fid = $_REQUEST['fid'];
    $sql = "INSERT INTO favoritemovie (U_ID, F_ID) VALUES($uid, $fid)";
    $result = $conn->query($sql);
    echo "已收藏";
} else if ($action == 'removefavoritemovie') {
    $fid = $_REQUEST['fid'];
    $sql = "DELETE FROM favoritemovie WHERE U_ID = $uid AND F_ID = $fid; ";
    $result = $conn->query($sql);
    if ($result)
        echo "收藏";
} else if ($action == 'addfavoritepeople') {
    $pid = $_REQUEST['pid'];
    $sql = "INSERT INTO favoritepeople (U_ID, P_ID) VALUES($uid, $pid)";
    $result = $conn->query($sql);
    echo "已关注";
} else if ($action == 'removefavoritepeople') {
    $pid = $_REQUEST['pid'];
    $sql = "DELETE FROM favoritepeople WHERE U_ID = $uid AND P_ID = $pid; ";
    $result = $conn->query($sql);
    echo "关注";
}

?>