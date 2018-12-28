<?php
require_once("database.php");
$searchfor = $_REQUEST['searchfor'];
?>
<?php if ($searchfor == "movie") : ?>
<?php 
$genre = $_REQUEST['genre'];
$sql = "SELECT * FROM films WHERE F_genre LIKE '%" . $genre . "%';";
$result = $conn->query($sql);
echo '<h4 id=" TotalCountRegion " class=" px14 text-center">共找到' . ($result->num_rows) . '个结果</h4>';
while ($row = $result->fetch_assoc()) : ?>
<?php $str_grade = strval($row['F_grade']); ?>
<div class="table">
    <div class="td">
        <a title="<?php echo $row['F_name_zh'] . "/" . $row['F_name_en'] ?>" target="_blank" href="http://www.mymtime.com/movieinfo.php?f_id=<?php echo $row['F_ID'] ?>">
            <img class="img_box" alt="<?php $row['F_name_zh'] . "/" . $row['F_name_en'] ?>" src="<?php echo $row['F_img_url'] ?>" width="96" height="128">
        </a>
    </div>
    <div class="td pl12 pr20">
        <div class="clearfix">
            <p class="point ml6">
                <span class="total"><?php echo $str_grade[0] ?></span>
                <span class="total2">.<?php echo $str_grade[1] ?></span>
            </p>
        </div>
        <h3 class="normal mt6">
            <a target="_blank" href="http://www.mymtime.com/movieinfo.php?f_id=<?php echo $row['F_ID'] ?>"><?php echo $row['F_name_zh'] ?></a>
            <span class="c_666">(<?php echo $row['F_year'] ?>)</span>
        </h3>
        <p>
            <a target="_blank" href="http://www.mymtime.com/movieinfo.php?f_id=<?php echo $row['F_ID'] ?>"><?php echo $row['F_name_en'] ?></a>
        </p>
    </div>
</div>
<?php endwhile; ?>

<?php elseif ($searchfor == "people") : ?>
<?php
$letter = $_REQUEST['letter'];
$sql = "SELECT * FROM people WHERE P_name_en LIKE '" . $letter . "%';";
$result = $conn->query($sql);
echo '<h4 id=" TotalCountRegion " class=" px14 ">共找到' . ($result->num_rows) . '个结果</h4>';
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
<?php endif; ?>