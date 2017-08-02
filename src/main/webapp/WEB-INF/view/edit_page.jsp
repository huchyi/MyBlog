<%@ page import="com.springmvc.db.model.ArticleModel" %>
<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  Date: 2017/6/15
  Time: 11:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%
    String url = request.getServerName();
    String basePath = "https://" + request.getServerName() + request.getContextPath() + "/";
    if(url != null && url.equals("localhost")){
        basePath = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
    ArticleModel articleModel = (ArticleModel) request.getAttribute("articleModel");
%>
<html>
<head>
    <title>编辑界面</title>
    <link rel="stylesheet" href="<%=basePath%>static_hcy/css/style.css" media="screen" type="text/css"/>
    <script type="text/javascript" src="<%=basePath%>static_hcy/js/jquery-3.2.1.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>static_hcy/css/edit_page.css" media="screen" type="text/css"/>
    <script src="<%=basePath%>static_hcy/ckeditor/ckeditor.js"></script>
    <script src="<%=basePath%>static_hcy/ckeditor/config.js"></script>
    <script src="<%=basePath%>static_hcy/ckfinder/ckfinder.js"></script>
    <script src="<%=basePath%>static_hcy/js/Base64.js"></script>

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
                }
               }
              }
              %>
        }


        function validate() {
            var formParam;

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
            formParam = "id=" + "<%=articleModel.getId()%>"
                + "&userid=" + userid
                + "&title=" + base64.encode(base64.encode(title.value))
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
                    alert("status:" + XMLHttpRequest.status + "，errorMsg:" + textStatus);
                }
            });
            return callbackData;
        }


        window.onload = function () {
            getCookies();
            var base64 = new Base64();
            var title = base64.decode(base64.decode("<%=articleModel.getTitle()%>"));
            title = title.replace(/&lt;/g,"<").replace(/&gt;/g,">");
            $("#title").val(title);

            var des = base64.decode(base64.decode("<%=articleModel.getDescribes()%>"));
            des = des.replace(/&lt;/g,"<").replace(/&gt;/g,">");
            $("#des_des").text(des);

            var conn1 = base64.decode(base64.decode("<%=articleModel.getContent()%>"));
            $("#content").text(conn1);


            var div2 = document.getElementById("div2");
            var div1 = document.getElementById("div1");

            var isPrivate = <%= articleModel.getIs_private()%>;
            div1.className = (isPrivate == "0") ? "open1" : "close1";
            div2.className = (isPrivate == "0") ? "open2" : "close2";
            div2.onclick = function () {
                div1.className = (div1.className == "close1") ? "open1" : "close1";
                div2.className = (div2.className == "close2") ? "open2" : "close2";
            };
        }
    </script>
</head>
<body>
<div id="edit_divCss" align="center">
    <jsp:include page="/template/header.jsp"/>
    <%--<form action="/article/update" method="post" accept-charset="UTF-8">--%>
    <div id="userinfo" style="visibility: hidden">
    </div>
    <br>
    <input type="text" name="title" placeholder="输入标题" style="padding: 15px;min-width: 60%;max-width: 100%" id="title">
    <br>
    <div style="margin-top: 60px">
        <label>
            <textarea rows="4" cols="8" name="des" class="des_des" id="des_des" placeholder="输入副标题"></textarea>
        </label>
    </div>
    <div style="margin-top: 60px">
        <label>
            <textarea id="content" cols="8" rows="2" class="ckeditor" name="content"></textarea>
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
    <%--</form>--%>
</div>

</body>
</html>
