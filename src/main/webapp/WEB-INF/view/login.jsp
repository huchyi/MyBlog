<%--
  Created by IntelliJ IDEA.
  Date: 2017/6/19
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String url = request.getServerName();
    String basePath = "https://" + request.getServerName() + request.getContextPath() + "/";
    if(url != null && url.equals("localhost")){
        basePath = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
%>
<html>
<head>
    <title>登录界面</title>
    <link rel="stylesheet" href="<%=basePath%>static_hcy/css/login_css.css" media="screen" type="text/css"/>
    <script type="text/javascript" src="<%=basePath%>static_hcy/js/jquery-3.2.1.min.js"></script>
    <script src="<%=basePath%>static_hcy/js/Base64.js"></script>
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
                    var uurl = "<%=basePath + request.getAttribute("url")%>";
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
    <div class="box login">
    <fieldset class="boxBody">
        <label>账号</label>
        <input type="text" tabindex="1" name="account" placeholder="ID/手机号/邮箱" required>
        <label>密码</label>
        <input type="password" tabindex="2" name="psw" placeholder="密码" required>
    </fieldset>
    <footer>
        <label><input type="checkbox" name="keep_login" tabindex="3">保持登录</label>
        <input type="submit" class="btnLogin" value="登录" onclick="validate()" tabindex="4">
    </footer>
    </div>
</body>
</html>
