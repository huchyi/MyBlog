<%--
  Created by IntelliJ IDEA.
  Date: 2017/6/19
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>登录界面</title>
    <link rel="stylesheet" href="<%=basePath%>css/login_css.css" media="screen" type="text/css"/>
    <script type="text/javascript" src="<%=basePath%>js/CookieUtils.js"></script>
    <script type="text/javascript">
        function validate() {
            //JavaScript判空，如果确定
            var username = window.document.getElementsByName("username");
            var psw = window.document.getElementsByName("psw");
            if (username === null || username === "") {
                alert("请输入id/phone/email");
            } else if (psw === null || psw === "") {
                alert("密码不能为空");
            } else {
                document.submit.submit();
            }
        }
    </script>
</head>
<body>

<%--<div id="divCss" align="center" style="padding-top: 300px;margin-bottom: 100px">--%>
<%--<form action="<%=basePath%>user/loginRequest" method="post" accept-charset="UTF-8">--%>
<%--<input type="text" name="url" value="<%=request.getAttribute("url")%>" style="visibility: hidden">--%>
<%--<br>--%>
<%--账号：<input type="text" name="account" placeholder="id/phone/email" style="padding: 5px;width: 150px">--%>
<%--<br>--%>
<%--密码：<input type="password" name="psw" placeholder="密码" style="padding: 5px;margin-top: 20px;width: 150px">--%>
<%--<br>--%>
<%--<input type="submit" onclick="validate()" value="登录" style="margin-top: 20px">--%>
<%--</form>--%>
<%--</div>--%>
<div id="login" align="center">
    <h1>Login</h1>
    <form action="<%=basePath%>user/loginRequest" method="post" accept-charset="UTF-8">
        <input type="text" required="required" name="account" placeholder="id/phone/email"/>
        <input type="password" required="required" name="psw" placeholder="密码"/>
        <button class="but" type="submit" onclick="validate()">登录</button>
        <label style="height: 1px">
        <input type="text" name="url" value="<%=request.getAttribute("url")%>" style="visibility: hidden"/>
        </label>
    </form>
</div>
</body>
</html>
