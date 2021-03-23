<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/7/26
  Time: 14:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="X-UA-Compatile" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <link href="<c:url value="/css/bootstrap.css"/>" rel="stylesheet"/>
    <title>学生第一党支部-后台管理</title>
</head>
<style>
    .my_nav {
        width: 100%;
        height: 50px;
        line-height: 50px;
    }
    .my_nav:hover {
        border-left: 5px #761c19 solid;
        background-color: rgba(0,0,0,.3);
        color: white;
        cursor: pointer;
        transition: .3s;
    }
    .nav_active {
        width: 100%;
        height: 50px;
        line-height: 50px;
        border-left: 5px #761c19 solid;
        background-color: rgba(0,0,0,.3);
        color: white;
        cursor: pointer;
    }
    .nav_active a {
        color: white;
    }
    a {
        width: 90%;
        height: 100%;
        color: black;
        padding-left: 10%;
        display: inline-block;
        outline: none;
        font-size: 16px;
        text-decoration: none;
    }
    a:hover {
        color: white;
        text-decoration: none;
    }
    a:focus {
        color: white;
        text-decoration: none;
    }
    #setting a {
        width:100%;
    }
</style>
<body>
    <a id="hidden_link" style="display: none" href="<c:url value="/logout.action"/>"></a>
    <div class="container-fluid" style="padding: 0px;height: 100%">
        <div class="row" style="width: 100%;height: 6%;background-color: #c30;margin-left: 0px;float: left;display: table;vertical-align:middle;">
            <div style="vertical-align:middle;display: table-cell">
                <span style="margin-left: 3%;color: white;float: left;font-size: 30px;font-weight: bold;">学生第一党支部</span>
            </div>
            <div align="right" style="vertical-align:middle;display: table-cell;padding-right: 30px;color: white">
                <div class="btn-group">
                    <button type="button" class="dropdown-toggle" style="background-color: rgba(0,0,0,0);outline: none;border: none;" data-toggle="dropdown">
                        ${sessionScope.admin_user}
                        <span class="caret" style="border-top-color: white"></span>
                    </button>
                    <ul id="setting" class="dropdown-menu pull-right">
                        <li><a onclick="alterPassword()" href="javascript:void(0)">修改密码</a></li>
                        <li><a onclick="logout()" href="javascript:void(0)">退出</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div style="background-color: rgb(238,238,238);height: 94%;width: 15%;float: left">
            <ul id="nav" class="list-unstyled" style="margin-top: 20px">
                <li class="my_nav" onclick="nav_switch(this)">
                    <a href="<c:url value="/adminNewsManage.action"/>" target="content">支部动态</a>
                    <span class="glyphicon glyphicon-chevron-right"></span>
                </li>
                <li class="my_nav" onclick="nav_switch(this)">
                    <a href="<c:url value="/adminDocumentManage.action"/>" target="content">文件通知</a>
                    <span class="glyphicon glyphicon-chevron-right"></span>
                </li>
                <li class="my_nav" onclick="nav_switch(this)">
                    <a href="<c:url value="/adminStudyManage.action"/>" target="content">学习资料</a>
                    <span class="glyphicon glyphicon-chevron-right"></span>
                </li>
                <li class="my_nav" onclick="nav_switch(this)">
                    <a href="<c:url value="/adminVideoManage.action"/>" target="content">视频资源</a>
                    <span class="glyphicon glyphicon-chevron-right"></span>
                </li>
                <li class="my_nav" onclick="nav_switch(this)">
                    <a href="<c:url value="/adminDownloadManage.action"/>" target="content">下载专区</a>
                    <span class="glyphicon glyphicon-chevron-right"></span>
                </li>
                <li class="my_nav" onclick="nav_switch(this)">
                    <a href="<c:url value="/adminBriefManage.action"/>" target="content">支部介绍</a>
                    <span class="glyphicon glyphicon-chevron-right"></span>
                </li>
                <li class="my_nav" onclick="nav_switch(this)">
                    <a href="<c:url value="/adminMemberManage.action"/>" target="content">党员风采</a>
                    <span class="glyphicon glyphicon-chevron-right"></span>
                </li>
            </ul>
        </div>
        <div style="background-color: white;height: 94%;width: 85%;color: white;float: left">
            <iframe name="content" src="<c:url value="/view/backstage/welcome.jsp"/>" style="width: 100%;height: 100%;border: none"></iframe>
        </div>
    </div>
</body>
<script src="<c:url value="/js/jquery-3.3.1.js"/>"></script>
<script src="<c:url value="/js/bootstrap.js"/>"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
    function nav_switch(ele) {
        var nav = document.getElementById('nav').childNodes
        for (var i = 0; i < nav.length; i++) {
            nav[i].className = 'my_nav'
        }
        ele.className = 'nav_active'
    }

    function logout() {
        if (confirm("确定要退出吗？"))
            document.getElementById('hidden_link').click()
    }

    function alterPassword() {
        layui.use('layer', function() {
            layer.open({
                title:'修改密码',
                type: 2,
                offset:100,
                area: ['450px', '460px'],
                fixed: false, //不固定
                maxmin: true,
                content: ['${pageContext.request.contextPath}/view/backstage/items/_admin_alter.jsp','no']
            })
        })
    }
</script>
</html>
