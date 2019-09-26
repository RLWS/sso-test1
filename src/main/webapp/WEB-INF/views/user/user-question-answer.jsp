<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<head>
    <!-- META TAGS -->
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>植物问答平台-问题发布</title>

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
                <img src="${user.img == null? "static/images/user_head.jpg" : user.img}"
                     style="height: 120px;width: 120px">
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
                <ul id="myTab" class="nav nav-tabs" style="margin-bottom: 0px">
                    <li class="active">
                        <a href="#release" data-toggle="tab">用户问题发布</a>
                    </li>
                    <li><a href="#question" data-toggle="tab" id="myQuestion">我发布的问题</a></li>
                    <li><a href="#answer" data-toggle="tab" id="myAnswer">我回答的问题</a></li>
                    <li><a href="#collect" data-toggle="tab" id="myCollect">我收藏的问题</a></li>
                </ul>
                <div id="myTabContent" class="tab-content">
                    <div class="tab-pane fade in active" id="release">
                        <form id="search-form" class="search-form clearfix" method="post" action="user_add_one_question"
                              autocomplete="off" style="margin: 0px">
                            <table class="table">
                                <caption>问题发布</caption>
                                <thead>
                                <tr>
                                    <th></th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>问题标题</td>
                                    <td>
                                        <input type="text" name="title"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>问题类型</td>
                                    <td>
                                        <input type="text" name="user_id" value="${user.id}" style="display: none">
                                        <input type="text" name="category_id" id="category" style="display: none">
                                        <select class="form-control" id="aa">
                                            <%-- 获取所有的植物类别选项 --%>
                                            <c:forEach items="${categories}" var="item">
                                                <option value="${item.id}">${item.content}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>详细内容</td>
                                    <td title="标记为紧急问题时,问题将会在首页顶部放置3天时间!!!">
                                        <input type="text" name="urgent" id="urgent" style="display: none">
                                        <select class="form-control" id="bb" ${user.frequency == 0?"disabled":""}>
                                            <option value="0">非紧急问题</option>
                                            <option value="1">标记为紧急问题</option>
                                        </select>
                                        <span style="font-size: 12px;float: right">您发布紧急问题的次数还有<i style="color: red">${user.frequency}</i>  次!</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <input type="text" name="content" id="content" style="display: none">
                                        <div id="editor">
                                            <p>请在次填写问题的详细内容...</p>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <button id="test" type="submit" class="btn btn-large btn-primary submit"
                                                title="点击进行发布!">点击发布
                                        </button>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </form>
                    </div>
                    <div class="tab-pane fade" id="question" >
                        <h3 class="search-header" style="color: #3b4348">我发布的问题</h3>
                        <div class="span8 page-content">
                            <div class="row separator  top-cats">
                                <ul class="pager">
                                    <li><a id="first" style="cursor: pointer">首页</a></li>
                                    <li><a id="prev" style="cursor: pointer">上一页</a></li>
                                    <li><a id="current">当前页:1</a></li>
                                    <li><a id="next" style="cursor: pointer">下一页</a></li>
                                    <li><a id="end" style="cursor: pointer">尾页</a></li>
                                    <li><a id="all_count">总页数:100</a></li>
                                </ul>
                                <div id="queBody"></div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="answer">
                        <h3 class="search-header" style="color: #3b4348">我回答的问题</h3>
                        <ul class="pager">
                            <li><a id="first_answer" style="cursor: pointer">首页</a></li>
                            <li><a id="prev_answer" style="cursor: pointer">上一页</a></li>
                            <li><a id="current_answer">当前页:1</a></li>
                            <li><a id="next_answer" style="cursor: pointer">下一页</a></li>
                            <li><a id="end_answer" style="cursor: pointer">尾页</a></li>
                            <li><a id="all_count_answer">总页数:100</a></li>
                        </ul>
                        <div id="queBody_answer"></div>
                    </div>
                    <div class="tab-pane fade" id="collect">
                        <h3 class="search-header" style="color: #3b4348">我收藏的问题</h3>
                        <ul class="pager">
                            <li><a id="first_collect" style="cursor: pointer">首页</a></li>
                            <li><a id="prev_collect" style="cursor: pointer">上一页</a></li>
                            <li><a id="current_collect">当前页:1</a></li>
                            <li><a id="next_collect" style="cursor: pointer">下一页</a></li>
                            <li><a id="end_collect" style="cursor: pointer">尾页</a></li>
                            <li><a id="all_count_collect">总页数:100</a></li>
                        </ul>
                        <div id="queBody_collect"></div>
                    </div>
                </div>

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

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">请选择您认为最适合的答案:</h4>
            </div>
            <div class="modal-body" style="height:200px;overflow: scroll">
                <input type="text" id="answerId" style="display: none">
                <table id="addAnswer">
                    <tr style="border-bottom: 1px solid silver; margin-top: 5px;">
                        <td><input type="radio" name="optimal" value=""></td>
                        <td>请选择您认为最适合的答案</td>
                    </tr>
                    <tr style="border-bottom: 1px solid silver; margin-top: 5px;">
                        <td><input type="radio" name="optimal"></td>
                        <td>请选择您认为最适合的答案</td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button id="closeModal" type="button" class="btn btn-success" data-dismiss="modal">关闭</button>
                <button id="submitOptimal" type="button" class="btn btn-success">提交最佳答案</button>
            </div>
        </div>
    </div>
</div>
<!-- 模态框（Modal）end -->

<!-- script -->
<script type='text/javascript' src='static/js/jquery-1.8.3.min.js'></script>
<script type='text/javascript' src='static/js/jquery-3.3.1.js'></script>
<script type='text/javascript' src='static/js/bootstrap.min.js'></script>
<script type='text/javascript' src='static/js/jquery.easing.1.3.js'></script>
<script type='text/javascript' src='static/js/jquery.liveSearch.js'></script>
<script type='text/javascript' src='static/js/jquery.form.js'></script>
<script type='text/javascript' src='static/js/jquery.validate.min.js'></script>
<script type="text/javascript" src="static/wangeditor/wangEditor.min.js"></script>
<script type="text/javascript">
    /* 获取我发布过的所有问题 */
    $(function () {
        /* 初始化当前页面和尾页(分页) */
        var page_current_context = 1;
        var page_end_context = 0;
        /*初始化编辑框*/
        var E = window.wangEditor
        var editor = new E('#editor')
        editor.customConfig.uploadImgServer = '/upload'
        editor.customConfig.uploadFileName = 'wangEditor'
        editor.create()

        /*提交时将类别编辑框的值付给input标签*/
        $("#test").click(function () {
            $("#content").val(editor.txt.html());
            /*获取类别标签的id用以传入后台服务器*/
            $("#category").val($("#aa").val());
            /*获取类别标签的id用以传入后台服务器*/
            $("#urgent").val($("#bb").val());
        })

        /* 点击时获取我发布过的所有问题 */
        $("#myQuestion").click(function () {
            myAjax(1, 4);
        })

        /* 点击下一页 */
        $("#next").click(function () {
            if (page_current_context < page_end_context) {
                page_current_context++;
                myAjax(page_current_context, 4)
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
                myAjax(page_current_context, 4)
            }
        })

        /* 返回首页 */
        $("#first").click(function () {
            page_current_context = 1;
            myAjax(page_current_context, 4);
        })

        /* 前往尾页 */
        $("#end").click(function () {
            page_current_context = page_end_context;
            myAjax(page_current_context, 4);
        })

        /* Ajax包装方法 */
        function myAjax(page_current, page_size) {
            $.ajax(
                {
                    type: 'get',
                    url: '/user_all_question',
                    dataType: 'json',
                    data: {
                        "user_id":${user.id},
                        "page_current": page_current,
                        "page_size": page_size
                    },
                    success: function (data) {
                        var last = JSON.stringify(data);
                        var json = JSON.parse(last);
                        var question = json.questions;
                        var pageVo = json.pageVo;
                        console.log(question)
                        $("#queBody").empty();
                        for (i in question) {
                            var abq = '';
                            if (question[i].optimal == 0)
                                var abq = '<a id="question_'+question[i].id+'" style="cursor: pointer;color: red" data-toggle="modal" data-target="#myModal" onclick="rlws(' + question[i].id + ')">选择最优答案</a></span>'
                            else
                                var abq = '';
                            $("#queBody").append('<section class="span8">' +
                                '                     <h4 class="category"><a href="/title_go_details?id=' + question[i].id + '">' + question[i].title + '</a></h4>' +
                                '                     <div class=" rlws-like">' +
                                '                     <span class="article-meta">' + question[i].time + '</span>' +
                                '                            类型:<a href="single.html">' + question[i].category.content + '</a>' +
                                '                            提问者:<a href="#">' + question[i].user.username + '</a>' +
                                '                     </span>' +
                                '                            收藏数:<span class="like-count" style="cursor: pointer">' + question[i].praise + '</span>' +
                                '                      <span class="article-meta" style="float:right">' +
                                abq +
                                '                     </div>' +
                                '                     <div class="category-description">' +
                                '                            <p style="display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;overflow: hidden;">' +
                                question[i].content +
                                '                            </p>' +
                                '                      </div>' +
                                '                      </section>');
                        }
                        page_end_context = Math.ceil(pageVo.page_count / pageVo.page_size);
                        $("#all_count").html("总页数:" + page_end_context);
                        $("#current").html("当前页:" + pageVo.page_current);
                    }
                }
            )
        }
    })

    /* 最优答案获取 */
    function rlws(questionId) {
        $("#answerId").val(questionId);
        $.ajax({
            type: 'get',
            url: '/user_choose_optimal_answer',
            dataType: 'json',
            data: {"questionId": questionId},
            success: function (data) {
                var last = JSON.stringify(data);
                var json = JSON.parse(last);
                console.log(json)
                $("#addAnswer").empty();
                if (json==null || json==undefined || json==""){
                    $("#addAnswer").append("该问题暂时没有用户回答！")
                }
                for (i in json) {
                    $("#addAnswer").append('<tr style="border-bottom: 1px solid silver; margin-top: 5px;">' +
                        '                        <td><input type="radio" name="optimal"  value="' + json[i].id + '"></td>' +
                        '                        <td>' + json[i].content + '</td>' +
                        '                    </tr>')
                }
            }
        })
    }

    /* 提交最佳答案 */
    $(function () {
        $("#submitOptimal").click(function () {
            if (confirm("您只能选择一次最佳的答案,确定提交吗?")) {
                var questionId = $("#answerId").val();
                var answerId = $('input[name="optimal"]:checked ').val();
                $.ajax(
                    {
                        type: 'get',
                        url: '/user_chooce_answer_optimal',
                        dataType: 'json',
                        data: {"question_id": questionId , "answer_id":answerId},
                        success: function (data) {
                            if (data){
                                $("#closeModal").click();
                                $("#question_"+questionId).remove();
                                alert("提交成功!");
                            }
                        }
                    }
                )
            }
        })
    })

    /* 获取我回答过的所有问题 */
    $(function () {
        /* 初始化当前页面和尾页(分页) */
        var page_current_context = 1;
        var page_end_context = 0;

        /* 点击时获取我发布过的所有问题 */
        $("#myAnswer").click(function () {
            myAjax(1, 4);
        })

        /* 点击下一页 */
        $("#next_answer").click(function () {
            if (page_current_context < page_end_context) {
                page_current_context++;
                myAjax(page_current_context, 4)
            } else {
                alert("已经是最后一页了")
            }
        })
        /* 点击上一页 */
        $("#prev_answer").click(function () {
            if (page_current_context == 1) {
                alert("已经是最前一页了")
            } else {
                page_current_context--;
                myAjax(page_current_context, 4)
            }
        })

        /* 返回首页 */
        $("#first_answer").click(function () {
            page_current_context = 1;
            myAjax(page_current_context, 4);
        })

        /* 前往尾页 */
        $("#end_answer").click(function () {
            page_current_context = page_end_context;
            myAjax(page_current_context, 4);
        })

        /* Ajax包装方法 */
        function myAjax(page_current, page_size) {
            $.ajax(
                {
                    type: 'get',
                    url: '/get_all_question_user_answer_ajax',
                    dataType: 'json',
                    data: {
                        "user_id":${user.id},
                        "page_current": page_current,
                        "page_size": page_size
                    },
                    success: function (data) {
                        var last = JSON.stringify(data);
                        var json = JSON.parse(last);
                        var question = json.questions;
                        var pageVo = json.pageVo;
                        console.log(question)
                        $("#queBody_answer").empty();
                        for (i in question) {
                            $("#queBody_answer").append('<section class="span8">' +
                                '                     <h4 class="category"><a href="/title_go_details?id=' + question[i].id + '">' + question[i].title + '</a></h4>' +
                                '                     <div class=" rlws-like">' +
                                '                     <span class="article-meta">' + question[i].time + '</span>' +
                                '                            提问者:<a href="#">' + question[i].user.username + '</a>' +
                                '                     </span>' +
                                '                            收藏数:<span class="like-count" style="cursor: pointer">' + question[i].praise + '</span>' +
                                '                     </div>' +
                                '                     <div class="category-description">' +
                                '                            <p style="display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;overflow: hidden;">' +
                                question[i].content +
                                '                            </p>' +
                                '                      </div>' +
                                '                      </section>');
                        }
                        page_end_context = Math.ceil(pageVo.page_count / pageVo.page_size);
                        $("#all_count_answer").html("总页数:" + page_end_context);
                        $("#current_answer").html("当前页:" + pageVo.page_current);
                    }
                }
            )
        }
    })

    /* 获取我收藏过的所有问题 */
    $(function () {
        /* 初始化当前页面和尾页(分页) */
        var page_current_context = 1;
        var page_end_context = 0;

        /* 点击时获取我收藏过的所有问题 */
        $("#myCollect").click(function () {
            myAjax(1, 4);
        })

        /* 点击下一页 */
        $("#next_collect").click(function () {
            if (page_current_context < page_end_context) {
                page_current_context++;
                myAjax(page_current_context, 4)
            } else {
                alert("已经是最后一页了")
            }
        })
        /* 点击上一页 */
        $("#prev_collect").click(function () {
            if (page_current_context == 1) {
                alert("已经是最前一页了")
            } else {
                page_current_context--;
                myAjax(page_current_context, 4)
            }
        })

        /* 返回首页 */
        $("#first_collect").click(function () {
            page_current_context = 1;
            myAjax(page_current_context, 4);
        })

        /* 前往尾页 */
        $("#end_collect").click(function () {
            page_current_context = page_end_context;
            myAjax(page_current_context, 4);
        })

        /* Ajax包装方法 */
        function myAjax(page_current, page_size) {
            $.ajax(
                {
                    type: 'get',
                    url: '/get_user_all_collect_question_ajax',
                    dataType: 'json',
                    data: {
                        "user_id":${user.id},
                        "page_current": page_current,
                        "page_size": page_size
                    },
                    success: function (data) {
                        var last = JSON.stringify(data);
                        var json = JSON.parse(last);
                        var collects = json.collects;
                        var pageVo = json.pageVo;
                        console.log(json)
                        $("#queBody_collect").empty();
                        for (i in collects) {
                            $("#queBody_collect").append('<section class="span8">' +
                                '                     <h4 class="category"><a href="/title_go_details?id=' + collects[i].question.id + '">' + collects[i].question.title + '</a></h4>' +
                                '                     <div class=" rlws-like">' +
                                '                            收藏数:<span class="like-count" style="cursor: pointer">' + collects[i].question.praise + '</span>' +
                                '                           <button type="button" class="btn btn-danger" style="float:right" onclick="cancel(' + collects[i].id + ',' + collects[i].question.id + ')">取消收藏</button>' +
                                '                     </div>' +
                                '                     <div class="category-description">' +
                                '                            <p style="display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;overflow: hidden;">' +
                                collects[i].question.content +
                                '                            </p>' +
                                '                      </div>' +
                                '                      </section>');
                        }
                        page_end_context = Math.ceil(pageVo.page_count / pageVo.page_size);
                        $("#all_count_collect").html("总页数:" + page_end_context);
                        $("#current_collect").html("当前页:" + pageVo.page_current);
                    }
                }
            )
        }
    })

    /* 取消我的收藏 */
    function cancel(collect_id,question_id) {
        if (confirm("您确定对该问题取消关注吗?")){
            $.ajax({
                type:"get",
                url:"/user_cancel_question_ajax",
                dataType:"json",
                data:{"collect_id":collect_id,"question_id":question_id},
                success: function (data) {
                    if (data){
                        alert("取消关注成功");
                        $("#myCollect").click();
                    } else {
                        alert("取消关注失败");
                    }
                }
            })
        }
    }
</script>

</body>
</html>