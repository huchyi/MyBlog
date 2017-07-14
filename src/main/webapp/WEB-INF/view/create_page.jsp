<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  Date: 2017/6/15
  Time: 14:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>新建文章</title>
    <link rel="stylesheet" href="../static_hcy/css/style.css" media="screen" type="text/css"/>
    <link rel="stylesheet" href="../static_hcy/css/edit_page.css" media="screen" type="text/css"/>
    <script type="text/javascript" src="../static_hcy/js/jquery-3.2.1.min.js"></script>
    <script src="../static_hcy/ckeditor/ckeditor.js"></script>
    <script src="../static_hcy/ckeditor/config.js"></script>
    <script src="../static_hcy/ckfinder/ckfinder.js"></script>
    <script src="../static_hcy/js/Base64.js"></script>

    <script type="text/javascript">

        var userName;
        var userid;
        function getCookies() {
            <%
           Cookie cookie = null;
           Cookie[] cookies = null;
           // 获取cookies的数据,是一个数组
           cookies = request.getCookies();
          if( cookies != null ){
          for (int i = 0; i < cookies.length; i++){
             cookie = cookies[i];
             String cookieName = cookie.getName();
               if(cookieName.compareTo("username") == 0){
            %>
            userName = "<%=URLDecoder.decode(cookie.getValue(),"utf-8")%>";
            <%
             }else if(cookieName.compareTo("userid") == 0){
             %>
            userid = "<%=URLDecoder.decode(cookie.getValue(),"utf-8")%>";
            <%
                    }
                 }
              }
              %>

            var userInfo = null;
            if (userid !== null && userid !== undefined) {
                userInfo = userInfo + "<input type='text' name='username' value='" + userName + "' >";
                userInfo = userInfo + "<input type='text' name='userid' value='" + userid + "' >";
                $("#userinfo").html(userInfo);
            }
        }

        function validate() {
            var formParam;
            var username = window.document.getElementsByName("username")[0];
            var userId = window.document.getElementsByName("userid")[0];

            var div2 = document.getElementById("div2");
            var div1 = document.getElementById("div1");
            var isPrivate = div1.className = (div1.className == "close1") ? "1" : "0";

            var title = window.document.getElementsByName("title")[0];
            if (title === null || title.value === "") {
                alert("请输入标题");
                return;
            }
            var des = window.document.getElementsByName("des")[0];
            if (des === null || des.value === "") {
                alert("请输入副标题");
                return;
            }
            var editor_data = CKEDITOR.instances.content.getData();
            if (editor_data === null || editor_data === "") {
                alert("请输入内容");
                return;
            }



            var base64 = new Base64();
            formParam = "username=" + username.value
                + "&userid=" + userId.value
                + "&title=" + base64.encode(base64.encode(title.value.replace(/</g,"&lt;").replace(/>/g,"&gt;")))
                + "&des=" + base64.encode(base64.encode(des.value.replace(/</g,"&lt;").replace(/>/g,"&gt;")))
                + "&content=" + base64.encode(base64.encode(editor_data))
                + "&isPrivate=" + isPrivate;

            var str = getData("/article/insert", formParam);
            if (str === null || str === "") {
                return;
            }
            var json = new Base64().decode(str);
            var obj = JSON.parse(json);
            var code = obj.code;
            var msg = obj.msg;
            if (code === null || code === "") {
                alert("提交失败");
            } else if (code === "1") {
                if (msg === null || msg === "") {
                    alert("提交失败");
                } else {
                    alert(msg);
                }
            } else if (code === "0") {
                if (msg === null || msg === "") {
                    alert("提交失败");
                } else {
                    location.href = "/article/showDetails?id=" + msg;
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
<div id="edit_divCss" align="center">
    <jsp:include page="/template/header.jsp"/>
    <%--<form action="../article/insert" method = "post"  accept-charset="UTF-8" id="form1">--%>

    <div id="userinfo" style="visibility: hidden">
        <script type="text/javascript">getCookies()</script>
    </div>
    <input type="text" name="title" placeholder="输入标题" style="padding: 15px;font-size: 18px;color: #232323">
    <br>
    <div style="margin-top: 60px">
        <label>
    <textarea rows="4" cols="4" name="des" placeholder="输入副标题" class="des_des" id="des_des"></textarea>
        </label>
    </div>
    <br>
    <div style="margin-top: 60px">
        <label>
            <textarea id="content" cols="8" rows="2" class="ckeditor" name="content"
                      placeholder="这里是内容......"></textarea>
        </label>
    </div>
    <br><br>
    <input type="submit" onclick="validate()" value="Submit">
    <br><br>
    <div id="btn">
        <div id='div1' class='open1'>
            <div id='div2' class='open2'></div>
        </div>
        <p id='editPrivateBtn'>公开:</p>
    </div>
    <script type="text/javascript">
        var div2 = document.getElementById("div2");
        var div1 = document.getElementById("div1");
        div2.onclick = function () {
            div1.className = (div1.className == "close1") ? "open1" : "close1";
            div2.className = (div2.className == "close2") ? "open2" : "close2";
        };
    </script>
    <%--</form>--%>
</div>

</body>
</html>
