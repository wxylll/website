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
            <label class="layui-form-label">标题</label>
            <div class="layui-input-block">
                <input style="width: 268px" type="text"  lay-verify="title" name="title"  class="layui-input" value="">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">发布时间</label>
            <div class="layui-input-inline">
                <input type="" class="layui-input" id="test5" name="releaseTime" value="">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">视频文件</label>
            <div class="layui-input-block">
                <div class="layui-upload">
                    <button type="button" class="layui-btn" id="test1"><i class="layui-icon"></i>选择视频</button>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"></label>
            <div class="layui-input-block">
                <div class="layui-upload">
                    <span style="color: red">仅支持MP4，其他格式可能无法播放</span>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"></label>
            <div class="layui-input-block">
                <div class="layui-upload">
                    <span style="color: red"></span>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"></label>
            <div class="layui-input-block">
                <div class="layui-upload">
                    <span style="color: red"></span>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"></label>
            <div class="layui-input-block">
                <div class="layui-upload">
                    <span style="color: red"></span>
                </div>
            </div>
        </div>
        <div align="center">
            <button type="button" onclick="addVideo()" class="layui-btn layui-btn-warm" style="margin-right: 50px">添加</button>
            <button type="button" onclick="quit()" class="layui-btn layui-btn-primary">取消</button>
        </div>
    </form>
</div>
</body>
<script src="<c:url value="/js/jquery-3.3.1.js"/>"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
    //日期选择控件
    layui.use('laydate', function() {
        var laydate = layui.laydate;
        laydate.render({
            elem: '#test5'
            ,type: 'datetime'
        });
    })

    layui.use('upload', function() {
        var $ = layui.jquery
            , upload = layui.upload;

        //视频上传
        var uploadInst = upload.render({
            elem: '#test1'
            ,field: 'file'
            ,auto:false
            ,accept: 'video'
            ,acceptMime: 'video/mp4'
        });
    })

    //确认添加
    function  addVideo() {
        layui.use('layer', function() {
            var inputs = document.getElementById('form1').getElementsByTagName('input')
            for (var i=0; i < inputs.length; i++){
                if (inputs[i].value.trim() == ''){
                    if (inputs[i].name != 'file') {
                        layer.alert('请先完善所有必要信息！')
                        return
                    } else {
                        layer.alert('请选择上传视频！')
                        return
                    }
                }
            }
            layer.load();
            var add_form = document.getElementById('form1')
            $.ajax({
                url: "${pageContext.request.contextPath}/adminVideoAdd.action",
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
