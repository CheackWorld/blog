<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
    <title>博客主页</title>
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
            <%--<img src="${pageContext.request.contextPath}/static/images/login2.jpg" alt='作者头像' class="avatar">--%>
                <img :src="url" class="layui-nav-img">
            <h3><span id="loginName"></span></h3>
            <a href="https://github.com/CheackWorld">我的github</a>
            <div class="counter">
                <span >文章</span>
                <span >分类</span>
            </div>
            <div class="counter">
                <span id="articleNum">2</span>
                <span id="typeNum">1</span>
            </div>
        </div>
    </div>
    <!--文章列表-->
    <div class="container-right">
        <div class="tab" id="tab">


        </div>
        <center>
            <div class="block">
                <%-- @size-change：当页面显示的条数发生变化的时候执行的函数，默认传递一个参数过去，参数的值就是当前页码显示的条数
                    @current-change：当页码发生变化的时候执行的函数，默认传递一个参数，参数的值就是当前的页码
                    :current-page：绑定当前页码
                    :page-sizes：绑定下拉框可控选择的页面显示的条数
                    :page-size：绑定当前显示的条数
                    :total：绑定总条数
                --%>
                <el-pagination
                        @size-change="handleSizeChange"
                        @current-change="handleCurrentChange"
                        :current-page="page"
                        :page-sizes="[2, 5, 10]"
                        :page-size="size"
                        layout="total, sizes, prev, pager, next, jumper"
                        :total="total">
                </el-pagination>
            </div>
        </center>
    </div>

</div>

<script>
    new Vue({
        el: "#app",
        data: {
            loginUserName: "",
            blogList: [],
            blogState: 1,
            userName: '',
            page: 1, // 当前页码，默认第一页
            size: 5, // 当前显示条数，默认五条
            total: 0,
            url:""
        },
        methods: {
            loadData3() {
                var _this = this;
                this.userName = localStorage.getItem("loginUserName");
                $.ajax({
                    url: '${pageContext.request.contextPath}/blog/myBlogList',
                    dataType: 'json',
                    type: 'get',
                    data: {
                        "blogState": this.blogState,
                        "userName": this.userName,
                        "page": this.page,
                        "size": this.size
                    },
                    success: function (rs) {
                        _this.blogList = rs.data.list;
                        _this.total = rs.data.total;
                        $("#articleNum").html(_this.total);
                        var str = "";
                        var cont = rs.data.list;
                        if (rs.data.list.length>0&&rs.status==200){
                            for (var i in cont) {

                                str += '<div class="blog"><div class="title">' + cont[i].blogTitle + '</div><div class="date">' + cont[i].blogTime + '</div><div class="desc">' + cont[i].blogContent + '</div><a href="${pageContext.request.contextPath}/article'  + '" class="detail">查看全文 &gt;&gt;</a></div><hr>';
                            }
                            $("#tab").html(str);
                        } else{
                            $("#tab").html("<h2 style='text-align:center;padding-top:50px;'>暂无文章，<a href='index.jsp'>返回</a></h2>");
                        }



                        //遍历数组
                        // for (var x in data) {
                        //     str +=
                        //         "<div class='title'>" + data[x].blogTitle + "</div>" +
                        //         "<div class='date'>" + data[x].blogTime + "</div>" +
                        //         "<div class='desc'>" + data[x].blogContent + "</div>" +
                        //         "<a href='article.jsp' class='detail'>查看全文</a>"
                        // }
                        //将数据

                        // $("#tab").empty();
                        // $("#tab").append(str2);
                    }, error: function () {
                        _this.$message("列表出错!!")
                    }
                })
            },
            handleSizeChange(newSize) { // size改变执行
                // 把当前改变之后的size，赋值给分页对象中的size，然后重新加载数据
                this.pageData.size = newSize;
                this.loadData();
            },
            handleCurrentChange(newPage) { // page改变执行
                this.pageData.page = newPage;
                this.loadData();
            }
        },
        mounted() {
            this.loadData3();
            this.url =  localStorage.getItem("loginUserHeadPic");
            $("#loginName").html(localStorage.getItem("loginUserName"));
        }
    })


</script>
</body>
</html>
