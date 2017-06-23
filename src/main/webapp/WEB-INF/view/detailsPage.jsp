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
    <%--<script type="text/javascript" src="<%=basePath%>js/highlight.pack.js"></script>--%>
    <link href="http://cdn.bootcss.com/highlight.js/8.0/styles/monokai_sublime.min.css" rel="stylesheet">
    <script src="http://cdn.bootcss.com/highlight.js/8.0/highlight.min.js"></script>
    <script >hljs.initHighlightingOnLoad();</script>
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
                    editStr = editStr + "<br/><h4 style=\"width:35px;color: #bae0ea;padding: 3px;border:1px solid #bae0ea;cursor:" +
                        " pointer;float: right\" onclick=\"toEdit()\">编辑</h4>";
                }
                editStr = editStr + "</div>";
                $("#edit").html(editStr);
            }
        }
    </script>
</head>
<body style="background: #e6e6e6;">
<div style="margin-left: 200px;margin-right: 200px;margin-top: -35px;min-width:600px;padding: 40px;min-height: 800px;background: #fefefe">
    <div id="edit">
        <script type="application/javascript">
            getCookies();
        </script>
    </div>

    <div style="background: #fefefe">
        <h2><%= articleModel.getTitle()%>
        </h2>
        <p style="margin-top: 30px">
        <div style="margin: 8px;padding: 8px;background: #f2f2f2">
            <h4>
                <%= articleModel.getDescribes()%>
            </h4>
        </div>
        <p style="margin-top: 100px">
        <h5 align="left"><%= articleModel.getContent()%>
        </h5>
    </div>
</div>
</body>
</html>
