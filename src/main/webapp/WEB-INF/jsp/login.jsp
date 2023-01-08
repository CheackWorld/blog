<%--
  Created by IntelliJ IDEA.
  User: HASEE
  Date: 2023/1/4
  Time: 19:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
    <title>login</title>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <%--<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/xadmin.css">--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/snow.css">
    <%--<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/login.css">
    <script src="${pageContext.request.contextPath}/static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/vue.js" type="text/javascript"></script>
    <!-- 引入组件库 -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="${pageContext.request.contextPath}/static/lib/layui/layui.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/xadmin.js" type="text/javascript"></script>
</head>
<body>
<div class="snow-container">
    <div class="snow foreground"></div>
    <div class="snow foreground layered"></div>
    <div class="snow middleground"></div>
    <div class="snow middleground layered"></div>
    <div class="snow background"></div>
    <div class="snow background layered"></div>
</div>
<div class="container">
    <div class="form-box" id="loginApp">
        <!-- 注册 -->
        <div class="register-box hidden">
            <form class="register-box" action="#" method="post">
                <h1>register</h1>
                <input type="text" v-model="user2.userName" placeholder="用户名">
                <input type="email" v-model="user2.email" placeholder="邮箱">
                <input type="password" v-model="user2.password" placeholder="密码">
                <input type="password" placeholder="确认密码" id="confirmPassword">
                <button type="button" @click="register">注册</button>
            </form>

        </div>
        <!-- 登录 -->
        <div class="login-box">
            <h1>login</h1>
            <form class="login-box" action="#" method="post">
                <input id="username" type="text" v-model="user.userName" placeholder="用户名"/>
                <input id="password" type="password" v-model="user.password" placeholder="密码"/>
                <button type="button" @click="login">登录</button>
            </form>

        </div>
    </div>
    <div class="con-box left">
        <h2 class="title">欢迎来到<span>山满林木的博客</span></h2>
        <p>快来<span>登录</span>吧</p>
        <img src="${pageContext.request.contextPath}/static/images/login1.jpg" alt="" class="smaller">
        <p>已有账号</p>
        <button onclick="gologin()">去登录</button>
    </div>
    <div class="con-box right">
        <h2 class="title">欢迎来到<span>山满林木的博客</span></h2>
        <p>快来<span>注册</span>吧</p>
        <img src="${pageContext.request.contextPath}/static/images/login2.jpg" alt="" class="smaller">
        <p>没有账号？</p>
        <button onclick="goregister()">去注册</button>
    </div>
</div>

<script type="text/javascript">
    new Vue({
        el: "#loginApp",// 挂载点，即钩子
        data: { // 数据绑定
            // 登录数据
            user: {
                userName: "",
                password: "",
            },
            //注册用户数据
            user2: {
                userName: "",
                email: "",
                password: "",
            },
        },
        methods: { // 定义方法
            // 登录方法
            login() {
                var _this = this;
                $.ajax({
                    url: '${pageContext.request.contextPath}/user/login',
                    dataType: 'json',
                    type: 'get',
                    data: this.user,
                    success: function (rs) {
                        _this.$message(rs.msg);
                        // 延迟
                        setTimeout(function () {
                            localStorage.setItem("loginUserName", _this.user.userName);
                            localStorage.setItem("loginUserHeadPic",rs.data.headPic);
                            if (rs.status == 200)
                            {
                                if (rs.data.role.roleName=="管理员") {
                                    location.href = '${pageContext.request.contextPath}/backstageIndex';
                                }else {
                                    location.href = '${pageContext.request.contextPath}/index';
                                }

                            }
                            else
                                location.reload()
                        }, 1000)
                    }, error: function () {
                        _this.$message("登录服务器错误");
                    }
                })
            },
            register() {
                var _this = this;
                var confirmPassword = $("#confirmPassword").value;
                $.ajax({
                    url: '${pageContext.request.contextPath}/user/register',
                    dataType: 'json',
                    type: 'post',
                    data: JSON.stringify(this.user2),
                    contentType: 'application/json',
                    success: function (rs) {
                        _this.$message(rs.msg);
                        setTimeout(function () {
                            if (rs.status == 200) {
                                _this.$message("注册成功！");
                                location.reload()
                            }
                            else
                                location.reload()
                        }, 1000)
                    }, error: function () {
                        _this.$message("注册错误");
                    }
                })
            }

        },
    })
    var form_box = document.getElementsByClassName('form-box')[0];
    var register_box = document.getElementsByClassName('register-box')[0];
    var login_box = document.getElementsByClassName('login-box')[0];

    function goregister() {
        form_box.style.transform = 'translateX(80%)';
        login_box.classList.add('hidden');
        register_box.classList.remove('hidden');
    }

    function gologin() {
        form_box.style.transform = 'translateX(0%)';
        register_box.classList.add('hidden');
        login_box.classList.remove('hidden');
    }
</script>
</body>
</html>
