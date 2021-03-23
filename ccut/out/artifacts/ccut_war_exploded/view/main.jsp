<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/7/23
  Time: 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="X-UA-Compatile" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>长春工业大学-网络工程党支部</title>
    <link href="<c:url value="/css/bootstrap.css"/>" rel="stylesheet"/>
</head>
<style>
    .nav {
        display: block;
        width: 100%;
        font-size: 20px;
        font-weight: 600;
        color: rgba(0,0,0,.6);
        padding-top: 8%;
        padding-bottom: 8%;
    }
    .nav:hover {
        color: rgba(0,0,0,.6);
        text-decoration: none;
        background-color: rgba(0,0,0,.03);
    }
    .nav:focus {
        color: rgba(0,0,0,.6);
        text-decoration: none;
        background-color: rgba(0,0,0,.05);
    }
    .nav_title {
        font-size: 25px;
        background-color: rgb(192,67,73);
        border-radius: 0px;
        padding: 20px 0px 20px 0px;
    }
    .left {
        padding: 0px 0px 100px 0px;
        background: linear-gradient(to bottom, rgba(0,0,0,.05), rgba(0,0,0,0));
    }
    iframe {
        width: 100%;
        border: none;
    }
    body::-webkit-scrollbar {
        display: none;
    }
</style>
<body>
    <div  class="container" style="width: 80%;">
        <img class="img-responsive center-block" width="100%" src="<c:url value="/image/art_head.png"/>">
    </div>
    <div class="container" style="width: 80%;padding-top: 1%">
        <div class="col-lg-2 left">
            <spen class="label center-block nav_title">网络工程</spen>
            <ul class="list-unstyled">
                <li><a href="<c:url value="/toNews.action"/>" target="content" class="text-center nav">支部新闻</a></li>
                <li><a href="<c:url value="/toStudy.action"/>" target="content" class="text-center nav">学习园地</a></li>
                <li><a href="<c:url value="/toMember.action"/>" target="content" class="text-center nav">班子成员</a></li>
                <li><a href="<c:url value="/toTeam.action"/>" target="content" class="text-center nav">党员队伍</a></li>
            </ul>
            <img class="img-responsive center-block" style="margin-top:100px; border-radius: 50%; opacity: .15" src="<c:url value="/image/danghui.jpg"/>">
        </div>
        <div class="col-lg-10">
            <iframe id="iframe_content" name="content" src="<c:url value="/toNews.action"/>" onload="reSize()" scrolling="no"></iframe>
        </div>
    </div>
</body>
<script>
    function reSize() {
        var iframe = document.getElementById('iframe_content')
        iframe.height = iframe.contentWindow.document.documentElement.scrollHeight;
    }
</script>
</html>
