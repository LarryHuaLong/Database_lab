
<?php
session_start();

if (isset($_SESSION['views'])) {
    $_SESSION['views'] = $_SESSION['views'] + 1;
} else {
    $_SESSION['views'] = 1;
}
echo "浏览量：" . $_SESSION['views'];
?>
<button id="logout" type="button" onclick="logout()" class="btn btn-link">退出</button>
<script>
    function logout() { 
        location = "test_logout.php";
     }
</script>