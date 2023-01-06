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
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/article.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/common.css">
</head>
<body>
<!--头部导航 navigation-->
<div class="nav">
    <img src="img/12.jpg">
    <span class="title">我的博客系统</span>
    <!--用来占据中间空白位置-->
    <span class="spacer"></span>
    <a href="index.html">主页</a>
    <a href="editor.html">写博客</a>
    <!--删除用户的登陆状态，需要动态处理-->
    <a href="login.html">注销</a>
</div>
<!--正文部分-->
<div class="container">
    <!--个人信息-->
    <div class="container-left">
        <div class="card">
            <img src="img/00.jpg" alt='作者头像' class="avatar">
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
        <div class="blog-content" id="1">
            <h3>我的第一篇博客</h3>
            <div class="date">2021-12-3</div>
            <p>
                从今天起我要好好敲代码.
                Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aut recusandaeomnis natus ut! Autem aliasullam sit facilis ipsa dolore, molestiae neque aperiam in a facere dolor
                mollitia dolorum animi.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aut recusandae
                omnis natus ut! Autem aliasullam sit facilis ipsa dolore, molestiae neque aperiam in a facere dolor
                mollitia dolorum animi.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aut recusandae
                omnis natus ut! Autem aliasullam sit facilis ipsa dolore, molestiae neque aperiam in a facere dolor
                mollitia dolorum animi.
            </p>
        </div>
    </div>
</div>
</body>
</html>
