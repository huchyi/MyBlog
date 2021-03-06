<%--
  Created by IntelliJ IDEA.
  Date: 2017/6/19
  Time: 15:09
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
    <title>注册</title>
    <link rel="stylesheet" href="<%=basePath%>static_hcy/css/register_css.css" media="screen" type="text/css"/>
    <script type="text/javascript" src="<%=basePath%>static_hcy/js/jquery-3.2.1.min.js"></script>
    <script src="<%=basePath%>static_hcy/js/Base64.js"></script>
    <script type="text/javascript">
        function validate() {
            //JavaScript判空，如果确定
            var username = window.document.getElementsByName("username")[0];
            var phone = window.document.getElementsByName("phone")[0];
            var email = window.document.getElementsByName("email")[0];
            var psw = window.document.getElementsByName("psw")[0];
            var psw2 = window.document.getElementsByName("psw2")[0];
             if (username.value === null || username.value === "") {
                alert("昵称不能为空");
                return;
            } else if (phone.value === null || phone.value === "") {
                alert("请输入手机号");
                 return;
            } else if (psw.value === null || psw.value === "") {
                alert("密码不能为空");
                 return;
            }  else if (psw2.value === null || psw2.value === "") {
                alert("请再次输入确认密码");
                 return;
            } else if (psw.value !== psw2.value) {
                alert("2次输入的密码不一致");
                 return;
            }
            var formParam = "username=" + username.value
                + "&phone=" + phone.value
                + "&email=" + email.value
                + "&psw=" + psw.value;
            var str = getData("<%=basePath%>user/registerRequest",formParam);
            if (str === null || str === "") {
                return;
            }
            var json = new Base64().decode(str);
            var obj = JSON.parse(json);
            var code = obj.code;
            var msg = obj.msg;
            if (code === null || code === "") {
                alert("注册失败");
            } else if (code === "1") {
                if (msg === null || msg === "") {
                    alert("注册失败");
                } else {
                    alert(msg);
                }
            } else if (code === "0") {
                if (msg === null || msg === "") {
                    alert("注册失败");
                } else {
                    var uurl = "<%=basePath%><%=request.getAttribute("url")%>";
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
                    alert("status:" + XMLHttpRequest.status + "，errorMsg:" + textStatus);
                }
            });
            return callbackData;
        }
    </script>
</head>
<body>
    <div class="box login">
    <fieldset class="boxBody">
        <label>
            昵称： <font style="color: #ff4444">*</font>
        </label>
            <input type="text" name="username" placeholder="昵称" maxlength="10" required>
        <label>
            手机号： <font style="color: #ff4444">*</font>
        </label>
        <input type="text" name="phone" placeholder="phone" maxlength="11" required>
        <label>
            邮箱：
        </label>
        <input type="text" name="email" placeholder="email" maxlength="60">
        <label>
            密码： <font style="color: #ff4444">*</font>
        </label>
        <input type="password"  name="psw" placeholder="密码" maxlength="20" required>
        <label>
            确认密码： <font style="color: #ff4444">*</font>
        </label>
        <input type="password" name="psw2" placeholder="确认密码" maxlength="20" required>
    </fieldset>
    <footer>
        <label onclick="window.history.go(-1)">返回</label>
        <input type="submit" class="btnLogin" value="注册" onclick="validate()" tabindex="4">
    </footer>
    </div>

</body>
</html>
