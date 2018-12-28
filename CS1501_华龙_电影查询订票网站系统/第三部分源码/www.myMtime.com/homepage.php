<?php
session_start();
$userid = $_SESSION['userinfo']['id'];
$username = $_SESSION['userinfo']['username'];
$email = $_SESSION['userinfo']['email'];
echo '欢迎来到你的主页' . $username;
?>
    <ul>
        <li>
            <p> ID：
                <?php echo $userid ?>
            </p>
        </li>
        <li>
            <label for="inputnewname"> 用户名:</label>
            <input type="text" name="username" id="inputnewname" placeholder="<?php echo $username ?>">
            <button id="changename" type="button">修改</button>
        </li>
        <li>
            <p>邮箱:
                <?php echo $email ?>
            </p>
        </li>
        <li>
            <label for="old_password">原密码：</label>
            <input type="password" name="oldpassword" id="old_password">
        </li>
        <li>
            <label for="new_password">新密码：</label>
            <input type="password" name="newpassword" id="new_password">
        </li>
        <li>

            <label for="confirm_password">确定新密码：</label>
            <input type="password" name="confirmpassword" id="confirm_password">
        </li>
        <li>
            <button id="changepassword" type="button">修改密码</button>
        </li>
    </ul>
    <script>
        $("#panel-homepage").ready(function () {
            $("#changename").click(function () {
                var old_name = "<?php echo $username ?>";
                var new_name = $("#inputnewname").val();
                if (new_name == "")
                    alert("请先在左侧输入框中输入新的用户名");
                else if (new_name == old_name)
                    alert("新的用户名不能与原用户名相同");
                else {
                    $.post("changeuserinfo.php", {
                        action: "changeusername",
                        newname: new_name
                    }, function (data, status) {
                        if (status == "success") eval(data);
                        else alert("错误：" + status);
                    });
                }
            });

        });
        $("#panel-homepage").ready(function () {
            $("#changepassword").click(function () {
                var old_pass = $("#old_password").val();
                var new_pass = $("#new_password").val();
                var confirm_pass = $("#confirm_password").val();
                if(old_pass == new_pass)
                    alert("新密码不能与原密码相同");
                else if (new_pass != confirm_pass) {
                    alert("输入密码不一致，请重试");
                } else {
                    $.post("changeuserinfo.php", {
                        action: "changepassword",
                        oldpassword: old_pass,
                        newpassword: new_pass
                    }, function (data, status) {
                        if (status == "success") eval(data);
                        else alert("错误：" + status);
                    });
                }
            });
        });
    </script>