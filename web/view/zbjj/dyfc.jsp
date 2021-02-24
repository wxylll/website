<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/10/24
  Time: 20:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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
    .box {width: 95%;margin-top: 20px;padding-bottom:20px;padding-top: 20px;padding-left: 50px;background: linear-gradient(to right, rgba(0,0,0,.04), rgba(0,0,0,0));}
    .box ul {float: left;display:inline-block;padding-top: 10px;}
    .box li {color: #8c8c8c;font-size: 20px;font-weight: bold;padding-top: 10px;padding-left: 60px;padding-bottom: 10px;}
</style>
<body>
<div class="title_l">
    <div>党员风采</div>
</div>
<c:forEach items="${members}" var="member">
    <div class="container box">
        <img width="200" height="200" style="float: left" src="<c:url value="/upload/photos/${member.photo}"/>?date=<%=new Date().getTime()%>">
        <ul class="list-unstyled">
            <li>姓名：${member.name}</li>
            <li></li>
            <li>职务：${member.position}</li>
            <li></li>
            <li>人生寄语：${member.note}</li>
        </ul>
    </div>
</c:forEach>
</body>
</html>
