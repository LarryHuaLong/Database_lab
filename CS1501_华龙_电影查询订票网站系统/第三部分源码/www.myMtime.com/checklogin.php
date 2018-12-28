<?php
session_start();
if (!empty($_SESSION['userinfo']) && !empty($_SESSION['userinfo']['id']) && !empty($_SESSION['userinfo']['username'])) {
    echo 'auto_login("' . $_SESSION['userinfo']['username'] . '");';
}
?>