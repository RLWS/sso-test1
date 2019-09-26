<%--
  Created by IntelliJ IDEA.
  User: RLWS_5871
  Date: 2018/11/22
  Time: 20:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

    <link type='text/css' href="static/js/dropzone/basic.min.css">
    <link type='text/css' href="static/js/dropzone/dropzone.min.css">
</head>
<body>
<div id="dropz" class="dropzone"></div>

<script type="text/javascript" src="static/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="static/js/dropzone/dropzone.min.js"></script>
<script>
    $(function () {

        var myDropzone = new Dropzone("#dropz",{
            url: "/upload",
            dictDefaultMessage: "拖动或点击上传头像",
            paramName: "dropzFile",     //传到后台的参数
            init:function () {
                this.on("success",function (file,data) {

                });
            }
        });
        alert("你好");
    })
</script>
</body>
</html>
