<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/7/29
  Time: 20:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="X-UA-Compatile" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/kindeditor/themes/default/default.css">
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
</style>
<body>
<div class="container-fluid">
    <div class="title"><span>支部介绍</span></div>
    <form id="form1" class="layui-form" style="width: 95%;" action="${pageContext.request.contextPath}/adminSetBrief.action" method="post" lay-filter="test1">
        <div class="layui-form-item">
            <div class="layui-input-block">
                <textarea id="brief" name="brief" style="width:100%;height:600px"></textarea>
            </div>
        </div>
        <div align="right">
            <button type="button" onclick="toSubmit()" class="layui-btn layui-btn-danger">更新</button>
        </div>
    </form>
</div>
<div style="display: none"><pre id="p1">${brief}</pre></div>
</body>
<script src="<c:url value="/js/jquery-3.3.1.js"/>"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/kindeditor/kindeditor-all.js"></script>
<script>
    var success = '${success}'
    var editor;
    var layer;
    layui.use('layer',function(){layer = layui.layer})
    KindEditor.ready(function(K) {
        editor = K.create('textarea[name="brief"]', {
            minHeight:'500px',
            allowFileManager : true,
            uploadJson : '${pageContext.request.contextPath}/kindeditor/jsp/upload_json.jsp',
            fileManagerJson : '${pageContext.request.contextPath}/kindeditor/jsp/file_manager_json.jsp',
            afterUpload: function(){this.sync();}, //图片上传后，将上传内容同步到textarea中
            afterBlur: function(){this.sync();},   ////失去焦点时，将上传内容同步到textarea中
        })
        K.html("#brief",document.getElementById('p1').innerHTML)
        if (success == 'success')  {
            layer.msg("更新成功")
        }
    });

    function toSubmit() {
        editor.sync()
        document.getElementById("form1").submit()
    }
</script>
</html>
