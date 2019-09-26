<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <link rel="stylesheet" href="static/css/answer.css">

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
                        <li><a style="cursor: pointer" onclick="${user==null?"alert('您还没登录!')":"location.href='user_release'"}">发出提问</a></li>
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

<!-- 中间部分开始 -->
<div class="page-container">
    <div class="container">
        <div class="row">

            <!-- 中间主体部分开始 -->
            <div class="span8 page-content">

                <article class=" type-post format-standard hentry clearfix">

                    <h1 class="post-title"><a href="#">${question.title}</a></h1>

                    <div class="post-meta clearfix">
                        <span class="date">
                            <fmt:formatDate value="${question.time}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </span>
                        <span class="author" title="点击可查看提问者的发布的问题哦">
                            <a ${user.username == question.user.username ? "onclick=\"alert('您不能够在此查看你的问题发布记录!');return false;\"":''} href="/to_user_all_history_question?id=${question.user.id}&username=${question.user.username}" id="author">${question.user.username}</a>
                        </span>
                        <span class="category">
                            <a href="to_category_result?category_id=${question.category.id}" title="点击可查找该类话题">${question.category.content}</a>
                        </span>
                        <span class="comments">
                            <a title="回复的数量" id="huifu">${questionAnswerCount}</a>条回复
                        </span>
                        <i class="questionId" style="display:none;">${question.id}</i>
                        <span class="like-count" style="cursor: pointer" title="点击进行收藏" id="shoucang">${question.praise}</span>
                        <span class="jub">
                            <a href="/user_report?question_id=${question.id}" class="jubao" >举报</a>
                        </span>
                        <span class="jub" style="position: relative">
                            <a id="share" style="cursor: pointer">分享</a>
                            <div id="share_to" style="position: absolute;left: 22px;top:-45px;width: 60px;
                            background: white;box-shadow:0 0 10px rgba(222,84,72,1);border-radius: 2px;display: none">
                                <a class="qq" href="qqname" target="_blank">QQ空间</a></br>
                                <a class="xlwb" href="xlwbname">新浪微博</a> </br>
                            </div>
                        </span>
                    </div>
                    <!-- 问题的内容 -->
                    ${question.content}
                </article>

                <form id="user-answer" class="search-form clearfix" method="get" action="#" autocomplete="off">
                    <textarea rows="5" id="content" style="width: 100%;resize:none;" name="content"></textarea>
                    <input type="text" id="answer_user_id" name="answer_user_id" value="${user == null ?"" : user.id}"
                           style="display: none;">
                    <input type="text" id="question_id" name="question_id" value="${question.id}" style="display: none">
                    <a class="btn btn-success" href="/login"  ${user != null ? "style='display: none'":""}
                       title="还没登录?点击前往登录">前往登录</a>
                    <button type="button" id="submit"
                            class="btn btn-success" ${user == null ? "style='display: none'":""} ${question.user.id == user.id ? "disabled" : ""} >提交回答
                    </button>
                </form>

                <h3 id="optimal_answer">最优回答</h3>
                <c:if test="${optimal==null}">
                    <article class="hentry">
                        <div class="post-meta clearfix rlws-answer">
                            <p>该提问者暂没确定最优回答!</p>
                        </div>
                    </article>
                </c:if>
                <c:if test="${optimal!=null}">
                    <article class="hentry">
                        <div class="post-meta clearfix rlws-answer" style="background: #ded3a9;">
                            <span class="author">${optimal.user.username}</span>
                            <span class="date"><fmt:formatDate value="${optimal.time}"
                                                               pattern="yyyy-MM-dd HH:mm:ss"/></span>
                            <span class="like-count">${optimal.praise}</span>
                            <span class="jub"><a href="/user_report?answer_id=${optimal.id}">举报</a></span>
                            <p id="answer_${optimal.id}">${optimal.content}</p>
                        </div>
                    </article>
                </c:if>

                <h3 id="answer">回答</h3>
                <%-- 遍历该问题的回答 --%>
                <c:forEach items="${allAnswer}" var="item">
                    <article class="hentry">
                        <div class="post-meta clearfix rlws-answer" style="margin-bottom: 0px">
                            <span class="author">${item.user.username}</span>
                            <span class="date"><fmt:formatDate value="${item.time}"
                                                               pattern="yyyy-MM-dd HH:mm:ss"/></span>
                            <span class="like-count" id="answer_${item.id}" style="cursor: pointer" title="点赞该回答" onclick="praiseAnswer(${item.id},${item.praise})">${item.praise}</span>
                            <span class="jub">
                                <i style="display: none">${item.id}</i>
                                <a class="replay" style="cursor: pointer" data-toggle="modal"
                                   data-target="#myModal">评论</a>
                            </span>
                            <span class="jub"><a class="jubao" href="/user_report?answer_id=${item.id}">举报</a></span>
                            <p id="questionAnswer_${item.id}">${item.content}</p>
                                <%-- 遍历该回答的回复 --%>
                            <c:forEach items="${item.replyList}" var="repItem">
                                <div class="post-meta clearfix rlws-post" style="margin-bottom: 5px">
                                    <span class="author">${repItem.user.username}</span>
                                    <span class="date"><fmt:formatDate value="${repItem.time}"
                                                                       pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                    <p style="margin-bottom: 0;">${repItem.content}</p>
                                </div>
                            </c:forEach>
                        </div>
                    </article>
                </c:forEach>
            </div>
            <!-- 中间主体部分结束 -->

            <div class="span4 page-sidebar">
                <section class="span3 articles-list">
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
            </div>
        </div>
    </div>
</div>
<!-- End of Page Container -->

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

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">请输入您的评论内容:</h4>
            </div>
            <div class="modal-body">
                <input type="text" id="answerId" style="display: none">
                <textarea rows="5" id="reply_content" style="width: 95%" name="content" escape="false"></textarea>
            </div>
            <div class="modal-footer">
                <button id="closeModal" type="button" class="btn btn-success" data-dismiss="modal">关闭</button>
                <button id="replyModal" type="button" class="btn btn-success">评论</button>
            </div>
        </div>
    </div>
</div>
<!-- 模态框（Modal）end -->

<!-- script -->
<script type='text/javascript' src='static/js/jquery-3.3.1.js'></script>
<script type='text/javascript' src='static/js/jquery.easing.1.3.js'></script>
<script type='text/javascript' src='static/js/jquery.liveSearch.js'></script>
<script type='text/javascript' src='static/js/jquery.form.js'></script>
<script type="text/javascript" src="static/js/bootstrap.min.js"></script>
<script>
    function needUser(){
        if (${user==null}) {
            alert("对不起,您还未登录!");
            return false;
        }
    }
    //分享到QQ空间
    var qqname = "http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=" + location.href + "&summary="+"${question.title==null?'':question.title}";
    $(".qq").attr("href", qqname);
    //分享到新浪微博
    var xlwbname = "http://v.t.sina.com.cn/share/share.php?url=" + location.href
    $(".xlwb").attr("href", xlwbname);

    $(function () {
        /*分享点击*/
        $("#share").click(function () {
            $("#share_to").slideToggle("slow");
        })
        $("#author").click(function () {
            if (${user==null}){
                alert("对不起,您需要登录才能查看他人历史发布信息!");
                return false;
            }
        })
        $(".jubao").on('click',function () {
            if (${user==null}){
                alert("对不起,您需要登录才能举报他人!");
                return false;
            }
        })
    })
</script>
<script>
    $(function () {
        /* 用户收藏问题 */
        $("#shoucang").click(function () {
            var questionId = $(this).prev().html();
            if (${user==null}) {
                alert("对不起,您还未登录!")
            } else {
                var user_id = ${user==null?999:user.id};
                var praice = parseInt($(this).html());
                $.ajax(
                    {
                        type: 'get',
                        url: '/user_click_praise',
                        dataType: 'json',
                        data: {"user_id": user_id, "question_id": questionId},
                        success: function (data) {
                            if (data) {
                                $("#shoucang").html(praice + 1);
                            } else {
                                alert("您已经收藏过该问题了呢!")
                            }
                        }
                    }
                )
            }
        });

        /* 获取当前时间 */
        var myDate = new Date();
        var year = myDate.getFullYear();
        var month = myDate.getMonth() + 1;
        var date = myDate.getDate();
        var h = myDate.getHours();
        var m = myDate.getMinutes();
        var s = myDate.getSeconds();
        var now = year + '-' + month + "-" + date + " " + h + ':' + m + ":" + s;

        /* 用户回答 */
        $("#submit").click(function () {
            var user_id = ${user==null?999:user.id};
            var question_id = $("#question_id").val();
            var content = $.trim($("#content").val());
            if (content==null || content=='' || content==undefined){
                alert("回答不能为空!")
            }else {
                var a = '<article class="hentry">';
                var b = '<div class="post-meta clearfix rlws-answer">';
                var c = '<span class="author">${user.username}</span>';
                var d = '<span class="date">' + now + '</span>';
                var e = '<span class="like-count">0</span>';
                var f = '<span class="jub"><a href="#" data-toggle="modal" data-target="#myModal">评论</a></span>';
                var g = '<span class="jub"><a href="#">举报</a></span>';
                var h = '<p>' + content + '</p>';
                var i = '</div>';
                var j = '</article>';
                $.ajax(
                    {
                        type: 'post',
                        url: '/user_answer_question',
                        dataType: 'json',
                        data: {
                            "user_id": user_id,
                            "question_id": question_id,
                            "content": content
                        },
                        success: function (data) {
                            if (data) {
                                $("#answer").after(a + b + c + d + e + f + g + h + i + j);
                                $("#content").val("");
                                $("#huifu").html(Number($("#huifu").html()) + 1);
                            } else {
                                alert("您已回答过该问题!")
                            }
                        }
                    }
                )
            }
        })

        /* 用户评论 */
        $(".replay").click(function () {
            $("#answerId").val($(this).prev().html())
        })
        $("#replyModal").click(function () {
            var reply_content = $("#reply_content").val();
            var a = '<div class="post-meta clearfix rlws-post">';
            var b = '<span class="author">${user.username}</span>';
            var c = '<span class="date">' + now + '</span>';
            var d = '<p style="margin-bottom: 0;">' + reply_content + '</p>';
            var e = '</div>';
            if (${user==null}) {
                alert("对不起,您还未登录!")
            } else {
                var user_id = ${user==null?999:user.id};
                var answerId = $("#answerId").val();
                $.ajax(
                    {
                        type: 'post',
                        url: '/user_reply_answer',
                        dataType: 'json',
                        data: {
                            "user_id": user_id,
                            "answer_id": answerId,
                            "content": reply_content
                        },
                        success: function (data) {
                            if (data) {
                                $("#questionAnswer_" + answerId).after(a + b + c + d + e);
                                $("#closeModal").click();
                            } else {
                                alert("评论失败!")
                            }
                        }
                    }
                )
            }
        })
    })

    function praiseAnswer(answerId,praice) {
        /* 用户点赞回答 */
        if (${user==null}) {
            alert("对不起,您还未登录!")
        } else {
            var user_id = ${user==null?999:user.id};
            $.ajax(
                {
                    type: 'get',
                    url: '/user_click_answer_praise',
                    dataType: 'json',
                    data: {"user_id": user_id, "answer_id": answerId},
                    success: function (data) {
                        if (data) {
                            $("#answer_"+answerId).html(praice + 1);
                            alert("点赞成功!")
                        } else {
                            alert("您已经赞过该回答了呢!")
                        }
                    }
                }
            )
        }
    }
</script>
</body>
</html>

