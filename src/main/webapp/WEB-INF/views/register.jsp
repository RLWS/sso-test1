<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<head>
    <!-- META TAGS -->
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>植物问答平台</title>

    <link rel="shortcut icon" href="static/images/rlws.png"/>


    <!-- Style Sheet-->
    <link rel='stylesheet' id='bootstrap-css-css' href='static/css/bootstrap5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='responsive-css-css' href='static/css/responsive5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='main-css-css' href='static/css/main5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='green-skin-css' href='static/css/green-skin5152.css' type='text/css' media='all'/>

</head>

<body>

<!-- Start of Header -->
<div class="header-wrapper">
    <header>
        <div class="container">

            <div class="logo-container">
                <!-- Website Logo -->
                <a href="index-2.html" title="知识的起源">
                    <img src="static/images/logo.png" alt="旋叶">
                </a>
                <span class="tag-line">敏而好学，不耻下问。</span>
            </div>

            <!-- Start of Main Navigation -->
            <nav class="main-nav">
                <div class="menu-top-menu-container">
                    <ul id="menu-top-menu" class="clearfix">
                        <li><a href="#3d">欢迎您的注册</a></li>
                    </ul>
                </div>
            </nav>
            <!-- End of Main Navigation -->
        </div>
    </header>
</div>
<!-- End of Header -->

<!-- Start of Search Wrapper -->
<div class="search-area-wrapper">
    <div class="search-area container">

        <h3 class="search-header">君子之学必好问，问与学，相辅而行者也。 </h3>
        <div class="span3"></div>
        <div class="span6 login">
            <h3 class="search-header">用 户 注 册</h3>
            <form id="search-form" class="search-form clearfix" method="post" action="/register">
                <input class="search-term required" id="username" type="text" name="username" placeholder="请输入用户名" title="请输入用户名!" maxlength="12" onkeydown="if(event.keyCode==32){return false;}"/>
                <p></p>
                <input class="search-term required" id="email" type="email" name="email" placeholder="请输入您的邮箱"
                       title="请输入您的邮箱!" onkeydown="if(event.keyCode==32){return false;}"/>
                <p></p>
                <input class="search-term required" id="password_a" type="password" name="password" placeholder="请输入您的密码"
                       title="请输入您的密码!"  maxlength="16" minlength="6" onkeydown="if(event.keyCode==32){return false;}"/>
                <p></p>
                <input class="search-term required" id="password_b" type="password" placeholder="请确认您的密码"
                       title="请确认您的密码!" maxlength="16" minlength="6" onkeydown="if(event.keyCode==32){return false;}"/>
                <p></p>
                <button type="submit" id="submit" class="btn btn-large btn-primary submit" title="点击进行注册!">点击开始注册</button>
                <p></p>
                <div id="error-container" style="color: red"></div>
            </form>
        </div>
        <div class="span3"></div>
    </div>
</div>
<!-- End of Search Wrapper -->

<!-- Start of Footer -->
<footer id="footer-wrapper">
    <div id="footer" class="container">
        <div class="row">

            <div class="span3">
                <section class="widget">
                    <h3 class="title">关于我们</h3>
                    <div class="textwidget">
                        <p>拓展人们的认识,开拓人们的视野,让更多的人能对我们身边的植物有更多的了解~去爱护她,守护她!</p>
                        <p>Expand people's understanding, broaden people's horizons, so that more people can have a
                            better understanding of the plants around us ~love and protect her!</p>
                    </div>
                </section>
            </div>

            <div class="span3">
                <section class="widget">
                    <h3 class="title">友情链接</h3>
                    <ul>
                        <li><a target="_blank" href="https://zhidao.baidu.com/" title="百度知道">百度知道</a></li>
                        <li><a target="_blank" href="http://wenda.so.com/" title="360问答">360 问答</a></li>
                        <li><a target="_blank" href="https://wenwen.sogou.com/" title="搜狗问答">搜狗问答</a></li>
                        <li><a target="_blank" href="https://iask.sina.com.cn/" title="新浪问答">新浪问答</a></li>
                    </ul>
                </section>
            </div>

            <div class="span3">
                <section class="widget">
                    <h3 class="title">常见问题</h3>
                    <div id="twitter_update_list">
                        <ul>
                            <li><a href="#">无法发起提问?</a></li>
                            <li><a href="#">无法进行注册?</a></li>
                            <li><a href="#">没有想要的答案?</a></li>
                            <li><a href="#">用户中心进不去?</a></li>
                        </ul>
                    </div>
                </section>
            </div>

            <div class="span3">
                <section class="widget">
                    <h3 class="title">欢迎咨询</h3>
                    <div class="textwidget">
                        <p>如果您对我们的网站有任何疑问,均可通过下方的联系方式和我们进行联系!</p>
                        <p>电话:0775-7822646</p>
                    </div>
                </section>
            </div>

        </div>
    </div>
    <!-- end of #footer -->

    <!-- Footer Bottom -->
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
    <!-- End of Footer Bottom -->

</footer>

<!-- script -->
<script type='text/javascript' src='static/js/jquery-1.8.3.min.js'></script>
<script type='text/javascript' src='static/js/jquery.easing.1.3.js'></script>
<script type='text/javascript' src='static/js/jquery.liveSearch.js'></script>
<script type='text/javascript' src='static/js/jquery.form.js'></script>
<script type='text/javascript' src='static/js/jquery.validate.min.js'></script>
<script type="text/javascript">
    $(function () {
        $("#email").blur(function () {
            $.ajax({
                type:"get",
                url:"register_email_ajax",
                dataType:"json",
                data:{"email":$("#email").val()},
                success:function (data) {
                    if (!data){
                        alert("该邮箱已被注册!");
                        $("#email").val('');
                    }
                },error:function () {
                    $("#email").val('');
                }
            })
        })
        $("#submit").click(function () {
            /*邮箱验证判断*/
            var reg = /\w+[@]{1}\w+[.]\w+/;
            if (!reg.test($("#email").val())) {
                $("#error-container").html("请输入正确的email")
                $("#email").focus();
                return false;
            }
            /*密码验证判断*/
            var paw1 = $("#password_a").val();
            var paw2 = $("#password_b").val();
            if (paw1 == '' || paw2 == ''){
                $("#error-container").html("输入的密码不能为空");
                return false;
            }
            if (paw1 != paw2){
                $("#error-container").html("两次输入的密码不一致");
                $("#password_b").focus();
                return false;
            }
            /* 用户名判断 */
            var username = $("#username").val();
            if (username == ""){
                $("#error-container").html("用户名不能为空");
                $("#error-container").focus();
                return false;
            }
        })
    })
</script>
</body>
</html>