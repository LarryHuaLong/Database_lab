<script>
    $("#hotPeopleRegion").ready(function () {
        $("#hotPeopleRegion li").on("mouseover", function () {
            $(this).addClass("on");
        });
    });
    $("#hotPeopleRegion").ready(function () {
        $("li").on("mouseout", function () {
            $(this).removeClass("on");
        });
    });
</script>
<?php
require_once("database.php");
$sql = "SELECT * FROM toppeople";
$result = $conn->query($sql);
$count = 0;
while ($row = $result->fetch_assoc()) : ?>
    <li class="">
        <em class="num<?php echo $count = $count + 1; ?>"></em>
        <div class="clearfix none">
            <strong><?php echo $row['P_count'] ?></strong>
            <a href="http://www.mymtime.com/peopleinfo.php?p_id=<?php echo $row['P_ID'] ?>"><?php echo $row['P_name_zh'] ?></a>
        </div>
        <div class="table">
            <div class="t_r">
                <div class="td">
                    <a title="<?php echo $row['P_name_zh'] . "/" . $row['P_name_en'] ?>" target="_blank" href="http://www.mymtime.com/peopleinfo.php?p_id=<?php echo $row['P_ID'] ?>">
                        <img class="img_box" alt="<?php echo $row['P_name_zh'] . "/" . $row['P_name_en'] ?>" src="<?php echo $row['P_img_url'] ?>"
                            width="75" height="100">
                    </a>
                </div>
                <div class="td pl12">
                    <h3 class="px14">
                        <a target="_blank" href="http://www.mymtime.com/peopleinfo.php?p_id=<?php echo $row['P_ID'] ?>"><?php echo $row['P_name_zh'] ?>
                            <br> <?php echo $row['P_name_en'] ?></a>
                    </h3>
                    <div class="clearfix mt9">
                        <p class="point">
                            <span class="per_point"><?php echo $row['P_count'] ."  人关注"?></span>
                        </p>
                        
                    </div>
                </div>
            </div>
        </div>
<?php endwhile; ?>