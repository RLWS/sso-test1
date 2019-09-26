<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>文章管理</title>
    <link rel="shortcut icon" href="static/images/rlws.png"/>
    <link href="static/assets/css/bootstrap.css" rel="stylesheet"/>
    <link href="static/assets/css/font-awesome.css" rel="stylesheet"/>
    <link href="static/assets/css/custom-styles.css" rel="stylesheet"/>
</head>
<body>
<div id="wrapper">
    <nav class="navbar navbar-default top-navbar" role="navigation">
        <div class="navbar-header">
            <a class="navbar-brand" href="#"><i class="fa fa-gear"></i> <strong>文章管理</strong></a>
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
                    <a href="/manager_to_apply"><i class="fa fa-qrcode"></i>申请管理</a>
                </li>

                <li>
                    <a class="active-menu" href="/manager_to_recommendation"><i class="fa fa-table"></i>文章管理</a>
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
                        用户推荐文章管理
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>文章 ID</th>
                                    <th>文章题目</th>
                                    <th>文章内容</th>
                                    <th>发布时间</th>
                                    <th>发布用户ID</th>
                                    <th>发布用户昵称</th>
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
                <h4 class="modal-title">请编辑您要修改的内容:</h4>
            </div>
            <div class="modal-body">
                <form id="search-form" class="search-form clearfix" method="post" action="manager_update_one_recommendation"
                      autocomplete="off">
                    <table class="table">
                        <tbody>
                        <tr>
                            <td>文章标题</td>
                            <td>
                                <input id="title" type="text" name="title" style="width: 400px"/>
                                <input id="id" type="text" name="id" style="display: none"/>
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
                                    <p>...</p>
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
                    url: '/manager_get_all_recommendation',
                    dataType: 'json',
                    data: {
                        "search": "",
                        "page_current": page_current,
                        "page_size": page_size
                    },
                    success: function (data) {
                        var last = JSON.stringify(data);
                        var json = JSON.parse(last);
                        var recommendations = json.recommendations;
                        var pageVo = json.pageVo;
                        console.log(json);
                        $("#tableBody").empty();
                        for (i in recommendations) {
                            $("#tableBody").append('<tr>\n' +
                                '                         <td style="vertical-align: middle">'+recommendations[i].id+'</td>\n' +
                                '                         <td style="vertical-align: middle;max-width: 100px;overflow: hidden; text-overflow:ellipsis;white-space: nowrap">'+recommendations[i].title+'</td>\n' +
                                '                         <td style="vertical-align: middle;max-width: 200px;overflow: hidden; text-overflow:ellipsis;white-space: nowrap">'+recommendations[i].content+'</td>\n' +
                                '                         <td style="vertical-align: middle">'+recommendations[i].time+'</td>\n' +
                                '                         <td style="vertical-align: middle">'+recommendations[i].user.id+'</td>\n' +
                                '                         <td style="vertical-align: middle">'+recommendations[i].user.username+'</td>\n' +
                                '                         <td style="vertical-align: middle">\n' +
                                '                             <button type="button" class="btn btn-danger" onclick="delectRecommendation('+recommendations[i].id+')">删除</button>\n' +
                                '                             <button type="button" class="btn btn-info"  data-toggle="modal" data-target="#myModal" onclick="editorBtn(' + recommendations[i].id + ')" >编辑</button>' +
                                '                             <a href="to_recommendation_details?id='+recommendations[i].id+'" type="button" class="btn btn-success">查看</a>\n' +
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

    /* 点击编辑时利用Ajax获取该条推荐文章内容 */
    function editorBtn(recommendation_id){
        $.ajax(
            {
                type:"get",
                url:"manager_get_recommendation_details",
                dataType:"json",
                data:{"recommendation_id":recommendation_id},
                success:function (data) {
                    var last = JSON.stringify(data);
                    var json = JSON.parse(last);
                    $("#title").val(json.title)
                    editor.txt.html(json.content)
                    $("#id").val(json.id)
                    $("#time").val(json.time)
                    $("#user_id").val(json.user_id)
                    console.log(json)
                }
            }
        )
    }

    /* 删除一个推荐文章 */
    function delectRecommendation(recommendation_id) {
        if (confirm("您确认要删除该推荐吗")) {
            $.ajax(
                {
                    type: "post",
                    url: "/manager_delect_one_recommendation_ajax",
                    dataType: "json",
                    data: {"recommendationId": recommendation_id},
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
</body>
</html>
