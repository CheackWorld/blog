<%--
  Created by IntelliJ IDEA.
  User: Cc
  Date: 2020/12/17
  Time: 15:03
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>后台模板</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/lib/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/lib/layui/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/vue.js"></script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin" id="app">
    <div class="layui-header">
        <div class="layui-logo">博客后台</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="${pageContext.request.contextPath}/static/images/login1.jpg" target="right">
                    <img :src="url" class="layui-nav-img">
                    {{loginUsername}}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="" target="right">基本资料</a></dd>
                    <dd><a href="" target="right">安全设置</a></dd>
                    <dd><a href="${pageContext.request.contextPath}/logout">退出登录</a></dd>
                </dl>
            </li>

        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree">
                <shiro:hasRole name="管理员">
                    <li class="layui-nav-item layui-nav-itemed">
                        <a class="" href="javascript:;">用户管理</a>
                        <dl class="layui-nav-child">
                            <dd><a href="${pageContext.request.contextPath}/userList" target="right">用户列表</a></dd>
                        </dl>
                        <dl class="layui-nav-child">
                            <dd><a href="${pageContext.request.contextPath}/blackList" target="right">黑名单</a></dd>
                        </dl>
                    </li>
                    <li class="layui-nav-item layui-nav-itemed">
                        <a class="" href="javascript:;">博客管理</a>
                        <dl class="layui-nav-child">
                            <dd><a href="${pageContext.request.contextPath}/blogList" target="right">博客列表</a></dd>
                        </dl>
                        <dl class="layui-nav-child">
                            <dd><a href="${pageContext.request.contextPath}/downBlogList" target="right">下架博客</a></dd>
                        </dl>
                        <dl class="layui-nav-child">
                            <dd><a href="${pageContext.request.contextPath}/blogMessageList" target="right">博客信息</a></dd>
                        </dl>
                    </li>
                </shiro:hasRole>
                <shiro:hasAnyRoles name="用户,管理员">
                    <li class="layui-nav-item">
                        <a class="" href="javascript:;">个人信息</a>
                        <dl class="layui-nav-child">
                            <dd><a href="#" target="right">修改密码</a></dd>
                        </dl>
                    </li>
                </shiro:hasAnyRoles>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <!--        <div style="padding: 15px;">内容主体区域</div>-->
        <iframe scrolling="0" rameborder="0" src="${pageContext.request.contextPath}/welcome" name="right" width="100%" height="98.5%"></iframe>
    </div>

    <div class="layui-footer" style="text-align: center;height: 50px">
        <!-- 底部固定区域 -->
        <p>Copyright &copy; 2015-2017 chenchen 渝ICP备xxxxxx号</p>
    </div>
</div>
<script th:src="@{layui/layui.js}" type="text/javascript"></script>
<script th:inline="javascript">
    //自动填充模块应该有的内容样式
    layui.use('element', function(){
        var element = layui.element;
    });
    new Vue({
        el:'#app',
        data:{
            loginUsername:"",
            url:"",
        },
        mounted(){
            this.loginUsername = localStorage.getItem("loginUserName");
            this.url =  localStorage.getItem("loginUserHeadPic");
        }
    })
</script>
</body>
</html>