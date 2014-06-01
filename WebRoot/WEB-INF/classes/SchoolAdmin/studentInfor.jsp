<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>学生用户信息</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script>
function init(){
	suit_Page();
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
.sex_radio{
	width:auto;
	height:auto;
	margin-top:5px;
	margin-left:7px;
	margin-right:4px;
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
	background:url(images/teacher_logon_log.png);
}
.project_words_style {
	width:340px;
	text-indent:20px;
	font-size: 12px;
	font-family: 宋体;
}
.show_view{
    margin-left:80px;
    width:600px;
}
.error_view{
    position:absolute;
    top:200px;
    left:200px;
    margin-top:-30px;
    height:30px;
    line-height:30px;
    font-size:16px;
    font-family: 宋体;
}
</style>
</head>

<body onload="init()">
<div class="project_creater_log"></div>
<div style="display:${studentInfor.realName == null ? '' : 'none'}" class="error_view">该学生还未填写详细信息</div>
<div style="display:${studentInfor.realName == null ? 'none' : ''}" class="show_view">
    <table width="100%" border="0">
        <tr>
          <td width="21%" align="right">
            真实姓名：
          </td>
          <td width="76%" align="left">
            ${studentInfor.realName }
          </td>
        </tr>

        <tr>
          <td align="right">
            院系类别：
          </td>
          <td align="left">
            ${studentInfor.college }
          </td>
        </tr>

        <tr>
          <td align="right">
            专业类别：
          </td>
          <td align="left">
            ${studentInfor.major }
          </td>
        </tr>

        <tr>
          <td align="right">
            email：
          </td>
          <td align="left">
            ${studentInfor.email }
          </td>
        </tr>

        <tr>
          <td align="right">年龄：</td>
          <td align="left">
            ${studentInfor.age }
          </td>
        </tr>

        <tr>
          <td align="right">性别：</td>
          <td align="left">
            <input type="radio" disabled="disabled" name="user_sex" ${studentInfor.sex eq "M" ? "checked='checked'" : ""} class="sex_radio" value="M"/>男
            <input type="radio" disabled="disabled" name="user_sex" ${studentInfor.sex eq "F" ? "checked='checked'" : ""} class="sex_radio" value="F"/>女
          </td>
        </tr>

        <tr>
          <td align="right">身份证号码：</td>
          <td align="left">
            ${studentInfor.idCard }
          </td>
        </tr>

        <tr>
          <td align="right">地址：</td>
          <td align="left">
            ${studentInfor.address }
          </td>
        </tr>

        <tr>
          <td align="right">手机：</td>
          <td align="left">
            ${studentInfor.phone }
          </td>
        </tr>

        <tr>
          <td align="right">qq：</td>
          <td align="left">
            ${studentInfor.qq }
          </td>
        </tr>

        <tr>
          <td align="right">个人简介：</td>
          <td colspan="2" align="left"><div class="project_words_style">${studentInfor.resume }</div></td>
        </tr>

        <tr>
          <td align="right">&nbsp;</td>
          <td align="left">&nbsp;</td>
        </tr>
    </table>
</div>
</body>
</html>
