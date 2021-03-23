<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/7/24
  Time: 11:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="X-UA-Compatile" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="<c:url value="/css/bootstrap.css"/>" rel="stylesheet"/>
</head>
<style>
    img {
        width: 150px;
        height: 150px;
        display: block;
        margin-bottom: 10px;
    }
    .box {
        display: inline-block;
        font-size: 18px;
        font-weight: bold;
        float: left;
        margin-left: 35px;
        margin-right: 35px;
        margin-top: 40px;
        color: #8c8c8c;
    }
    body::-webkit-scrollbar {
        display: none;
    }
</style>
<body style="padding-bottom: 5%">
    <div class="container-fluid" style="padding-top: 25px">
        <strong style="font-size: 20px;color: gray">党员队伍 &gt;</strong>
        <hr style="background-color: gray;height: 2px;border: none;opacity: .5"/>
    </div>
    <div class="container">
        <c:forEach items="${teamMembers}" var="teamMember">
            <div align="center" class="box">
                <img src="<c:url value='/upload/photos/${teamMember.photo}'/>?date=<%=new Date().getTime()%>">
                <div>${teamMember.name}</div>
            </div>
        </c:forEach>
    </div>
</body>
</html>
