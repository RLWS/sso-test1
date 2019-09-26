<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<head>
    <!-- META TAGS -->
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>植物问答平台-达人申请</title>

    <link rel="shortcut icon" href="static/images/rlws.png"/>


    <!-- Style Sheet-->
    <link rel='stylesheet' id='bootstrap-css-css' href='static/css/bootstrap5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='responsive-css-css' href='static/css/responsive5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='main-css-css' href='static/css/main5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='green-skin-css' href='static/css/green-skin5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='user-center-css' href='static/css/user-center-css.css' type='text/css' media='all'/>
</head>

<body>


<div class="container" style="background: #eee">

    <!-- 头部开始 -->
    <div class="header-wrapper">
        <header>
            <div class="container">
                <div class="logo-container">
                    <a href="index-2.html" title="知识的起源">
                        <img src="static/images/logo.png" alt="旋叶">
                    </a>
                    <span class="tag-line">敏而好学，不耻下问。</span>
                </div>
                <nav class="main-nav">
                    <div class="menu-top-menu-container">
                        <ul id="menu-top-menu" class="clearfix">
                            <li><span class="tag-line"><a>亲爱的 ${user.username} ,欢迎您的到来</a></span></li>
                            <li><span class="tag-line"><a href="/user_logout">退出登录</a></span></li>
                            <li><span class="tag-line"><a href="/index">返回首页</a>&nbsp;&nbsp;&nbsp;</span></li>
                        </ul>
                    </div>
                </nav>
            </div>
        </header>
    </div>
    <!-- 头部结束 -->

    <!-- 主体开始 -->
    <div class="container">
        <div class="row">
            <div class="span3 rlws-left">
                <img src="${user.img == null? "static/images/user_head.jpg" : user.img}">
                <h3 class="search-header">${user.username}</h3>
                <ul class="list-group">
                    <li class="list-group-item"><a href="/user">我的信息</a></li>
                    <li class="list-group-item"><a href="/user_release">问答相关</a></li>
                    <li class="list-group-item"><a href="/user-change-password">密码修改</a></li>
                    <li class="list-group-item"><a href="/user-change">信息修改</a></li>
                    <li class="list-group-item"><a href="/user_to_message">我的消息</a></li>
                    <c:if test="${user.power == 2}">
                        <li class="list-group-item"><a href="/user_talent">达人中心</a></li>
                    </c:if>
                    <c:if test="${user.power == 1}">
                        <li class="list-group-item"><a href="#">达人申请</a></li>
                    </c:if>
                </ul>
            </div>
            <div class="span9 rlws-right">
                <form id="search-form" class="search-form clearfix" method="get" action="#" autocomplete="off">
                    <table class="table">
                        <caption>达人申请</caption>
                        <thead>
                        <tr>
                            <th></th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>申请人的邮箱</td>
                            <td>
                                <input type="text" name="user_id"  value="${user.email}" readonly>
                            </td>
                        </tr>
                        <tr>
                            <td>最佳回答数量</td>
                            <td>
                                <input type="text" name="user_id" id="user_id" value="${user.id}" style="display: none">
                                <input type="text" name="username" id="bestAnswerCount" readonly value="${bestAnswerCount}"/>
                            </td>
                        </tr>
                        <tr>
                            <td>申请理由:</td>
                            <td>
                                <textarea rows="5" id="content" style="width: 100%;resize:none;" name="content" >如果您的最佳回答数量达到 ${BestAnswerCount} 次,下方的按钮就会开发!您还差${BestAnswerCount-bestAnswerCount}次!</textarea>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: center">
                                <c:if test="${bestAnswerCount>=BestAnswerCount}">
                                    <button class="btn btn-success" id="btn">提交申请</button>
                                </c:if>
                                <c:if test="${bestAnswerCount<BestAnswerCount}">
                                    <span class="btn btn-success" disabled title="申请条件尚未满足">提交申请</span>
                                </c:if>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </div>
    </div>
    <!-- 主体结束 -->

    <!-- 底部开始 -->
    <footer id="footer-wrapper">

        <div id="footer-bottom-wrapper">
            <div id="footer-bottom" class="container">
                <div class="row">
                    <div class="span9">
                        <p class="copyright">
                            Copyright © 2018. All Rights Reserved by Plant Lore.
                        </p>
                    </div>
                    <div class="span3">
                        <p class="copyright">
                            Graduation design from Ming.
                        </p>
                    </div>
                </div>
            </div>
        </div>

    </footer>
    <!-- 底部结束-->
</div>


<!-- script -->
<script type='text/javascript' src='static/js/jquery-1.8.3.min.js'></script>
<script type='text/javascript' src='static/js/jquery.easing.1.3.js'></script>
<script type='text/javascript' src='static/js/jquery.liveSearch.js'></script>
<script type='text/javascript' src='static/js/jquery.form.js'></script>
<script type='text/javascript' src='static/js/jquery.validate.min.js'></script>
<script>
    $(function () {
        $("#btn").click(function () {
            var user_id = $("#user_id").val();
            var content = $("#content").val();
            $.ajax(
                {
                    type:"post",
                    url:"/user_apply_talent_ajax",
                    dataType:"json",
                    data:{
                        user_id:user_id,
                        content:content
                    },
                    success:function (data) {
                        if (data){
                            alert("申请成功,请等待结果");
                        } else {
                            alert("申请失败,请稍后再试")
                        }
                    }
                }
            )
        })
    })
</script>
</body>
</html>