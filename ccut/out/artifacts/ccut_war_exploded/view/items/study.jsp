<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/7/23
  Time: 21:01
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
    a {
        color: #8c8c8c;
    }
    .link {
        width: 100%;
        padding: 10px;
        font-size: 18px;
        color: #8c8c8c;
    }
    body::-webkit-scrollbar {
        display: none;
    }
</style>
<body>
<div class="container-fluid" style="padding-top: 25px">
    <strong style="font-size: 20px;color: gray">学习园地 &gt;</strong>
    <hr style="background-color: gray;height: 2px;border: none;opacity: .5"/>
</div>
<div class="container-fluid">
    <ul>
        <c:forEach items="${articles}" var="article" varStatus="i">
            <li class="link">
                <a href="<c:url value="/getArticle.action?id=${article.id}"/>" target="_blank">${article.title}</a>
                <span style="float: right"><fmt:formatDate value="${article.releaseTime}" pattern="yyyy-MM-dd"/></span>
            </li>
            <c:if test="${i.count % 5 == 0 && i.count < 15}" >
                <li class="link" style="list-style: none;padding: 0px;margin-left: -16px"><hr style="height:1px;border:none;border-top:1px dashed gray;width: 100%;" /></li>
            </c:if>
        </c:forEach>
    </ul>

    <!--超出容量显示加载更多-->
    <c:if test="${not (fn:length(articles) < 10)}">
        <div style="width: 100%"><a style="float: right;margin-right: 10px;font-size: 16px" href="<c:url value="/study_showMore.action"/>" target="_blank"><i>more&gt;&gt;</i></a></div>
    </c:if>
</div>
</body>
</html>
