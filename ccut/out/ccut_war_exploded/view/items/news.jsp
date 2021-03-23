<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/7/23
  Time: 17:13
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
<body style="padding-bottom: 20px">
    <div class="container-fluid">
        <c:if test="${!empty slides}">
            <div id="myCarousel" class="carousel slide" style="width: 100%" data-ride="carousel" data-interval="5000">
                <!-- 轮播（Carousel）指标 -->
                <ol class="carousel-indicators">
                    <c:forEach begin="0" end="${slides.size() - 1}" var="i">
                        <li data-target="#myCarousel" data-slide-to="${i}" <c:if test="${i == 0}">class="active"</c:if>></li>
                    </c:forEach>
                </ol>
                <!-- 轮播（Carousel）项目 -->
                <div class="carousel-inner">
                    <c:forEach varStatus="status" items="${slides}" var="slide">
                        <div class="item <c:if test="${status.first}">active</c:if>">
                            <a href="<c:url value="/getNews.action?id=${slide.article.id}"/>" target="_blank"><img style="height: 350px; width: 100%" src="<c:url value="/upload/slides/s${slide.id}.jpg"/>?date=<%=new Date().getTime()%>"></a>
                            <div class="carousel-caption right">
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
    <div class="container-fluid" style="padding-top: 25px">
        <strong style="font-size: 16px;">支部新闻 &gt;&gt;</strong>
        <hr style="background-color: gray;height: 2px;border: none;opacity: .5"/>
    </div>
    <div class="container-fluid">
        <ul>
            <c:forEach items="${articles}" var="article">
                <li class="link">
                    <a href="<c:url value="/getNews.action?id=${article.id}"/>" target="_blank">${article.title}</a>
                    <span style="float: right"><fmt:formatDate value="${article.releaseTime}" pattern="yyyy-MM-dd"/></span>
                </li>
            </c:forEach>
        </ul>

        <!--超出容量显示加载更多-->
        <c:if test="${not (fn:length(articles) < 10)}">
            <div style="width: 100%"><a style="float: right;margin-right: 10px;font-size: 16px" href="<c:url value="/news_showMore.action"/>" target="_blank"><i>more&gt;&gt;</i></a></div>
        </c:if>

    </div>
</body>
<script src="<c:url value="/js/jquery-3.3.1.js"/>"></script>
<script src="<c:url value="/js/bootstrap.min.js"/>"></script>
</html>
