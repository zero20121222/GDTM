<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>用户信息更改</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script type="text/javascript" src="js/School_User_CL.js"></script>
<script>
function init(){
	suit_Page();
	var updateFactory = new updateInputFactory();
	updateFactory.createView();
}

/* 注册input的onblur和onfocus事件处理类 */
function updateInputFactory(){}
updateInputFactory.prototype.createView = function(){
	var officeObj = new inputElementObj($("user_office")); 
	officeObj.onblurEvent = officeBlurEvent;
	officeObj.createView();
	
	var ageObj = new inputElementObj($("user_age"));
	ageObj.onblurEvent = ageBlurEvent;
	ageObj.createView();
	
	var cardObj = new inputElementObj($("user_card"));
	cardObj.onblurEvent = cardBlurEvent;
	cardObj.createView();
	
	var addressObj = new inputElementObj($("user_address"));
	addressObj.createView();
	
	var phoneObj = new inputElementObj($("user_phone"));
	phoneObj.onblurEvent = phoneBlurEvent;
	phoneObj.createView();
	
	var emailObj = new inputElementObj($("user_email"));
	emailObj.onblurEvent = emailBlurEvent;
	emailObj.createView();
	
	var qqObj = new inputElementObj($("user_qq"));
	qqObj.onblurEvent = qqBlurEvent;
	qqObj.createView();
	
	var resume = new textareaElementObj($("user_resume") , 200);
	resume.createView();
	resume.setTextInfor($("user_resume").value);
	
	var submit = new updateSubmitObj($("update_submit"));
	submit.createView();
}

//重写对象元素的onblur事件函数
function officeBlurEvent(inputObj){
	return function(){
		checkOffice(inputObj);
	}
}
function checkOffice(inputObj){//验证真实姓名格式是否正确(可能是中国人也可能使外国人)
	inputObj.parentNode.className = "input_frame";
		
	if(inputObj.value == ""){
		$("user_office_error").style.display = "block";
		$("user_office_error").innerHTML = "请输入办公室信息...";
		return false;
	}else{
		$("user_office_error").style.display = "none";
		return true;
	}
}

function ageBlurEvent(inputObj){//验证年龄格式以及信息
	return function(){
		checkAge(inputObj);
	}
}
function checkAge(inputObj){
	inputObj.parentNode.className = "input_frame";
		
	if(inputObj.value != "" && !check_age(inputObj.value)){
		$("user_age_error").style.display = "block";
		$("user_age_error").innerHTML = "您输入的年龄格式不正确...";
		return false;
	}else{
		$("user_age_error").style.display = "none";
		return true;
	}
}

function cardBlurEvent(inputObj){//验证身份证格式以及信息
	return function(){
		checkCard(inputObj);
	}
}
function checkCard(inputObj){
	inputObj.parentNode.className = "input_frame";
		
	if(!check_Card(inputObj.value)){
		$("user_card_error").style.display = "block";
		$("user_card_error").innerHTML = "您输入的身份证号码格式不正确...";
		return false;
	}else{
		$("user_card_error").style.display = "none";
		return true;
	}
}

function phoneBlurEvent(inputObj){//验证身份证格式以及信息
	return function(){
		checkPhone(inputObj);
	}
}
function checkPhone(inputObj){
	inputObj.parentNode.className = "input_frame";
		
	if(!check_phone(inputObj.value)){
		$("user_phone_error").style.display = "block";
		$("user_phone_error").innerHTML = "您输入的手机号码格式不正确...";
		return false;
	}else{
		$("user_phone_error").style.display = "none";
		return true;
	}
}

function emailBlurEvent(inputObj){//验证身份证格式以及信息
	return function(){
		checkEmail(inputObj);
	}
}
function checkEmail(inputObj){
	inputObj.parentNode.className = "input_frame";
		
	if(inputObj.value == ""){
		$("user_email_error").style.display = "block";
		$("user_email_error").innerHTML = "请输入email信息...";
		return false;
	}else if(!check_Email(inputObj.value)){
		$("user_email_error").style.display = "block";
		$("user_email_error").innerHTML = "您输入的email格式不正确...";
		return false;
	}else{
		$("user_email_error").style.display = "none";
		return true;
	}
}

function qqBlurEvent(inputObj){//验证身份证格式以及信息
	return function(){
		checkQq(inputObj);
	}
}
function checkQq(inputObj){
	inputObj.parentNode.className = "input_frame";
	
	if(!check_Qq(inputObj.value)){
		$("user_qq_error").style.display = "block";
		$("user_qq_error").innerHTML = "您输入的qq格式不正确...";
		return false;
	}else{
		$("user_qq_error").style.display = "none";
		return true;
	}
}

//信息提交按钮事件处理设定
var formsubmit = false;//用于控制是否已经点击submit按钮
function updateSubmitObj(submitObj){
	this.submitObj = submitObj;
}
updateSubmitObj.prototype.createView = function(){
	addEvent(this.submitObj , "click", this.clickEvent);
}
updateSubmitObj.prototype.clickEvent = function(){
	if(checkOffice($("user_office")) && checkAge($("user_age")) && checkCard($("user_card")) && checkPhone($("user_phone")) && checkEmail($("user_email")) && checkQq($("user_qq")) && !formsubmit){
		$("user_update_form").action = "UserManageServlet?type=update_teacher_infor";
		
		$("update_result").style.display = "block";
		$("update_result").innerHTML = "系统正在检索信息...";
		$("user_update_form").submit();
	}
};
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
#update_submit{
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
#update_submit:hover{
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
.update_result_view{
	color:green;
	font-size:12px;
	font-weight:bold;
	display:none;
}
</style>
</head>

<body onload="init()">
<input type="hidden" id="update_result" value="${update_result }"/>
<div class="user_infor_frame">
<div class="user_infor_body">
	<div class="user_update_frame">
		<div class="user_update_log"></div>
		<form id="user_update_form" method="post">
			<table width="100%" border="0">
			<tr>
			  <td colspan="3" align="right">&nbsp;</td>
			</tr>
			<tr>
			  <td width="30%" align="right">
			  	<span style="color:red">*&nbsp;</span>真实姓名：
			  </td>
			  <td width="70%" align="left">${teacherInfor.realName }</td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="true_name_error" class="error_infor"></span></td>
			</tr>
			<tr>
			  <td align="right">
			  	<span style="color:red">*&nbsp;</span>院系类别：
			  </td>
			  <td align="left">${teacherInfor.college }</td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left">&nbsp;</td>
			</tr>
			
			<tr>
			  <td align="right">
			  	<span style="color:red">*&nbsp;</span>学位：
			  </td>
			  <td align="left">${teacherInfor.degree }</td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left">&nbsp;</td>
			</tr>
			
			<tr>
			  <td align="right">
			  	<span style="color:red">*&nbsp;</span>职位：
			  </td>
			  <td align="left">${teacherInfor.position }</td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="user_position_error" class="error_infor"></span></td>
			</tr>
			
			<tr>
			  <td align="right">
			  	<span style="color:red">*&nbsp;</span>办公室：
			  </td>
			  <td align="left">
			  	<div class="input_frame"><input type="text" name="user_office" id="user_office" value="${teacherInfor.office }"/></div>
			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="user_office_error" class="error_infor"></span></td>
			</tr>
			
			<tr>
			  <td align="right">
			  	<span style="color:red">*&nbsp;</span>email：
			  </td>
			  <td align="left">
			  	<div class="input_frame"><input type="text" name="user_email" id="user_email" value="${teacherInfor.email }"/></div>
			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="user_email_error" class="error_infor"></span></td>
			</tr>
			
			<tr>
			  <td align="right">年龄：</td>
			  <td align="left">
			  	<div class="input_frame"><input type="text" name="user_age" id="user_age" value="${teacherInfor.age }"/></div>
			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="user_age_error" class="error_infor"></span></td>
			</tr>
			<tr>
			  <td align="right">性别：</td>
			  <td align="left">
			  	<input type="radio" name="user_sex" checked="checked" class="sex_radio" ${teacherInfor.sex eq "M" ? "checked='checked'" : ""} value="M"/>男
			  	<input type="radio" name="user_sex" class="sex_radio" ${teacherInfor.sex eq "F" ? "checked='checked'" : ""} value="F"/>女
			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left">&nbsp;</td>
			</tr>
			<tr>
			  <td align="right">身份证号码：</td>
			  <td align="left">
			  	<div class="input_frame"><input type="text" name="user_card" value="${teacherInfor.idCard }" id="user_card"/></div>			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="user_card_error" class="error_infor"></span></td>
			</tr>
			<tr>
			  <td align="right">地址：</td>
			  <td align="left">
			  	<div class="input_frame">
			  		<input type="text" name="user_address" maxlength="50" id="user_address" value="${teacherInfor.address }"/>
			  	</div>
			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="user_address_error" class="error_infor"></span></td>
			</tr>
			<tr>
			  <td align="right">手机：</td>
			  <td align="left">
			  	<div class="input_frame"><input type="text" name="user_phone" id="user_phone" value="${teacherInfor.phone }"/></div>			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="user_phone_error" class="error_infor"></span></td>
			</tr>
			<tr>
			  <td align="right">qq：</td>
			  <td align="left">
			  	<div class="input_frame"><input type="text" name="user_qq" id="user_qq" value="${teacherInfor.qq }"/></div>			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="user_qq_error" class="error_infor"></span></td>
			</tr>
			<tr>
			  <td align="right">个人简介：</td>
			  <td rowspan="2" align="left">
				<div class="textarea_frame">
					<textarea id="user_resume" name="user_resume" class="user_resume">${teacherInfor.resume }</textarea>
				</div>
			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			</tr>
			
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span class="update_result_view" id="update_result"></span></td>
			  </tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><input type="button" id="update_submit" value="更改信息"/></td>
			  </tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left">&nbsp;</td>
			</tr>
			</table>
		</form>
	</div>
</div>
</div>
</body>
</html>
