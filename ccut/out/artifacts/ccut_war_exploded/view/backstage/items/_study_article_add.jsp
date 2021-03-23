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
<body style="padding-bottom: 30px">
<div style="width: 100%;padding-top: 20px">
    <form id="form1" class="layui-form" style="width: 95%;" method="post" lay-filter="test1">
        <div class="layui-form-item">
            <label class="layui-form-label">标题</label>
            <div class="layui-input-block">
                <input type="text"  lay-verify="title" name="title"  class="layui-input" value="">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">发布时间</label>
            <div class="layui-input-inline">
                <input type="" class="layui-input" id="test5" name="releaseTime" value="">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">附件</label>
            <div class="layui-input-inline" style="width:auto">
                <div class="layui-upload">
                    <button type="button" class="layui-btn layui-btn-normal" id="testList" onclick="addFile()">添加附件</button>
                    <div class="layui-upload-list">
                        <table class="layui-table">
                            <thead>
                            <tr><th>文件名</th>
                                <th>大小</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr></thead>
                            <tbody id="demoList"></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label lay-verify="required" class="layui-form-label">正文</label>
            <div class="layui-input-block">
                <textarea id="content" name="content" style="width:100%;height:600px"></textarea>
            </div>
        </div>
        <div align="right">
            <button id="submit_btn" type="button" onclick="toSubmit()" class="layui-btn layui-btn-danger">发布</button>
            <button type="button" onclick="quit()" class="layui-btn layui-btn-primary">取消</button>
        </div>
        <div id="inputs" style="display: none"></div>
    </form>
</div>
</body>
<script src="<c:url value="/js/jquery-3.3.1.js"/>"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/kindeditor/kindeditor-all.js"></script>
<script>

    //日期选择控件
    layui.use('laydate', function() {
        var laydate = layui.laydate;
        laydate.render({
            elem: '#test5'
            ,type: 'datetime'
        });
    })

    var selected = [];
    function addFile() {
        var fileInput = document.createElement('input')
        var id = new Date().getTime() + ""
        fileInput.setAttribute('id', id)
        fileInput.setAttribute('type', "file")
        fileInput.setAttribute('name', "attachments")
        fileInput.setAttribute('onchange', "selectFile(this)")
        document.getElementById('inputs').appendChild(fileInput)
        document.getElementById(id).click()
    }

    function selectFile(obj) {
        if (selected.indexOf(obj.files[0].name) == -1) {
            var tr = '<tr>'
                + '<td>' + obj.files[0].name + '</td>'
                + '<td>' + (obj.files[0].size / 1014).toFixed(1) + 'kb</td>'
                + '<td>等待上传</td>'
                + '<td>'
                + '<button value="'+ obj.files[0].name +'" class="layui-btn layui-btn-xs layui-btn-danger demo-delete" onclick="removeFile(this,'+ obj.id +')">删除</button>'
                + '</td>'
                + '</tr>';
            document.getElementById('demoList').innerHTML += tr;
            selected.push(obj.files[0].name)
        } else {
            obj.remove()
        }
    }

    function removeFile(obj, id) {
        obj.parentNode.parentNode.remove()
        document.getElementById(id).remove()
        var inputs = document.getElementsByName('attachments') //删除空文件输入框
        for (var i = inputs.length-1; i >= 0; i--) {
            if (inputs[i].files.length == 0) {
                inputs[i].remove()
            }
        }
        for (var i=0; i < selected.length; i++) {
            if (selected[i] == obj.value) {
                selected.splice(i,1)
            }
        }
    }

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
    });

    function quit() {
        var index = parent.layer.getFrameIndex(window.name)
        parent.layer.close(index)
    }

    function toSubmit() {
        var inputs = document.getElementsByName('attachments') //删除空文件输入框
        for (var i = inputs.length-1; i >= 0; i--) {
            if (inputs[i].files.length == 0) {
                inputs[i].remove()
            }
        }
        editor.sync()
        layui.use('layer', function() {
            if (document.getElementById('content').value.trim() == '') {
                layer.alert("不能没有正文！")
                return
            }
            var inputs = document.getElementsByTagName('input')
            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].value.trim() == '' && inputs[i].name != 'attachments') {
                    layer.alert("请先完善各项内容，不允许空值！")
                    return
                }
            }
            layer.load();
            var add_form = document.getElementById('form1')
            $.ajax({
                type:'POST',
                url:'${pageContext.request.contextPath}/studyAdd.action',
                cache:false,
                data: new FormData(add_form),
                processData: false,
                contentType: false,
                success:function (data) {
                    layer.closeAll('loading');
                    if (data == 'success')  {
                        layer.msg('添加成功！')
                        parent.location.reload(true)
                        quit()
                    } else {
                        layer.msg('添加失败！')
                    }
                },
                error:function () {
                    layer.closeAll('loading');
                    layer.msg('添加失败！')
                }
            })
        })
    }
</script>
</html>
