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
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    ArticleModel articleModel = (ArticleModel) request.getAttribute("articleModel");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>文章详情</title>
    <link rel="stylesheet" href="<%=basePath%>/css/details_styles.css" media="screen" type="text/css"/>
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/Base64.js"></script>
    <%--<script type="text/javascript" src="<%=basePath%>js/highlight.pack.js"></script>--%>
    <link href="http://cdn.bootcss.com/highlight.js/8.0/styles/monokai_sublime.min.css" rel="stylesheet">
    <script src="http://cdn.bootcss.com/highlight.js/8.0/highlight.min.js"></script>
    <script>hljs.initHighlightingOnLoad();</script>
    <script type="application/javascript">
        function toEdit() {
            window.location.href = "/article/editPage?id=" + <%= articleModel.getId()%>;
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

            if (userid !== null && userid !== undefined) {
                var editStr;
                editStr = "<div align='left'>当前登录用户：" + userName;
                var userid2 = <%=articleModel.getUserid()%>;
                if (userid2 !== undefined && userid == userid2) {
                    editStr = editStr + "<br/><p id='editText' onclick=\"toEdit()\">编辑</p><br/><br/>";
                    editStr = editStr + "<div><div id='div1' class='open1'><div id='div2' class='open2'></div></div><p id='editPrivateBtn'>公开:</p></div>"
                }
                editStr = editStr + "</div>";
                $("#edit").html(editStr);


                var div2 = document.getElementById("div2");
                var div1 = document.getElementById("div1");

                var isPrivate = <%= articleModel.getIs_private()%>;
                div1.className = (isPrivate == "0") ? "open1" : "close1";
                div2.className = (isPrivate == "0") ? "open2" : "close2";
                div2.onclick = function () {
                    changeIsPrivate((div2.className == "close2")?"0":"1",userid2,div1,div2);
                };
            }
        }


        function changeIsPrivate(isPrivate,userid,div1,div2) {

            var param = "{\"isPrivate\":\""+isPrivate+"\"," +
                "\"userid\":\""+userid+"\"," +
                "\"id\":\"<%=articleModel.getId()%>\"," +
            "}";
            param = new Base64().encode(param);

            $.get("/article/updatePrivate?param=" + param, function (data, status) {
//                alert("update:" + data);
                if(data === "success"){
                    div1.className = (div1.className == "close1") ? "open1" : "close1";
                    div2.className = (div2.className == "close2") ? "open2" : "close2";
                }else{
                    alert("设置失败，status：" + status);
                }
            });
        }

        //
        //        window.onload=function(){
        //            var div2=document.getElementById("div2");
        //            var div1=document.getElementById("div1");
        //            div2.onclick=function(){
        //                div1.className=(div1.className=="close1")?"open1":"close1";
        //                div2.className=(div2.className=="close2")?"open2":"close2";
        //            }
        //        }
    </script>
</head>
<body style="background: #e6e6e6;">
<div id="divCss">
    <div id="edit">
        <script type="application/javascript">
            getCookies();
        </script>
    </div>

    <div style="background: #fefefe;margin-top: 30px">
        <p id="title"><%= articleModel.getTitle()%>
        </p>
        <p style="margin-top: 30px">
        <p id="des">
        <pre id="preCss"><%= articleModel.getDescribes()%>
        </pre>
        </p>
        <p style="margin-top: 100px">
            <%= articleModel.getContent()%>
        </p>
    </div>

    <div id="bottom">
        <p>作者：<%= articleModel.getUsername()%>  | 创建时间：<%= articleModel.getCreate_time()%>
        </p>
    </div>
</div>
</body>
</html>
