<%--
  Created by IntelliJ IDEA.
  User: HASEE
  Date: 2023/1/6
  Time: 17:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<html>
<head>
    <title>用户列表</title>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="${pageContext.request.contextPath}/static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/vue.js" type="text/javascript"></script>
    <!-- 引入组件库 -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="${pageContext.request.contextPath}/static/lib/layui/layui.js" type="text/javascript"></script>
</head>
<body>
<div id="app">
    <%-- 搜索用户的form表单--%>
    <center>
        <el-form :inline="true" :model="pageData" class="demo-form-inline">
            <el-form-item>
                <el-input v-model="pageData.userName" placeholder="username"></el-input>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="el-icon-search" circle @click="selectUser"></el-button>
            </el-form-item>
        </el-form>
    </center>
    <el-button type="primary" @click="goUserAdd">新增用户</el-button>
    <el-table
            :data="userList"
            border
            style="width: 100%">
        <el-table-column
                type="index"
                label="序号"
                align="center"
                width="80">
        </el-table-column>
        <el-table-column label="头像" align="center" width="251">
            <template v-slot="{row}">
                <img :src="row.headPicture" alt="错误" width="180px" height="57px">
            </template>
        </el-table-column>
        <el-table-column
                prop="userName"
                label="用户名"
                align="center"
                width="120">
        </el-table-column>
        <el-table-column
                prop="password"
                label="密码"
                align="center"
                width="310">
        </el-table-column>
        <el-table-column
                prop="email"
                label="邮箱"
                align="center"
                width="180">
        </el-table-column>
        <el-table-column
                label="用户状态"
                align="center"
                width="100">
            <template slot-scope="{row}">
                <el-switch
                        v-model="row.userState"
                        active-color="#ff4949"
                        inactive-color="#13ce66"
                        :active-value="0"
                        :inactive-value="1"
                        @change="changeUserState(row.userState,row.userName)">
                </el-switch>
            </template>
        </el-table-column>
        <el-table-column
                prop="role.roleName"
                label="角色"
                align="center"
                width="80">
        </el-table-column>
        <el-table-column
                align="center"
                label="操作">
            <template slot-scope="scope">
                <el-popconfirm
                        confirm-button-text='确定'
                        cancel-button-text='取消'
                        icon="el-icon-info"
                        icon-color="red"
                        confirm-button-type="danger"
                        cancel-button-type="Text"
                        :title="title"
                        @confirm="deleteUserByUserName(scope.row.userName)">
                    <el-button type="danger" slot="reference" icon="el-icon-delete" size="small" @click="setTitle(scope.row.userName)"></el-button>
                </el-popconfirm>
                <el-button type="primary" icon="el-icon-edit" size="small" @click="goEditUser(scope.row)"></el-button>
            </template>
        </el-table-column>
    </el-table>
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

<script type="text/javascript">
    new Vue({
        el: '#app',
        data: {
            userList: [],
            // 分页对象
            pageData: {
                page: 1, // 当前页码，默认第一页
                size: 5, // 当前显示条数，默认五条
                userState: 1,
                userName: "" // 用户模糊查询用户的
            },
            total: 0,
            title:""
        },
        methods: {
            loadData() { // 加载用户数据
                var _this = this;
                $.ajax({
                    url: '${pageContext.request.contextPath}/user/userList',
                    dataType: 'json',
                    type: 'get',
                    data: this.pageData,
                    success: function (rs) {
                        _this.userList = rs.data.list;
                        _this.total = rs.data.total;
                    }, error: function () {
                        _this.$message("用户列表出错");
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
            },
            selectUser() { // 模糊查询用户
                this.pageData.page = 1;
                this.pageData.size = 5;
                this.loadData();
            },
            changeUserState(userState,userName){ // 改变用户的状态
                var _this = this;
                this.$confirm('此操作将禁用' + userName + ',是否继续?', '警告', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'error'
                }).then(()=>{
                    // 发送ajax请求，修改当前用户状态，修改成功之后，刷新页面
                    $.ajax({
                    url:'${pageContext.request.contextPath}/user/changeUserState/' + userState + '/' +userName,
                    dataType: 'json',
                    type:'put',
                    success:function (rs) {
                        if (rs.status==200){
                            _this.$message({
                                type: 'success',
                                message: '禁用成功!'
                            });
                        }else {
                            _this.$message({
                                type: 'error',
                                message: '禁用失败!'
                            });
                        }
                        setTimeout(function () {
                            location.reload();
                        },1000)
                    },error:function () {
                        _this.$message("禁用服务器错误");
                    }
                })
            }).catch(() => {
                    this.$message({
                    type: 'info',
                    message: '已取消禁用'
                });
                location.reload(); // 刷新一下
            })
            },
            setTitle(userName){ // 设置删除的提示信息
                this.title = "是否删除" + userName + "?";
            },
            deleteUserByUserName(userName){ // 删除用户
                var _this = this;
                $.ajax({
                    url:'${pageContext.request.contextPath}/user/deleteUserByUsername/'+userName,
                    dataType:'json',
                    type:'delete',
                    success:function (rs) {
                        _this.$message(rs.msg);
                        setTimeout(function () {
                            location.reload();
                        },1000);
                    }
                })
            },
            goEditUser(user){ // 去修改用户的页面
                delete user.headPicture; // 删除js对象中某个属性
                delete user.userState;
                delete user.role;
                delete user.userId;
                localStorage.setItem("updateUser",JSON.stringify(user));
                x_admin_show('修改用户','${pageContext.request.contextPath}/userEdit',500,400);
            },
            goUserAdd(){ // 打开行啊
                x_admin_show('新增用户','${pageContext.request.contextPath}/userAdd',500,400);
            },

        },
        mounted() {
            this.loadData();
        }
    })
</script>

</body>
</html>
