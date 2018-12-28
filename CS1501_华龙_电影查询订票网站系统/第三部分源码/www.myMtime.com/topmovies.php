<script>
$("#hotMovieRegion").ready(function () {
        $("#hotMovieRegion li").on("mouseover", function () {
            $(this).addClass("on");
        });
});
$("#hotMovieRegion").ready(function () {
    $("#hotMovieRegion li").on("mouseout", function () {
        $(this).removeClass("on");
    });
});
</script>
<?php
require_once("database.php");
$sql = "SELECT * FROM topfilms";
$result = $conn->query($sql);
$count = 0;
while ($row = $result->fetch_assoc()) : ?>
<?php $str_grade = strval($row['F_grade']);?>
<li class="" >
    <em class="num<?php echo $count = $count+1;?>"></em>
    <div class="clearfix none">
        <strong><?php echo $str_grade[0].'.'.$str_grade[1] ?></strong>
        <a href="http://www.mymtime.com/movieinfo.php?f_id=<?php echo $row['F_ID'] ?>"><?php echo $row['F_name_zh'] ?></a>
    </div>
    <div class="table">
        <div class="t_r">
            <div class="td">
                <a title="<?php echo $row['F_name_zh'] . "/" . $row['F_name_en'] ?>" target="_blank" href="http://www.mymtime.com/movieinfo.php?f_id=<?php echo $row['F_ID'] ?>">
                    <img class="img_box" alt="<?php echo $row['F_name_zh'] . "/" . $row['F_name_en'] ?>" src="<?php echo $row['F_img_url'] ?>"
                        width="75" height="100">
                </a>
            </div>
            <div class="td pl12">
                <h3 class="px14">
                    <a target="_blank" href="http://www.mymtime.com/movieinfo.php?f_id=<?php echo $row['F_ID'] ?>"> <?php echo $row['F_name_zh'] ?>
                        <br><?php echo $row['F_name_en'] ?></a>
                </h3>
                <div class="clearfix mt9">
                    <p class="point">
                        <span class="total"><?php echo $str_grade[0] ?></span>
                        <span class="total2">.<?php echo $str_grade[1] ?></span>
                    </p>
                </div>
            </div>
        </div>
    </div>
</li>
<?php endwhile; ?>