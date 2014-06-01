<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>教师及学生密码更改</title>
<script type="text/javascript" src="js/BasicJavascript.js?Ver=2014010501"></script>
<script type="text/javascript" src="js/School_User_CL.js"></script>
<script>
function init(){
	suit_Page();
	adaptView();
	window.onresize = adaptView;//实现浏览器大小更改是更改页面的显示位置大小
	var updateFactory = new updateInputFactory();
	updateFactory.createView();
}

//为了实现在不同的显示器下得到同样的登入界面对象显示在中间操作
function adaptView(){
	var frame = parent.document.getElementById("main_body");
	
	var winHeight = windowHeight() < 600 ? 686 : windowHeight();
	var marginlength = (winHeight - (frame.offsetHeight+205))/2 + "px";
	
	//是登入界面居中显示
	frame.style.marginTop = marginlength;
	frame.style.marginBottom = marginlength;
}

/* 注册input的onblur和onfocus事件处理类 */
function updateInputFactory(){}
updateInputFactory.prototype.createView = function(){
	var oldPWObj = new inputElementObj($("old_password")); 
	oldPWObj.onblurEvent = oldPWBlurEvent;
	oldPWObj.createView();
	
	var newPWObj = new inputElementObj($("new_password"));
	newPWObj.onblurEvent = newPWBlurEvent;
	newPWObj.onkeyupEvent = newPWKeyupEvent;
	newPWObj.createView();
	
	var newPWObj2 = new inputElementObj($("new_password2"));
	newPWObj2.onblurEvent = newPWBlurEventAgain;
	newPWObj2.createView();
	
	var submit = new updateSubmitObj($("update_submit"));
	submit.createView();
}

//重写对象元素的onblur事件函数
var old_save = null;
var check_result = false;
function oldPWBlurEvent(inputObj){//旧密码的验证操作
	return function(){
		oldPWCheck(inputObj);
	}
}
function oldPWCheck(inputObj){
	inputObj.parentNode.className = "input_frame";
	var errorObj = $("old_pw_error");
	
	if(inputObj.value == (null || "")){
		errorObj.style.color = "red";
		errorObj.style.display = "block";
		errorObj.innerHTML = "请输入当前账号密码...";
		return false;
	}else if(old_save != inputObj.value || !check_result){//验证是否当前输入密码已验证过了（或者未通过验证）
		//保存需要更改的密码信息
		checkOldPassword(errorObj);
		return check_result;
	}else{
		errorObj.style.display = "none";
		return true;
	}
}
function checkOldPassword(errorObj){
	var url = "UserManageServlet?type=check_scuser_password&old_password="+$("old_password").value;
	
	var checkRequest = newXMLHttpRequest();
	checkRequest.open("post" , url, true);
	checkRequest.onreadystatechange = checkPasswordRequest(checkRequest , errorObj);
	
	checkRequest.send(null);
}
function checkPasswordRequest(checkRequest , errorObj){
	return function(){
		if(checkRequest.readyState == 1 || checkRequest.readyState == 2 || checkRequest.readyState == 3){
					
		}else if(checkRequest.readyState == 4){
			if(checkRequest.status == 200){
				var result = checkRequest.responseText
				
				if(result == "true"){
					//输入密码正确
					errorObj.style.color = "green";
					errorObj.innerHTML = "密码验证通过！";
					check_result = true;
				}else{
					//删除失败
					errorObj.style.color = "red";
					errorObj.innerHTML = "密码不正确！";
					check_result = false;
				}
			}
		}else{
			//系统异常
			errorObj.style.color = "red";
			errorObj.innerHTML = "系统异常请再次尝试...";
		}
	}
}


function newPWBlurEvent(inputObj){//新密码格式验证
	return function(){
		newPWCheck(inputObj);
	}
}
function newPWKeyupEvent(inputObj){
	return function(){
		checkPWComplex(inputObj , $("new_pw_error"));
	}
}
function newPWCheck(inputObj){
	inputObj.parentNode.className = "input_frame";
	var errorObj = $("new_pw_error");
	
	if(!check_PW(inputObj.value)){
		errorObj.className = "error_infor";
		errorObj.style.color = "red";
		errorObj.style.display = "block";
		errorObj.innerHTML = "您输入的密码格式不正确...";
		return false;
	}else{
		return true;
	}
}
//编写一个密码样式控制操作对象
function checkPWComplex(inputObj , errorObj){
	var pwValue = inputObj.value;
	var pwLength = pwValue.length;
	
	if(pwLength >= 6 && pwLength <= 10){
		if(!pwValue.match(/[0-9]/) || !pwValue.match(/[a-zA-Z]/) || pwLength < 8){
			//表示只含有数字或者字母，未包含两者
			errorObj.className = "pw_complex_1";
		}else{
			errorObj.className = "pw_complex_2";
		}
	}else if(pwLength > 10){
		if(!pwValue.match(/[0-9]/) || !pwValue.match(/[a-zA-Z]/)){
			//表示只含有数字或者字母，未包含两者
			errorObj.className = "pw_complex_2";
		}else{
			errorObj.className = "pw_complex_3";
		}
	}else if(pwLength == 0){
		errorObj.className = "error_infor";
		errorObj.innerHTML = "6-16位（由数字、字母或符号组成）";
	}else{
		errorObj.innerHTML = "";
		errorObj.className = "pw_complex_0";
	}
}

function newPWBlurEventAgain(inputObj){//新密码确认
	return function(){
		newPWCheck2(inputObj);
	}
}
function newPWCheck2(inputObj){
	inputObj.parentNode.className = "input_frame";
	var errorObj = $("new_pw_error2");
	
	if(inputObj.value != $("new_password").value){
		errorObj.style.color = "red";
		errorObj.style.display = "block";
		errorObj.innerHTML = "您输入的密码不正确...";
		return false;
	}else{
		errorObj.style.display = "none";
		return true;
	}
}

//信息提交按钮事件处理设定(使用ajax提交操作)
var formsubmit = false;//用于控制是否已经点击submit按钮
function updateSubmitObj(submitObj){
	this.submitObj = submitObj;
}
updateSubmitObj.prototype.createView = function(){
	addEvent(this.submitObj , "click", this.clickEvent(this));
}
updateSubmitObj.prototype.clickEvent = function(updateObj){
	return function(){
		if(oldPWCheck($("old_password")) && newPWCheck($("new_password")) && newPWCheck2($("new_password2")) && !formsubmit){
			formsubmit = true;
			var errorObj = $("new_pw_error2");
			errorObj.style.color = "green";
			errorObj.style.display = "block";
			errorObj.innerHTML = "系统正在检索信息...";
			
			var url = "UserManageServlet?type=update_scuser_passowrd&old_password="+$("old_password").value+"&new_password="+$("new_password").value;
			
			var commitRequest = newXMLHttpRequest();
			commitRequest.open("post" , url, true);
			commitRequest.onreadystatechange = updateObj.updatePasswordRequest(commitRequest , errorObj);
			
			commitRequest.send(null);
		}
	}
};
updateSubmitObj.prototype.updatePasswordRequest = function(commitRequest , errorObj){
	return function(){
		if(commitRequest.readyState == 1 || commitRequest.readyState == 2 || commitRequest.readyState == 3){
					
		}else if(commitRequest.readyState == 4){
			if(commitRequest.status == 200){
				var result = commitRequest.responseText
				formsubmit = false;
				
				if(result == "true"){
					errorObj.style.color = "green";
					errorObj.style.display = "block";
					errorObj.innerHTML = "密码更改成功！";
				}else{
					errorObj.style.color = "red";
					errorObj.style.display = "block";
					errorObj.innerHTML = "密码更改失败！";
				}
			}
		}else{
			//系统异常
			errorObj.style.color = "red";
			errorObj.style.display = "block";
			errorObj.innerHTML = "系统异常请再次尝试...";
			formsubmit = false;
		}
	}
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
.error_infor{
	font-size:12px;
	font-weight:normal;
}
.pw_complex_0{
	height:20px;
	width:209px;
	overflow:hidden;
	background:url(images/password_complexity.png);
}
.pw_complex_1{
	height:20px;
	width:209px;
	overflow:hidden;
	background:url(images/password_complexity.png);
	background-position:0px -20px; 
}
.pw_complex_2{
	height:20px;
	width:209px;
	overflow:hidden;
	background:url(images/password_complexity.png);
	background-position:0px -40px; 
}
.pw_complex_3{
	height:20px;
	width:209px;
	overflow:hidden;
	background:url(images/password_complexity.png);
	background-position:0px -60px; 
}
tr > td{
	font-size:14px;
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
			  	<span style="color:red">*&nbsp;</span>旧密码：
			  </td>
			  <td width="70%" align="left">
			  	<div class="input_frame"><input type="password" name="old_password" id="old_password"/></div>
			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><div class="error_infor" id="old_pw_error"></div></td>
			</tr>
			
			<tr>
			  <td align="right">
			  	<span style="color:red">*&nbsp;</span>新密码：
			  </td>
			  <td align="left">
			  	<div class="input_frame"><input type="password" name="new_password" id="new_password"/></div>
			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><div class="error_infor" id="new_pw_error">6-16位（由数字、字母或符号组成）</div></td>
			</tr>
			
			<tr>
			  <td align="right">
			  	<span style="color:red">*&nbsp;</span>重新输入：
			  </td>
			  <td align="left">
			  	<div class="input_frame"><input type="password" name="new_password2" id="new_password2"/></div>
			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><div id="new_pw_error2" class="error_infor"></div></td>
			</tr>
			
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><input type="button" id="update_submit" value="更改密码"/></td>
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
