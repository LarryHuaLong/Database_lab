
<div class=" ">
    <div class="othermovie">
        <ul class="">
<?php
session_start();
require_once("database.php");
$sql = "SELECT * FROM films WHERE films.F_ID IN( SELECT DISTINCT show.F_ID FROM `show` WHERE `show`.S_start_time > NOW())";
$result = $conn->query($sql);
echo '<h4 id=" onShowTotalCount " class=" px14 text-center">共有' . ($result->num_rows) . '步影片正在上映</h4>';
while ($row = $result->fetch_assoc()) : ?>
<li class=" ">
    <a href="http://www.mymtime.com/movieinfo.php?f_id=<?php echo $row['F_ID'] ?>" title="<?php echo $row['F_name_zh'] . "/" . $row['F_name_en'] . $row['F_year'] ?>" target="_blank" class="picbox __r_c_"
        pan="M14_TheaterIndex_Hotplay_Cover">
        <img class="img_box" alt="<?php echo $row['F_name_zh'] . "/" . $row['F_name_en'] ?>" src="<?php echo $row['F_img_url'] ?>" width="96" height="128">
        <span class="score" mid="<?php echo $row['F_ID'] ?>"><?php $str_grade = strval($row['F_grade']);
                                                            echo $str_grade[0] . '.' . $str_grade[1]; ?></span>
    </a>
    <dl>
        <dt>
            <a href="http://www.mymtime.com/movieinfo.php?f_id=<?php echo $row['F_ID'] ?>" class="__r_c_" pan="M14_TheaterIndex_Hotplay_Text" target="_blank"><?php echo $row['F_name_zh'] ?></a>
        </dt>
        <dd class="__r_c_" pan="M14_TheaterIndex_Hotplay_Text">
            <p><?php echo $row['F_runtime'] ?>分钟 - <?php echo $row['F_genre'] ?></p>
        </dd>
    </dl>
</li>
<?php endwhile; ?>     
        </ul>
    </div>
</div>