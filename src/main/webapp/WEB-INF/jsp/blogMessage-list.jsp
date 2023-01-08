<%--
  Created by IntelliJ IDEA.
  User: HASEE
  Date: 2023/1/6
  Time: 19:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>博客信息</title>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/xadmin.css">
    <script src="${pageContext.request.contextPath}/static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/vue.js" type="text/javascript"></script>
    <!-- 引入组件库 -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="${pageContext.request.contextPath}/static/lib/layui/layui.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/xadmin.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/static/js/echarts-5.3.3.js" type="text/javascript"></script>
</head>
<body>
<div id="app">
    <div style="border:3px;width: 504px;height: 504px;margin-left: 450px">
        <div id="blogType" style="height: 504px;width: 504px;"></div>
    </div>

</div>

<script type="text/javascript">
    new Vue({
        el:'#app',
        data:{

        },
        methods:{
            loadType(){
                var _this=this;
                var pie = echarts.init(document.getElementById("blogType"));
                $.ajax({
                    url:'${pageContext.request.contextPath}/echarts/pie',
                    dataType:'json',
                    type:'get',
                    success:function (rs) {
                        var option = {
                            title: {
                                text: '博客种类',
                                subtext: 'Cheack Data',
                                left: 'center'
                            },
                            tooltip: {
                                trigger: 'item'
                            },
                            legend: {
                                orient: 'vertical',
                                left: 'left',
                            },
                            series: [
                                {
                                    name: 'Access From',
                                    type: 'pie',
                                    radius: '50%',
                                    data:
                                        rs.data
                                    ,
                                    emphasis: {
                                        itemStyle: {
                                            shadowBlur: 10,
                                            shadowOffsetX: 0,
                                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                                        }
                                    }
                                }
                            ]
                        };
                        pie.setOption(option)
                    },error:function () {
                        _this.$message("获取错误")
                    }
                })
            }
        },
        mounted(){
            this.loadType();
        }
    })
</script>
</body>
</html>
