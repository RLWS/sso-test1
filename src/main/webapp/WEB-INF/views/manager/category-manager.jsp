<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>类别管理</title>
    <link rel="shortcut icon" href="static/images/rlws.png"/>
    <link href="static/assets/css/bootstrap.css" rel="stylesheet"/>
    <link href="static/assets/css/font-awesome.css" rel="stylesheet"/>
    <link href="static/assets/css/custom-styles.css" rel="stylesheet"/>
    <link href="static/js/dropzone/basic.min.css" media='all'>
    <link href="static/js/dropzone/dropzone.min.css" media='all'>
</head>

<body>
<div id="wrapper">
    <%-- 顶部代码 --%>
    <nav class="navbar navbar-default top-navbar" role="navigation">
        <div class="navbar-header">
            <a class="navbar-brand" href="#"><i class="fa fa-gear"></i> <strong>类别管理</strong></a>
        </div>
        <ul class="nav navbar-top-links navbar-right">
            <li class="dropdown"><a href="#">亲爱的 ${manager.email} 管理员</a></li>
            <li class="dropdown"><a href="/manager_exit">退出登录</a></li>
            <li class="dropdown"><a href="#">&nbsp;</a></li>
        </ul>
    </nav>
    <%-- 左边代码 --%>
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">
                <li><a href="/manager_to_user"><i class="fa fa-dashboard"></i> 用户管理</a></li>
                <li><a href="/manager_to_question"><i class="fa fa-desktop"></i>问题管理</a></li>
                <li><a href="/manager_to_report"><i class="fa fa-bar-chart-o"></i>举报管理</a></li>
                <li><a href="/manager_to_apply"><i class="fa fa-qrcode"></i>申请管理</a></li>
                <li><a href="/manager_to_recommendation"><i class="fa fa-table"></i>文章管理</a></li>
                <li><a class="active-menu" href="/manager_to_category"><i class="fa fa-sitemap"></i> 类别管理</a></li>
            </ul>
        </div>
    </nav>
    <div id="page-wrapper">
        <div id="page-inner">
            <div class="row">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        类别信息管理
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>类别 Id</th>
                                    <th>类别名称</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="tableBody">
                                <tr>
                                    <td style="vertical-align: middle">' + users[i].id + '</td>
                                    <td style="vertical-align: middle">' + users[i].id + '</td>
                                    <td style="vertical-align: middle">
                                        <button type="button" class="btn btn-danger" onclick="delectUser()">删除</button>
                                        <button type="button" class="btn btn-info" data-toggle="modal"
                                                data-target="#myUpdateModal" onclick="updateCategory()">编辑
                                        </button>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                            <ul class="pager">
                                <li><a id="first" style="cursor: pointer">首页</a></li>
                                <li><a id="prev" style="cursor: pointer">上一页</a></li>
                                <li><a id="current">当前页:1</a></li>
                                <li><a id="next" style="cursor: pointer">下一页</a></li>
                                <li><a id="end" style="cursor: pointer">尾页</a></li>
                                <li><a id="all_count">总页数:${page_count}</a></li>
                                <button type="button" data-toggle="modal"
                                        data-target="#myModal" class="btn btn-success" style="float: right">添加类别
                                </button>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 模态框（Modal）添加一个类别 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">添加类别:</h4>
            </div>
            <div class="modal-body">
                <input type="text" name="username" placeholder="请输入类别名" title="请输入类别名!" id="addCategory"/>
                <button type="submit" class="btn btn-success" onclick="addCategory()">确认添加</button>
            </div>
            <div class="modal-footer">
                <button id="closeModal" type="button" class="btn btn-success" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<!-- 模态框（Modal）添加一个类别 end -->

<!-- 模态框（Modal）修改一个类别 -->
<div class="modal fade" id="myUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">编辑类别信息:</h4>
            </div>
            <div class="modal-body">
                类别  ID:<input type="text" id="category_id" name="id" readonly>
                类别名称:<input type="text" id="content" name="content"/>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-large btn-primary" onclick="updateCategory()">确定修改</button>
                <button type="button" class="btn btn-success" data-dismiss="modal" id="updateModal">关闭</button>
            </div>
        </div>
    </div>
</div>
<!-- 模态框（Modal）修改一个用户 end -->
<script src="static/assets/js/jquery-1.10.2.js"></script>
<script src="static/assets/js/bootstrap.min.js"></script>
<script type="text/javascript">
    var page_current_context = 1;
    var page_end_context = 1;
    var url = '/manager_get_all_category';
    $(function () {
        /* 初始化当前页面和尾页(分页) */
        myAjax(1, 7, url);

        /* 点击下一页 */
        $("#next").click(function () {
            if (page_current_context < page_end_context) {
                page_current_context++;
                myAjax(page_current_context, 7, url)
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
                myAjax(page_current_context, 7, url)
            }
        })

        /* 返回首页 */
        $("#first").click(function () {
            page_current_context = 1;
            myAjax(page_current_context, 7, url);
        })

        /* 前往尾页 */
        $("#end").click(function () {
            page_current_context = page_end_context;
            myAjax(page_current_context, 7, url);
        })
    })

    /* 删除一个类别 */
    function delectCategory(category_id) {
        if (confirm("您确认要删除该类别吗?这将会删除该类别下的所有问题!!!")) {
            $.ajax(
                {
                    type: "get",
                    url: "/manager_delete_one_category",
                    dataType: "json",
                    data: {"category_id": category_id},
                    success: function (data) {
                        if (data) {
                            myAjax(page_current_context, 7, url);
                            alert("删除成功");
                        } else {
                            alert("删除失败")
                        }
                    }
                }
            )

        }
    }

    /* 添加一个类别 */
    function addCategory() {
        if (confirm("您确认要添加一个类别吗")) {
            var content = $("#addCategory").val();
            $.ajax(
                {
                    type: "post",
                    url: "/manager_add_one_category",
                    dataType: "json",
                    data: {"content": content},
                    success: function (data) {
                        if (data) {
                            $("#closeModal").click();
                            myAjax(page_current_context, 7, url);
                            alert("添加成功")
                        } else {
                            alert("添加失败")
                        }
                    }
                }
            )
            myAjax(1, 7, url)
        }
    }

    /* 编辑类别(提交编辑) */
    function updateCategory() {
        var id = $("#category_id").val();
        var content = $("#content").val();
        $.ajax(
            {
                type: "post",
                url: "/manager_update_one_category",
                dataType: "json",
                data: {"id": id,"content":content},
                success: function (data) {
                    if (data) {
                        $("#updateModal").click();
                        myAjax(page_current_context, 7, url);
                        alert("修改成功")
                    } else {
                        alert("修改失败")
                    }
                }
            }
        )
    }

    /* 编辑类别(点击编辑) */
    function clickUpdate(category_id) {
        $.ajax(
            {
                type: "get",
                url: "/manager_select_one_category",
                dataType: "json",
                data: {"category_id": category_id},
                success: function (data) {
                    var last = JSON.stringify(data);
                    var json = JSON.parse(last);
                    console.log(json)
                    $("#category_id").val(json.id);
                    $("#content").val(json.content);
                }
            }
        )
    }

    /* Ajax包装方法 */
    function myAjax(page_current, page_size, urll) {
        $.ajax(
            {
                type: 'get',
                url: urll,
                dataType: 'json',
                data: {
                    "page_current": page_current,
                    "page_size": page_size
                },
                success: function (data) {
                    var last = JSON.stringify(data);
                    var json = JSON.parse(last);
                    var categories = json.categories;
                    var pageVo = json.pageVo;
                    console.log(json);
                    $("#tableBody").empty();
                    for (i in categories) {
                        $("#tableBody").append('<tr>\n' +
                            '                         <td style="vertical-align: middle">' + categories[i].id + '</td>' +
                            '                         <td style="vertical-align: middle">' + categories[i].content + '</td>' +
                            '                         <td style="vertical-align: middle">' +
                            '                             <button type="button" class="btn btn-danger" onclick="delectCategory(' + categories[i].id + ')">删除</button>\n' +
                            '                             <button type="button" class="btn btn-info"  data-toggle="modal" data-target="#myUpdateModal" onclick="clickUpdate('+ categories[i].id + ')" >编辑</button>\n' +
                            '                         </td>' +
                            '                     </tr>')
                    }
                    page_end_context = Math.ceil(pageVo.page_count / pageVo.page_size);
                    page_current_context = page_current;
                    $("#all_count").html("总页数:" + page_end_context);
                    $("#current").html("当前页:" + pageVo.page_current);
                }
            }
        )
    }


</script>
</body>
</html>