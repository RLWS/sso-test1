<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>用户管理</title>
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
            <a class="navbar-brand" href="#"><i class="fa fa-gear"></i> <strong>用户管理</strong></a>
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
                <li><a class="active-menu" href="/manager_to_user"><i class="fa fa-dashboard"></i> 用户管理</a></li>
                <li><a href="/manager_to_question"><i class="fa fa-desktop"></i>问题管理</a></li>
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
                        用户信息管理
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
                                    <th>用户 Id</th>
                                    <th>用户头像</th>
                                    <th>用户性别</th>
                                    <th>用户昵称</th>
                                    <th>用户邮箱</th>
                                    <th>用户密码</th>
                                    <th>权限</th>
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
                                <button type="button" data-toggle="modal"
                                        data-target="#myModal" class="btn btn-success" style="float: right">添加用户
                                </button>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 模态框（Modal）添加一个用户 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">添加用户信息:</h4>
            </div>
            <div class="modal-body">
                <form id="search-form" class="search-form clearfix" method="post" action="/manager_add_one_user">
                    <center>
                        <table>
                            <tr>
                                <td>用户名:</td>
                                <td><input type="text" name="username" placeholder="请输入用户名" title="请输入用户名!"/></td>
                            </tr>
                            <tr>
                                <td>用户邮箱:</td>
                                <td><input id="email" type="email" name="email" placeholder="请输入用户邮箱" title="请输入用户邮箱!"/>
                                </td>
                            </tr>
                            <tr>
                                <td>用户密码:</td>
                                <td><input id="password_a" type="text" name="password" placeholder="请输入用户密码"
                                           title="请输入用户密码!" maxlength="16" minlength="6"
                                           onkeyup="value=value.replace(/[\u4e00-\u9fa5]/ig,'')"/></td>
                            </tr>
                        </table>
                        <button id="replyModal" type="submit" class="btn btn-success">确认添加</button>
                    </center>
                </form>
            </div>
            <div class="modal-footer">
                <button id="closeModal" type="button" class="btn btn-success" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<!-- 模态框（Modal）添加一个用户 end -->

<!-- 模态框（Modal）修改一个用户 -->
<div class="modal fade" id="myUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">编辑用户信息:</h4>
            </div>
            <div class="modal-body">
                <form class="search-form clearfix" method="post" action="manager_update_user" autocomplete="off">
                    <table class="table">
                        <tbody>
                        <tr>
                            <td>昵称</td>
                            <td>
                                <input type="text" id="user_id" name="id" style="display: none">
                                <input type="text" id="username" name="username" />
                            </td>
                        </tr>
                        <tr>
                            <td>邮箱</td>
                            <td><input type="email" id="useremail" name="email"/></td>
                        </tr>
                        <tr>
                            <td>性别</td>
                            <td>
                                <input type="text" id="userRadios" name="userRadios" value=""/>
                            </td>
                        </tr>
                        <tr>
                            <td>密码</td>
                            <td>
                                <input type="text" id="password" name="password" value="" maxlength="16" minlength="6"
                                       onkeyup="value=value.replace(/[\u4e00-\u9fa5]/ig,'')" />
                            </td>
                        </tr>
                        <tr>
                            <td>头像</td>
                            <td>
                                <input type="text" name="img" id="img" disabled style="display: none">
                                <img src="" id="userImg" width="38px" height="38px">
                            </td>
                        </tr>
                        <tr>
                            <td>权限</td>
                            <td><input type="text" name="power" id="power"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: center;">
                                <button type="submit" class="btn btn-large btn-primary">确定修改</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
            </div>
            <div class="modal-footer">
                <button  type="button" class="btn btn-success" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<!-- 模态框（Modal）修改一个用户 end -->
<script src="static/assets/js/jquery-1.10.2.js"></script>
<script src="static/assets/js/bootstrap.min.js"></script>
<script type="text/javascript">
    var page_current_context = 1;
    var page_end_context = ${page_count == null ? 1 : page_count};
    var url = '/manager_get_all_user';
    var search_context = "";
    $(function () {
        /* 初始化当前页面和尾页(分页) */
        myAjax(1, 7,url);

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
    })

    /* 删除一个用户 */
    function delectUser(user_id) {
        if (confirm("您确认要删除该用户吗")) {
            $.ajax(
                {
                    type: "get",
                    url: "/manager_delect_one_user",
                    dataType: "json",
                    data: {"user_id": user_id},
                    success: function (data) {
                        if (data) {
                            alert("删除成功")
                        } else {
                            alert("删除失败")
                        }
                    }
                }
            )
            myAjax(1, 7,url)
        }
    }

    /* 用户修改信息 */
    function updateUser(user_id) {
        $.ajax(
            {
                type:"get",
                url:"/manager_get_one_user",
                dataType:"json",
                data:{"user_id":user_id},
                success:function (data) {
                    var last = JSON.stringify(data);
                    var json = JSON.parse(last);
                    console.log(json)
                    var sex = json.sex == 0?"女":"男";
                    var img = json.img == null?"static/images/user_head.jpg":json.img;
                    $("#username").val(json.username);
                    $("#useremail").val(json.email);
                    $("#userRadios").val(sex);
                    $("#password").val(json.password);
                    $("#userImg").attr("src",img);
                    $("#user_id").val(json.id)
                    $("#power").val(json.power)
                    $("#img").val(json.img)
                }
            }
        )
    }

    /* 搜索功能实现 */
    $("#searchBtn").click(function () {
        url = '/manager_select_user';
        var search = $("#search").val();
        search_context = search;
        myAjax(1,7,url);
    })

    /* 结束搜索功能实现 */
    $("#searchBtnEnd").click(function () {
        url = '/manager_get_all_user';
        search_context = "";
        myAjax(1,7,url);
    })

    /* Ajax包装方法 */
    function myAjax(page_current, page_size ,urll) {
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
                    var users = json.users;
                    var pageVo = json.pageVo;
                    console.log(json);
                    $("#tableBody").empty();
                    for (i in users) {
                        var sex = users[i].sex == 0 ? '女' : '男';
                        var img = users[i].img == null ? 'static/images/user_head.jpg' : users[i].img;
                        var power = users[i].power == 1 ? '普通用户' : '达人用户';
                        $("#tableBody").append('<tr>\n' +
                            '                        <td style="vertical-align: middle">' + users[i].id + '</td>' +
                            '                        <td style="vertical-align: middle"><img src="' + img + '"' +
                            '                                width="38px" height="38px"></td>' +
                            '                        <td style="vertical-align: middle">' + sex + '</td>' +
                            '                        <td style="vertical-align: middle">' + users[i].username + '</td>' +
                            '                        <td style="vertical-align: middle">' + users[i].email + '</td>' +
                            '                        <td style="vertical-align: middle">' + users[i].password + '</td>' +
                            '                        <td style="vertical-align: middle">' + power + '</td>' +
                            '                        <td style="vertical-align: middle">' +
                            '                            <button type="button" class="btn btn-danger" onclick="delectUser(' + users[i].id + ')">删除</button>' +
                            '                            <button type="button" class="btn btn-info"  data-toggle="modal" data-target="#myUpdateModal" onclick="updateUser(' + users[i].id + ')" >编辑</button>' +
                            '                        </td>' +
                            '                    </tr>')
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