<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/7/24
  Time: 10:07
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
    ul {
        float: left;
        display:inline-block;
        padding-top: 10px;
    }
    li {
        color: #8c8c8c;
        font-size: 20px;
        font-weight: bold;
        padding-top: 10px;
        padding-left: 60px;
        padding-bottom: 10px;
    }
    .box {
        width: 95%;
        border-left: 5px solid #c30;
        margin-top: 10px;
        padding-bottom:20px;
        padding-top: 20px;
        padding-left: 50px;
        background: linear-gradient(to right, rgba(0,0,0,.04), rgba(0,0,0,0));
    }
    body::-webkit-scrollbar {
        display: none;
    }
</style>
<body>
    <div class="container-fluid" style="padding-top: 25px">
        <strong style="font-size: 20px;color: gray">班子成员 &gt;</strong>
        <hr style="background-color: gray;height: 2px;border: none;opacity: .5"/>
    </div>
    <c:forEach items="${members}" var="member">
        <div class="container box">
            <img width="200" height="200" style="float: left" src="<c:url value="/upload/photos/${member.photo}"/>?date=<%=new Date().getTime()%>">
            <ul class="list-unstyled">
                <li>姓名：${member.name}</li>
                <li></li>
                <li>职务：${member.position}</li>
                <li></li>
                <li>政治面貌：${member.politicsStatus}</li>
            </ul>
        </div>
    </c:forEach>
</body>
</html>
