<?php
session_start();
$userid = $_SESSION['userinfo']['id'];
require_once("database.php");
$sql = "SELECT * FROM favoritemovie,films WHERE favoritemovie.U_ID = ".$userid." AND favoritemovie.F_ID = films.F_ID";
$result = $conn->query($sql);
echo '<h4 id=" TotalCountRegion " class=" px14 text-center">共有' . ($result->num_rows) . '个收藏</h4>';
while ($row = $result->fetch_assoc()) : ?>
<div class="table">
    <div class="td">
        <a title="<?php echo $row['F_name_zh'] . "/" . $row['F_name_en'] ?>" target="_blank" href="http://www.mymtime.com/movieinfo.php?f_id=<?php echo $row['F_ID'] ?>">
            <img class="img_box" alt="<?php $row['F_name_zh'] . "/" . $row['F_name_en'] ?>" src="<?php echo $row['F_img_url'] ?>" width="96" height="128">
        </a>
    </div>
    <div class="td pl12 pr20">
        <div class="clearfix">
            <p class="point ml6">
                <span class="total"><?php $str_grade = strval($row['F_grade']);
                                    echo $str_grade[0] ?></span>
                <span class="total2">.<?php echo $str_grade[0] ?></span>
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
<?php endwhile;?>