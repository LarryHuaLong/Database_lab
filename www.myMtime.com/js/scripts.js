"use strict";
$(document).ready(function () {
    $("#hotMovieRegion").load("topmovies.php");
    $("#hotPeopleRegion").load("toppeople.php");
    $("#btn-login").click(function () {
        var email = $("#InputEmail").val();
        var password = $("#InputPassword").val();
        $.post("login.php", {
                action: "login",
                email: email,
                password: password
            },
            function (data, status) {
                if (status == "success")
                    eval(data);
                else
                    alert("错误：" + status);
            });
    });
    $("#btn-signup").click(function () {
        var email = $("#InputEmail").val();
        var password = $("#InputPassword").val();
        $.post("signup.php", {
                action: "signup",
                email: email,
                password: password
            },
            function (data, status) {
                if (status == "success")
                    eval(data);
                else
                    alert("错误：" + status);
            });
    });
});

function auto_login(username) {
    $("#modalToggle").hide();
    $("#loginModal").hide();
}