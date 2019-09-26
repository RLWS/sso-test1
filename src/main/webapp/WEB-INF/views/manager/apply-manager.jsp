<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>申请管理</title>
    <link rel="shortcut icon" href="static/images/rlws.png"/>
    <link href="static/assets/css/bootstrap.css" rel="stylesheet"/>
    <link href="static/assets/css/font-awesome.css" rel="stylesheet"/>
    <link href="static/assets/css/custom-styles.css" rel="stylesheet"/>
</head>
<body>
<div id="wrapper">
    <nav class="navbar navbar-default top-navbar" role="navigation">
        <div class="navbar-header">
            <a class="navbar-brand" href="#"><i class="fa fa-gear"></i> <strong>申请管理</strong></a>
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
                    <a href="/manager_to_report"><i class="fa fa-bar-chart-o"></i>举报管理</a>
                </li>
                <li>
                    <a class="active-menu" href="/manager_to_apply"><i class="fa fa-qrcode"></i>申请管理</a>
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
                <div class="panel panel-default">
                    <div class="panel-heading">
                        用户达人申请管理
                        <div style="float: right">
                            <input type="number" id="apply" value="${BestAnswerCount}">
                            <button id="updateApplyBtn" class="btn btn-info">修改申请要求次数</button>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>申请 ID</th>
                                    <th>申请理由</th>
                                    <th>申请时间</th>
                                    <th>申请用户ID</th>
                                    <th>申请用户昵称</th>
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
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">请您查看用户的详细问答情况:</h4>
            </div>
            <div class="modal-body">
                用户昵称:<span style="color: #fd8e3d" id="username">暖暖</span><br>
                最佳回答:<span style="color: #fd8e3d" id="bestCount">5</span>条<br>
                发布问题:<span style="color: #fd8e3d" id="questionCount">5</span>条<br>
                回答问题:<span style="color: #fd8e3d" id="answerCount">5</span>条<br>
                回复回答:<span style="color: #fd8e3d" id="replyCount">5</span>条
                <textarea rows="5" id="content" style="width: 95%" name="content" disabled></textarea>
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
<script type="text/javascript">
    $(function () {
        /* 初始化当前页面和尾页(分页) */
        var page_current_context = 1;
        var page_end_context = ${page_count == null ? 1 : page_count};
        myAjax(1, 7);

        /* 点击修改达人申请条件 */
        $("#updateApplyBtn").click(function () {
            var num = $("#apply").val();
            if (confirm("您确定要修改申请成为达人的条件么?")){
                $.ajax({
                    type:"get",
                    url:"manager_update_apply_count",
                    dataType:"json",
                    data:{"num":num},
                    success:function (data) {
                        if (data){
                            alert("修改成功!");
                        }
                    },error:function () {
                        alert("修改失败!");
                    }
                })
            }
        })

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
                    url: '/get_all_apply_user_ajax',
                    dataType: 'json',
                    data: {
                        "search": "",
                        "page_current": page_current,
                        "page_size": page_size
                    },
                    success: function (data) {
                        var last = JSON.stringify(data);
                        var json = JSON.parse(last);
                        var applies = json.applies;
                        var pageVo = json.pageVo;
                        console.log(json);
                        $("#tableBody").empty();
                        for (i in applies) {
                            $("#tableBody").append('<tr>\n' +
                                '                         <td style="vertical-align: middle">'+applies[i].id+'</td>\n' +
                                '                         <td style="vertical-align: middle;max-width: 200px;overflow: hidden; text-overflow:ellipsis;white-space: nowrap" class="adsf">'+applies[i].content+'</td>\n' +
                                '                         <td style="vertical-align: middle">'+applies[i].time+'</td>\n' +
                                '                         <td style="vertical-align: middle">'+applies[i].user.id+'</td>\n' +
                                '                         <td style="vertical-align: middle" class="fdsa">'+applies[i].user.username+'</td>\n' +
                                '                         <td style="vertical-align: middle">\n' +
                                '                             <button type="button" class="btn btn-success" onclick="agreeApply('+applies[i].id+','+applies[i].user.id+')">同意</button>\n' +
                                '                             <button type="button" class="btn btn-warning" onclick="deleteApply('+applies[i].id+')">忽略</button>\n' +
                                '                             <button type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal" onclick="searchUser('+applies[i].user.id+',this)">查看用户信息</button>\n' +
                                '                         </td>\n' +
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
<script>
    /* 点击查看申请用户的详细信息 */
    function searchUser(user_id,obj) {
        $.ajax(
            {
                type:"get",
                url:"manager_get_user_message",
                datatype:"json",
                data:{"user_id":user_id},
                success:function (data) {
                    var list = JSON.stringify(data);
                    var json = JSON.parse(list);
                    console.log(json);
                    $("#questionCount").html(json.questionCount);
                    $("#answerCount").html(json.answerCount);
                    $("#replyCount").html(json.replyCount);
                    $("#bestCount").html(json.bestCount);
                    $("#content").html($(obj).parent().siblings(".adsf").html())
                    $("#username").html($(obj).parent().siblings(".fdsa").html())
                }
            }
        )
    }

    /* 点击忽略删除一条数据 */
    function deleteApply(apply_id) {
        if (confirm("您确认要忽略该申请吗")) {
            $.ajax(
                {
                    type: "get",
                    url: "/manager_delete_one_apply",
                    dataType: "json",
                    data: {"apply_id": apply_id},
                    success: function (data) {
                        if (data) {
                            alert("忽略成功")
                        } else {
                            alert("忽略失败")
                        }
                    }
                }
            )
            window.location.reload();
        }
    }

    /* 点击同意用户成为达人用户 */
    function agreeApply(apply_id,user_id) {
        if (confirm("您确认要同意该申请吗")) {
            $.ajax(
                {
                    type: "get",
                    url: "/manager_agree_user_apply",
                    dataType: "json",
                    data: {"apply_id": apply_id,"user_id":user_id},
                    success: function (data) {
                        if (data) {
                            alert("操作成功")
                        } else {
                            alert("操作失败")
                        }
                    }
                }
            )
            window.location.reload();
        }
    }
</script>
</body>
</html>
