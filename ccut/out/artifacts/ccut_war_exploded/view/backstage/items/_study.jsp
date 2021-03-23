<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/7/28
  Time: 16:20
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
<style>
    .title {
        width: 100%;
        height: 50px;
        line-height: 50px;
        padding-left: 20px;
        border-left: 5px #c30 solid;
        background-color: rgb(238,238,238);
        margin-top: 20px;
        margin-bottom: 20px;
    }
    .title span {
        font-size: large;
        font-weight: bold;
    }
    .articles {
        width: 100%;
        padding-left: 10px;
        padding-right: 10px;
    }
</style>
<body>
<div class="container-fluid">
    <div class="title"><span>文章管理</span></div>
    <div class="articles">
        <table id="article_table" class="layui-hide" lay-filter="test">
            <button class="layui-btn layui-btn-normal" style="float: right" onclick="articleAdd()"><i class="layui-icon">&#xe654;</i>添加</button>
            <div class="layui-inline">
                <input id="search_input" class="layui-input" name="keyword" autocomplete="off" type="text" value="">
            </div>
            <button id="search_btn" class="layui-btn" data-type="reload" onclick="search()">搜索</button>
        </table>
    </div>
</div>
</body>
<script src="<c:url value="/js/jquery-3.3.1.js"/>"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script>
    var news = [<c:forEach items="${articles}" var="article">
        {'id':'${article.id}', 'title':'${article.title}', 'releaseTime':'<fmt:formatDate value="${article.releaseTime}" pattern="yyyy-MM-dd HH:mm:ss"/>'},
        </c:forEach> ]

    //渲染表格
    var article_table;
    layui.use('table', function(){
        var table = layui.table;

        //渲染文章表格
        article_table = table.render({
            elem: '#article_table'
            ,data: news
            ,page:{layout: [ 'count', 'prev', 'page', 'next', 'skip'],limit:15}
            ,cols: [[ //表头
                {field: 'id',title:'ID',unresize:true}
                ,{field:'title',title:'标题',unresize:true}
                ,{field: 'releaseTime',title:'发布时间',unresize:true}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:150}
            ]]
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            if(obj.event === 'del'){
                layer.confirm('确定要删除这篇文章吗？',
                    {offset:300},
                    function(index){
                        $.ajax({
                            url:'${pageContext.request.contextPath}/adminStudyDelete.action?id=' + data.id,
                            type:'get',
                            success:function () {
                                layer.msg('删除成功！')
                            },
                            error:function () {
                                layer.msg('删除失败！')
                            }
                        })
                        obj.del();
                        layer.close(index);
                    });
            } else if(obj.event === 'edit'){
                articleAlter(data.id)
            }
        });
    });

    //搜索
    function search() {
        var text = document.getElementById("search_input").value.trim()
        $.ajax({
            url:'${pageContext.request.contextPath}/adminArticleSearch.action?title=' + text,
            type:'get',
            success:function (data) {
                var result = eval("(" + data + ")")
                article_table.reload({
                    data:result
                    ,page: {
                        curr: 1 //重新从第 1 页开始
                        ,count:result.length
                    }
                });
            },
            error:function () {
                layer.msg('请求错误！')
            }
        })
    }

    //搜索框绑定回车事件
    $('#search_input').bind('keyup', function(event) {
        if (event.keyCode == "13") {
            //回车执行查询
            $('#search_btn').click();
        }
    });

    //编辑文章
    function articleAlter(id) {
        var index = layer.open({
            title:'编辑文章',
            type: 2,
            offset:0,
            area: ['100%', '100%'],
            fixed: false, //不固定
            maxmin: true,
            content: ['${pageContext.request.contextPath}/adminGetArticle.action?id=' + id]
        })
        layui.layer.full(index);
    }

    //添加新闻
    function articleAdd() {
        var index = layer.open({
            title:'添加文章',
            type: 2,
            offset:0,
            area: ['100%', '100%'],
            fixed: false, //不固定
            maxmin: true,
            content: ['${pageContext.request.contextPath}/view/backstage/items/_study_article_add.jsp']
        })
        layui.layer.full(index);
    }

</script>
</html>
