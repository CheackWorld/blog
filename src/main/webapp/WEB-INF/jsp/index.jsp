<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
    <title>博客主页</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/common.css">
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="${pageContext.request.contextPath}/static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/vue.js" type="text/javascript"></script>
    <!-- 引入组件库 -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
</head>
<body>
<!--头部导航 navigation-->
<div class="nav">
    <img src="${pageContext.request.contextPath}/static/images/login1.jpg">
    <span class="title">我的博客系统</span>
    <!--用来占据中间空白位置-->
    <span class="spacer"></span>
    <a href="index.html">主页</a>
    <a href="editor.html">写博客</a>
    <!--删除用户的登陆状态，需要动态处理-->
    <a href="login.html">注销</a>
</div>
<!--正文部分-->
<div class="container" id="app">
    <!--个人信息-->
    <div class="container-left">
        <div class="card">
            <img src="${pageContext.request.contextPath}/static/images/login2.jpg" alt='作者头像' class="avatar">
            <h3>芊芊子</h3>
            <a href="https://www.gitee.com/">我的gitee</a>
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
        <div class="blog">
            <div class="title">我的第一篇博客</div>
            <div class="date">2021-12-1</div>
            <div class="desc">
                从今天起, 我要认真敲代码. Lorem ipsum, dolor sit amet consectetur
                adipisicing elit. Cum distinctio ullam eum ut
                veroab laborum numquam tenetur est in dolorum a sint, assumenda
                adipisci similique quaerat vel.
                Facere,
                et.
            </div>
            <a href="article.html?blogId=1" class="detail">查看全文 &gt; &gt;</a>
        </div>
        <div class="blog">
            <div class="title">我的第二篇博客</div>
            <div class="date">2021-12-3</div>
            <div class="desc">
                从今天起, 我要认真敲代码. Lorem ipsum, dolor sit amet consectetur
                adipisicing elit. Cum distinctio ullam eum ut
                veroab laborum numquam tenetur est in dolorum a sint, assumenda
                adipisci similique quaerat vel.
                Facere,
                et.
            </div>
            <!--&gt是转义字符 ，他的意思是 >>-->
            <a href="article.html?blogId=2" class="detail">查看全文 &gt; &gt;</a>
        </div>
        <div class="blog">
            <div class="title">我的第三篇博客</div>
            <div class="date">2021-12-5</div>
            <div class="desc">
                从今天起, 我要认真敲代码. Lorem ipsum, dolor sit amet consectetur
                adipisicing elit. Cum distinctio ullam eum ut
                veroab laborum numquam tenetur est in dolorum a sint, assumenda
                adipisci similique quaerat vel.
                Facere,
                et.
            </div>
            <!--&gt是转义字符 ，他的意思是 >>-->
            <a href="article.html?blogId=3" class="detail">查看全文 &gt; &gt;</a>
        </div>
    </div>
</div>

<script>
    new Vue({
        el:"#app",
        data:
    })
</script>
</body>
</html>
