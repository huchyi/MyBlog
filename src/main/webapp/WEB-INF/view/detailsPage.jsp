<%@ page import="com.springmvc.db.model.ArticleModel" %>
<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  Date: 2017/6/14
  Time: 16:26
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String url = request.getServerName();
    String basePath = "https://" + request.getServerName() + request.getContextPath() + "/";
    if(url != null && url.equals("localhost")){
        basePath = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
    ArticleModel articleModel = (ArticleModel) request.getAttribute("articleModel");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta name="viewport"
          content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>文章详情</title>
    <link rel="stylesheet" href="<%=basePath%>static_hcy/css/details_styles.css" media="screen" type="text/css"/>
    <script type="text/javascript" src="<%=basePath%>static_hcy/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>static_hcy/js/Base64.js"></script>

    <%--<link href="http://cdn.bootcss.com/highlight.js/8.0/styles/monokai_sublime.min.css" rel="stylesheet">--%>
    <%--<script src="http://cdn.bootcss.com/highlight.js/8.0/highlight.min.js"></script>--%>
    <%-- 代码高亮 --%>
    <link rel="stylesheet" href="<%=basePath%>static_hcy/css/highlight-zenburn.css" media="screen" type="text/css"/>
    <script type="text/javascript" src="<%=basePath%>static_hcy/js/highlight.js"></script>

    <%-- 图片有预览效果--%>
    <link href="<%=basePath%>static_hcy/css/lightbox.css" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>static_hcy/js/lightbox.js"></script>
    <script type="application/javascript">
        function toEdit() {
            window.location.href = "<%=basePath%>article/editPage?id=" + <%= articleModel.getId()%>;
        }


        function getCookies() {
            var userName;
            var userid;
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

            if (userid !== null && userid !== undefined && "<%=request.getAttribute("isShowEdit")%>" == "true") {
                var editStr;
                editStr = "<div>";
                editStr = editStr + "<li class='editList1'>" +
                    "<div id='div1' class='open1'><div id='div2' class='open2'>" +
                    "</div></div>" +
                    "</li>";
                editStr = editStr + "<li class='editList2'>" +
                    "<p id='editPrivateBtn'>公开:</p>" +
                    "</li>";
                editStr = editStr + "<li class='editList3'><p class='editText' onclick=\"toEdit()\">编辑</p></li>";
                editStr = editStr + "</div>";
                $("#edit").html(editStr);


                var div2 = document.getElementById("div2");
                var div1 = document.getElementById("div1");

                var isPrivate = <%= articleModel.getIs_private()%>;
                div1.className = (isPrivate == "0") ? "open1" : "close1";
                div2.className = (isPrivate == "0") ? "open2" : "close2";
                div2.onclick = function () {
                    changeIsPrivate((div2.className == "close2") ? "0" : "1", userid, div1, div2);
                };
            }
        }


        function changeIsPrivate(isPrivate, userid, div1, div2) {

            var param = "{\"isPrivate\":\"" + isPrivate + "\"," +
                "\"userid\":\"" + userid + "\"," +
                "\"id\":\"<%=articleModel.getId()%>\"," +
                "}";
            param = new Base64().encode(param);

            $.get("<%=basePath%>article/updatePrivate?param=" + param, function (data, status) {
//                alert("update:" + data);
                if (data === "success") {
                    div1.className = (div1.className == "close1") ? "open1" : "close1";
                    div2.className = (div2.className == "close2") ? "open2" : "close2";
                } else {
                    alert("设置失败，status：" + status);
                }
            });
        }


        window.onload = function () {
            var base64 = new Base64();
            var title = base64.decode(base64.decode("<%= articleModel.getTitle()%>"))
            $("#title").html(title);

            var des = base64.decode(base64.decode("<%= articleModel.getDescribes()%>"))
            $("#preCss").html(des);

            var con = base64.decode(base64.decode("<%= articleModel.getContent()%>"))
            $("#contentt").html(con);

            hljs.initHighlightingOnLoad();
            $(document).ready(function () {
                $('pre').each(function (i, e) {
                    hljs.highlightBlock(e)
                });
            });


            var imgs = document.getElementsByTagName('img');
            for (var i = 0;i<imgs.length;i++){
                imgs[i].setAttribute("data-lightbox", "imgs-" + i);
                imgs[i].setAttribute("id", "imgs-" + i);
                $("#imgs-" + i).wrapAll("<a data-lightbox='"+ "imgs-" + i +"' href='"+ imgs[i].getAttribute('src') +"'></a>");
            }

            lightbox.option({
                'resizeDuration': 200,
                'wrapAround': true,
                'maxWidth':2000
            })
        }

    </script>
</head>
<body>
<div id="divCss_detail">
    <jsp:include page="/template/header.jsp"/>
    <div id="divCss2_detail">

        <div id="edit">
            <script type="application/javascript">
                getCookies();
            </script>
        </div>

        <div style="background: #fefefe;margin-top: 30px">
            <p id="title">
            </p>
            <br style="margin-top: 30px">
            <p id="preCss">
            </p>
            <br style="margin-top: 80px">
            <p id="contentt">
            </p>
        </div>
    </div>
    <div id="bottom">
        <p>作者：<%= articleModel.getUsername()%>  | 创建时间：<%= articleModel.getCreate_time()%>
        </p>
    </div>
</div>
</body>
</html>
