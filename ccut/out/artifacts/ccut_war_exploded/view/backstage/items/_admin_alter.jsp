<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/8/3
  Time: 8:46
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
<body>
<div align="center" style="width: 100%;padding-top: 20px">
    <form id="form1" class="layui-form" style="width: 95%;" method="post" lay-filter="test1">
        <div class="layui-form-item">
            <label class="layui-form-label">原账号</label>
            <div class="layui-input-block">
                <input type="text"  lay-verify="title" name="oldAccount" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"  class="layui-input" value="">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">新账号</label>
            <div class="layui-input-block">
                <input type="text"  lay-verify="title" name="newAccount" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"  class="layui-input" value="">
            </div>
        </div>
        <div align="center">
            <hr style="height:1px;border:none;border-top:1px dashed gray;width: 100%;opacity: .5" />
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">原密码</label>
            <div class="layui-input-block">
                <input type="password"  lay-verify="title" name="oldPassword" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"  class="layui-input" value="">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">新密码</label>
            <div class="layui-input-block">
                <input type="password" id="pass1"  lay-verify="title" name="newPassword" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" class="layui-input" value="">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">确认新密码</label>
            <div class="layui-input-block">
                <input type="password" id="pass2" lay-verify="title" class="layui-input" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="">
            </div>
        </div>
        <div align="center">
            <button type="button" onclick="alter()" class="layui-btn layui-btn-warm" style="margin-right: 50px">修改</button>
            <button type="button" onclick="quit()" class="layui-btn layui-btn-primary">取消</button>
        </div>
    </form>
    <a id="hidden_link" style="display: none;" target="_parent" href="<c:url value="/view/backstage/login.jsp"/>"/>
</div>
</body>
<script src="<c:url value="/js/jquery-3.3.1.js"/>"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>

    function alter() {
        layui.use('layer', function() {
            var inputs = document.getElementsByTagName('input')
            var pass1 = document.getElementById('pass1')
            var pass2 = document.getElementById('pass2')
            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].value.trim() == "") {
                    layer.tips('此项为必填！', inputs[i], {
                        tips: [1, '#c30'],
                        time: 2000
                    });
                    inputs[i].focus()
                    return
                }
            }
            if (pass1.value != pass2.value) {
                layer.msg('两次输入的密码不一致!', {icon: 2,anim: 6,area: ['240px','65px']});
                pass2.focus()
                return
            }
            layer.load()
            $.ajax({
                type:'GET',
                url:'${pageContext.request.contextPath}/alterAdminAccount.action',
                data: $("#form1").serialize(),
                success: function (data) {
                    layer.closeAll('loading');
                    if (data == 'success') {
                        layer.msg("修改成功！即将跳转到登录页面！",function () {
                            document.getElementById('hidden_link').click()
                            quit()
                        })
                    } else {
                        layer.msg(data)
                    }
                },
                error:function () {
                    layer.closeAll('loading');
                    layer.msg("网络错误！修改失败！")
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
