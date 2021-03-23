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
</head>
<body>
<div style="width: 100%;padding-top: 20px">
    <form id="form1" class="layui-form" style="width: 95%;" method="post" lay-filter="test1">
        <input type="hidden"  name="id"  value="${article.id}">
        <div class="layui-form-item">
            <label class="layui-form-label">标题</label>
            <div class="layui-input-block">
                <input type="text"  lay-verify="title" name="title"  class="layui-input" value="${article.title}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">发布时间</label>
            <div class="layui-input-inline">
                <input type="" class="layui-input" id="test5" name="releaseTime" value="<fmt:formatDate value='${article.releaseTime}' pattern='yyyy-MM-dd HH:mm:ss'/>">
            </div>
        </div>
        <div class="layui-form-item">
            <label lay-verify="required" class="layui-form-label">正文</label>
            <div class="layui-input-block">
                <textarea id="content" name="content" style="width:100%;height:600px"></textarea>
            </div>
        </div>
        <div align="right">
            <button type="button" onclick="toSubmit()" class="layui-btn layui-btn-danger">保存修改</button>
            <button type="button" onclick="quit()" class="layui-btn layui-btn-primary">取消</button>
        </div>
    </form>
</div>
<div style="display: none"><pre id="p1">${article.content}</pre></div>
</body>
<script src="<c:url value="/js/jquery-3.3.1.js"/>"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/kindeditor/kindeditor-all.js"></script>
<script>
    layui.use('laydate', function() {
        var laydate = layui.laydate;
        laydate.render({
            elem: '#test5'
            ,type: 'datetime'
        });
    })

    var editor;
    KindEditor.ready(function(K) {
        editor = K.create('textarea[name="content"]', {
            minHeight:'500px',
            allowFileManager : true,
            uploadJson : '${pageContext.request.contextPath}/kindeditor/jsp/upload_json.jsp',
            fileManagerJson : '${pageContext.request.contextPath}/kindeditor/jsp/file_manager_json.jsp',
            afterUpload: function(){this.sync();}, //图片上传后，将上传内容同步到textarea中
            afterBlur: function(){this.sync();},   ////失去焦点时，将上传内容同步到textarea中
        })
        K.html("#content",document.getElementById('p1').innerHTML)
    });

    function quit() {
        var index = parent.layer.getFrameIndex(window.name)
        parent.layer.close(index)
    }

    function toSubmit() {
        editor.sync()
        layui.use('layer', function() {
            if (document.getElementById('content').value.trim() == '') {
                layer.alert("不能没有正文！")
                return
            }
            var inputs = document.getElementsByTagName('input')
            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].value.trim() == '') {
                    layer.alert("请先完善各项内容，不允许空值！")
                    return
                }
            }
            $.ajax({
                type:'POST',
                url:'${pageContext.request.contextPath}/articleAlter.action',
                data:$('#form1').serialize(),
                success:function () {
                    layer.msg('修改成功！')
                    parent.location.reload(true)
                    quit()
                },
                error:function () {
                    layer.msg('修改失败！')
                }
            })
        })
    }
</script>
</html>
