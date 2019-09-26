<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<head>
    <!-- META TAGS -->
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>植物问答平台-更多推荐</title>

    <link rel="shortcut icon" href="images/rlws.png"/>


    <!-- Style Sheet-->
    <link rel='stylesheet' id='bootstrap-css-css' href='static/css/bootstrap5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='responsive-css-css' href='static/css/responsive5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='main-css-css' href='static/css/main5152.css' type='text/css' media='all'/>

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
                        <li><a style="cursor: pointer"
                               onclick="${user==null?"alert('您还没登录!')":"location.href='user_release'"}">发出提问</a></li>
                        <li><a href="/question_no_answer">等我回答</a></li>
                        <c:if test="${user == null}">
                            <li><a href="/login">登录</a></li>
                            <li><a href="/register">注册</a></li>
                        </c:if>
                        <c:if test="${user != null}">
                            <li><a href="/user">用户中心</a></li>
                        </c:if>
                        <li><a style="cursor: pointer"
                               onclick="${user.power==2?"location.href='user_talent'":"alert('您还不是达人用户，请加倍努力哦！')"}">达人中心</a>
                        </li>
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
            <input class="search-term required" type="text" id="searchTitle" name="searchTitle"
                   placeholder="您可以在这里输入查找内容..."
                   title="请点击右边'Search'按钮进行查找!"/>
            <input class="search-btn" type="submit" value="Search"/>
            <div id="search-error-container"></div>
        </form>
    </div>
</div>
<!-- 查询信息结束 -->

<!-- 中间内容开始 -->
<div class="page-container">
    <div class="container">
        <div class="row">

            <!-- 中间左边部分开始 -->
            <div class="span8 page-content">
                <div id="tableBody"></div>
                <c:forEach items="${recommendations}" var="item" varStatus="num">
                    <c:if test="${num.index % 3 == 0}"><div class="row-fluid separator top-cats"></c:if>
                    <section class="span4">
                        <h4 class="category"><a
                                style="display: -webkit-box;-webkit-line-clamp: 1;-webkit-box-orient: vertical;overflow: hidden;"
                                href="to_recommendation_details?id=${item.id}">${item.title}</a></h4>
                        <div class="category-description">
                            <p style="display: -webkit-box;-webkit-line-clamp: 3;-webkit-box-orient: vertical;overflow: hidden;">
                                    ${item.content}
                            </p>
                        </div>
                    </section>
                    <c:if test="${(num.index+1) % 3 == 0}"></div></c:if>
                </c:forEach>
                <ul class="pager">
                    <li><a id="first" style="cursor: pointer">首页</a></li>
                    <li><a id="prev" style="cursor: pointer">上一页</a></li>
                    <li><a id="current">当前页:1</a></li>
                    <li><a id="next" style="cursor: pointer">下一页</a></li>
                    <li><a id="end" style="cursor: pointer">尾页</a></li>
                    <li><a id="all_count">总页数:${page_count}</a></li>
                </ul>
                <!-- 中间左边部分结束 -->
            </div>
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
                            <li><a href="/index">首页</a></li>
                            <li>
                                <a style="cursor: pointer" ${user==null?"onclick=\"alert('您还未登录!')\"":"href='/user'"}>用户中心</a>
                            </li>
                            <li><a href="/login">登录</a></li>
                            <li><a href="/register">注册</a></li>
                        </ul>
                    </div>
                </section>

                <section class="widget">
                    <h3 class="title">分类</h3>
                    <div class="tagcloud">
                        <c:forEach items="${categories}" var="item">
                            <a href="to_category_result?category_id=${item.id}"
                               class="btn btn-mini">${item.content}</a>
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
<script type="text/javascript">
    var page_current_context = 1;
    var page_end_context = ${page_count == null ? 1 : page_count};
    var url = '/all_recommendation_ajax';
    var search_context = "";
    $(function () {
        /* 初始化当前页面和尾页(分页) */
        myAjax(1, 9, url);

        /* 点击下一页 */
        $("#next").click(function () {
            if (page_current_context < page_end_context) {
                page_current_context++;
                myAjax(page_current_context, 9, url)
            } else {
                alert("已经是最后一页了")
            }
        })
        /* 点击上一页 */
        $("#prev").click(function () {
            if (page_current_context == 1) {
                alert("已经是最前一页了")
            } else {
                page_current_context--;
                myAjax(page_current_context, 9, url)
            }
        })

        /* 返回首页 */
        $("#first").click(function () {
            page_current_context = 1;
            myAjax(page_current_context, 9, url);
        })

        /* 前往尾页 */
        $("#end").click(function () {
            page_current_context = page_end_context;
            myAjax(page_current_context, 9, url);
        })

        /* Ajax包装方法 */
        function myAjax(page_current, page_size, urll) {
            $.ajax(
                {
                    type: 'get',
                    url: urll,
                    dataType: 'json',
                    data: {
                        "search": search_context,
                        "page_current": page_current,
                        "page_size": page_size
                    },
                    success: function (data) {
                        var last = JSON.stringify(data);
                        var json = JSON.parse(last);
                        var recommendation = json.recommendations;
                        var pageVo = json.pageVo;
                        var rlws = '';
                        console.log(recommendation);
                        $("#tableBody").empty();
                        for (i in recommendation) {
                            if (i % 3 == 0) {
                                rlws = rlws + '<div class="row-fluid separator top-cats">';
                            }
                            rlws = rlws + '<section class="span4">' +
                                '                        <h4 class="category"><a style="display: -webkit-box;-webkit-line-clamp: 1;-webkit-box-orient: vertical;overflow: hidden;" href="to_recommendation_details?id='+recommendation[i].id+'">'+recommendation[i].title+'</a></h4>' +
                                '                        <div class="category-description">' +
                                '                            <p style="display: -webkit-box;-webkit-line-clamp: 3;-webkit-box-orient: vertical;overflow: hidden;">'+recommendation[i].content+'</p>\n' +
                                '                        </div>' +
                                '                    </section>'
                            var ii = parseInt(i) + 1;
                            if (ii % 3 == 0) {
                                rlws = rlws + '</div>';
                            }
                        }
                        $("#tableBody").append(rlws);
                        page_end_context = Math.ceil(pageVo.page_count / pageVo.page_size);
                        $("#all_count").html("总页数:" + page_end_context);
                        $("#current").html("当前页:" + pageVo.page_current);
                    }
                }
            )
        }
    })
</script>
</body>
</html>