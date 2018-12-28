"use strict";
$(document).ready(function () {
    $("#v-pills-onshow").load("onshow.php");
    $("#hotMovieRegion").load("topmovies.php");
    $("#hotPeopleRegion").load("toppeople.php");
    $.get("checklogin.php", function (data, status) {
        if (status == "success")
            eval(data);
        else
            alert("错误：" + status);
    });
    $("#typePickerRegion ul li a").click(function () {
        $(this).addClass("on");
        var genre = $(this).html();
        $("#searchResultRegion").load("searchresult.php", {
            searchfor: "movie",
            genre: genre
        });
    });
    $("ul#initialcn li a").click(function () {
        $(this).addClass("on");
        var letter = $(this).html();
        $("#searchResultRegion").load("searchresult.php", {
            searchfor: "people",
            initial: "cn",
            letter: letter
        });
    });
    $("ul#initialen li a").click(function () {
        $(this).addClass("on");
        var letter = $(this).html();
        $("#searchResultRegion").load("searchresult.php", {
            searchfor: "people",
            initial: "en",
            letter: letter
        });
    });
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
    $("button#homepage").click(function () {
        $("#v-pills-tab a:last").tab('show');
        $("#panel-homepage").load("homepage.php");
        $("#panel-favoritemovie").load("favoritemovie.php");
        $("#panel-favoritepeople").load("favoritepeople.php");
        $("#panel-mytickets").load("usertickets.php");
    });
});

function auto_login(username) {
    $("button#modalToggle").attr("style", "display:none;");
    $("#loginModal").modal('hide');
    $("a#logout").attr("style", "display:inline;");
    $("button#homepage").attr("style", "display:inline;");
    $("#welcome").html("欢迎，" + username);
}