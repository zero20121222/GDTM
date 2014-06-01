<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>详细公告信息</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script>
function init(){
    $("views_frame").style.background = "url(Schoolinfor/${schoolNew.schoolId}/News/${schoolNew.picture}) no-repeat 50%";
}
</script>
<style>
*{
	margin: 0;
	padding: 0;
	outline:none;
}
body {
	line-height: 1.5em;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #666;
	text-align:center;
	background: #fff;
}
input{
	width:180px;
	height:20px;
	margin-top:5px;
	margin-left:7px;
	line-height:20px;
	font-size:13px;
	font-family:Verdana,Tahoma,Arial;
	border:0 none;
}
tr > td{
	font-size:14px;
}
tr{
    height:30px;
}
.project_creater_log{
	width:128px;
	height:128px;
	position:absolute;
	top:20px;
	right:20px;
	background:url(images/upload_file.png);
}
.project_words_style {
	width:340px;
	text-indent:20px;
	font-size: 12px;
	font-family: 宋体;
}
#views_frame{
    width:414px;
    height:204px;
    position:relative;
    margin-top:10px;
    margin-left:100px;
    margin-bottom:28px;
    cursor:pointer;
    background:url(image/01.png) no-repeat 50% 50%;
}
</style>
</head>

<body onload="init()">
<div class="project_creater_log"></div>
    <table width="100%" border="0">
        <tr>
          <td width="21%" align="right">信息标题：</td>
          <td width="76%" align="left">
            ${schoolNew.title }
          </td>
        </tr>

        <tr>
          <td align="right">发布人名称：</td>
          <td align="left">
            ${schoolNew.senderName }
          </td>
        </tr>

        <tr>
          <td align="right">公告文件名称：</td>
          <td align="left">
            ${schoolNew.contentFile }
          </td>
        </tr>

        <tr>
          <td align="right">发布时间：</td>
          <td align="left">
            ${schoolNew.time }
          </td>
        </tr>

        <tr>
          <td align="right">详细内容：</td>
          <td align="left"><div class="project_words_style">${schoolNew.content }</div></td>
        </tr>
    </table>
    <div id='views_frame' title='上传图片'></div>
</body>
</html>
