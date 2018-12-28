<?php
session_start();
$userid = $_SESSION['userinfo']['id'];
require_once("database.php");
$sql = "SELECT * 
        FROM tickets, `show`, films, theaters 
        WHERE tickets.S_ID = `show`.S_ID 
            AND `show`.`F_ID` = films.F_ID 
            AND `show`.`T_ID` = theaters.T_ID 
            AND tickets.U_ID = $userid
        ORDER BY S_start_time DESC";
$result = $conn->query($sql);
echo '<h4 id=" TotalCountRegion " class=" px14 text-center">共预定了' . ($result->num_rows) . '张电影票</h4>';
while ($row = $result->fetch_assoc()) : ?>
<div class="card">
    <table class="table">
        <tbody>
            <tr>
                <td>
                    <img src="<?php echo $row['F_img_url'] ?>" alt="<?php $row['F_name_zh'] . "/" . $row['F_name_en'] ?>" style="width:100%">
                </td>
                <td>
                    <div class="card-body">
                        <h4 class="card-title"><?php echo $row['T_name'] ?></h4>
                        <div class="card-text">
                            <ul>
                                <li>电影：<?php echo$row['F_name_zh']?></li>
                                <li>开始时间：<?php echo $row['S_start_time'] ?></li>
                                <li>结束时间：<?php echo $row['S_end_time'] ?></li>
                                <li>票价：<?php echo $row['S_price'] ?></li>
                            </ul>
                        </div>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
</div>
<?php endwhile;?>