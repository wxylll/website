<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/7/24
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="X-UA-Compatile" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <link href="<c:url value="/css/bootstrap.css"/>" rel="stylesheet"/>
    <title>网络工程党支部-${title}</title>
</head>
<style>
    .content {
        width: 100%;
        min-height:100%;
        height: auto;
        border-radius: 10px;
        border: 2px #c30 solid;
        padding: 10px;
        border-top: 20px #c30 solid;
    }
</style>
<body>
    <div class="container">
        <div class="content">
            <strong style="font-size: 16px;">${title} &gt;&gt;</strong>
            <hr style="background-color: gray;height: 2px;border: none;opacity: .5;margin-top: 5px"/>
            <div align="center"><table id="link_table" class="layui-hide" lay-filter="test"></table></div>
        </div>
    </div>
</body>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
<script>
    var data = [<c:forEach items="${articles}" var="article">
        {"title":"${article.title}",
            "date":"<fmt:formatDate value="${article.releaseTime}" pattern="yyyy-MM-dd"/>",
            "id":"${article.id}"},
        </c:forEach>]
    layui.use('table', function(){
        var table = layui.table;


        //第一个实例
        table.render({
            elem: '#link_table'
            ,data: data
            ,page:{layout: [ 'count', 'prev', 'page', 'next', 'skip'],limit:21}
            ,cols: [[ //表头
                {field: 'title',unresize:true,templet:function(d) {
                        return "<a href='${pageContext.request.contextPath}/getNews.action?id=" +  d.id +  "'>" + d.title + "</a>"
                    }}
                ,{field: 'date',unresize:true}
            ]]
        });
    });

</script>
</html>
