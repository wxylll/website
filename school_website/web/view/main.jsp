<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/10/19
  Time: 10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="X-UA-Compatile" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>计算机科学与工程学院学生学生第一党支部</title>
    <link href="${pageContext.request.getContextPath()}/css/bootstrap.css" rel="stylesheet"/>
</head>
<style type="text/css">
    .menu {width:170px;height:100%;background-color: rgb(111,39,41);color:white;font-size: 22px;line-height: 70px;float:left;transition: .3s;}
    .menu:hover {background-color: rgb(183,0,49);cursor: pointer}
    .menu:hover ul{height: 140px}
    .menu ul {background-color: rgb(111,39,41);list-style: none;padding-left: 0px;width: 170px;height:0px;transition: .3s;transition:height .5s;overflow: hidden;position: absolute; z-index: 9999;}
    .menu li {transition: .3s;overflow: hidden;}
    .menu li:hover {background-color: rgb(148,39,25);cursor: pointer}
    .title {width:100%;border-bottom: 4px solid #b4b4b4;height: 50px}
    .title div {border-bottom: 4px solid #6f2729;height: 50px;width:auto;line-height: 50px;font-size: 28px;font-family: '微软雅黑','黑体';color: #6f2729;font-weight: bold;display: inline-block;text-decoration: none;}
    .title_l {width:100%;border-bottom: 2px solid #b4b4b4;height: 50px}
    .title_l a {float:right;font-size: 10px;color: #af8e39;font-family: '微软雅黑','黑体';line-height: 50px;text-decoration: none;padding-right: 10px}
    .title_l div {border-bottom: 2px solid #6f2729;height: 50px;width:auto;line-height: 50px;font-size: 20px;font-family: '微软雅黑','黑体';color: #6f2729;font-weight: bold;display: inline-block;text-decoration: none;}
    .list {list-style: none;padding-top: 25px}
    .list li {height: 30px;margin-bottom: 15px}
    .list a {font-size: 20px;color: #000000;font-family: '微软雅黑','黑体';line-height: 30px;text-decoration: none;}
    .list a:hover {color: #c30;cursor: pointer}
    .list_l {list-style: none;padding-top: 25px;padding-right: 10px;padding-left: 10px;}
    .list_l li {height: 20px;margin-bottom: 15px}
    .list_l a {font-size: 15px;color: #000000;font-family: '微软雅黑','黑体';line-height: 20px;text-decoration: none;}
    .list_l a:hover {color: #c30;cursor: pointer}
    .a_menu {text-decoration: none;color: white}
    .a_menu:visited {text-decoration: none;color: white}
    .a_menu:hover {text-decoration: none;color: white}
    .a_menu:link {text-decoration: none;color: white}
</style>
<body>
<div class="container-fluid" style="background-color: rgb(148,39,25);height: 250px;padding-right: 5%;padding-left: 5%">
    <div id="head" style="background-image: url('/image/head1.png');width: 100%;height: 100%;background-repeat: no-repeat;background-size: contain;background-position:center right;transition: 3s">
        <img height="100%" src="${pageContext.request.getContextPath()}/image/head_.png"/>
    </div>
</div>
<div align="center" class="container-fluid" style="background-color: rgb(111,39,41);height: 70px;padding-right: 5%;padding-left: 5%">
    <div style="width: 1020px">
        <a href="<c:url value="/toMain.action"/>" class="a_menu"><div class="menu">首&nbsp;&nbsp;&nbsp;页</div></a>
        <a href="<c:url value="/toBranch.action?title=支部介绍"/>" class="a_menu">
            <div class="menu">支部简介
                <ul>
                    <a href="<c:url value="/toBranch.action?title=支部介绍"/>" class="a_menu"><li>支部介绍</li></a>
                    <a href="<c:url value="/toBranch.action?title=党员风采"/>" class="a_menu"><li>党员风采</li></a>
                </ul>
            </div>
        </a>
        <a href="<c:url value="/showMore.action?category=2&title=文件通知"/>"><div class="menu">文件通知</div></a>
        <a href="<c:url value="/showMore.action?category=4&title=视频资源"/>"><div class="menu">视频资源</div></a>
        <a href="<c:url value="/showMore.action?category=3&title=学习资料"/>"><div class="menu">学习资料</div></a>
        <a href="<c:url value="/showMore.action?category=5&title=下载专区"/>"><div class="menu">下载专区</div></a>
    </div>
</div>
<div class="container-fluid" style="padding-left: 10%;padding-right: 10%;padding-top: 20px">
    <!--支部动态-->
    <div align="left" style="width:100%">
        <div class="title">
            <div>支部动态</div>
        </div>
        <div align="left" class="col-lg-5" style="padding-top: 20px;height: 400px">
            <c:if test="${!(empty slides)}">
                <div id="myCarousel" class="carousel slide" style="width: 100%;height: 100%" data-ride="carousel" data-interval="5000">
                    <!-- 轮播（Carousel）指标 -->
                    <ol class="carousel-indicators">
                        <c:forEach begin="0" end="${slides.size() - 1}" var="i">
                            <li data-target="#myCarousel" data-slide-to="${i}" <c:if test="${i == 0}">class="active"</c:if>></li>
                        </c:forEach>
                    </ol>
                    <!-- 轮播（Carousel）项目 -->
                    <div class="carousel-inner">
                        <c:forEach varStatus="status" items="${slides}" var="slide">
                            <div class="item <c:if test="${status.first}">active</c:if>" style="height: 100%">
                                <a href="<c:url value="/getArticle.action?id=${slide.article.id}"/>" target="_blank">
                                    <img width="100%" height="100%" style="height: 100%!important;" src="<c:url value="/upload/slides/s${slide.id}.jpg"/>?date=<%=new Date().getTime()%>">
                                </a>
                                <div class="carousel-caption">
                                    <span>${slide.article.title}</span>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <!-- 轮播（Carousel）导航 -->
                    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </c:if>


        </div>
        <div class="col-lg-7" style="padding-top: 20px;height: 400px">
            <ul class="list">
                <c:forEach items="${news}" var="new1">
                    <li><a href="<c:url value="/getArticle.action?id=${new1.id}"/>" target="_blank">${new1.title}<span style="float: right"><fmt:formatDate value="${new1.releaseTime}" pattern="yyyy-MM-dd"/></span></a></li>
                </c:forEach>
                <a href="<c:url value="/showMore.action?category=1&title=支部动态"/>" style="float: right;color: #af8e39;"><i>more&gt;&gt;</i></a>
            </ul>
        </div>
    </div>
    <!--文件通知-->
    <div class="col-lg-6" style="padding-left: 0px;padding-top: 30px;height:300px;">
        <div class="title_l">
            <div>文件通知</div>
            <a href="<c:url value="/showMore.action?category=2&title=文件通知"/>">更多&gt;&gt;</a>
        </div>
        <div>
            <ul class="list_l">
                <c:forEach items="${informs}" var="inform">
                    <li><a href="<c:url value="/getArticle.action?id=${inform.id}"/>" target="_blank">${inform.title}<span style="float: right"><fmt:formatDate value="${inform.releaseTime}" pattern="yyyy-MM-dd"/></span></a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <div class="col-lg-1"></div>
    <!--视频资源-->
    <div class="col-lg-5" style="padding-left: 0px;padding-top: 30px;height:300px;">
        <div class="title_l">
            <div>视频资源</div>
            <a href="<c:url value="/showMore.action?category=4&title=视频资源"/>">更多&gt;&gt;</a>
        </div>
        <div>
            <ul class="list_l">
                <c:forEach items="${videos}" var="video">
                    <li><a href="<c:url value="/getVideo.action?id=${video.id}"/>&date=<%=new Date().getTime()%>" target="_blank">${video.title}<span style="float: right"><fmt:formatDate value="${video.releaseTime}" pattern="yyyy-MM-dd"/></span></a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <div class="row" style="width: 100%;padding-top: 50px;padding-bottom: 50px">
        <img width="100%" src="${pageContext.request.getContextPath()}/image/bwcx.png"/>
    </div>
    <!--学习资料-->
    <div class="col-lg-6" style="padding-left: 0px;padding-top: 30px;height:300px;">
        <div class="title_l">
            <div>学习资料</div>
            <a href="<c:url value="/showMore.action?category=3&title=学习资料"/>">更多&gt;&gt;</a>
        </div>
        <div>
            <ul class="list_l">
                <c:forEach items="${studies}" var="study">
                    <li><a href="<c:url value="/getArticle.action?id=${study.id}"/>" target="_blank">${study.title}<span style="float: right"><fmt:formatDate value="${study.releaseTime}" pattern="yyyy-MM-dd"/></span></a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <div class="col-lg-1"></div>
    <!--下载专区-->
    <div class="col-lg-5" style="padding-left: 0px;padding-top: 30px;height:300px;">
        <div class="title_l">
            <div>下载专区</div>
            <a href="<c:url value="/showMore.action?category=5&title=下载专区"/>">更多&gt;&gt;</a>
        </div>
        <div>
            <ul class="list_l">
                <c:forEach items="${downloads}" var="download">
                    <li><a download="${download.title}" href="<c:url value="/upload/attachment/${download.file}"/>?date=<%=new Date().getTime()%>" target="_blank">${download.title}<span style="float: right"><fmt:formatDate value="${download.releaseTime}" pattern="yyyy-MM-dd"/></span></a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<div align="center" style="width: 100%;height: 100px;background-color: #323232;color:white;line-height: 100px">
版权所有：长春工业大学维护制作
</div>
</body>
<script src="${pageContext.request.getContextPath()}/js/jquery-3.3.1.js"></script>
<script src="${pageContext.request.getContextPath()}/js/bootstrap.min.js"></script>
<script type="text/javascript">
    var bg = true;
    setInterval("change_bg()",8000)
    function change_bg() {
        bg = !bg;
        document.getElementById('head').style.backgroundImage = "url('/image/head" + (bg ? 1 : 2) + ".png')"
    }
</script>
</html>
