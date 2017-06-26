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

    <link rel="stylesheet" href="<%=basePath%>css/style.css" media="screen" type="text/css"/>

    <script type="text/javascript" src="<%=basePath%>js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/Base64.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/CookieUtils.js"></script>
    <script type="text/javascript">
        var userName;
        var userid;
        function getCookies() {
            <%
           Cookie cookie = null;
           Cookie[] cookies = null;
       // 获取cookies的数据,是一个数组数据。
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

            var  headDiv = null;
            if (userid === null || userid === undefined) {
                headDiv = "<table style=\"text-space: 10px\">"
                    + "<tr align=\"center\">"
                    + " <td>"
                    + "  <a href=\"<%=basePath%>user/login?url=/article/showHomePage\">登录</a>"
                    + "</td>"
                    + "<td>"
                    + "<a href=\"<%=basePath%>user/register?url=/article/showHomePage\">注册</a>"
                    + "</td>"
                    + "</tr>"
                    + "</table>";
            }else{
                headDiv = "<a href=\"<%=basePath%>user/login\">当前登录用户：" + userName + "</a>"
                    + "    <a href='' onclick='loginOut();return false'>退出登录</a>";
            }
            $("#head").html(headDiv);
        }

        function loginOut() {
            $.get("/user/loginOut", function (data, status) {
                if(data === "success"){
                    window.location.href = "<%=basePath%>article/showHomePage";
                }
            });
        }
        function newBlog() {
            if(userid !== null || userid !== undefined){
                window.open('/article/editPage');
            }else{
                window.location.href = "<%=basePath%>user/login?url=/article/showHomePage"
            }
        }

        function getPageCount() {
            getCookies();
            $.get("/article/getArticleListByUserid?userid=" + userid, function (data, status) {
                setTop(data);
            });
        }

        function setTop(data) {
            var json = new Base64().decode(data)
            var list = eval("(" + json + ")");
            var ulCss = "";
            for (var i = 0; i < list.length; i++) {
                ulCss += "<li>";
                ulCss += "<p id='title' onclick='toDetails(" + list[i].id + ") '>" + list[i].title + "</p>";
                ulCss += "<p id='des'  onclick='toDetails(" + list[i].id + ")'>" + list[i].describes + "</p>";
                ulCss += "<p></p>";
                ulCss += "<p id='userAndTime'>作者:" + list[i].username + " | 创建时间:" + list[i].create_time + "</p>";
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
    <div style="padding-top: 40px;padding-left: 20px;float: left" id="head">
    </div>
    <h2 style="padding-top: 80px">我的BLOG</h2>
    <h6><a href="" onclick="newBlog()">新建博客</a></h6>
    <ul id="ulCss">
    </ul>
    <p style="margin-top: 100px">
</div>

</body>
</html>
