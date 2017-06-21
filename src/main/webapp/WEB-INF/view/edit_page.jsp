<%@ page import="com.springmvc.db.model.ArticleModel" %>
<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  User: chuanyihuang
  Date: 2017/6/15
  Time: 11:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    ArticleModel articleModel = (ArticleModel) request.getAttribute("articleModel");
%>
<html>
<head>
    <title>编辑界面</title>
    <link rel="stylesheet" href="/css/style.css" media="screen" type="text/css"/>
    <script type="text/javascript" src="<%=basePath%>js/jquery-3.2.1.min.js"></script>
    <script src="/ckeditor/ckeditor.js"></script>
    <script src="/ckeditor/config.js"></script>
    <script src="/ckfinder/ckfinder.js"></script>

    <script type="text/javascript">
        var userid;
        function getCookies() {
            <%
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

            var userInfo = null;
            if (userid !== null && userid !== undefined) {
                userInfo = userInfo + "<input type='text' name='userid' value='" + userid + "' >";
                $("#userinfo").html(userInfo);
            }
        }

        function validate() {
            //JavaScript判空，如果确定
            var editor_data = CKEDITOR.instances.content.getData();
            var title = window.document.getElementsByName("title");
            var des = window.document.getElementsByName("des");
            if (editor_data === null || editor_data === ""
                || title === null || title === ""
                || des === null || des === "") {
                alert("数据为空不能提交");
            } else {
                if (confirm(editor_data) && userid !== null && userid !== undefined) {
                    document.submit.submit();
                }
            }
        }
    </script>
</head>
<body>
<div id="divCss" align="center" style="padding-top: 100px;margin-bottom: 100px">
    <form action="/article/update" method="post" accept-charset="UTF-8">
        <div id="userinfo" style="visibility: hidden" ><script type="text/javascript">getCookies()</script></div>
        <input type="text" name="id" style="visibility: hidden" value="<%=articleModel.getId()%>">
        <br>
        <h2><input type="text" name="title" placeholder="输入标题" style="padding: 15px"
                   value="<%=articleModel.getTitle()%>"></h2>
        <br>
        <h5><textarea rows="4" cols="4" name="des" placeholder="输入副标题"
                      style="padding: 15px;width: 60%"><%=articleModel.getDescribes()%></textarea></h5>
        <%--<h5><input type="text" name="des" placeholder="输入副标题" style="padding: 15px;width: 60%"></h5>--%>
        <br>
        <div>
            <textarea id="TextArea1" cols="8" rows="2" class="ckeditor"
                      name="content"><%=articleModel.getContent()%></textarea>
        </div>
        <br><br>
        <input type="submit" onclick="validate()" value="Submit">
    </form>
</div>

</body>
</html>
