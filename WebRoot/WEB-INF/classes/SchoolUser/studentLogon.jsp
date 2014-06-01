<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String result = (String)request.getAttribute("save_result");
	
	//设置一个数据用于二次判断用于确定该页面是否已被访问过
	String ifDetail = request.getParameter("ifDetail");
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>学生用户详细信息填写</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script>
function init(){
	initializeLogon();
	var logon = new logonInputFactory();
	logon.createView();
}

/* 注册input的onblur和onfocus事件处理类 */
function logonInputFactory(){}
logonInputFactory.prototype.createView = function(){
	var nameObj = new inputElementObj($("true_name"));
	nameObj.onblurEvent = nameBlurEvent;//重写blur事件方法
	nameObj.createView();
	
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
	
	var submit = new logonSubmitObj($("logon_submit"));
	submit.createView();
	
	var collegeObj = new userCollegeObj($("user_college") , $("user_major"));
	collegeObj.createView();
};

function initializeLogon(){//初始换全部input的输入信息
	var saveResult = $("save_result").value;
	if(saveResult != "null"){
		if(saveResult == "true"){
			formsubmit = true;
			parent.closeFillUserWindow();
		}else{
			$("logon_result").style.display = "block";
			$("logon_result").style.color = "red";
			$("logon_result").innerHTML = "用户信息保存失败...";
			formsubmit = false;
		}
	}

	var inputObjs = document.getElementsByTagName("input");
	for(var i=0;i<inputObjs.length;i++){
		inputObjs[i].value = inputObjs[i].type == "text" ? "" : inputObjs[i].value;
	}
}

//重写对象元素的onblur事件函数
function nameBlurEvent(inputObj){
	return function(){
		checkTrueName(inputObj);
	}
}
function checkTrueName(inputObj){//验证真实姓名格式是否正确(可能是中国人也可能使外国人)
	inputObj.parentNode.className = "input_frame";
		
	if(inputObj.value == ""){
		$("true_name_error").style.display = "block";
		$("true_name_error").innerHTML = "请输入真实姓名...";
		return false;
	}else{
		$("true_name_error").style.display = "none";
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
function logonSubmitObj(submitObj){
	this.submitObj = submitObj;
}
logonSubmitObj.prototype.createView = function(){
	addEvent(this.submitObj , "click", this.clickEvent);
};
logonSubmitObj.prototype.clickEvent = function(){
	if(checkTrueName($("true_name")) && checkAge($("user_age")) && checkCard($("user_card")) && checkPhone($("user_phone")) && checkEmail($("user_email")) && checkQq($("user_qq")) && !formsubmit){
		$("st_logon_form").action = "SchoolLogonServlet?type=StudentLogon";
		
		$("logon_result").style.display = "block";
		$("logon_result").innerHTML = "信息正在检索...";
		formsubmit = true;
		$("st_logon_form").submit();
	}
};


//用于封装从数据库返回的学院&专业数据
function SelectCollege(){
	this.college = null;//学院名称
	this.majors = new Array();
}
SelectCollege.prototype.setCollegeValue = function(obj){//装载对象元素
	if(obj != null){
		this.college = obj.collegeName;
		this.majors[0] = obj.major1;
		this.majors[1] = obj.major2;
		this.majors[2] = obj.major3;
		this.majors[3] = obj.major4;
		this.majors[4] = obj.major5;
		this.majors[5] = obj.major6;
		this.majors[6] = obj.major7;
		this.majors[7] = obj.major8;
		this.majors[8] = obj.major9;
		this.majors[9] = obj.major10;
	}
};

function userCollegeObj(collegeselect , majorselect){//学校的院系信息
	this.collegeArray = new Array();//创建一个保存数据的数组
	this.collegeselect = collegeselect;//院系
	this.majorselect = majorselect;//专业
}
userCollegeObj.prototype.createView = function(){
	var collegeRequest = newXMLHttpRequest();
	collegeRequest.open("post" , "IndexInterlizeServlet?type=querySchoolCollege", true);
	collegeRequest.onreadystatechange = this.selectColleges(collegeRequest , this);
	
	collegeRequest.send(null);
};
userCollegeObj.prototype.selectColleges = function(collegeRequest , collegeObj){//调用Ajax技术异步查询数据
	return function(){
		if(collegeRequest.readyState == 1 || collegeRequest.readyState == 2 || collegeRequest.readyState == 3){
			
		}else if(collegeRequest.readyState == 4){
			if(collegeRequest.status == 200){
				var colleges = eval(collegeRequest.responseText);
				
				for(var i=0;i<colleges.length;i++){
					var college = new SelectCollege();
					college.setCollegeValue(colleges[i]);
					
					collegeObj.collegeArray.push(college);
				}
				
				collegeObj.createCollegeSelect();
			}
		}
	}
};
userCollegeObj.prototype.createCollegeSelect = function(){
	for(var i=0;i<this.collegeArray.length;i++){
		var option = new Option(this.collegeArray[i].college , this.collegeArray[i].college);
		this.collegeselect.options[i] = option;
		addEvent(this.collegeselect , "change", this.changeCollegeEvent(this));
	}
	
	for(var i=0;i<this.collegeArray[0].majors.length;i++){
		if(this.collegeArray[0].majors[i] == "null"){
			break;
		}
		var option = new Option(this.collegeArray[0].majors[i] , this.collegeArray[0].majors[i]);
		this.majorselect.options[i] = option;
	}
};
userCollegeObj.prototype.changeMajorSelect = function(changeValue){
	var changeNum = 0;
	for(var i=0;i<this.collegeArray.length;i++){
		if(this.collegeArray[i].college == changeValue){
			changeNum = i;
			break;
		}
	}
	
	for(var i=0;i<this.collegeArray[changeNum].majors.length;i++){
		if(this.collegeArray[changeNum].majors[i] == "null"){
			break;
		}
		var option = new Option(this.collegeArray[changeNum].majors[i] , this.collegeArray[changeNum].majors[i]);
		this.majorselect.options[i] = option;
	}
};
userCollegeObj.prototype.removeMajorSelect = function(){//清除专业选择
	for(var i=0 ; i<this.majorselect.length ; i++){
        this.majorselect.remove(i);
    }  
};
userCollegeObj.prototype.changeCollegeEvent = function(collegeObj){//清除专业选择
	return function(){
		collegeObj.removeMajorSelect();
		collegeObj.changeMajorSelect(collegeObj.collegeselect.value);
	};
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
.stu_logon_frame{
	width:500px;
	margin:0px auto;
	position:relative;
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
.stu_logon_log{
	width:128px;
	height:128px;
	position:absolute;
	top:20px;
	right:20px;
	background:url(images/school_login_logo.png);
}
.logon_result_view{
	color:green;
	font-size:12px;
	font-weight:bold;
	display:none;
}
</style>
</head>

<body onload="init()">
	<input type="hidden" id="save_result" value="<%=result %>"/>
	<div class="stu_logon_frame">
		<div class="stu_logon_log"></div>
		<form id="st_logon_form" method="post">
			<table width="100%" border="0">
			<tr>
			  <td colspan="3" align="right">&nbsp;</td>
			</tr>
			<tr>
			  <td width="21%" align="right">
			  	<span style="color:red">*&nbsp;</span>真实姓名：
			  </td>
			  <td width="76%" align="left">
				<div class="input_frame"><input type="text" name="true_name" id="true_name"/></div>
			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="true_name_error" class="error_infor"></span></td>
			</tr>
			<tr>
			  <td align="right">
			  	<span style="color:red">*&nbsp;</span>院系类别：
			  </td>
			  <td align="left">
			  	<select name="user_college" id="user_college">
			  		<option value="1">信息工程系</option>
			  	</select>
			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left">&nbsp;</td>
			</tr>
			<tr>
			  <td align="right">
			  	<span style="color:red">*&nbsp;</span>专业类别：
			  </td>
			  <td align="left">
				<select name="user_major" id="user_major">
					<option value="1">信息工程系</option>
				</select>
			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left">&nbsp;</td>
			</tr>
			<tr>
			  <td align="right">
			  	<span style="color:red">*&nbsp;</span>email：
			  </td>
			  <td align="left">
			  	<div class="input_frame"><input type="text" name="user_email" id="user_email"/></div>
			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="user_email_error" class="error_infor"></span></td>
			</tr>
			
			
			<tr>
			  <td align="right">年龄：</td>
			  <td align="left">
			  	<div class="input_frame"><input type="text" name="user_age" id="user_age"/></div>
			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="user_age_error" class="error_infor"></span></td>
			</tr>
			<tr>
			  <td align="right">性别：</td>
			  <td align="left">
			  	<input type="radio" name="user_sex" checked="checked" class="sex_radio" value="M"/>男
			  	<input type="radio" name="user_sex" class="sex_radio" value="F"/>女			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left">&nbsp;</td>
			</tr>
			<tr>
			  <td align="right">身份证号码：</td>
			  <td align="left">
			  	<div class="input_frame"><input type="text" name="user_card" id="user_card"/></div>			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="user_card_error" class="error_infor"></span></td>
			</tr>
			<tr>
			  <td align="right">地址：</td>
			  <td align="left">
			  	<div class="input_frame">
			  		<input type="text" name="user_address" maxlength="50" id="user_address"/>
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
			  	<div class="input_frame"><input type="text" name="user_phone" id="user_phone"/></div>			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="user_phone_error" class="error_infor"></span></td>
			</tr>
			<tr>
			  <td align="right">qq：</td>
			  <td align="left">
			  	<div class="input_frame"><input type="text" name="user_qq" id="user_qq"/></div>			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="user_qq_error" class="error_infor"></span></td>
			</tr>
			<tr>
			  <td align="right">个人简介：</td>
			  <td rowspan="2" align="left">
				<div class="textarea_frame">
					<textarea id="user_resume" name="user_resume" class="user_resume"></textarea>
				</div>
			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			</tr>
			
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span class="logon_result_view" id="logon_result"></span></td>
			  </tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><input type="button" id="logon_submit" value="保存"/></td>
			  </tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left">&nbsp;</td>
			</tr>
			</table>
		</form>
	</div>
</body>
</html>
