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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
</head>
<style type="text/css">
    .menu {width:170px;height:100%;background-color: rgb(111,39,41);color:white;font-size: 22px;line-height: 70px;float:left;transition: .3s;}
    .menu:hover {background-color: rgb(183,0,49);cursor: pointer}
    .menu:hover ul{height: 140px}
    .menu ul {background-color: rgb(111,39,41);list-style: none;padding-left: 0px;width: 170px;height:0px;transition: .3s;transition:height .5s;overflow: hidden;position: absolute; z-index: 9999;}
    .menu li {transition: .3s;overflow: hidden;}
    .menu li:hover {background-color: rgb(148,39,25);cursor: pointer}
    .title {width:100%;border-bottom: 4px solid #b4b4b4;height: 80px;}
    .title div {border-bottom: 4px solid #6f2729;height: 80px;width:auto;line-height: 100px;font-size: 28px;font-family: '微软雅黑','黑体';color: #6f2729;font-weight: bold;display: inline-block;text-decoration: none;}
    .title_l {width:100%;border-bottom: 3px solid #b4b4b4;height: 60px}
    .title_l a {float:right;font-size: 10px;color: #af8e39;font-family: '微软雅黑','黑体';line-height: 50px;text-decoration: none;padding-right: 10px}
    .title_l div {border-bottom: 3px solid #6f2729;height: 60px;width:auto;line-height: 60px;font-size: 23px;font-family: '微软雅黑','黑体';color: #6f2729;font-weight: bold;display: inline-block;text-decoration: none;}
    .list {list-style: none;padding-top: 25px;padding-right: 0px}
    .list li {height: 30px;margin-bottom: 20px}
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
<div class="container-fluid" style="padding-left: 10%;padding-right: 10%;padding-top: 30px;margin-bottom:30px;height:80%">
    <div class="col-lg-2" style="background-image: linear-gradient(rgba(230,230,230,1),white);height: 100%;padding: 0px">
        <div align="center" style="width: 100%;height: 80px;background-color: rgb(148,39,25);color: white;font-size: 30px;line-height: 80px">
            ${title}
        </div>
    </div>
    <div class="col-lg-10" style="height: 100%;padding-left: 50px">
        <div class="title_l">
            <div>${title}</div>
        </div>
        <ul id="biuuu_city_list" class="list"></ul>
        <div align="right" id="demo8"></div>

    </div>
</div>
<div align="center" style="width: 100%;height: 100px;background-color: #323232;color:white;line-height: 100px">
    版权所有：长春工业大学维护制作
</div>
</body>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script src="${pageContext.request.getContextPath()}/js/jquery-3.3.1.js"></script>
<script src="${pageContext.request.getContextPath()}/js/bootstrap.min.js"></script>
<script type="text/javascript">

    layui.use(['laypage', 'layer'], function(){
        var data = [
            <c:if test="${!((title eq '视频资源') or (title eq '下载专区'))}">
                <c:forEach items="${sources}" var="source">
                '<a target="_bank" href="${pageContext.request.getContextPath()}/getArticle.action?id=${source.id}">${source.title}<span style="float: right"><fmt:formatDate value="${source.releaseTime}" pattern="yyyy-MM-dd"/></span></a>',
                </c:forEach>
            </c:if>
            <c:if test="${title eq '视频资源'}">
            <c:forEach items="${sources}" var="source">
            '<a target="_bank" href="${pageContext.request.getContextPath()}/getVideo.action?id=${source.id}">${source.title}<span style="float: right"><fmt:formatDate value="${source.releaseTime}" pattern="yyyy-MM-dd"/></span></a>',
            </c:forEach>
            </c:if>
            <c:if test="${title eq '下载专区'}">
            <c:forEach items="${sources}" var="source">
            '<a target="_bank" download="${source.title}" href="${pageContext.request.getContextPath()}/upload/attachment/${source.file}">${source.title}<span style="float: right"><fmt:formatDate value="${source.releaseTime}" pattern="yyyy-MM-dd"/></span></a>',
            </c:forEach>
            </c:if>
        ];

        //调用分页
        layui.laypage.render({
            elem: 'demo8'
            ,count: data.length
            ,limit:9
            ,layout:['prev', 'page', 'next','count','skip']
            ,jump: function(obj){
                //模拟渲染
                document.getElementById('biuuu_city_list').innerHTML = function(){
                    var arr = []
                        ,thisData = data.concat().splice(obj.curr*obj.limit - obj.limit, obj.limit);
                    layui.each(thisData, function(index, item){
                        arr.push('<li>'+ item +'</li>');
                    });
                    return arr.join('');
                }();
            }
        });

    });

    var bg = true;
    setInterval("change_bg()",8000)
    function change_bg() {
        bg = !bg;
        document.getElementById('head').style.backgroundImage = "url('/image/head" + (bg ? 1 : 2) + ".png')"
    }
</script>
</html>
