<%--
  Created by IntelliJ IDEA.
  User: HASEE
  Date: 2023/1/6
  Time: 17:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改用户</title>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/xadmin.css">
    <script src="${pageContext.request.contextPath}/static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/vue.js" type="text/javascript"></script>
    <!-- 引入组件库 -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="${pageContext.request.contextPath}/static/lib/layui/layui.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/xadmin.js" type="text/javascript"></script>
<body>
<div id="app">
    <div style="margin: 20px;"></div>
    <el-form label-position="right" label-width="100px" :model="user">
        <el-row>
            <el-col :span="16">
                <el-form-item label="用户名">
                    <el-input v-model="user.userName" readonly></el-input>
                </el-form-item>
            </el-col>
        </el-row>
        <el-row>
            <el-col :span="16">
                <el-form-item label="密码">
                    <el-input v-model="user.password"></el-input>
                </el-form-item>
            </el-col>
        </el-row>
        <el-row>
            <el-col :span="16">
                <el-form-item label="邮箱">
                    <el-input v-model="user.email"></el-input>
                </el-form-item>
            </el-col>
        </el-row>
        <el-form-item>
            <el-button @click="restUser">重置</el-button>
            <el-button type="primary" @click="updateUser">确定</el-button>
        </el-form-item>
    </el-form>
</div>
<script type="text/javascript">
    new Vue({
        el: '#app',
        data: {
            user: {
                username:"",
                password:"",
                email:""
            }
        },
        methods:{
            restUser(){ // 重置
                this.loadUser();
            },
            updateUser(){ // 修改
                var _this = this;
                $.ajax({
                    url:'${pageContext.request.contextPath}/user/updateUserByUserName',
                    dataType:'json',
                    type:'put',
                    data:JSON.stringify(this.user),
                    contentType:'application/json',
                    success:function (rs) {
                        if (rs.status == 200){
                            layer.alert(rs.msg,{icon:6},function () {
                                var index = parent.layer.getFrameIndex(window.name);
                                parent.layer.close(index);
                                parent.location.reload();
                            })
                        }else {
                            layer.alert(rs.msg,{icon:5},function () {
                                var index = parent.layer.getFrameIndex(window.name);
                                parent.layer.close(index);
                                parent.location.reload();
                            })
                        }
                    },error:function () {
                        _this.$message("修改服务器出错");
                    }
                })
            },
            loadUser(){ // 回显和重置用户修改信息
                this.user = JSON.parse(localStorage.getItem("updateUser"));
            }
        },
        mounted(){
            this.loadUser();
        }
    })
</script>

</body>
</html>
