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
                <img src="${user.img == null? "static/images/user_head.jpg" : user.img}" style="height: 120px;width: 120px">
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
                <form id="search-form" class="search-form clearfix" method="post" action="add_one_question" autocomplete="off">
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
                                <input type="text" name="category" id="category" style="display: none">
                                <select class="form-control" id="aa">
                                    <%-- 获取所有的植物类别选项 --%>
                                    <c:forEach items="${categories}" var="item">
                                        <option value="${item.id}">${item.content}</option>
                                    </c:forEach>
                                </select>
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
                                <button id="test" type="submit" class="btn btn-large btn-primary submit" title="点击进行发布!">点击发布</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
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
<script type='text/javascript' src='static/js/jquery.easing.1.3.js'></script>
<script type='text/javascript' src='static/js/jquery.liveSearch.js'></script>
<script type='text/javascript' src='static/js/jquery.form.js'></script>
<script type='text/javascript' src='static/js/jquery.validate.min.js'></script>
<script type="text/javascript" src="static/wangeditor/wangEditor.min.js"></script>

<script type="text/javascript">
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
</script>

</body>
</html>