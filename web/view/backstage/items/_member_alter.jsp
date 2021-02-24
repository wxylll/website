<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/7/29
  Time: 19:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="X-UA-Compatile" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
</head>
<body>
<div style="width: 100%;padding-top: 20px">
    <form id="form1" class="layui-form" style="width: 95%;" method="post" lay-filter="test1">
        <input type="hidden" name="id" value="${member.id}">
        <div class="layui-form-item">
            <label class="layui-form-label">姓名</label>
            <div class="layui-input-block">
                <input type="text"  lay-verify="title" name="name"  class="layui-input" value="${member.name}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">照片</label>
            <div class="layui-input-block">
                <div class="layui-upload">
                    <button type="button" class="layui-btn" id="test1"><i class="layui-icon"></i>选择图片</button>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">预览图</label>
            <div class="layui-input-block">
                <div class="layui-upload-list">
                    <img id="demo1" class="layui-upload-img" width="200" height="200" src="<c:url value='/upload/photos/${member.photo}'/>?date=<%=new Date().getTime()%>">
                    <p id="demoText"></p>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label lay-verify="required" class="layui-form-label">职务</label>
            <div class="layui-input-block">
                <input type="text" name="position" lay-verify="title"  class="layui-input" value="${member.position}">
            </div>
        </div>
        <div class="layui-form-item">
            <label lay-verify="required" class="layui-form-label">人生寄语</label>
            <div class="layui-input-block">
                <input type="text" name="note" lay-verify="title"  class="layui-input" value="${member.note}" size="300">
            </div>
        </div>
        <div align="center">
            <button type="button" onclick="alter()" class="layui-btn layui-btn-warm" style="margin-right: 50px">修改</button>
            <button type="button" onclick="quit()" class="layui-btn layui-btn-primary">取消</button>
        </div>
    </form>
</div>
</body>
<script src="<c:url value="/js/jquery-3.3.1.js"/>"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
    layui.use('upload', function() {
        var $ = layui.jquery
            , upload = layui.upload;

        //普通图片上传
        var img;
        var uploadInst = upload.render({
            elem: '#test1'
            ,url: "${pageContext.request.contextPath}/adminMemberPhotoAlter.action?id=${member.id}"
            ,field: 'newPhoto'
            ,accept: 'images'
            ,acceptMime: 'image/*'
            , before: function (obj) {
                layer.load();
                obj.preview(function (index, file, result) {
                    img = result;
                });
            }
            , done: function (res) {
                layer.closeAll('loading');
                //如果上传失败
                if (res.code > 0) {
                    return layer.msg('上传失败！');
                }
                //上传成功
                $('#demo1').attr('src', img); //图片链接（base64）
                parent.updateImg('${member.id}', img)
                return layer.msg('上传成功！');
            }
            , error: function () {
                layer.closeAll('loading');
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function () {
                    uploadInst.upload();
                });
            }
        });
    })

    //确认修改
    function  alter() {
        layui.use('layer', function() {
            var inputs = document.getElementById('form1').getElementsByTagName('input')
            for (var i=0; i < inputs.length; i++){
                if (inputs[i].value.trim() == '' && inputs[i].name != 'newPhoto'){
                    layer.alert('请先完善所有必要信息！')
                    return
                }
            }
            layer.load();
            var add_form = document.getElementById('form1')
            $.ajax({
                url: "${pageContext.request.contextPath}/adminMemberAlter.action",
                type: "POST",
                cache:false,
                data: new FormData(add_form),
                processData: false,
                contentType: false,
                success: function (data) {
                    layer.closeAll('loading');
                    if (data == 'success') {
                        layer.msg("修改成功！")
                        parent.location.reload(true)
                        quit()
                    } else {
                        layer.msg("修改失败！")
                    }
                },
                error:function () {
                    layer.closeAll('loading');
                    layer.msg("修改失败！")
                }
            })
        })
    }

    //退出当前窗口
    function quit() {
        var index = parent.layer.getFrameIndex(window.name)
        parent.layer.close(index)
    }
</script>
</html>
