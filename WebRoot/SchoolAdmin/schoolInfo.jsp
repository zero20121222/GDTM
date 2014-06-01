<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>学校信息</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script type="text/javascript" src="js/School_User_CL.js"></script>
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
.user_infor_frame{
	clear: both;
	width: 980px;
	margin: 0 auto;
	
	overflow:hidden;
}
.user_infor_body {
	width: 800px;
	margin: 30px;
	margin-left:90px;
	padding: 9px;
	
	overflow:hidden;
	border: 1px solid #c3c4c5;
	background: #d8d7d7;
	border-radius:5px;
	box-shadow:3px 3px 2px #000;
}
.user_update_frame{
	width:100%;
	height:auto;
	position:relative;
	background:white;
}
.input_frame{
	width:195px;
	height:30px;
	float:left;
	background:url(images/input_noenter.png);
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
#logon_submit{
	width:102px;
	height:29px;
	
	font-size:13px;
	font-weight:bold;
	line-height:29px;
	color:white;
	cursor:pointer;
	background:url(images/frame_button0.png) no-repeat;
	border:0px none;
}
#logon_submit:hover{
	background:url(images/frame_button1.png) no-repeat;
}
.sex_radio{
	width:auto;
	height:auto;
	margin-top:5px;
	margin-left:7px;
	margin-right:4px;
}
.error_infor{
	color:red;
	font-size:12px;
	font-weight:bold;
	display:none;
}
tr > td{
	font-size:14px;
}
.textarea_frame{
	position:relative;
	width:320px;
	height:90px;
	background:url(images/textarea_noenter.png);
}
.textarea_maxCount{
	position:absolute;
	bottom:2px;
	right:8px;
	font-size:12px;
	text-align:center;
	background:white;
}
.user_resume{
	margin-top:10px;
	margin-left:10px;
	min-width:300px;
	min-height:70px;
	max-width:300px;
	max-height:70px;
	font-size:13px;
	overflow:hidden;
	border:0px none;
}
.user_update_log{
	width:128px;
	height:128px;
	position:absolute;
	top:20px;
	right:100px;
	background:url(images/teacher_logon_log.png);
}
.logon_result_view{
	color:green;
	font-size:12px;
	font-weight:bold;
	display:none;
}
tr{
    height:30px;
}
</style>
</head>

<body onload="init()">
<div class="user_infor_frame">
<div class="user_infor_body">
	<div class="user_update_frame">
		<div class="user_update_log"></div>
		<form id="te_logon_form" method="post">
			<table width="100%" border="0">
			<tr style="height:10px;">
			  <td colspan="2" align="right">&nbsp;</td>
			</tr>
			<tr>
			  <td width="30%" align="right">
			  	<span style="color:red">*&nbsp;</span>学校名称：
			  </td>
			  <td width="70%" align="left">${schoolInfor.name }</td>
			</tr>
			<tr>
			  <td align="right">
			  	<span style="color:red">*&nbsp;</span>所在省份：
			  </td>
			  <td align="left">${schoolInfor.province }</td>
			</tr>
			
			<tr>
			  <td align="right">
			  	<span style="color:red">*&nbsp;</span>详细地址：
			  </td>
			  <td align="left">${schoolInfor.address }</td>
			</tr>
			
			<tr>
			  <td align="right">
			  	<span style="color:red">*&nbsp;</span>学校大小：
			  </td>
			  <td align="left">${schoolInfor.size }</td>
			</tr>
			
			<tr>
			  <td align="right">
			  	<span style="color:red">*&nbsp;</span>创办时间：
			  </td>
			  <td align="left">${schoolInfor.foundTime }</td>
			</tr>
			
			<tr>
			  <td align="right">
			  	<span style="color:red">*&nbsp;</span>学校代码：
			  </td>
              <td align="left">${schoolInfor.schoolId }</td>
			</tr>

            <tr>
                <td align="right">学校级别：</td>
                <td align="left">${schoolInfor.schoolLevel }</td>
            </tr>

            <tr>
                <td align="right">学校资料文档：</td>
                <td align="left">${schoolInfor.schoolFile }</td>
            </tr>
			
			<tr>
			  <td align="right">现任校长：</td>
			  <td align="left">
			  	<div class="input_frame"><input type="text" name="user_age" id="user_age" value="${schoolInfor.headmaster }"/></div>
			  </td>
			</tr>

			<tr>
			  <td align="right">联系电话：</td>
			  <td align="left">
                  <div class="input_frame"><input type="text" name="user_age" id="user_age" value="${schoolInfor.phone }"/></div>
			  </td>
			</tr>

			<tr>
			  <td align="right">Email：</td>
			  <td align="left">
			  	<div class="input_frame"><input type="text" name="user_card" value="${schoolInfor.eamil }" id="user_card"/></div>			  </td>
			</tr>

			<tr>
			  <td align="right">学校专业数目：</td>
			  <td align="left">
			  	<div class="input_frame"><input type="text" name="user_qq" id="user_qq" value="${schoolInfor.collegeNumber }"/></div>			  </td>
			</tr>

			<tr>
			  <td align="right">在校学生数目：</td>
			  <td align="left">
                  <div class="input_frame"><input type="text" name="user_phone" id="user_phone" value="${schoolInfor.studentNumber }"/></div>
			  </td>
			</tr>

            <tr>
                <td align="right">在校教师数目：</td>
                <td align="left">
                    <div class="input_frame"><input type="text" name="user_phone" id="user_phone" value="${schoolInfor.teacherNumber }"/></div>			  </td>
            </tr>

            <tr>
                <td align="right">实验室信息：</td>
                <td rowspan="2" align="left">
                    <div class="textarea_frame">
                        <textarea id="user_resume" name="user_resume" class="user_resume">${schoolInfor.labInfor }</textarea>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
            </tr>

            <tr>
                <td align="right">师资力量信息：</td>
                <td rowspan="2" align="left">
                    <div class="textarea_frame">
                        <textarea id="user_resume" name="user_resume" class="user_resume">${schoolInfor.teacherInfor }</textarea>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
            </tr>

			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><input type="button" id="logon_submit" value="更改信息"/></td>
			</tr>

            <tr style="height:10px;">
                <td colspan="2" align="right">&nbsp;</td>
            </tr>
			</table>
		</form>
	</div>
</div>
</div>
</body>
</html>
