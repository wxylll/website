<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/7/24
  Time: 17:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="X-UA-Compatile" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="<c:url value="/css/bootstrap.css"/>" rel="stylesheet"/>
    <title>${article.title}</title>
</head>
<style>
    .head {
        width: 100%;
        background-color: #c30;
        display: block;
        padding-top: 5px;
    }
    .head span {
        color: white;
        font-weight: bold;
        font-size:35px;
        display: inline-block;
        padding-top: 40px;
        padding-left: 70px;
        padding-bottom: 20px
    }
    iframe {
        width: 95%;
        border: none;
    }
</style>
<body style="background-color: rgba(192,192,192,.2)">
    <div style="padding-left: 0px;padding-right:0px;box-shadow: 0px 0px 30px #8c8c8c" class="container">
        <div class="head">
            <img style="vertical-align:top;" src="<c:url value="/image/logo.png"/>">
            <span>网络工程党支部</span>
        </div>
    </div>
    <div style="padding-left: 0px;padding-right:0px;background-color: white;box-shadow: 0px 10px 10px #8c8c8c;" align="center" class="container">
        <h3 style="padding: 10px;font-weight: 600;font-size: 20px">${article.title}</h3>
        <hr style="background-color: #c30;height: 5px;width:95%;border: none;opacity: 1">
        <span>发布时间：<fmt:formatDate value="${article.releaseTime}" pattern="yyyy-MM-dd"/></span>
        <div align="left" style="width: 95%">
            <div style="min-height: 70%">${article.content}</div>
            <hr style="background-color: #c30;height: 2px;width:100%;border: none;opacity: 1">
            <c:if test="${not empty article.attachments}">
                <c:forEach items="${article.attachments}" var="attachment">
                    <div align="left" style="padding-bottom: 2px;width: 100%;padding-left: 20px;">
                        <img width="30" src="<c:url value="/image/fujian.png"/>">
                        <a style="vertical-align:bottom;" href="<c:url value="/upload/attachment/${fn:substring(attachment, 0, 2)}/${attachment}"/>?date=<%= new Date().getTime()%>" download="${fn:substring(attachment, 32, fn:length(attachment))}">${fn:substring(attachment, 32, fn:length(attachment))}</a>
                    </div>
                </c:forEach>
                <div style="width: 100%;height: 30px"></div>
            </c:if>
            <c:if test="${empty article.attachments}">
                <div style="width: 100%;height: 50px"></div>
            </c:if>
        </div>
    </div>
</body>
</html>
