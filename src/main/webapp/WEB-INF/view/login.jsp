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
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.2.1.min.js"></script>
    <script src="<%=basePath%>js/Base64.js"></script>
    <script type="text/javascript">
        function validate() {
            //JavaScript判空，如果确定
            var account = window.document.getElementsByName("account")[0];
            var psw = window.document.getElementsByName("psw")[0];
            if (account.value === null || account.value === "") {
                alert("账号不能为空");
                return;
            } else if (psw.value === null || psw.value === "") {
                alert("密码不能为空");
                return;
            }
            var formParam = "account=" + account.value
                + "&psw=" + psw.value;
            var str = getData("<%=basePath%>user/loginRequest",formParam);
            if (str === null || str === "") {
                return;
            }
            var json = new Base64().decode(str);
            var obj = JSON.parse(json);
            var code = obj.code;
            var msg = obj.msg;
            if (code === null || code === "") {
                alert("登录失败");
            } else if (code === "1") {
                if (msg === null || msg === "") {
                    alert("登录失败");
                } else {
                    alert(msg);
                }
            } else if (code === "0") {
                if (msg === null || msg === "") {
                    alert("登录失败");
                } else {
                    var uurl = "<%=request.getAttribute("url")%>";
                    if(uurl == null || uurl == undefined){
                        location.href = "<%=basePath%>article/showHomePage"
                        return;
                    }
                    location.href = uurl;
                }
            }
        }

        function getData(url, jsonText) {
            var callbackData = "";
            $.ajax({
                type: 'post',
                url: url,
                data: jsonText,
                async: false,
                success: function (data) {
                    callbackData = data;
                },
                error: function (XMLHttpRequest, textStatus) {
                    alert("status:" + XMLHttpRequest.status + "errorMsg:" + textStatus);
                }
            });
            return callbackData;
        }
    </script>
</head>
<body>
<%--<form class="box login" action="<%=basePath%>user/loginRequest" method="post" accept-charset="UTF-8">--%>
    <div class="box login">


    <fieldset class="boxBody">
        <label>账号</label>
        <input type="text" tabindex="1" name="account" placeholder="id/phone/email" required>
        <label>密码</label>
        <input type="password" tabindex="2" name="psw" placeholder="密码" required>
    </fieldset>
    <footer>
        <label><input type="checkbox" name="keep_login" tabindex="3">保持登录</label>
        <input type="submit" class="btnLogin" value="登录" onclick="validate()" tabindex="4">
    </footer>
    </div>
<%--</form>--%>
<%--<div id="login" align="center">--%>
    <%--<h1>Login</h1>--%>
    <%--<form action="<%=basePath%>user/loginRequest" method="post" accept-charset="UTF-8">--%>
        <%--<input type="text" required="required" name="account" placeholder="id/phone/email"/>--%>
        <%--<input type="password" required="required" name="psw" placeholder="密码"/>--%>
        <%--<button class="but" type="submit" onclick="validate()">登录</button>--%>
        <%--<label style="height: 1px">--%>
        <%--<input type="text" name="url" value="<%=request.getAttribute("url")%>" style="visibility: hidden"/>--%>
        <%--</label>--%>
    <%--</form>--%>
<%--</div>--%>
</body>
</html>
