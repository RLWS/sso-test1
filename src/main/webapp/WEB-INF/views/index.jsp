<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<head>

    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>植物问答平台-首页</title>

    <link rel="shortcut icon" href="static/images/rlws.png"/>
    <link rel='stylesheet' id='bootstrap-css-css' href='static/css/bootstrap5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='responsive-css-css' href='static/css/responsive5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='main-css-css' href='static/css/main5152.css' type='text/css' media='all'/>
    <!-- 滚动列表 -->
    <link rel="stylesheet" href="static/css/newsbox/bootstrap-theme.min.css" type="text/css">
    <style type="text/css">
        .demo2>li{
            line-height: 35px;
        }
        .demo2>li>h4{
            display: inline;
        }
        .demo2>li>span{
            float: right; margin-left: 20px;
        }
    </style>
</head>

<body>

<!-- 头部开始 -->
<div class="header-wrapper">
    <header>
        <div class="container">

            <!-- 头部左边开始 -->
            <div class="logo-container">

                <a href="" title="知识的起源">
                    <img src="static/images/logo.png" alt="旋叶">
                </a>
                <span class="tag-line">敏而好学，不耻下问。</span>
            </div>
            <!-- 头部左边结束 -->
            <!-- 头部右边开始 -->
            <nav class="main-nav">
                <div class="menu-top-menu-container">
                    <ul id="menu-top-menu" class="clearfix">
                        <li><a href="/index">首页</a></li>
                        <li><a style="cursor: pointer" onclick="${user==null?"alert('您还没登录!')":"location.href='user_release'"}">  发出提问</a></li>
                        <li><a href="/question_no_answer">等我回答</a></li>
                        <c:if test="${user == null}">
                        <li><a href="/login">登录</a></li>
                        <li><a href="/register">注册</a></li>
                        </c:if>
                        <c:if test="${user != null}">
                            <li><a href="/user">用户中心</a></li>
                        </c:if>
                        <li><a style="cursor: pointer" onclick="${user.power==2?"location.href='user_talent'":"alert('您还不是达人用户，请加倍努力哦！')"}">达人中心</a></li>
                        <li><a href="more_recommendation">更多推荐</a></li>
                    </ul>
                </div>
            </nav>
            <!-- 头部右边结束 -->
        </div>
    </header>
</div>
<!-- 头部结束 -->

<!-- 查询区域开始 -->
<div class="search-area-wrapper">
    <div class="search-area container">
        <h3 class="search-header">善问者，如攻坚木，先其易者，后其节目。</h3>
        <p class="search-tag-line">如果您有任何疑问,您可以在下方询问或查找您需要的内容!</p>

        <form id="search-form" class="search-form clearfix" method="get" action="search_result">
            <input class="search-term required" type="text" id="searchTitle" name="searchTitle" placeholder="您可以在这里输入查找内容..."
                   title="请点击右边'Search'按钮进行查找!"/>
            <input class="search-btn" type="submit" value="Search"/>
            <div id="search-error-container"></div>
        </form>
    </div>
</div>
<!-- 查询信息结束 -->

<!-- 中间内容开始 -->
<div class="page-container"  id="mydiv" >
    <div class="container">
        <div class="row">
            <!-- 中间左边部分开始 -->
            <div class="span8 page-content">
                <%-- 紧急求助部分内容 --%>
                <div class="row" style="text-align: center"><h3 style="margin: 0px;color: #e84646">紧急求助</h3></div>
                <div class="row">
                    <ul class="demo2">
                        <c:forEach items="${questionsUrgent}" var="item">
                            <li>
                                <h4><a href="/title_go_details?id=${item.id}">${item.title}</a></h4>
                                <span><fmt:formatDate value="${item.time}" pattern="yyyy-MM-dd"/></span>
                                <span>类别：${item.category.content}</span>
                                <span>作者：${item.user.username}</span>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="row separator">
                    <section class="span4 articles-list">
                        <h3>近期热门</h3>
                        <ul class="articles">
                            <%-- 获取最近一周最热门(点赞最多的)6条新闻 --%>
                            <c:forEach items="${questions}" var="item">
                                <li class="article-entry standard">
                                    <h4><a href="/title_go_details?id=${item.id}">${item.title}</a></h4>
                                    <span class="article-meta">
                                        <fmt:formatDate value="${item.time}"/>
                                        <a href="#" title="提问者">${item.user.username}</a>
                                    </span>
                                    <span class="like-count rl_title${item.id}" title="被收藏的次数">${item.praise}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </section>

                    <section class="span4 articles-list">
                        <h3>最新提问</h3>
                        <ul class="articles">
                            <%-- 获取最新发布的6条新闻 --%>
                            <c:forEach items="${questionDetails}" var="item">
                                <li class="article-entry standard">
                                    <h4><a href="/title_go_details?id=${item.id}">${item.title}</a></h4>
                                    <span class="article-meta">
                                        <fmt:formatDate value="${item.time}"/>
                                        <a href="#" title="提问者">${item.user.username}</a>
                                    </span>
                                    <i class="questionId" style="display:none;">${item.id}</i>
                                    <span class="like-count rl_title${item.id}" title="被收藏的次数">${item.praise}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </section>

                </div>
            </div>
            <!-- 中间左边部分结束 -->

            <!-- 中间右边部分开始 -->
            <aside class="span4 page-sidebar">

                <section class="widget">
                    <div class="support-widget">
                        <h3 class="title">帮助</h3>
                        <p class="intro">
                            您需要帮助吗?如果您需要我们的帮助,请与我们的管理员联系!联系方式如下:<br>
                            QQ:1600510083<br>
                            EMAIL:rlws1600510083@sina.com<br>
                            PHONE:18877544079
                        </p>
                    </div>
                </section>

                <section class="widget">
                    <div class="quick-links-widget">
                        <h3 class="title">快速链接</h3>
                        <ul id="menu-quick-links" class="menu clearfix">
                            <li><a href="/index" >首页</a></li>
                            <li><a style="cursor: pointer" ${user==null?"onclick=\"alert('您还未登录!')\"":"href='/user'"}>用户中心</a></li>
                            <li><a href="/login">登录</a></li>
                            <li><a href="/register">注册</a></li>
                        </ul>
                    </div>
                </section>

                <section class="widget">
                    <h3 class="title">分类</h3>
                    <div class="tagcloud">
                        <c:forEach items="${categories}" var="item">
                            <a href="to_category_result?category_id=${item.id}" class="btn btn-mini">${item.content}</a>
                        </c:forEach>
                    </div>
                </section>

            </aside>
            <!-- 中间右边部分结束 -->
        </div>
    </div>
</div>
<!-- 中间内容结束 -->

<!-- 底部开始 -->
<footer id="footer-wrapper">
    <!-- 上底部开始 -->
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
    <!-- 上底部结束 -->

    <!-- 下底部开始 -->
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
    <!-- 下底部结束 -->

</footer>
<!-- 底部结束 -->

<!-- script -->
<script type='text/javascript' src='static/js/jquery-1.8.3.min.js'></script>
<script type='text/javascript' src='static/js/jquery.easing.1.3.js'></script>
<script type='text/javascript' src='static/js/jquery.liveSearch.js'></script>
<script type='text/javascript' src='static/js/jquery.form.js'></script>
<script type='text/javascript' src='static/js/jquery.validate.min.js'></script>
<!-- 背景特效 -->
<script type="text/javascript" src="static/js/particle/canvas-particle.js"></script>
<!-- 滚动列表 -->
<script type="text/javascript" src="static/js/newsbox/jquery.bootstrap.newsbox.min.js"></script>
<script>
    window.onload = function() {
        //配置
        var config = {
            vx: 4,	//小球x轴速度,正为右，负为左
            vy: 4,	//小球y轴速度
            height: 2,	//小球高宽，其实为正方形，所以不宜太大
            width: 2,
            count: 200,		//点个数
            color: "121, 162, 185", 	//点颜色
            stroke: "79, 176, 132", 		//线条颜色
            dist: 6000, 	//点吸附距离
            e_dist: 20000, 	//鼠标吸附加速距离
            max_conn: 10 	//点到点最大连接数
        }
        //调用
        CanvasParticle(config);
    }
    $(function () {
        $(".demo2").bootstrapNews({
            newsPerPage: 5,
            autoplay: true,
            pauseOnHover: true,
            navigation: false,
            direction: 'down',
            newsTickerInterval: 2500,
            onToDo: function () {
                //console.log(this);
            }
        });
        $(".demo2").css("height","auto");
        /*  将首页中的后退按钮禁用，避免退出登录后还可以返回上一个页面 */
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