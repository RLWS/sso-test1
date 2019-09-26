<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>问题管理</title>
    <link rel="shortcut icon" href="static/images/rlws.png"/>
    <link href="static/assets/css/bootstrap.css" rel="stylesheet"/>
    <link href="static/assets/css/font-awesome.css" rel="stylesheet"/>
    <link href="static/assets/css/custom-styles.css" rel="stylesheet"/>
</head>
<body>
<div id="wrapper">
    <nav class="navbar navbar-default top-navbar" role="navigation">
        <div class="navbar-header">
            <a class="navbar-brand" href="#"><i class="fa fa-gear"></i> <strong>问题管理</strong></a>
        </div>
        <ul class="nav navbar-top-links navbar-right">
            <li class="dropdown"><a href="#">亲爱的 ${manager.email} 管理员</a></li>
            <li class="dropdown"><a href="/manager_exit">退出登录</a></li>
            <li class="dropdown"><a href="#">&nbsp;</a></li>
        </ul>
    </nav>
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">
                <li><a href="/manager_to_user"><i class="fa fa-dashboard"></i> 用户管理</a></li>
                <li><a class="active-menu" href="/manager_to_question"><i class="fa fa-desktop"></i>问题管理</a></li>
                <li><a href="/manager_to_report"><i class="fa fa-bar-chart-o"></i>举报管理</a></li>
                <li><a href="/manager_to_apply"><i class="fa fa-qrcode"></i>申请管理</a></li>
                <li><a href="/manager_to_recommendation"><i class="fa fa-table"></i>文章管理</a></li>
                <li><a href="/manager_to_category"><i class="fa fa-sitemap"></i> 类别管理</a></li>
            </ul>
        </div>
    </nav>
    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        用户发布问题管理
                        <div style="float: right">
                            <input type="text" id="search">
                            <button id="searchBtn" class="btn btn-info">搜索</button>
                            <button id="searchBtnEnd" class="btn btn-info">结束搜索</button>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>问题 ID</th>
                                    <th>问题题目</th>
                                    <th>问题内容</th>
                                    <th>问题类别</th>
                                    <th>发布时间</th>
                                    <th>发布用户ID</th>
                                    <th>被收藏数</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="tableBody">
                                </tbody>
                            </table>
                            <ul class="pager">
                                <li><a id="first" style="cursor: pointer">首页</a></li>
                                <li><a id="prev" style="cursor: pointer">上一页</a></li>
                                <li><a id="current">当前页:1</a></li>
                                <li><a id="next" style="cursor: pointer">下一页</a></li>
                                <li><a id="end" style="cursor: pointer">尾页</a></li>
                                <li><a id="all_count">总页数:${page_count}</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">请输入您要修改的内容:</h4>
            </div>
            <div class="modal-body">
                <form id="search-form" class="search-form clearfix" method="post" action="manager_update_one_question"
                      autocomplete="off">
                    <table class="table">
                        <tbody>
                        <tr>
                            <td>问题标题</td>
                            <td>
                                <input id="title" type="text" name="title"/>
                                <input id="category_id" type="text" name="category_id" style="display: none"/>
                                <input id="id" type="text" name="id" style="display: none"/>
                                <input id="optimal" type="text" name="optimal" style="display: none"/>
                                <input id="praise" type="text" name="praise" style="display: none"/>
                                <input id="time" type="text" name="time" style="display: none"/>
                                <input id="user_id" type="text" name="user_id" style="display: none"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">详细内容:</td>
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
                                        title="点击进行修改!">确认修改
                                </button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
            </div>
            <div class="modal-footer">
                <button id="closeModal" type="button" class="btn btn-success" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<!-- 模态框（Modal）end -->
<script src="static/assets/js/jquery-1.10.2.js"></script>
<script src="static/assets/js/bootstrap.min.js"></script>
<script src="static/wangeditor/wangEditor.min.js"></script>
<script type="text/javascript">

    /*初始化编辑框*/
    var E = window.wangEditor
    var editor = new E('#editor')
    editor.customConfig.uploadImgServer = '/upload'
    editor.customConfig.uploadFileName = 'wangEditor'
    editor.create()

    editor.txt.html("<h1>test</h1>")

    /*提交时将编辑框的值付给input标签*/
    $("#test").click(function () {
        $("#content").val(editor.txt.html());
        /*获取标签的id用以传入后台服务器*/
        $("#category").val($("#aa").val());
    })

    /* 点击编辑时利用Ajax获取该条问题内容 */
    function editorBtn(question_id){
        $.ajax(
            {
                type:"get",
                url:"manager_editor_question",
                dataType:"json",
                data:{"question_id":question_id},
                success:function (data) {
                    var last = JSON.stringify(data);
                    var json = JSON.parse(last);
                    $("#title").val(json.title)
                    editor.txt.html(json.content)
                    $("#category_id").val(json.category_id)
                    $("#id").val(json.id)
                    $("#optimal").val(json.optimal)
                    $("#praise").val(json.praise)
                    $("#time").val(json.time)
                    $("#user_id").val(json.user_id)
                    console.log(json)
                }
            }
        )
    }

    /* 删除一个问题 */
    function delectQuestion(question_id) {
        if (confirm("您确认要删除该问题吗")) {
            $.ajax(
                {
                    type: "get",
                    url: "/manager_delect_one_question",
                    dataType: "json",
                    data: {"question_id": question_id},
                    success: function (data) {
                        if (data) {
                            alert("删除成功")
                        } else {
                            alert("删除失败")
                        }
                    }
                }
            )
            window.location.reload();
        }
    }
</script>
<script type="text/javascript">
    var page_current_context = 1;
    var page_end_context = ${page_count == null ? 1 : page_count};
    var url = '/get_all_question_ajax';
    var search_context = "";
    $(function () {
        /* 初始化当前页面和尾页(分页) */
        myAjax(1, 7 ,url);

        /* 点击下一页 */
        $("#next").click(function () {
            if (page_current_context < page_end_context) {
                page_current_context++;
                myAjax(page_current_context, 7,url)
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
                myAjax(page_current_context, 7,url)
            }
        })

        /* 返回首页 */
        $("#first").click(function () {
            page_current_context = 1;
            myAjax(page_current_context, 7,url);
        })

        /* 前往尾页 */
        $("#end").click(function () {
            page_current_context = page_end_context;
            myAjax(page_current_context, 7,url);
        })

        /* 搜索功能实现 */
        $("#searchBtn").click(function () {
            url = '/manager_select_Question';
            var search = $("#search").val();
            search_context = search;
            myAjax(1,7,url);
        })

        /* 结束搜索功能实现 */
        $("#searchBtnEnd").click(function () {
            url = '/get_all_question_ajax';
            search_context = "";
            myAjax(1,7,url);
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
                        var question = json.questions;
                        var pageVo = json.pageVo;
                        console.log(json);
                        $("#tableBody").empty();
                        for (i in question) {
                            $("#tableBody").append('<tr>' +
                                '                         <td style="vertical-align: middle">' + question[i].id + '</td>' +
                                '                         <td style="vertical-align: middle;max-width: 100px;overflow: hidden; text-overflow:ellipsis;white-space: nowrap">' + question[i].title + '</td>' +
                                '                         <td style="vertical-align: middle;max-width: 200px;overflow: hidden; text-overflow:ellipsis;white-space: nowrap">' + question[i].content + '</td>' +
                                '                         <td style="vertical-align: middle">' + question[i].category.content + '</td>' +
                                '                         <td style="vertical-align: middle">' + question[i].time + '</td>' +
                                '                         <td style="vertical-align: middle">' + question[i].user.id + '</td>' +
                                '                         <td style="vertical-align: middle">' + question[i].praise + '</td>' +
                                '                         <td style="vertical-align: middle">' +
                                '                             <button type="button" class="btn btn-danger" onclick="delectQuestion('+question[i].id+')">删除</button>' +
                                '                             <a type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal" onclick="editorBtn('+question[i].id+')">编辑</a>' +
                                '                             <a href="/title_go_details?id=' + question[i].id + '" class="btn btn-success">查看</a>' +
                                '                         </td>' +
                                '                     </tr>')
                        }
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
