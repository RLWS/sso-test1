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
                <ul id="myTab" class="nav nav-tabs">
                    <li class="active">
                        <a href="#talent_release" data-toggle="tab">达人文章发布</a>
                    </li>
                    <li><a href="#talent_manager" data-toggle="tab" id="talentMsg">达人文章管理</a></li>
                </ul>
                <div id="myTabContent" class="tab-content">
                    <div class="tab-pane fade in active" id="talent_release">
                        <form id="search-form" class="search-form clearfix" method="post" action="user_talent_release"
                              autocomplete="off" style="margin-top: 0">
                            <table class="table">
                                <caption>达人文章发布</caption>
                                <thead>
                                <tr>
                                    <th></th>
                                    <th><input type="text" style="display: none" value="${user.id}" name="user_id"></th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>文章标题</td>
                                    <td>
                                        <input type="text" name="title"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">详细内容:</td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <input type="text" name="content" id="content" style="display: none">
                                        <div id="editor">
                                            <p>请在次填写文章的详细内容...</p>
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
                    <div class="tab-pane fade" id="talent_manager">
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
<script type='text/javascript' src='static/js/jquery-3.3.1.js'></script>
<script type='text/javascript' src='static/js/bootstrap.min.js'></script>
<script type='text/javascript' src='static/js/jquery.easing.1.3.js'></script>
<script type='text/javascript' src='static/js/jquery.liveSearch.js'></script>
<script type='text/javascript' src='static/js/jquery.form.js'></script>
<script type='text/javascript' src='static/js/jquery.validate.min.js'></script>
<script type="text/javascript" src="static/wangeditor/wangEditor.min.js"></script>

<script type="text/javascript">
    /* 初始化编辑框 */
    $(function () {
        /*初始化编辑框*/
        var E = window.wangEditor
        var editor = new E('#editor')
        editor.customConfig.uploadImgServer = '/upload'
        editor.customConfig.uploadFileName = 'wangEditor'
        editor.create()

        /*提交时将编辑框的值付给input标签*/
        $("#test").click(function () {
            $("#content").val(editor.txt.html());
            /*获取标签的id用以传入后台服务器*/
            $("#category").val($("#aa").val());
        })
    })
    /* 获取达人发布的所有文章 */
    $(function () {
        $("#talentMsg").click(function () {
            /* 初始化当前页面和尾页(分页) */
            var page_current_context = 1;
            var page_end_context = ${page_count == null ? 1 : page_count};
            myAjax(1, 4);
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
                myAjax(page_current_context, 7);
            })

            /* Ajax包装方法 */
            function myAjax(page_current, page_size) {
                $.ajax(
                    {
                        type: 'get',
                        url: '/user_talent_get_all_recommendation',
                        dataType: 'json',
                        data: {
                            "user_id":${user.id},
                            "page_current": page_current,
                            "page_size": page_size
                        },
                        success: function (data) {
                            var last = JSON.stringify(data);
                            var json = JSON.parse(last);
                            var recommendations = json.recommendations;
                            var pageVo = json.pageVo;
                            console.log(json);
                            $("#queBody").empty();
                            for (i in recommendations) {
                                $("#queBody").append('<section class="span8">' +
                                    '                   <h4 class="category"><a href="to_recommendation_details?id=' + recommendations[i].id + '">' + recommendations[i].title + '</a></h4>' +
                                    '                      <div class=" rlws-like">' +
                                    '                         <span class="article-meta">' + recommendations[i].time + '</span>' +
                                    '                       <button type="button" class="btn btn-danger" style="float:right" onclick="del(' + recommendations[i].id + ')">删除</button>' +
                                    '                       </div>' +
                                    '                       <div class="category-description">' +
                                    '                             <p style="display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;overflow: hidden;">' +
                                    recommendations[i].content +
                                    '                             </p>' +
                                    '                        </div>' +
                                    '                  </section>')
                            }
                            page_end_context = Math.ceil(pageVo.page_count / pageVo.page_size);
                            $("#all_count").html("总页数:" + page_end_context);
                            $("#current").html("当前页:" + pageVo.page_current);
                        }
                    }
                )
            }
        })
    })
    /* 删除一篇文章 */
    function del(id) {
        var recommendationId = id;
        if (confirm("您确定删除该文章吗?")){
            $.ajax(
                {
                    type: "post",
                    url: "/user_delect_one_recommendation_ajax",
                    dataType: "json",
                    data: {recommendationId: recommendationId},
                    success: function (data) {
                        if (data) {
                            alert("删除成功!")
                            $("#talentMsg").click();
                        } else {
                            alert("删除失败!")
                        }
                    }
                }
            )
        }
    }
    /* 修改一篇文章 */
</script>

</body>
</html>