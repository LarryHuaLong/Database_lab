<?php
session_start();
$userid = $_SESSION['userinfo']['id'];
require_once("database.php");
$sql = "SELECT * FROM favoritepeople,people WHERE favoritepeople.U_ID = ".$userid." AND favoritepeople.P_ID = people.P_ID";
$result = $conn->query($sql);
echo '<h4 id=" TotalCountRegion " class=" px14 text-center">共有' . ($result->num_rows) . '个关注</h4>';
while ($row = $result->fetch_assoc()) : ?>
<div class="table">
    <div class="td">
        <a title="<?php echo $row['P_name_zh'] . "/" . $row['P_name_en'] ?>" target="_blank" href="http://www.mymtime.com/peopleinfo.php?p_id=<?php echo $row['P_ID'] ?>">
            <img class="img_box" alt="<?php echo $row['P_name_zh'] . "/" . $row['P_name_en'] ?>" src="<?php echo $row['P_img_url'] ?>"
                width="96" height="128">
        </a>
    </div>
    <div class="td pl12 pr20">
        <h3 class="normal mt6">
            <a target="_blank" href="http://www.mymtime.com/peopleinfo.php?p_id=<?php echo $row['P_ID'] ?>"><?php echo $row['P_name_zh'] ?></a>
        </h3>
        <p>
            <a target="_blank" href="http://www.mymtime.com/peopleinfo.php?p_id=<?php echo $row['P_ID'] ?>"><?php echo $row['P_name_en'] ?></a>
        </p>
        <p class="mt15 c_666"><?php echo $row['P_gender'] . "，生于" . $row['P_birthday'] . '(' . $row['P_position'] . ')' ?></p>
        
    </div>
</div>
<?php endwhile; ?>