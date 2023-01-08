<%--
  Created by IntelliJ IDEA.
  User: HASEE
  Date: 2023/1/7
  Time: 17:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>博客列表</title>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="${pageContext.request.contextPath}/static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/vue.js" type="text/javascript"></script>
    <!-- 引入组件库 -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="${pageContext.request.contextPath}/static/lib/layui/layui.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/xadmin.js" type="text/javascript"></script>

</head>
<body>
<div id="app">
    <%-- 搜索用户的form表单--%>
    <center>
        <el-form :inline="true" :model="pageData" class="demo-form-inline">
            <el-form-item>
                <el-input v-model="pageData.blogTitle" placeholder="blogTitle"></el-input>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" icon="el-icon-search" circle @click="selectBlog"></el-button>
            </el-form-item>
        </el-form>
    </center>
    <el-table
            :data="blogList"
            border
            style="width: 100%">
        <el-table-column
                type="index"
                label="序号"
                align="center"
                width="80">
        </el-table-column>
        <el-table-column
                prop="blogTitle"
                label="标题"
                align="center"
                width="200">
        </el-table-column>
        <el-table-column
                prop="blogTime"
                label="发表时间"
                align="center"
                width="230">
        </el-table-column>
        <el-table-column
                label="内容"
                align="center"
                width="200">
            <template slot-scope="{row}">
                <el-link :underline="false" href="${pageContext.request.contextPath}/selectByBlogId">查看</el-link>
            </template>
        </el-table-column>
        <el-table-column
                prop="blogType"
                label="类别"
                align="center"
                width="160">
        </el-table-column>
        <el-table-column
                label="发表状态"
                align="center"
                width="100">
            <template slot-scope="{row}">
                <el-switch
                        v-model="row.blogState"
                        active-color="#ff4949"
                        inactive-color="#13ce66"
                        :active-value="0"
                        :inactive-value="1"
                        @change="changeBlogState(row.blogState,row.blogTitle,row.user.userName)">
                </el-switch>
            </template>
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
                        @confirm="deleteBlogByBlogTitle(scope.row.blogTitle)">
                    <el-button type="danger" slot="reference" icon="el-icon-delete" size="small" @click="setTitle(scope.row.blogTitle)"></el-button>
                </el-popconfirm>
                <el-button type="primary" icon="el-icon-edit" size="small" @click="goEditBlog(scope.row)"></el-button>
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
        el:'#app',
        data:{
            blogList:[],
            //分页对象
            pageData:{
                page:1,
                size:5,
                blogState:0,
                blogTitle:"",

            },
            total:0,
            title:"",
            userName:""
        },
        methods:{
            loadData2(){
                var _this = this;
                $.ajax({
                    url: '${pageContext.request.contextPath}/blog/blogList',
                    dataType: 'json',
                    type: 'get',
                    data: this.pageData,
                    success: function (rs) {
                        _this.blogList = rs.data.list;
                        _this.total = rs.data.total;
                        _this.userName
                    }, error: function () {
                        _this.$message("用户列表出错");
                    }
                })
            },
            handleSizeChange(newSize) { // size改变执行
                // 把当前改变之后的size，赋值给分页对象中的size，然后重新加载数据
                this.pageData.size = newSize;
                this.loadData2();
            },
            handleCurrentChange(newPage) { // page改变执行
                this.pageData.page = newPage;
                this.loadData2();
            },
            changeBlogState(blogState,blogTitle,userName){
                var _this = this;

                this.$confirm('此操作将上架'+blogTitle+'，是否继续？','警告',{
                    confirmButtonText:'确定',
                    cancelButtonText:'取消',
                    type:'error'
                }).then(()=>{
                    $.ajax({
                    url:'${pageContext.request.contextPath}/blog/changeBlogState/'+blogState+'/'+blogTitle+'/'+userName,
                    dataType:'json',
                    type:'put',
                    success:function (rs) {
                        if (rs.status==200){
                            _this.$message({
                                type:'success',
                                message:'审核成功!'
                            });
                        } else {
                            _this.$message({
                                type:'error',
                                message:'审核失败！'
                            });
                        }
                        setTimeout(function () {
                            location.reload();
                        },1000)
                    },error:function () {

                        _this.$message("审核服务器错误")
                    }
                })
            }).catch(()=>{
                    this.$message({
                    type:'info',
                    message:'已取消审核'
                });
                location.reload();
            })
            },
            setTitle(blogTitle){
                this.title = "是否删除"+blogTitle+"?";
            }
        },

        mounted(){
            this.loadData2();
        }
    })
</script>
</body>
</html>
