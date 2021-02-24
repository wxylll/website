<%@ page import="java.util.Date" %>
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
    .slides {
        width: 100%;
        padding-left: 10px;
        padding-right: 10px;
    }
    .slides th {
        height:30px !important;
        font-size: 20px !important;
        font-weight: bold !important;
        text-align: center;
    }
    .slides td {
        height: 100px;
        text-align: center;
    }
    .slides td div {
        height: 100px;
        line-height: 100px;
    }
    .btn_position {
        margin-top: 30px;
        margin-right: 20px;
    }
    .status {
        border-radius: 5px;
        padding: 5px;
        color: white;
        background-color: #d58512;
    }
</style>
<body>
 <div class="container-fluid">
     <div class="title"><span>轮播管理</span></div>
     <div class="slides">
         <table id="slides_table" class="layui-hide" lay-filter="test"></table>
     </div>
     <div class="title"><span>动态管理</span></div>
     <div class="articles">
         <table id="article_table" class="layui-hide" lay-filter="test">
             <button class="layui-btn layui-btn-normal" style="float: right" onclick="newsAdd()"><i class="layui-icon">&#xe654;</i>添加</button>
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
    var data = [{'id':'1','title':'---','status':'0','aid':''}
                ,{'id':'2','title':'---','status':'0','aid':''}
                ,{'id':'3','title':'---','status':'0','aid':''}
                ,{'id':'4','title':'---','status':'0','aid':''}]
    var slides = [<c:forEach items="${slides}" var="slide">
        [${slide.id},'${slide.article.title}','${slide.article.id}'],
    </c:forEach>]
    var news = [<c:forEach items="${news}" var="news">
            {'id':'${news.id}', 'title':'${news.title}', 'releaseTime':'<fmt:formatDate value="${news.releaseTime}" pattern="yyyy-MM-dd HH:mm:ss"/>'},
        </c:forEach> ]

    //渲染表格
    var article_table;
    layui.use('table', function(){
        var table = layui.table;

        //读取轮播数据
        for (var i=0; i < slides.length; i++) {
            data[(slides[i][0] - 1)]['title'] = slides[i][1]
            data[(slides[i][0] - 1)]['status'] = '1'
            data[(slides[i][0] - 1)]['aid'] = slides[i][2]
        }

        //渲染轮播表格
        table.render({
            elem: '#slides_table'
            ,data: data
            ,cols: [[ //表头
                {field: 'id',title:'序号',unresize:true}
                ,{title:'缩略图',unresize:true, templet:function(d) {
                    return "<div align='center style='width:100%'><img id='img"+ d.id +"' style='width:200px;height:100px;max-width:200px;display:inline-block;' src='${pageContext.request.contextPath}/upload/slides/s" + d.id + ".jpg?date=<%=new Date().getTime()%>' /><div>"
                    }}
                ,{field: 'title',title:'标题',unresize:true}
                ,{field: 'status',title:'状态',unresize:true, templet:function(d) {
                    return d.status == '1' ? "<span class='status' style='background-color: green'>展示中</span>" : "<span class='status'>未设置</span>"
                    }}
                ,{title:'操作',unresize:true, templet:function(d) {
                    return "<button class='layui-btn btn_position' onclick='slideAlter("+ d.id + "," + (d.aid != "" && d.aid !="undefined" ? d.aid : "undefined")+")'>设置</button>" +
                        "<button onclick='removeSlide(" + d.id + ")' class='layui-btn layui-btn-danger btn_position'>清除</button>"
                    }}
            ]]
        });

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
                layer.confirm('确定要删除这篇新闻吗？',
                    {offset:300},
                    function(index){
                    $.ajax({
                        url:'${pageContext.request.contextPath}/adminArticleDelete.action?id=' + data.id,
                        type:'get',
                        success:function (data) {
                            if (data == 'success') {
                                layer.msg('删除成功！')
                                obj.del();
                                layer.close(index);
                            } else
                                layer.msg('删除失败，该新闻被设为轮播内容！', {icon: 2,anim: 6})
                        },
                        error:function () {
                            layer.msg('删除失败！')
                        }
                    })
                });
            } else if(obj.event === 'edit'){
                newsAlter(data.id)
            }
        });
    });

    //搜索
    function search() {
        var text = document.getElementById("search_input").value.trim()
        $.ajax({
            url:'${pageContext.request.contextPath}/adminArticleSearch.action?cid=1&title=' + text,
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

    //修改轮播信息
    function slideAlter(sid,aid) {
        layer.open({
            title:'轮播设置',
            type: 2,
            offset:100,
            area: ['700px', '530px'],
            fixed: false, //不固定
            maxmin: true,
            content: ['${pageContext.request.contextPath}/view/backstage/items/_news_slide_alter.jsp?sid='+ sid +'&aid='+ aid,'no']
        })
    }

    //清除轮播内容
    function removeSlide(id) {
        layer.confirm('确定要清除此轮播内容？',
            {offset:300},
            function(index){
                $.ajax({
                    url:'${pageContext.request.contextPath}/adminSlideDelete.action?id=' + id,
                    type:'get',
                    success:function () {
                        layer.msg('删除成功！')
                        location.reload(true)
                    },
                    error:function () {
                        layer.msg('删除失败！',{offset:300})
                    }
                })
                layer.close(index);
            });
    }

    //编辑新闻
    function newsAlter(id) {
        var index = layer.open({
            title:'编辑新闻',
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
    function newsAdd() {
        var index = layer.open({
            title:'添加新闻',
            type: 2,
            offset:0,
            area: ['100%', '100%'],
            fixed: false, //不固定
            maxmin: true,
            content: ['${pageContext.request.contextPath}/view/backstage/items/_article_add.jsp?cid=1']
        })
        layui.layer.full(index);
    }

    //更新轮播缩略图
    function updateImg(id, data) {
        document.getElementById('img'+ id).src = data
    }

</script>
</html>
