<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<link rel="stylesheet" href="<%=basePath%>css/headCss.css">

<div style="background: #F6F6F6;height: 100px">
    <div style="padding-top: 25px">
        <div class="page-head">
            <li class="head-text" style="margin-left: 80px"><a href="<%=basePath%>article/showHomePage"
                                                               style="color: #555555">文章</a></li>
        </div>
        <div class="page-head-right" id="notLogin">
        </div>
        <div class="page-head-right" id="hasLogin">
        </div>
    </div>
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript">
        $.get("<%=basePath%>user/queryUserIsLogin", function (data) {
            var headHtml = "";
            if (data === "true") {

                var username;
                <%
                 Cookie[] cookies = request.getCookies();
                    if (null!=cookies){
                      for (Cookie cookie : cookies) {
                         if ("username".equals(cookie.getName())){
                %>
                username = "<%=cookie.getValue()%>";
                <%
                         }
                      }
                    }

                %>

                headHtml = headHtml
                    + " <li class='head-text'><a style='color: #555555' href='' onclick='newBlog();return false;'>写文章</a></li>"
                    + "<li class='head-text'><a href='' onclick='showMyHome();return false;' style='color: #555555'>用户：" + username + "</a></li>"
                    + "<li class='head-text'><a href='' onclick='loginOut();return false;' style='color: #555555;margin-right:30px'>退出</a></li>"
                $("#hasLogin").html(headHtml);
            } else {
                headHtml = headHtml + " <li class='head-text'><a href='' onclick='login();return false;'' style='color: #555555'>登陆</a></li>"
                    + "<li class='head-text'><a href='' onclick='register();return false;' style='color: #555555;margin-right:30px'>注册</a></li>"
                $("#notLogin").html(headHtml);
            }
        });

        function newBlog() {
            if(userid !== null && userid !== undefined){
                window.open('<%=basePath%>/article/editPage');
            }else{
                window.location.href = "<%=basePath%>user/login?url=/article/showHomePage";
            }
        }

        function showMyHome() {
            window.location.href = "<%=basePath%>article/showMyHome";
        }

        function loginOut() {
            $.get("<%=basePath%>/user/loginOut", function (data, status) {
                if(data === "success"){
                    window.location.reload();
                }
            });
        }

        function login() {
            window.location.href = "<%=basePath%>user/login?url=/article/showHomePage";
        }

        function register() {
            window.location.href = "<%=basePath%>user/register?url=/article/showHomePage";
        }

        //        $(function () {
        //            $.ajax({
        //                type: "GET",
        //                url: "user/queryUserIsLogin",
        //                dataType: "json",
        //                success: function (msg) {
        //                    var headHtml = "";
        //                    alert("msg:" + msg);
        //                    if (msg) {
        //                        headHtml = headHtml
        //                            + " <li class='head-text'><a style='color: #555555' href='article/editPage'>写文章</a></li>"
        //                            + "<li class='head-text'><a href='user/showMyHome' style='color: #555555'>我的</a></li>"
        //                            + "<li class='head-text'><a href='user/loginOut' style='color: #555555;margin-right:280px'>退出</a></li>"
        //                        $("#hasLogin").html(headHtml);
        //                    } else {
        //                        headHtml = headHtml + " <li class='head-text'><a href='user/login' style='color: #555555'>登陆</a></li>"
        //                            + "<li class='head-text'><a href='user/register' style='color: #555555;margin-right:280px'>注册</a></li>"
        //                        $("#notLogin").html(headHtml);
        //                    }
        //                }
        //            });
        //        });
    </script>
</div>