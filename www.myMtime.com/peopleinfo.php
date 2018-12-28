
<?php
session_start();
$p_id = $_GET['p_id'];
require_once("database.php");
$sql = "SELECT * FROM people WHERE P_ID=$p_id ";
$result = $conn->query($sql);
if ($result) : ?>
<?php $row = $result->fetch_assoc(); ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><?php echo $row['P_name_zh'] . "/" . $row['P_name_en'] ?></title>
    <meta name="Keywords" content="<?php echo $row['P_name_zh'] ?>,<?php echo $row['P_name_zh'] ?>">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/bootstrap.css">
    <script src="js/jquery.js"></script>
    <script src="js/popper.js"></script>
    <script src="js/bootstrap.js"></script>
    <link href="css/publicpack.css" rel="stylesheet" media="all" type="text/css">
    <link href="css/database.css" rel="stylesheet" media="all" type="text/css">
    
</head>

<body>
    <div class="db_shadow">
        <div class="db_coverinner">
                <a title=" <?php echo $row['P_name_zh'] ?>">
                    <img src=" <?php echo $row['P_img_url'] ?>" alt=" <?php echo $row['P_name_zh'] ?>">
                </a>
        </div>
        <div class="db_ihead">
            <div class="db_head">
                <div class="clearfix">
                    <h1 style="font-size:35px;"> <?php echo $row['P_name_zh'] ?></h1>
                    <p class="db_year" style="font-size:30px;"></p>
                    <p class="db_enname" style="font-size:25px;"><?php echo $row['P_name_en'] ?></p>
                </div>
                <div class="grade_tool" id="ratingRegion">
                    <div class="gradebox  ">
                        <p>关注数：</p>
                        <?php echo $row['P_count'] ?>
                    </div>
                </div>
                <div>
<?php if (!empty($_SESSION['userinfo']) && !empty($_SESSION['userinfo']['id'])) : ?>
                    <button id="addfavorite" type="button" class="btn btn-success">关注</button>
                    <script>
                    $(document).ready(function () {
                        $("#addfavorite").click(function () { 
                            var status = $(this).html();
                            if(status == "关注")
                                $(this).load("addfavorite.php",{action:"addfavoritepeople",pid:<?php echo $row['P_ID'] ?>});
                            else if(status == "已关注")
                                $(this).load("addfavorite.php",{action:"removefavoritepeople",pid:<?php echo $row['P_ID'] ?>});
                        });
                    });
                    </script>
<?php endif; ?>
                </div>
            </div>
        </div>
        <div class="base_r">
            <div class="pt15">
                <dl class="info_l">
                    <dd>
                        <strong>性别：</strong>
                        <p> <?php echo $row['P_gender'] ?></p>
                    </dd>
                    <dd>
                        <strong>生日:</strong>
                        <p> <?php if ($row['P_birthday']) echo $row['P_birthday'];
                            else echo "-" ?></p>
                    </dd>
                    <dd>
                        <strong>身高:</strong>
                        <p> <?php if ($row['P_height']) echo $row['P_height'];
                            else echo "-" ?></p>
                    </dd>
                    <dd>
                        <strong>体重:</strong>
                        <p> <?php if ($row['P_weight']) echo $row['P_weight'];
                            else echo "-" ?></p>
                    </dd>
                    <dd>
                        <strong>位置:</strong>
                        <p> <?php if ($row['P_position']) echo $row['P_position'];
                            else echo "-" ?></p>
                    </dd>
                    
                    <button id="changepeopleinfo" type="button" class="btn btn-info" >修改人物信息</button>
                    <script>
                    $(document).ready(function () {
                        $("#changepeopleinfo").click(function () { 
                            $("#changepeopleinfoform").show();
                        });
                    });
                    </script>
                </dl>
                <div id="changepeopleinfoform" style="display: none;">
                    <dl class="info_l">
                        <dd>
                        <label for="inputgender"> 性别:</label>
                        <input type="text" name="gender" id="inputgender" value="<?php echo $row['P_gender'] ?>">
                        </dd>
                        <dd>
                            <label for="inputbirthday"> 生日:</label>
                            <input type="text" name="birthday" id="inputbirthday" value="<?php if ($row['P_birthday']) echo $row['P_birthday']; ?>">
                        </dd>
                        <dd>
                            <label for="inputheight"> 身高:</label>
                            <input type="number" name="height" id="inputheight" value="<?php if ($row['P_height']) echo $row['P_height']; ?>">
                        </dd>
                        <dd>
                            <label for="inputweight"> 体重:</label>
                            <input type="number" name="weight" id="inputweight" value="<?php if ($row['P_weight']) echo $row['P_weight']; ?>">
                        </dd>
                        <dd>
                            <label for="inputposition"> 位置:</label>
                            <input type="text" name="position" id="inputposition" value="<?php if ($row['P_position']) echo $row['P_position']; ?>">
                        </dd>
                        <button id="submit" type="button" class="btn btn-info">提交修改</button>
                        <script>
                        $(document).ready(function () {
                            $("#submit").click(function () { 
                                var gender = $("#inputgender").val();
                                var birthday = $("#inputbirthday").val();
                                var height = $("#inputheight").val();
                                var weight = $("#inputweight").val();
                                var position = $("#inputposition").val();
                                $.post("changepeopleinfo.php", {
                                    p_id:<?php echo $row['P_ID'] ?>,
                                    gender :gender,
                                    birthday :birthday,
                                    height :height,
                                    weight :weight,
                                    position :position
                                },
                                function (data, status) {
                                    if (status == "success"){
                                        eval(data);
                                        window.location.reload();
                                    }
                                    else
                                        alert("错误：" + status);
                                });
                            });
                        });
                        </script>
                    </dl>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
<?php else : ?>
<?php echo "该人物不在数据库中" ?>
<?php endif; ?>