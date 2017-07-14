<%--
  Created by IntelliJ IDEA.
  User: v-chuanyihuang
  Date: 2017/7/4
  Time: 16:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <title>关于作者</title>
    <link rel="stylesheet" href="../static_hcy/css/about_me.css">
</head>
<body>
<div class="box">
    <p>作者：hcy</p>
    <a href="https://github.com/huchyi">点击去作者GitHub</a>
    <p style="margin-top: 100px">
    欢迎大家留言并提意见，有问题请在Issues中反馈。
</div>
</body>
</html>
