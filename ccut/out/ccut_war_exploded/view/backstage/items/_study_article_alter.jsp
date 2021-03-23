<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        <input type="hidden" name="id" value="${article.id}">
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
            <label class="layui-form-label">附件</label>
            <div class="layui-input-inline" style="width:auto">
                <div class="layui-upload">
                    <button type="button" class="layui-btn layui-btn-normal" onclick="addFile()">添加附件</button>
                    <div class="layui-upload-list">
                        <table class="layui-table">
                            <thead>
                            <tr><th>文件名</th>
                                <th>大小</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr></thead>
                            <tbody id="fileList">
                                <c:forEach items="${article.attachments}" var="attachment">
                                    <tr>
                                        <td>${fn:substring(attachment, 32, fn:length(attachment))}</td>
                                        <td>---</td>
                                        <td><span style="color: #5FB878;">已上传</span></td>
                                        <td><button type="button" value="${attachment}" class="layui-btn layui-btn-xs layui-btn-danger demo-delete" onclick="removeFile(this)">删除</button></td>
                                   </tr>
                                </c:forEach>
                            </tbody>
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
            <button id="submit_btn" type="button" onclick="toSubmit()" class="layui-btn layui-btn-danger">确认修改</button>
            <button type="button" onclick="quit()" class="layui-btn layui-btn-primary">取消</button>
        </div>
    </form>
    <input id="fileInput" style="display: none" type="file" name="attachment" onchange="selectFile(this)"/>
</div>
<div style="display: none"><pre id="p1">${article.content}</pre></div>
</body>
<script src="<c:url value="/js/jquery-3.3.1.js"/>"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/kindeditor/kindeditor-all.js"></script>
<script>
    var aid = '${article.id}'

    //日期选择控件
    layui.use(['laydate','layer'], function() {
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
                if (inputs[i].value.trim() == '' && inputs[i].name != 'attachment') {
                    layer.alert("请先完善各项内容，不允许空值！")
                    return
                }
            }
            layer.load();
            $.ajax({
                type:'POST',
                url:'${pageContext.request.contextPath}/studyAlter.action',
                data: $('#form1').serialize(),
                success:function (data) {
                    layer.closeAll('loading');
                    layer.msg('修改成功！')
                    parent.location.reload(true)
                    quit()
                },
                error:function () {
                    layer.closeAll('loading');
                    layer.msg('修改失败！')
                }
            })
        })
    }

    var selected = [<c:forEach items="${article.attachments}" var="attachment">
        '${fn:substring(attachment, 32, fn:length(attachment))}',
        </c:forEach>];
    var fileInput = document.getElementById('fileInput')
    function addFile() {
        fileInput.click()
    }

    function selectFile(obj) {
        layui.use('layer', function() {
            if (obj.files.length > 0 && selected.indexOf(obj.files[0].name) == -1) {
                layer.load()
                var fileData = new FormData()
                fileData.append("attachment", obj.files[0])

                $.ajax({
                    type: 'post',
                    url: '${pageContext.request.contextPath}/adminAttachmentAlter.action?aid=${article.id}',
                    data: fileData,
                    cache:false,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                        if (data != null) {
                            layer.closeAll('loading');
                            layer.msg('上传成功！')
                            var tr = '<tr>'
                                + '<td>' + obj.files[0].name + '</td>'
                                + '<td>' + (obj.files[0].size / 1014).toFixed(1) + 'kb</td>'
                                + '<td><span style="color: #5FB878;">上传成功</span></td>'
                                + '<td>'
                                + '<button type="button" value="'+ data + obj.files[0].name +'" class="layui-btn layui-btn-xs layui-btn-danger demo-delete" onclick="removeFile(this)">删除</button>'
                                + '</td>'
                                + '</tr>';
                            document.getElementById('fileList').innerHTML += tr;
                            selected.push(obj.files[0].name)
                        } else {
                            layer.msg('上传失败!', {icon: 2,anim: 6});
                        }
                    },
                    error: function () {
                        layer.closeAll('loading');
                        layer.msg('上传失败!', {icon: 2,anim: 6});
                    }
                })
            }
        })
    }

    function removeFile(obj) {
        layer.load()
        $.ajax({
            type: 'get',
            url: '${pageContext.request.contextPath}/adminAttachmentDelete.action?aid='+ aid +'&attachment=' + obj.value,
            success:function () {
                layer.closeAll('loading');
                parent.layer.msg('删除成功！')
                obj.parentNode.parentNode.remove()
                var fileName = obj.value.substring(32)
                for (var i=0; i < selected.length; i++) {
                    if (selected[i] == fileName) {
                        selected.splice(i,1)
                    }
                }
            },
            error:function () {
                layer.closeAll('loading');
                layer.msg('删除失败！')
            }
        })
    }

</script>
</html>
