<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  Date: 2017/6/20
  Time: 17:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <meta name="viewport"
          content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta HTTP-EQUIV="Cache-Control" CONTENT="must-revalidate">

    <title>我的主页</title>

    <link rel="stylesheet" href="../static_hcy/css/style.css" media="screen" type="text/css"/>

    <script type="text/javascript" src="../static_hcy/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="../static_hcy/js/Base64.js"></script>
    <script type="text/javascript" src="../static_hcy/js/CookieUtils.js"></script>
    <script type="text/javascript">

        function getPageCount() {
            $.get("/article/getArticleListByUserid", function (data, status) {
                setTop(data);
            });
        }

        function setTop(data) {
            var base64 = new Base64();
            var json = base64.decode(data)
            var list = eval("(" + json + ")");
            var ulCss = "";
            for (var i = 0; i < list.length; i++) {
                var isPrivate = list[i].is_private;
                ulCss += "<li>";
                ulCss += " <p id='title' onclick='toDetails(" + list[i].id + ") '>" + base64.decode(base64.decode(list[i].title)) + "</p>";
                ulCss += "<p id='des'  onclick='toDetails(" + list[i].id + ")'>" + base64.decode(base64.decode(list[i].describes)) + "</p><br>";
                ulCss += "<p id='userAndTime'>作者:" + list[i].username
                    + " | 创建时间:" + list[i].create_time
                    + " | " + ((isPrivate === "0") ? "公开" : "私有")
                    + "</p>";
                ulCss += "</li>";
            }
            $("#ulCss").html(ulCss);
        }

        function toDetails(id) {
            window.open("/article/showDetails?id=" + id);
        }
    </script>
</head>
<body onload="getPageCount()">
<div id="divCss">
    <jsp:include page="/template/header.jsp"/>
    <ul id="ulCss">
    </ul>
    <p style="margin-top: 100px">
</div>

</body>
</html>
