<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: zh
  Date: 2019/7/26
  Time: 14:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>网络工程党支部-后台登录</title>
    <link href="<c:url value="/css/bootstrap.css"/>" rel="stylesheet"/>
</head>
<style>
    h1 {
        color:white;
        font-weight: bold;
    }
    button {
        color: rgba(255,255,255,.8);
        background-color: rgba(0,0,0,.6);
        border-radius: 0px 0px 3px 3px;
        height: 50px;
        border: none;
        outline: none;
        transition: all .3s;
    }
    button:hover {
        color: white;
        background-color: rgba(0,0,0,1);
    }
</style>
<body style="background: linear-gradient(to bottom, rgba(0,0,0,.01),white)">
    <div align="center" class="container" style="padding-top: 10%">
        <div style="width: 50%;padding-bottom: 0px;box-shadow: 0px 0px 15px rgba(0,0,0,1);border-radius: 3px" class="row">
            <div class="row" style="margin: 0px;background-color: #c30;border-radius: 3px 3px 0px 0px">
                <h1>网络工程党支部</h1>
                <h1>后台管理</h1>
            </div>
            <div class="row" style="margin: 0px;padding-top: 50px;background-color: white">
                <span id="msg" style="color: red;padding: 5px;display: block">${msg}</span>
                <form id="form1" class="form-horizontal" style="margin-bottom: 0px;" role="form" action="<c:url value="/login.action"/>" method="post">
                    <div style="margin-right: 0px;margin-left: 0px;padding-bottom: 20px;width: 80%" class="form-group">
                        <label for="account" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="account" name="account"
                                   placeholder="Account...">
                        </div>
                    </div>
                    <div style="margin-right: 0px;margin-left: 0px;padding-bottom: 30px;width: 80%" class="form-group">
                        <label for="password" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="Password...">
                        </div>
                    </div>
                    <div style="margin-right: 0px;margin-left: 0px;padding-bottom: 0px;margin-bottom: 0px" class="form-group">
                        <div align="center">
                            <button type="button" class="btn-block" onclick="toSubmit()">登录</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
<script src="<c:url value="/js/jquery-3.3.1.js"/>"></script>
<script src="<c:url value="/js/bootstrap.min.js"/>"></script>
<script>

    document.onkeydown = function(e){
        var ev = document.all ? window.event : e;
        if(ev.keyCode==13) {
            toSubmit();
        }
    }

    function toSubmit() {
        if (document.getElementById("account").value.trim() == "") {
            document.getElementById("msg").innerHTML = "账号不能为空！"
            return
        } else if (document.getElementById("password").value.trim() == "") {
            document.getElementById("msg").innerHTML = "密码不能为空！"
            return
        }
        document.getElementById("form1").submit()
    }
</script>
</html>
