<%--
  Created by IntelliJ IDEA.
  Date: 2017/6/19
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <script type="text/javascript">
        function validate() {
            //JavaScript判空，如果确定
            var username = window.document.getElementsByName("username");
            var phone = window.document.getElementsByName("phone");
            var email = window.document.getElementsByName("email");
            var psw = window.document.getElementsByName("psw");
            var psw2 = window.document.getElementsByName("psw2");
             if (username === null || username === "") {
                alert("昵称不能为空");
            } else if (phone === null || phone === "") {
                alert("请输入手机号");
            } else if (psw === null || psw === "") {
                alert("密码不能为空");
            }  else if (psw2 === null || psw2 === "") {
                alert("请再次输入确认密码");
            } else if (psw.value !== psw2.value) {
                alert("2次输入的密码不一致");
            } else {
                document.submit.submit();
            }
        }
    </script>
</head>
<body>

<div id="divCss" align="center" style="padding-top: 300px;margin-bottom: 100px">
    <form action="/user/registerRequest" method="post" accept-charset="UTF-8">
        <table>
            <tr>
                <td>
                    <input type="text" name="url" value="<%=request.getAttribute("url")%>" style="visibility: hidden">
                </td>
            </tr>
            <tr>
                <td>
                    昵称：
                </td>
                <td>
                    <input type="text" name="username" placeholder="昵称" style="padding: 5px;width: 100px">
                </td>
                <td>
                    <font style="color: #ff0000">*</font>
                </td>
            </tr>
            <tr>
                <td>
                    手机号：
                </td>
                <td>
                    <input type="text" name="phone" placeholder="phone" style="padding: 5px;width: 100px">
                </td>
                <td>
                    <font style="color: #ff0000">*</font>
                </td>
            </tr>
            <tr>
                <td>
                    邮箱：
                </td>
                <td>
                    <input type="text" name="email" placeholder="email" style="padding: 5px;width: 100px">
                </td>
            </tr>
            <tr>
                <td>
                    密码：
                </td>
                <td>
                    <input type="password" required="true" name="psw" placeholder="密码" style="padding: 5px;width: 100px">
                </td>
                <td>
                    <font style="color: #ff0000">*</font>
                </td>
            </tr>
            <tr>
                <td>
                    确认密码：
                </td>
                <td>
                    <input type="password" name="psw2" placeholder="确认密码" style="padding: 5px;width: 100px">
                </td>
                <td>
                    <font style="color: #ff0000">*</font>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="submit" onclick="validate()" value="Submit">
                </td>
            </tr>
            <%--<tr>--%>
                <%--<td>--%>
                    <%--昵称：<input type="text" name="username" placeholder="昵称" style="padding: 5px;width: 100px">--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--账号：<input type="text" name="userid" placeholder="id/phone/email" style="padding: 5px;width: 100px">--%>
                <%--</td>--%>
                <%--<td>--%>
                   <%--密码： <input type="text" name="psw" placeholder="密码" style="padding: 5px;width: 100px">--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--重复密码： <input type="text" name="psw2" placeholder="重复密码" style="padding: 5px;width: 100px">--%>
                <%--</td>--%>
                <%--<td>--%>
                    <%--submit： <input type="submit" onclick="validate()" value="Submit">--%>
                <%--</td>--%>
            <%--</tr>--%>
        </table>
    </form>
</div>

</body>
</html>
