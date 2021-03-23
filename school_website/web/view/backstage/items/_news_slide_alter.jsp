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
            <label class="layui-form-label">序号</label>
            <div class="layui-input-block">
                <input type="text"  lay-verify="title" name="sid"  class="layui-input" value="<%=request.getParameter("sid")%>" readonly="readonly">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">轮播图</label>
            <div class="layui-input-block">
                <div class="layui-upload">
                    <button type="button" class="layui-btn" id="test1"><i class="layui-icon"></i>上传图片</button>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">缩略图</label>
            <div class="layui-input-block">
                <div class="layui-upload-list">
                    <img id="demo1" class="layui-upload-img" width="400" height="200" src="<c:url value='<%="/upload/slides/s"+request.getParameter("sid")+".jpg"%>'/>?date=<%=new Date().getTime()%>">
                    <p id="demoText"></p>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label lay-verify="required" class="layui-form-label">文章ID</label>
            <div class="layui-input-block">
                <input type="text" name="aid" lay-verify="title"  class="layui-input"
                       value="<%= !request.getParameter("aid").equals("undefined") ? request.getParameter("aid") : "" %>"
                       placeholder="<%= request.getParameter("aid").equals("undefined") ? "未设置" : "" %>">
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
    var id = <%=request.getParameter("sid")%>
    layui.use('upload', function() {
        var $ = layui.jquery
            , upload = layui.upload;

        //普通图片上传
        var img; //保存选中图片（base64）
        var uploadInst = upload.render({
            elem: '#test1'
            , url: '${pageContext.request.contextPath}/adminUploadSlide.action?id=' + '<%=request.getParameter("sid")%>'
            ,field: 'slide'
            ,accept: 'images'
            ,acceptMime: 'image/jpg'
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
                parent.updateImg(id, img)
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

    //确认设置
    function  alter() {
        layui.use('layer', function() {
            var inputs = document.getElementById('form1').getElementsByTagName('input')
            for (var i=0; i < inputs.length; i++){
                if (inputs[i].value.trim() == '' && inputs[i].name != 'slide'){
                    layer.alert('请先完善所有必要信息！')
                    return
                }
            }
            layer.load();
            $.ajax({
                url: "${pageContext.request.contextPath}/adminSetSlide.action",
                type: "POST",
                data: $("#form1").serialize(),
                success: function (data) {
                    layer.closeAll('loading');
                    if (data == 'success') {
                        layer.msg("设置成功！")
                        parent.location.reload(true)
                        quit()
                    } else {
                        layer.msg("设置失败！" + data)
                    }
                },
                error:function () {
                    layer.closeAll('loading');
                    layer.msg("设置失败！")
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
