<%--
  Created by IntelliJ IDEA.
  User: HASEE
  Date: 2023/1/6
  Time: 17:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>写博客</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/conmmon.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/blog_edit.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/editor.md-master/css/editormd.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/xadmin.css">
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="${pageContext.request.contextPath}/static/js/jquery-2.1.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/vue.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/editor.md-master/editormd.js"></script>
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="${pageContext.request.contextPath}/static/lib/layui/layui.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/xadmin.js" type="text/javascript"></script>

</head>
</head>
<body>
<div class="nav">
    <img src="${pageContext.request.contextPath}/static/images/login1.jpg">
    <span class="title">我的博客系统</span>
    <span class="spacer"></span>
    <a href="${pageContext.request.contextPath}/index">主页</a>
    <a href="myblog_list.html">个人主页</a>
    <a href="${pageContext.request.contextPath}/addBlog">写博客</a>
    <a href="${pageContext.request.contextPath}/logout">注销</a>
</div>
<div class="blog-edit-container" id="app">
    <div class="title">
        <input id="title" type="text" placeholder="在这里写下文章标题">
        <button @click="addBlog()">发布文章</button>
    </div>

    <el-select v-model="value" placeholder="请选择板块">
        <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value"
                @click.native="getItem(item)"
        >
        </el-option>
    </el-select>
    <div id="editorDiv">
        <textarea style="display:none;" id="editorText"></textarea>
    </div>
</div>
<script>
    var time=new Date();
    var editor;
    var blogTitle = "";
    var blogContent ="";
    var blogType = "";
    var userName=localStorage.getItem("loginUserName");
    var blogTime=time.toLocaleString();
    <%--function mysub(){--%>
        <%--var title = jQuery("#title");--%>
        <%--var context = jQuery("#editorText");--%>
        <%--if(jQuery.trim(title.val())==""){--%>
            <%--alert("请先输入标题！");--%>
            <%--title.focus();--%>
            <%--return;--%>
        <%--}--%>
        <%--if(jQuery.trim(context.val())==""){--%>
            <%--alert("请先输入正文！");--%>
            <%--context.focus();--%>
            <%--return;--%>
        <%--}--%>
        <%--jQuery.ajax({--%>
            <%--url:"addart",--%>
            <%--type:"POST",--%>
            <%--data:{"title":title.val(),"context":context.val()},--%>
            <%--success:function(result){--%>
                <%--if(result!=null && result.succ==200 && result.data==1){--%>
                    <%--alert("恭喜：添加成功！");--%>
                    <%--if(confirm("是否继续添加文章？")){--%>
                        <%--location.href = location.href;--%>
                    <%--}else{--%>
                        <%--location.href = "${pageContext.request.contextPath}/index";--%>
                    <%--}--%>
                <%--}else{--%>
                    <%--alert("操作失败，请重试！")--%>
                <%--}--%>
            <%--}--%>
        <%--});--%>
    <%--}--%>
    new Vue({
        el:"#app",
        data:{
            options:[{
                value:'旅游',
                label:""
            },{
                value:'美食',
                label:""
            },{
                value:'计算机',
                label:""
            }],
            article:{
                blogTitle:blogTitle,
                blogTime:blogTime,
                blogContent:blogContent,
                blogType:blogType,
                userName:userName
            },
            value:''

        },
        methods:{
            initEdit(md){
                editor = editormd("editorDiv", {
                    width: "100%",
                    height: "calc(100% - 50px)",
                    markdown: md,
                    path: "${pageContext.request.contextPath}/static/editor.md-master/lib/",
                    saveHTMLToTextarea: true
                });
            },
            addBlog(){
                var _this=this;
                this.article.blogContent = editor.getMarkdown();
                this.article.blogTitle = $("#title").val();
                if(jQuery.trim(this.article.blogTitle)==""||this.article.blogContent==""||this.value==""){
                    _this.$message("标题、内容、类别不能为空");
                    title.focus();
                    return;
                }

                $.ajax({
                    url:"${pageContext.request.contextPath}/blog/addBlog",
                    type:'post',
                    dataType:'json',
                    data:JSON.stringify(this.article),
                    contentType:'application/json',
                    success:function(rs){
                        if(rs.status==200){
                            _this.$message(rs.msg);
                            location.href = "${pageContext.request.contextPath}/index";
                        }else{
                            _this.$message(rs.msg);
                        }
                    },error:function () {
                        _this.$message("服务器出错");
                    }
                });
            },
            getItem(item){
                this.article.blogType=item.value;
            }
        },
        mounted(){
            this.initEdit("# 你好编译器");
        }
    })
</script>
</body>
</html>
