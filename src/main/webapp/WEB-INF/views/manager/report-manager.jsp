<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>举报管理</title>
    <link rel="shortcut icon" href="static/images/rlws.png"/>
    <link href="static/assets/css/bootstrap.css" rel="stylesheet"/>
    <link href="static/assets/css/font-awesome.css" rel="stylesheet"/>
    <link href="static/assets/css/custom-styles.css" rel="stylesheet"/>
</head>
<body>
<div id="wrapper">

    <nav class="navbar navbar-default top-navbar" role="navigation">
        <div class="navbar-header">
            <a class="navbar-brand" href="#"><i class="fa fa-gear"></i> <strong>举报管理</strong></a>
        </div>

        <ul class="nav navbar-top-links navbar-right">
            <li class="dropdown">
                <a href="#">
                    亲爱的 ${manager.email} 管理员
                </a>
            </li>
            <li class="dropdown">
                <a href="/manager_exit">
                    退出登录
                </a>
            </li>
            <li class="dropdown">
                <a href="#">&nbsp;
                </a>
            </li>
        </ul>
    </nav>
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">
                <li>
                    <a href="/manager_to_user"><i class="fa fa-dashboard"></i> 用户管理</a>
                </li>
                <li>
                    <a href="/manager_to_question"><i class="fa fa-desktop"></i>问题管理</a>
                </li>
                <li>
                    <a class="active-menu" href="/manager_to_report"><i class="fa fa-bar-chart-o"></i>举报管理</a>
                </li>
                <li>
                    <a href="/manager_to_apply"><i class="fa fa-qrcode"></i>申请管理</a>
                </li>

                <li>
                    <a href="/manager_to_recommendation"><i class="fa fa-table"></i>文章管理</a>
                </li>
                <li><a href="/manager_to_category"><i class="fa fa-sitemap"></i> 类别管理</a></li>
            </ul>

        </div>

    </nav>

    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <ul id="myTab" class="nav nav-tabs">
                    <li class="active">
                        <a href="#talent_release" data-toggle="tab" id="reportQuestion">用户举报问题管理</a>
                    </li>
                    <li><a href="#talent_manager" data-toggle="tab" id="reportAnswer">用户举报回答管理</a></li>
                </ul>
                <div id="myTabContent" class="tab-content">
                    <div class="tab-pane fade in active" id="talent_release">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                用户举报问题管理
                            </div>
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered table-hover">
                                        <thead>
                                        <tr>
                                            <th>举报 ID</th>
                                            <th>被举报问题ID</th>
                                            <th>被举报Title</th>
                                            <th>举报人</th>
                                            <th>举报人昵称</th>
                                            <th>举报信息</th>
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
                    <div class="tab-pane fade" id="talent_manager">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                用户举报答案管理
                            </div>
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered table-hover">
                                        <thead>
                                        <tr>
                                            <th>举报 ID</th>
                                            <th>被举报回答ID</th>
                                            <th>被举报内容</th>
                                            <th>举报人</th>
                                            <th>举报人昵称</th>
                                            <th>举报信息</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody id="tableBody_answer">

                                        </tbody>
                                    </table>
                                    <ul class="pager">
                                        <li><a id="first_answer" style="cursor: pointer">首页</a></li>
                                        <li><a id="prev_answer" style="cursor: pointer">上一页</a></li>
                                        <li><a id="current_answer">当前页:1</a></li>
                                        <li><a id="next_answer" style="cursor: pointer">下一页</a></li>
                                        <li><a id="end_answer" style="cursor: pointer">尾页</a></li>
                                        <li><a id="all_count_answer">总页数:${page_count}</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">具体的回答内容:</h4>
            </div>
            <div class="modal-body">
                回答用户:<span style="color: #fd8e3d" id="username"></span><br>
                回答时间:<span style="color: #fd8e3d" id="answerTime"></span>
                <textarea rows="5" id="answer_content" style="width: 95%" name="content" disabled></textarea>
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
<script>
    /* 被举报问题的获取 */
    $(function () {
        /* 初始化当前页面和尾页(分页) */
        var page_current_context = 1;
        var page_end_context = ${page_count == null ? 1 : page_count};
        myAjax(1, 7);

        /* 点击下一页 */
        $("#next").click(function () {
            if (page_current_context < page_end_context) {
                page_current_context++;
                myAjax(page_current_context, 7)
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
                myAjax(page_current_context, 7)
            }
        })

        /* 返回首页 */
        $("#first").click(function () {
            page_current_context = 1;
            myAjax(page_current_context, 7);
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
                    url: '/get_report_question_ajax',
                    dataType: 'json',
                    data: {
                        "search": "",
                        "page_current": page_current,
                        "page_size": page_size
                    },
                    success: function (data) {
                        var last = JSON.stringify(data);
                        var json = JSON.parse(last);
                        var reports = json.reports;
                        var pageVo = json.pageVo;
                        console.log(json);
                        $("#tableBody").empty();
                        for (i in reports) {
                            $("#tableBody").append('<tr>\n' +
                                '                        <td style="vertical-align: middle">' + reports[i].id + '</td>\n' +
                                '                        <td style="vertical-align: middle;">' + reports[i].question_id + '</td>\n' +
                                '                        <td style="vertical-align: middle;max-width: 100px;overflow: hidden; text-overflow:ellipsis;white-space: nowrap">' + reports[i].question.title + '</td>\n' +
                                '                        <td style="vertical-align: middle">' + reports[i].user_id + '</td>\n' +
                                '                        <td style="vertical-align: middle">' + reports[i].user.username + '</td>\n' +
                                '                        <td style="vertical-align: middle;max-width: 200px;overflow: hidden; text-overflow:ellipsis;white-space: nowrap">' + reports[i].content + '</td>\n' +
                                '                        <td style="vertical-align: middle">\n' +
                                '                            <button type="button" class="btn btn-danger" onclick="delectQuestion(' + reports[i].question_id + ')">删除该条问题</button>\n' +
                                '                            <button type="button" class="btn btn-warning" onclick="delectReport(' + reports[i].id + ')">忽略</button>\n' +
                                '                            <a href="/title_go_details?id=' + reports[i].question_id + '" class="btn btn-success">查看</a>' +
                                '                        </td>\n' +
                                '                    </tr>')
                        }
                        page_end_context = Math.ceil(pageVo.page_count / pageVo.page_size);
                        $("#all_count").html("总页数:" + page_end_context);
                        $("#current").html("当前页:" + pageVo.page_current);
                    }
                }
            )
        }
    })

    /* 被举报回答的获取 */
    $(function () {
        /* 初始化当前页面和尾页(分页) */
        var page_current_context = 1;
        var page_end_context = ${page_count == null ? 1 : page_count};

        $("#reportAnswer").click(function () {
            myAjax(1, 7);
        })

        /* 点击下一页 */
        $("#next_answer").click(function () {
            if (page_current_context < page_end_context) {
                page_current_context++;
                myAjax(page_current_context, 7)
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
                myAjax(page_current_context, 7)
            }
        })

        /* 返回首页 */
        $("#first_answer").click(function () {
            page_current_context = 1;
            myAjax(page_current_context, 7);
        })

        /* 前往尾页 */
        $("#end_answer").click(function () {
            page_current_context = page_end_context;
            myAjax(page_current_context, 7);
        })

        /* Ajax包装方法 */
        function myAjax(page_current, page_size) {
            $.ajax(
                {
                    type: 'get',
                    url: '/get_report_answer_ajax',
                    dataType: 'json',
                    data: {
                        "search": "",
                        "page_current": page_current,
                        "page_size": page_size
                    },
                    success: function (data) {
                        var last = JSON.stringify(data);
                        var json = JSON.parse(last);
                        var reports = json.reports;
                        var pageVo = json.pageVo;
                        console.log(json);
                        $("#tableBody_answer").empty();
                        for (i in reports) {
                            $("#tableBody_answer").append('<tr>\n' +
                                '                        <td style="vertical-align: middle">' + reports[i].id + '</td>\n' +
                                '                        <td style="vertical-align: middle;">' + reports[i].answer_id + '</td>\n' +
                                '                        <td style="vertical-align: middle;max-width: 260px;overflow: hidden; text-overflow:ellipsis;white-space: nowrap">' + reports[i].answer.content + '</td>\n' +
                                '                        <td style="vertical-align: middle">' + reports[i].user_id + '</td>\n' +
                                '                        <td style="vertical-align: middle">' + reports[i].user.username + '</td>\n' +
                                '                        <td style="vertical-align: middle;max-width: 200px;overflow: hidden; text-overflow:ellipsis;white-space: nowrap">' + reports[i].content + '</td>\n' +
                                '                        <td style="vertical-align: middle">\n' +
                                '                            <button type="button" class="btn btn-danger" onclick="delectAnswer(' + reports[i].answer_id + ')">删除该条回答</button>\n' +
                                '                            <button type="button" class="btn btn-warning" onclick="delectReport(' + reports[i].id + ')">忽略</button>\n' +
                                '                            <a class="btn btn-success" data-toggle="modal" data-target="#myModal" onclick="seeAnswer(' + reports[i].answer_id + ')">查看</a>' +
                                '                        </td>\n' +
                                '                    </tr>')
                        }
                        page_end_context = Math.ceil(pageVo.page_count / pageVo.page_size);
                        $("#all_count_answer").html("总页数:" + page_end_context);
                        $("#current_answer").html("当前页:" + pageVo.page_current);
                    }
                }
            )
        }
    })
</script>
<script>
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

    /* 删除一个回答 */
    function delectAnswer(answer_id) {
        if (confirm("您确认要删除该回答吗")) {
            $.ajax(
                {
                    type: "get",
                    url: "/manager_delete_one_answer",
                    dataType: "json",
                    data: {"answer_id": answer_id},
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

    /* 忽略一个举报 */
    function delectReport(report_id) {
        if (confirm("您确认要忽略该举报吗")) {
            $.ajax(
                {
                    type: "get",
                    url: "/manager_delete_one_report",
                    dataType: "json",
                    data: {"report_id": report_id},
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

    /* 查看具体的回答 */
    function seeAnswer(answer_id) {
        $.ajax(
            {
                type: "get",
                url: "/manager_search_one_answer",
                dataType: "json",
                data: {"answer_id": answer_id},
                success: function (data) {
                    var list = JSON.stringify(data);
                    var json = JSON.parse(list);
                    console.log(data)
                    $("#answer_content").val(json.content);
                    $("#answerTime").html(json.time);
                    $("#username").html(json.user.username);
                }
            }
        )
    }
</script>
</body>
</html>
