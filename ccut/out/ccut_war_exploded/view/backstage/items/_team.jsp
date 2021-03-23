<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/8/2
  Time: 10:50
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
    .members {
        width: 100%;
        padding-left: 10px;
        padding-right: 10px;
    }
    .members th {
        height:30px !important;
        font-size: 20px !important;
        font-weight: bold !important;
        text-align: center;
    }
    .members td {
        height: 100px;
        text-align: center;
    }
    .members td div {
        height: 100px;
        line-height: 100px;
    }
    .btn_position {
        margin-top: 30px;
        margin-right: 20px;
    }
</style>
<body>
<div class="container-fluid">
    <div class="title"><span>队伍管理</span></div>
    <div class="members">
        <table id="slides_table" class="layui-hide" lay-filter="test">
            <button class="layui-btn layui-btn-normal" onclick="memberAdd()"><i class="layui-icon">&#xe654;</i>添加</button>
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
    var data = [<c:forEach items="${teamMembers}" var="teamMember">
        {'id':'${teamMember.id}','name':'${teamMember.name}','photo':'${teamMember.photo}'},
        </c:forEach>]

    layui.use('table', function(){
        var table = layui.table;
        //渲染轮播表格
        table.render({
            elem: '#slides_table'
            ,data: data
            ,cols: [[ //表头
                {field: 'name',title:'姓名',unresize:true}
                ,{title:'photo',title:'照片',unresize:true, templet:function(d) {
                        return "<div align='center style='width:100%'><img id='img"+ d.id +"' style='width:100px;height:100px;max-width:200px;display:inline-block;' src='${pageContext.request.contextPath}/upload/photos/" + d.photo + "?date=<%=new Date().getTime()%>' /></div>"
                    }}
                ,{title:'操作',unresize:true, templet:function(d) {
                        return "<button class='layui-btn btn_position' onclick='staffAlter("+ d.id + ",\"" + d.photo +"\",\""+ d.name +"\")'>编辑</button>" +
                            "<button onclick='deleteStaff(" + d.id + ")' class='layui-btn layui-btn-danger btn_position'>删除</button>"
                    }}
            ]]
        });
    })

    //添加成员
    function memberAdd() {
        layer.open({
            title:'添加成员',
            type: 2,
            offset:100,
            area: ['390px', '440px'],
            fixed: false, //不固定
            maxmin: true,
            content: ['${pageContext.request.contextPath}/view/backstage/items/_team_add.jsp','no']
        })
    }

    function staffAlter(id, photo, name) {
        layer.open({
            title:'成员信息',
            type: 2,
            offset:100,
            area: ['390px', '440px'],
            fixed: false, //不固定
            maxmin: true,
            content: ['${pageContext.request.contextPath}/view/backstage/items/_team_alter.jsp?id=' + id + "&photo=" + photo + "&name=" + name,'no']
        })
    }

    function deleteStaff(id) {
        layer.confirm('确定要删除此成员？',
            {offset:300},
            function(index){
                $.ajax({
                    url:'${pageContext.request.contextPath}/adminTeamMemberDelete.action?id=' + id,
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

    function updateImg(id, data) {
        document.getElementById('img'+ id).src = data
    }
</script>
</html>
