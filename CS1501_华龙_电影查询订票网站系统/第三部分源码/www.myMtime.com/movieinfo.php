
<?php
session_start();
if (!empty($_SESSION['userinfo']) && !empty($_SESSION['userinfo']['id']))
    $checklogin = true;
else
    $checklogin = false;

$f_id = $_GET['f_id'];
require_once("database.php");
$sql = "SELECT * FROM films,people WHERE F_directorID = P_ID AND F_ID=$f_id ";
$result = $conn->query($sql);

$sql_show = "SELECT show.T_ID, T_name, S_ID, S_start_time, S_end_time, S_price, S_tickets_left 
                FROM `show`,theaters
                WHERE show.T_ID=theaters.T_ID AND F_ID=$f_id AND S_start_time > NOW() 
                ORDER BY T_ID ";
$result_show = $conn->query($sql_show);

$show = array();
while ($row_show = $result_show->fetch_assoc()) {
    array_push($show, [
        'tid' => $row_show['T_ID'],
        'tname' => $row_show['T_name'],
        'sid' => $row_show['S_ID'],
        'start' => $row_show['S_start_time'],
        'end' => $row_show['S_end_time'],
        'price' => $row_show['S_price'],
        'tickets' => $row_show['S_tickets_left']
    ]);
}
$sql_actin = "SELECT * FROM actin,people WHERE actin.P_ID = people.P_ID AND actin.F_ID=$f_id ";
$result_actin = $conn->query($sql_actin);
if ($result) : ?>
<?php $row = $result->fetch_assoc();
$str_grade = strval($row['F_grade']); ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><?php echo $row['F_name_zh'] . "/" . $row['F_name_en'] . "(" . $row['F_year'] . ")" ?></title>
    <meta name="Keywords" content="<?php echo $row['F_name_zh'] ?>,<?php echo $row['F_name_zh'] ?>">
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
            <a title=" <?php echo $row['F_name_zh'] ?>(  <?php echo $row['F_year'] ?> )">
                <img src=" <?php echo $row['F_img_url'] ?>" alt=" <?php echo $row['F_name_zh'] ?>(  <?php echo $row['F_year'] ?> )">
            </a>
            <dl>
                <dt>
                    
                </dt>
    <?php if ($checklogin && !empty($show)) : ?>
                <dd>
                    <div class="form-group">
                        <label for="selectShow">选择影院和场次:</label>
                        <select class="custom-select" name="selectShow" id="selectShow">
                            
                        </select>
                    </div>
                </dd>
                
                <dd>
                    <button id="orderticket" class="btn btn-primary">定票</button>
                </dd>
                <script>
                var show = <?php echo json_encode($show) ?>;
                var shows="";
                for (var i = 0; i < show.length; i++) {
                    shows += "<option value=" + show[i]['sid'] + ">" +
                    show[i]['tname'] + "\n" +
                    "  " + show[i]['start'] + "-到-" + show[i]['end'] + 
                    "   票价：" + show[i]['price'] + "元" +
                    "   还剩：" + show[i]['tickets'] + "张票" +
                    "</option>";
                }
                $(document).ready(function () {

                    $("#selectShow").html(shows);
                    $("#orderticket").click(function(){
                        var sid = $("#selectShow").val();
                        $.post("orderticket.php", {
                            sid: sid
                        },
                        function (data, status) {
                            if (status == "success")
                                eval(data);
                            else
                                alert("错误：" + status);
                        });
                    });
                });
                </script>
    <?php endif; ?>
            </dl>
        </div>
        <div class="db_ihead">
            <div class="db_head">
                <div class="clearfix">
                    <h1 style="font-size:35px;"> <?php echo $row['F_name_zh'] ?></h1>
                    <p class="db_year" style="font-size:30px;">( <?php echo $row['F_year'] ?>)</p>
                    <p class="db_enname" style="font-size:25px;"><?php echo $row['F_name_en'] ?></p>
                </div>
                <div class="grade_tool" id="ratingRegion">
                    <div class="gradebox  ">
                        <b><?php echo $str_grade[0] ?>
                            <sup>.<?php echo $str_grade[1] ?></sup>
                        </b>
                        <p>总分：10</p>
                    </div>
                </div>
                <div class="otherbox  ">
                    <span> <?php echo $row['F_runtime'] ?>分钟 -  <?php echo $row['F_genre'] ?> -   <?php echo $row['F_releaseDate'] ?>上映</span>
                </div>
                <div>
    <?php if ($checklogin) : ?>
                    <button id="addfavorite" type="button" class="btn btn-success">收藏</button>
                    <script>
                        $(document).ready(function () {
                            $("#addfavorite").click(function () { 
                                var status = $(this).html();
                                if(status == "收藏")
                                $(this).load("addfavorite.php",{action:"addfavoritemovie",fid:<?php echo $row['F_ID'] ?>});
                                else if(status == "已收藏")
                                $(this).load("addfavorite.php",{action:"removefavoritemovie",fid:<?php echo $row['F_ID'] ?>});
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
                        <strong>导演：</strong>
                        <a href="http://www.mymtime.com/peopleinfo.php?p_id=<?php echo $row['F_directorID'] ?>" target="_blank" rel="v:directedBy"> <?php echo $row['P_name_zh'] ?></a>
                    </dd>
                    <dd>
                        <strong>国家地区：</strong>
                        <a> <?php echo $row['F_nation'] ?></a>
                    </dd>
                </dl>
            </div>
            <div class="db_actor">
                <dl>
                    <dt>
                        <div class="actor_tit">
                            <h4> 演员 Actor</h4>
                        </div>
                        <div class="character_tit">
                            <div class="character_inner">
                                <h4> 角色 Character</h4>
                            </div>
                        </div>
                    </dt>
    <?php while ($row = $result_actin->fetch_assoc()) : ?>
                    <dd>
                        <div class="actor_tit">
                            <div class="pic_58">
                                <a href="http://www.mymtime.com/peopleinfo.php?p_id=<?php echo $row['P_ID'] ?>" title="<?php echo $row['P_name_zh'] ?> <?php echo $row['P_name_en'] ?>" target="_blank">
                                    <img alt="<?php echo $row['P_name_zh'] ?> <?php echo $row['P_name_en'] ?>" src="<?php echo $row['P_img_url'] ?>" width="58" height="58">
                                </a>
                                <h3>
                                    <a href="http://www.mymtime.com/peopleinfo.php?p_id=<?php echo $row['P_ID'] ?>" target="_blank"><?php echo $row['P_name_zh'] ?></a>
                                </h3>
                                <p>
                                    <a href="http://www.mymtime.com/peopleinfo.php?p_id=<?php echo $row['P_ID'] ?>" target="_blank"><?php echo $row['P_name_en'] ?></a>
                                </p>
                            </div>
                        </div>
                        <div class="character_tit">
                            <em>&nbsp;</em>
                            <div class="character_inner">
                                <div class="pic_58">
                                    <img alt="<?php echo $row['role'] ?>" src="<?php echo $row['role_img_url'] ?>" width="58" height="58">
                                    <h3><?php echo $row['role'] ?></h3>
                                </div>
                            </div>
                        </div>
                    </dd>
    <?php endwhile; ?>
                </dl>
            </div>
        </div>
    </div>
</body>

</html>
<?php else : ?>
    <?php echo "该电影ID不在数据库中" ?>
<?php endif; ?>