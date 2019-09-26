<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>植物问答平台-用户消息</title>
    <link rel="shortcut icon" href="static/images/rlws.png"/>
    <link rel='stylesheet' id='bootstrap-css-css' href='static/css/bootstrap5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='responsive-css-css' href='static/css/responsive5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='main-css-css' href='static/css/main5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='green-skin-css' href='static/css/green-skin5152.css' type='text/css' media='all'/>
    <link rel='stylesheet' id='user-center-css' href='static/css/user-center-css.css' type='text/css' media='all'/>
    <link rel='stylesheet' href='static/css/message.css' type='text/css'/>
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
                <img src="${user.img == null? "static/images/user_head.jpg" : user.img}">
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
                <div class="row">
                    <div class="span2">
                        <ul class="mesaul">
                            <c:forEach items="${userList}" var="item">
                                <li value="${item.id}">
                                    <img src="${item.img == null? 'static/images/user_head.jpg' : item.img}" alt="头像">
                                    <h4><a>${item.username}</a></h4>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="span6">
                        <div class="ri">
                            <div class="area" id="area">
                                <pre>请点击左侧的用户进行信息发送</pre>
                            </div>
                            <div class="rig">
                                <input id="user_id_j" type="text" value="${userId==null?"0":userId}" style="margin: 0 ;width: 50px;text-align: center" readonly>
                                <b>您正在与<i id="otherUser" style="color:#8F3E00;">${username == null?"您还未选择接收用户":username}</i>进行消息通话</b>
                                <textarea rows="5" id="content"></textarea>
                                <button id="btn_message" class="btn btn-default">发送信息</button>
                            </div>
                        </div>

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
<script type='text/javascript' src='static/js/jquery.easing.1.3.js'></script>
<script type='text/javascript' src='static/js/jquery.liveSearch.js'></script>
<script type='text/javascript' src='static/js/jquery.form.js'></script>
<script type='text/javascript' src='static/js/jquery.validate.min.js'></script>
<script>
    $(function () {
        /* 默认滚动条到底部 */
        $("#area").scrollTop($("#area")[0].scrollHeight);

        /* 从其他用户历史问题中过来是,需要判断是否与该用户有过联系 */
        if (${userId != null}){
            $('.mesaul').find('li').each(function () {
                if ('${userId}' == $(this).val()){
                    userMessage('${userId}');
                    return false;
                }
            })
        }

        /* 点击左边用户 */
        $(".mesaul>li").click(function () {
            var otherUserId = $(this).val();
            $("#user_id_j").val(otherUserId);
            userMessage(otherUserId);
            return false;
        })

        /* 异步获取用户交流信息 */
        function userMessage(otherUserId){
            var userId = ${user==null?999:user.id};
            $.ajax({
                type:"get",
                url:"user_get_all_message_ajax",
                dataType: "json",
                data:{user_id_f:userId,user_id_j:otherUserId},
                success:function (data) {
                    var list = JSON.stringify(data);
                    var json = JSON.parse(list);
                    console.log(json);
                    var otherUser = json.otherUser;
                    var allMessage = json.allMessage;
                    console.log(otherUser.img)
                    var img = "${user.img == null? 'static/images/user_head.jpg' : user.img}";
                    var otherImg = 'static/images/user_head.jpg';
                    if (otherUser.img != null){
                        otherImg = otherUser.img;
                        console.log(otherImg);
                    }
                    $("#area").empty();
                    $("#otherUser").html(otherUser.username)
                    for (i in allMessage){
                        var a = '<div style="text-align: left">';
                        var b = '<div style="text-align: right">';
                        var d = '<pre style="text-align: left"><i style="color: #01AAED">'+allMessage[i].time+'</i><br>'+ allMessage[i].content +'</pre>';
                        var e = '</div>';
                        if (allMessage[i].user_id_f == userId){
                            var c = '<img src="'+img+'" alt="头像">';
                            $("#area").append(b+d+c+e);
                        } else {
                            var c = '<img src="'+otherImg+'" alt="头像">';
                            $("#area").append(a+c+d+e);
                        }
                        //滚动到最下面
                        $("#area").scrollTop($("#area")[0].scrollHeight);
                    }
                },
                error:function () {
                    alert("信息获取错误,请与管理员联系!")
                }
            })
        }

        /* 用户发送信息 */
        $("#btn_message").click(function () {
            var content = $("#content").val();
            if (content==null || content=='' || content==undefined){
                alert("发送的信息不能为空!")
            } else {
                var user_id_j = $("#user_id_j").val();
                var user_id_f = ${user==null?999:user.id};
                var img = "${user.img == null? 'static/images/user_head.jpg' : user.img}";
                $.ajax({
                    type:"post",
                    url:"user_send_message_ajax",
                    dataType:"json",
                    data:{user_id_f:user_id_f,user_id_j:user_id_j,content:content},
                    success:function (data) {
                        var list = JSON.stringify(data);
                        var json = JSON.parse(list);
                        var message = json.message;
                        var boolean = json.boolean;
                        if (boolean){
                            $("#area").append('<div style="text-align: right">\n' +
                                '                    <pre><i style="color: #01AAED">'+message.time+'</i><br>'+message.content+'</pre>\n' +
                                '                    <img src="'+img+ '" alt="头像">\n' +
                                '                </div>');

                            $("#area").scrollTop($("#area")[0].scrollHeight);
                            $("#content").val('');
                        } else {
                            alert("信息发送错误,请与管理员联系!")
                        }
                    },
                    error:function () {
                        alert("信息发送错误,请与管理员联系!")
                    }
                })
            }
        })
    })
</script>
</body>
</html>