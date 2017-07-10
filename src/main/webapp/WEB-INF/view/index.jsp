<%@ page import="java.net.URLDecoder" %>
<%@ taglib prefix="c" uri="http://www.springframework.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  Date: 2017/6/6
  Time: 16:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <meta name="viewport"
          content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta HTTP-EQUIV="Cache-Control" CONTENT="must-revalidate">

    <title>首页</title>

    <link rel="stylesheet" href="<%=basePath%>css/style.css" media="screen" type="text/css"/>

    <script type="text/javascript" src="<%=basePath%>js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/Base64.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/CookieUtils.js"></script>
    <script type="text/javascript">
        <%--var userName;--%>
        <%--var userid;--%>
        <%--function getCookies() {--%>
        <%--<%--%>
        <%--Cookie cookie = null;--%>
        <%--Cookie[] cookies = null;--%>
        <%--// 获取cookies的数据,是一个数组--%>
        <%--cookies = request.getCookies();--%>
        <%--if( cookies != null ){--%>
        <%--for (int i = 0; i < cookies.length; i++){--%>
        <%--cookie = cookies[i];--%>
        <%--String cookieName = cookie.getName();--%>
        <%--if(cookieName.compareTo("username") == 0){--%>
        <%--%>--%>
        <%--userName = "<%=URLDecoder.decode(cookie.getValue(),"utf-8")%>";--%>
        <%--<%--%>
        <%--}else if(cookieName.compareTo("userid") == 0){--%>
        <%--%>--%>
        <%--userid = "<%=URLDecoder.decode(cookie.getValue(),"utf-8")%>";--%>
        <%--<%--%>
        <%--}--%>
        <%--}--%>
        <%--}--%>
        <%--%>--%>

        <%--var  headDiv = null;--%>
        <%--if (userid === null || userid === undefined) {--%>
        <%--headDiv = "<table style=\"text-space: 10px\">"--%>
        <%--+ "<tr align=\"center\">"--%>
        <%--+ " <td>"--%>
        <%--+ "  <a href=\"<%=basePath%>user/login?url=/article/showHomePage\">登录</a>"--%>
        <%--+ "</td>"--%>
        <%--+ "<td>"--%>
        <%--+ "<a href=\"<%=basePath%>user/register?url=/article/showHomePage\">注册</a>"--%>
        <%--+ "</td>"--%>
        <%--+ "</tr>"--%>
        <%--+ "</table>";--%>
        <%--}else{--%>
        <%--headDiv = "<a href=\"<%=basePath%>article/showMyHome\">当前登录用户：" + userName + "</a>"--%>
        <%--+ "    <a href='' onclick='loginOut();return false'>退出登录</a>";--%>
        <%--}--%>
        <%--$("#head").html(headDiv);--%>
        <%--}--%>

        <%--function newBlog() {--%>
        <%--if(userid !== null && userid !== undefined){--%>
        <%--window.open('<%=basePath%>/article/editPage');--%>
        <%--}else{--%>
        <%--window.location.href = "<%=basePath%>user/login?url=/article/showHomePage";--%>
        <%--}--%>
        <%--}--%>

        <%--function loginOut() {--%>
        <%--$.get("/user/loginOut", function (data, status) {--%>
        <%--if(data === "success"){--%>
        <%--window.location.reload();--%>
        <%--}--%>
        <%--});--%>
        <%--}--%>

        window.onload = function() {
//            getCookies();
            $.get("<%=basePath%>article/getPageNumCount", function (data) {
                getPageData(data, 1);
            });
        }

        function getPageData(pageSize, pageNum) {
            if(pageSize > 30){
                document.getElementById("menuOut").style.visibility="visible";//隐藏
                setBottom(pageSize, pageNum);
            }
            $.get("<%=basePath%>article/getPageNumData?pageNum=" + pageNum + "&totalCount=" + pageSize, function (data) {
                setTop(data);
            });
        }

        function setTop(data) {
            var base64 = new Base64();
            var json = base64.decode(data);
            var list = eval("(" + json + ")");
            var ulCss = "";
            for (var i = 0; i < list.length; i++) {
                ulCss += "<li>";
                ulCss += "<p id='title' onclick='toDetails(" + list[i].id + ") '>" + base64.decode(base64.decode(list[i].title)) + "</p>";
                ulCss += "<p id='des'  onclick='toDetails(" + list[i].id + ")'>" + base64.decode(base64.decode(list[i].describes)) + "</p><br>";
                ulCss += "<p id='userAndTime'>作者:" + list[i].username + " | 创建时间:" + list[i].create_time
                    + "| 阅读次数：" + list[i].read_times
                    + "</p>";
                ulCss += "</li>";
            }

            $("#ulCss").html(ulCss);
        }

        function toDetails(id) {
//            alert("到详情页去");
//            $.get("/article/showDetails?id=" + id);
//            window.location.href="/article/showDetails?id=" + id;
            window.open("<%=basePath%>article/showDetails?id=" + id);
        }

        function setBottom(pageSize, pageNum) {
            var menuUL = "";
            var size = parseInt(pageSize / 10);
            var yu = size % 10;
            if (yu !== 0) {
                size = size + 1;
            }
            menuUL += "<li><a id='menuLiANor' href='' onclick=\"getPageData(" + pageSize + ",1);return false\">首页</a></li>";


            if (size < 7) {
                for (var i = 1; i <= size; i++) {
                    if (pageNum === i) {
                        menuUL += "<li><a id='menuLiASel' href='' onclick=\"getPageData(" + pageSize + "," + i + ");return false\">" + i + "</a></li>";
                    } else {
                        menuUL += "<li><a id='menuLiANor' href='' onclick=\"getPageData(" + pageSize + "," + i + ");return false\">" + i + "</a></li>";
                    }
                }
            } else {
                var head = true;
                var tail = true;
                for (i = 1; i <= size; i++) {
                    if (pageNum === i) {
                        menuUL += "<li><a id='menuLiASel' href='' onclick=\"getPageData(" + pageSize + "," + i + ");return false\">" + i + "</a></li>";
                    } else if (Math.abs(pageNum - i) < 3) {
                        menuUL += "<li><a id='menuLiANor' href='' onclick=\"getPageData(" + pageSize + "," + i + ");return false\">" + i + "</a></li>";
                    } else if (pageNum - i <= -3) {
                        if (head) {
                            head = false;
                            menuUL += "<li><a id='menuLiAEllipsis'>......</a></li>";
                        }
                    } else if (pageNum - i >= 3) {
                        if (tail) {
                            tail = false;
                            menuUL += "<li><a id='menuLiAEllipsis'>......</a></li>";
                        }
                    }
                }
            }

            menuUL += "<li><a id='menuLiANor' href='' onclick=\"getPageData(" + pageSize + "," + size + ");return false\">尾页</a></li>";
            $("#menu").html(menuUL);
        }
    </script>
</head>
<body>
<div id="divCss0">
    <jsp:include page="/template/header.jsp"/>
    <div id="divCss">
        <ul id="ulCss">
        </ul>
        <p style="margin-top: 100px">
        <div id="menuOut" style="visibility: hidden">
            <ul id="menu">
            </ul>
        </div>
    </div>
</div>
</body>
</html>
