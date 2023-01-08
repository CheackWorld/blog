<%--
  Created by IntelliJ IDEA.
  User: HASEE
  Date: 2023/1/6
  Time: 14:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>博客文章</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/conmmon.css">
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="${pageContext.request.contextPath}/static/js/xadmin.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/lib/layui/layui.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/vue.js" type="text/javascript"></script>
    <!-- 引入组件库 -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
</head>
<body>
<!--头部导航 navigation-->
<div class="nav">
    <img src="${pageContext.request.contextPath}/static/images/login2.jpg">
    <span class="title">我的博客系统</span>
    <!--用来占据中间空白位置-->
    <span class="spacer"></span>
    <a href="${pageContext.request.contextPath}/index">主页</a>
    <a href="${pageContext.request.contextPath}/index">个人主页</a>
    <a href="${pageContext.request.contextPath}/addBlog">写博客</a>
    <!--删除用户的登陆状态，需要动态处理-->
    <a href="${pageContext.request.contextPath}/logout">注销</a>
</div>
<!--正文部分-->
<div class="container" id="app">
    <!--个人信息-->
    <div class="container-left">
        <div class="card">
            <img :src="url" class="layui-nav-img">
            <h3><span id="loginName"></span></h3>
            <a href="https://github.com/CheackWorld">我的github</a>
            <div class="counter">
                <span>文章</span>
                <span>分类</span>
            </div>
            <div class="counter">
                <span>2</span>
                <span>1</span>
            </div>
        </div>
    </div>
    <!--文章列表-->
    <div class="container-right">
        <%--<div class="blog-content" id="1">--%>
            <%--<h3>我的第一篇博客</h3>--%>
            <%--<div class="date">2021-12-3</div>--%>
            <%--<p>--%>
                <%--从今天起我要好好敲代码.--%>
                <%--Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aut recusandaeomnis natus ut! Autem aliasullam sit facilis ipsa dolore, molestiae neque aperiam in a facere dolor--%>
                <%--mollitia dolorum animi.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aut recusandae--%>
                <%--omnis natus ut! Autem aliasullam sit facilis ipsa dolore, molestiae neque aperiam in a facere dolor--%>
                <%--mollitia dolorum animi.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aut recusandae--%>
                <%--omnis natus ut! Autem aliasullam sit facilis ipsa dolore, molestiae neque aperiam in a facere dolor--%>
                <%--mollitia dolorum animi.--%>
            <%--</p>--%>
        <%--</div>--%>
    </div>
</div>
<script>
    new Vue({
        el:"#app",
        data:{
            url:""

        },
        methods:{

        },
        mounted(){
            this.url =  localStorage.getItem("loginUserHeadPic");
            $("#loginName").html(localStorage.getItem("loginUserName"));
        }
    })
</script>
</body>
</html>
