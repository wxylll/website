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
        <div class="layui-form-item">
            <label class="layui-form-label">姓名</label>
            <div class="layui-input-block">
                <input type="text"  lay-verify="title" name="name"  class="layui-input" value="">
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
                    <img id="demo1" class="layui-upload-img" width="200" height="200" src="<c:url value='/image/photo.jpg'/>">
                    <p id="demoText"></p>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label lay-verify="required" class="layui-form-label">职务</label>
            <div class="layui-input-block">
                <input type="text" name="position" lay-verify="title"  class="layui-input" value="">
            </div>
        </div>
        <div class="layui-form-item">
            <label lay-verify="required" class="layui-form-label">人生寄语</label>
            <div class="layui-input-block">
                <input type="text" name="note" lay-verify="title"  class="layui-input" value="" size="300">
            </div>
        </div>
        <div align="center">
            <button type="button" onclick="addMember()" class="layui-btn layui-btn-warm" style="margin-right: 50px">添加</button>
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
        var uploadInst = upload.render({
            elem: '#test1'
            ,field: 'photo'
            ,auto:false
            ,accept: 'images'
            ,acceptMime: 'image/*'
            , choose: function (obj) {
                obj.preview(function (index, file, result) {
                    document.getElementById('demo1').src = result;
                });
            }
        });
    })

    //确认添加
    function  addMember() {
        layui.use('layer', function() {
            var inputs = document.getElementById('form1').getElementsByTagName('input')
            for (var i=0; i < inputs.length; i++){
                if (inputs[i].value.trim() == ''){
                    if (inputs[i].name != 'photo') {
                        layer.alert('请先完善所有必要信息！')
                        return
                    } else {
                        layer.alert('请选择照片！')
                        return
                    }
                }
            }
            layer.load();
            var add_form = document.getElementById('form1')
            $.ajax({
                url: "${pageContext.request.contextPath}/adminMemberAdd.action",
                type: "POST",
                cache:false,
                data: new FormData(add_form),
                processData: false,
                contentType: false,
                success: function (data) {
                    layer.closeAll('loading');
                    if (data == 'success') {
                        layer.msg("添加成功！")
                        parent.location.reload(true)
                        quit()
                    } else {
                        layer.msg("添加失败！")
                    }
                },
                error:function () {
                    layer.closeAll('loading');
                    layer.msg("添加失败！")
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
