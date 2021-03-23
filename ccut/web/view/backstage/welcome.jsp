<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/8/3
  Time: 11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="X-UA-Compatile" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <link href="<c:url value="/css/bootstrap.css"/>" rel="stylesheet"/>
</head>
<body>
<div align="center" class="container" style="padding-top: 10%">
    <div style="width: 600px;">
        <img width="300" src="<c:url value="/image/network.png"/>"/>
        <div align="left" style="display: inline-block;width: 290px;vertical-align:bottom">
            <h3 style="color: #bfbfbf;display: inline-block">网络工程党支部</h3>
            <h2 style="color: #bfbfbf;display: inline-block">信息公示-后台管理</h2>
        </div>
    </div>
</div>
</body>
</html>
