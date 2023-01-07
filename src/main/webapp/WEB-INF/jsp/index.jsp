<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
    <title>博客主页</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/common.css">>
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
    <img src="${pageContext.request.contextPath}/static/images/login1.jpg">
    <span class="title">我的博客系统</span>
    <!--用来占据中间空白位置-->
    <span class="spacer"></span>
    <a href="${pageContext.request.contextPath}/goBackstageIndex">主页</a>
    <a href="editor.html">写博客</a>
    <!--删除用户的登陆状态，需要动态处理-->
    <a href="${pageContext.request.contextPath}/logout">注销</a>
</div>
<!--正文部分-->
<div class="container" id="app">
    <!--个人信息-->
    <div class="container-left">
        <div class="card">
            <img src="${pageContext.request.contextPath}/static/images/login2.jpg" alt='作者头像' class="avatar">
            <h3><span id="loginName"></span></h3>
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
        <div class="tab">

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
                            :current-page="pageData.page"
                            :page-sizes="[2, 5, 10]"
                            :page-size="pageData.size"
                            layout="total, sizes, prev, pager, next, jumper"
                            :total="total">
                    </el-pagination>
                </div>
            </center>
        </div>
    </div>

</div>

<script>
    new Vue({
        el: "#app",
        data: {
            loginUserName: "",
            blogList: [],
            pageData: {
                page: 1, // 当前页码，默认第一页
                size: 5, // 当前显示条数，默认五条
                // userState: 1,
                blogTitle: "" // 用户模糊查询用户
            },
            total: 0,
            title: ""
        },
        methods: {
            loadData3() {
                var _this = this;
                $.ajax({
                    url: '${pageContext.request.contextPath}/blog/blogList',
                    dataType: 'json',
                    type: 'get',
                    data: this.pageData,
                    success: function (rs) {
                        //取得list
                        // _this.blogList = rs.data.list;
                        // _this.total = rs.data.total;
                        var str="";
                        // var data = rs.data;
                        //遍历数组
                        for (var x in data) {
                            str +=
                                "<div class='title'>" + data[x].blogTitle + "</div>" +
                                "<div class='date'>" + data[x].blogTime + "</div>" +
                                "<div class='desc'>" + data[x].blogContent + "</div>" +
                                "<a href='article.jsp' class='detail'>查看全文</a>"
                        }
                        //将数据
                        $("#tab").html(str)
                    }, error: function () {
                        _this.$message("列表出错!!")
                    }
                })
            },
            handleSizeChange(newSize) { // size改变执行
                // 把当前改变之后的size，赋值给分页对象中的size，然后重新加载数据
                this.pageData.size = newSize;
                this.loadData3();
            },
            handleCurrentChange(newPage) { // page改变执行
                this.pageData.page = newPage;
                this.loadData3();
            },
            selectArticle() { // 模糊查询文章
                this.pageData.page = 1;
                this.pageData.size = 5;
                this.loadData3();
            },
        },
        mounted() {
            this.loadData3();
            $("#loginName").html(localStorage.getItem("loginUserName"));
        }
    })



</script>
</body>
</html>
