<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<head>
    <!-- META TAGS -->
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>植物问答平台-用户信息</title>

    <link rel="shortcut icon" href="static/images/rlws.png"/>


    <!-- Style Sheet-->
    <link rel='stylesheet' id='bootstrap-css-css' href='static/css/bootstrap5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='responsive-css-css' href='static/css/responsive5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='main-css-css' href='static/css/main5152.css' type='text/css' media='all'/>
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
                        <li class="list-group-item"><a href="/user_talent_apply">达人申请</a></li>
                    </c:if>
                </ul>
            </div>
            <div class="span9 rlws-right">
                <form id="search-form" class="search-form clearfix" method="post" action="user-change-password"
                      autocomplete="off">
                    <table class="table">
                        <caption>用户密码修改</caption>
                        <thead>
                        <tr>
                            <td colspan="2" style="text-align: center"><h3 style="color:red;">${message != null ? message : ""}</h3></td>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>请输入原密码</td>
                            <td>
                                <input type="password" id="root_pwd" minlength="6" maxlength="16" onkeyup="value=value.replace(/[\u4e00-\u9fa5]/ig,'')"/>
                            </td>
                        </tr>
                        <tr>
                            <td>请输入新密码</td>
                            <td>
                                <input type="password" id="new_pwd" minlength="6" maxlength="16" onkeyup="value=value.replace(/[\u4e00-\u9fa5]/ig,'')"/>
                            </td>
                        </tr>
                        <tr>
                            <td>请再次输入新密码</td>
                            <td>
                                <input type="password" name="password" id="password" minlength="6" maxlength="16" onkeyup="value=value.replace(/[\u4e00-\u9fa5]/ig,'')"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: center;">
                                <button type="submit" class="btn btn-large btn-primary" id="sub">确定修改</button>
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
        $("#sub").click(function () {
            var user_pwd = ${user.password};
            var root_pwd = $("#root_pwd").val();
            var new_pwd = $("#new_pwd").val();
            var password = $("#password").val();
            if (root_pwd == "" || new_pwd == "" || password == "") {
                alert("3个密码框不能为空!")
            } else {
                if ($.trim(password) == $.trim(new_pwd)) {
                    if ($.trim(user_pwd) == $.trim(root_pwd)) {
                        return true;
                    } else {
                        alert("原密码输入错误!")
                        return false;
                    }
                } else {
                    alert("两次输入的密码不一致")
                    return false;
                }
            }
            return false;
        });

    })
</script>

</body>
</html>