<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<link rel="stylesheet" href="../../static_hcy/css/headCss.css">

<div style="background: #dfe3e6;height: 100px">
    <div style="padding-top: 25px">
        <div class="page-head">
            <li class="head-text" style="margin-left: 80px">
                <table>
                    <tr>
                        <td>
                            <a href="/article/showHomePage" style="color: #555555">
                                首页
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p class="head_about_me" onclick="toAbout()">关于作者</p>
                        </td>
                    </tr>
                </table>
            </li>
        </div>
        <div class="page-head-right" id="notLogin">
        </div>
        <div class="page-head-right" id="hasLogin">
        </div>
    </div>
    <script type="text/javascript" src="../../static_hcy/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript">
        $.get("/user/queryUserIsLogin", function (data) {
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
        
        function toAbout() {
            window.location.href = "/template/about_me.jsp";
        }

        function newBlog() {
          window.open('/article/editPage');
        }

        function showMyHome() {
            window.location.href = "/article/showMyHome";
        }

        function loginOut() {
            $.get("/user/loginOut", function (data, status) {
                if(data === "success"){
                    window.location.reload();
                }
            });
        }

        function login() {
            window.location.href = "/user/login?url=article/showHomePage";
        }

        function register() {
            window.location.href = "/user/register?url=article/showHomePage";
        }

    </script>
</div>