<%@ page import="com.springmvc.db.model.ArticleModel" %>
<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  Date: 2017/6/15
  Time: 11:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    ArticleModel articleModel = (ArticleModel) request.getAttribute("articleModel");
%>
<html>
<head>
    <title>编辑界面</title>
    <link rel="stylesheet" href="<%=basePath%>css/style.css" media="screen" type="text/css"/>
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.2.1.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/edit_page.css" media="screen" type="text/css"/>
    <script src="<%=basePath%>ckeditor/ckeditor.js"></script>
    <script src="<%=basePath%>ckeditor/config.js"></script>
    <script src="<%=basePath%>ckfinder/ckfinder.js"></script>
    <script src="<%=basePath%>js/Base64.js"></script>

    <script type="text/javascript">
        var userid;
        function getCookies() {
            <%
            String psw = null;
           Cookie cookie = null;
           Cookie[] cookies = null;
           // 获取cookies的数据,是一个数组
           cookies = request.getCookies();
          if( cookies != null ){
          for (int i = 0; i < cookies.length; i++){
             cookie = cookies[i];
             String cookieName = cookie.getName();
               if(cookieName.compareTo("userid") == 0){
             %>
            userid = "<%=URLDecoder.decode(cookie.getValue(),"utf-8")%>";
            <%
                    }else if(cookieName.compareTo("psw") == 0){
                   psw = URLDecoder.decode(cookie.getValue(),"utf-8");
                    }
                 }
              }
              %>

            var userInfo = null;
            if (userid !== null && userid !== undefined) {
                userInfo = userInfo + "<input type='text' name='userid' value='" + userid + "'>";
                $("#userinfo").html(userInfo);
            }
        }


        function validate() {
            var formParam;
            var userId = window.document.getElementsByName("userid")[0];
            var id = window.document.getElementsByName("id")[0];

            var div1 = document.getElementById("div1");
            var isPrivate = (div1.className == "close1") ? "1" : "0";

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
            formParam = "id=" + id.value
                + "&userid=" + userId.value
                + "&title=" + title.value
                + "&des=" + base64.encode(base64.encode(des.value))
                + "&content=" + base64.encode(base64.encode(editor_data))
                + "&isPrivate=" + isPrivate;

            var str = getData("<%=basePath%>article/update", formParam);
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
                    location.href = "<%=basePath%>article/showDetails?id=" + msg;
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
    <%--<form action="/article/update" method="post" accept-charset="UTF-8">--%>
    <div id="userinfo" style="visibility: hidden">
        <script type="text/javascript">getCookies()</script>
    </div>

    <label>
        <%--<input type="text" name="psw" style="visibility: hidden" value="<%=psw%>">--%>
        <input type="text" name="id" style="visibility: hidden" value="<%=articleModel.getId()%>">
    </label>
    <br>
    <h2><input type="text" name="title" placeholder="输入标题" style="padding: 15px"
               value="<%=articleModel.getTitle()%>"></h2>
    <br>
    <h5><textarea rows="4" cols="4" name="des" placeholder="输入副标题" id="des" style="padding: 15px;width: 60%">
         <script type="application/javascript">
                    var base64 = new Base64();
                    var conn = base64.decode(base64.decode("<%=articleModel.getDescribes()%>"))
                    $("#preCss").html(conn);
                </script>
    </textarea></h5>
    <%--<h5><input type="text" name="des" placeholder="输入副标题" style="padding: 15px;width: 60%"></h5>--%>
    <br>
    <div>
        <label>
            <textarea id="content" cols="8" rows="2" class="ckeditor" name="content">
                  <script type="application/javascript">
                    var base64 = new Base64();
                    var conn = base64.decode(base64.decode("<%=articleModel.getContent()%>"))
                    $("#content").html(conn);
                </script></textarea>
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

        var isPrivate = <%= articleModel.getIs_private()%>;
        div1.className = (isPrivate == "0") ? "open1" : "close1";
        div2.className = (isPrivate == "0") ? "open2" : "close2";
        div2.onclick = function () {
            div1.className = (div1.className == "close1") ? "open1" : "close1";
            div2.className = (div2.className == "close2") ? "open2" : "close2";
        };
    </script>
    <%--</form>--%>
</div>

</body>
</html>
