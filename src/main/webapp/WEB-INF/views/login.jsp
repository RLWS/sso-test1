<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<head>

    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>植物问答平台-登录</title>

    <link rel="shortcut icon" href="static/images/rlws.png"/>
    <link rel='stylesheet' id='bootstrap-css-css' href='static/css/bootstrap5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='responsive-css-css' href='static/css/responsive5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='pretty-photo-css-css' href='static/js/prettyphoto/prettyPhotoaeb9.css' type='text/css'
          media='all'/>
    <link rel='stylesheet' id='main-css-css' href='static/css/main5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='green-skin-css' href='static/css/green-skin5152.css' type='text/css' media='all'/>

</head>

<body>

<div class="header-wrapper">
    <header>
        <div class="container">

            <div class="logo-container">
                <a title="知识的起源">
                    <img src="static/images/logo.png" alt="旋叶">
                </a>
                <span class="tag-line">敏而好学，不耻下问。</span>
            </div>


            <nav class="main-nav">
                <div class="menu-top-menu-container">
                    <ul id="menu-top-menu" class="clearfix">
                        <li><a href="/index">返回首页</a></li>
                        <li><a href="#3d">欢迎您的登录</a></li>
                    </ul>
                </div>
            </nav>

        </div>
    </header>
</div>


<div class="search-area-wrapper">
    <div class="search-area container">

        <h3 class="search-header">善问者，如攻坚木，先其易者，后其节目。</h3>
        <div class="span3"></div>
        <div class="span6 login">
            <h3 class="search-header">登 录</h3>
            <form id="search-form" class="search-form clearfix" method="post" action="login" role="form">
                <input class="search-term required" type="email" id="email" name="email" placeholder="请输入用户名"
                       title="请输入用户名!"/>
                <p></p>
                <input class="search-term required" type="password" id="password" name="password" placeholder="请输入密码"
                       title="请输入密码!" maxlength="16" minlength="6"
                       onkeyup="value=value.replace(/[\u4e00-\u9fa5]/ig,'')"/>
                <p></p>
                <input class="radio" type="radio" id="111" name="userRadios" value="user" checked>
                <label for="111">用户登录</label>
                <input class="radio" type="radio" id="11" name="userRadios" value="manager"><label
                    for="11">管理员登录</label>
                <p></p>
                <button id="submit" type="submit" class="btn btn-large btn-primary submit" title="点击进行登录!">点击进行登录
                </button>
                <a class="btn btn-large btn-primary submit" title="没有账号?点击进行注册!" href="/register">点击开始注册</a>
                <p></p>
                <div id="search-error-container" style="color: red"><c:if test="${login != null}">${login}</c:if></div>
            </form>
        </div>
        <div class="span3"></div>
    </div>
</div>

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

<!-- script -->
<script type='text/javascript' src='static/js/jquery-1.8.3.min.js'></script>
<script type='text/javascript' src='static/js/jquery.easing.1.3.js'></script>
<script type='text/javascript' src='static/js/jquery.liveSearch.js'></script>
<script type='text/javascript' src='static/js/jquery.form.js'></script>
<script type='text/javascript' src='static/js/jquery.validate.min.js'></script>
<script type="text/javascript">
    $(function () {
        $("#submit").click(function () {
            var reg = /\w+[@]{1}\w+[.]\w+/;
            if (!reg.test($("#email").val())) {
                alert("请输入正确的email！");
                $("#email").focus();
                return false;
            }
        })

        /*  将登录页面中的后退按钮禁用，避免管理员退出登录后还可以返回上一个页面 */
        if (window.history && window.history.pushState){
            $(window).on('popstate',function () {
                window.history.pushState('forward',null,'#');
                window.history.forward(1);
            });
            window.history.pushState('forword',null,'#');
            window.history.forward(1);
        }
    })
</script>
</body>
</html>