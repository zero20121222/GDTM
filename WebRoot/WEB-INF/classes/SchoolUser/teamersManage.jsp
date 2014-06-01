<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>团队人员管理页面</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script type="text/javascript" src="js/School_User_CL.js"></script>
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/DWRTeamManage.js"></script>
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
.teamer_infor_body{
	width:960px;
	height:auto;
	
	margin:auto;
	margin-top:30px;
	padding-bottom:50px;
	
	position:relative;
}
#teamer_infors_out{/*这个作为一个隐藏框架对象*/
	width:924px;
	height:auto;
	
	position:relative;
	margin-left:30px;
	padding-bottom:10px;
	overflow:hidden;
}
.team_stage_view{
	position:absolute;
	top:0px;
	right:0px;
	width:80px;
	height:80px;
	z-index:100;
	background:url(images/req_team_wait.png) no-repeat 50%;
}
.body_frame{
	width:900px;
	height:auto;
	
	float:left;
	margin-right:40px;
	overflow:hidden;
	border:9px solid #d8d7d7;
	background:white;
	border-radius:5px;
	box-shadow:3px 3px 2px #000;
}

.pro_frameout{
	float:left;
	width:390px;
	height:160px;
	
	cursor:default;
	margin-top:10px;
	margin-left:20px;
	margin-right:40px;
	margin-bottom:15px;
	overflow:hidden;
}
.pro_frame{
	position:relative;
	float:left;
	width:350px;
	height:150px;
	
	border:3px solid #78C945;
	background:#EBEBEB;
	border-radius:3px;
	box-shadow:2px 2px 2px #000;
}
.frame_title{
	width:350px;
	height:29px;
	font-size:13px;
	font-weight:bold;
	line-height:29px;
	
	background:url(images/logo_divider.png) no-repeat bottom;
}
.frame_body{
	width:350px;
	height:120px;
}
.pro_picture{
	width:48px;
	height:48px;
	float:left;
	margin:5px 5px 0px 30px;
	background:white;
	
	border:1px solid white;
	border-radius:3px;
	box-shadow:2px 2px 2px #000;
}
.pro_infor{
	width:220px;
	height:140px;
	
	float:left;
	margin-left:10px;
	margin-top:5px;
}
.pro_infor td{
	font-size:13px;
	color:#333333
}
.pro_select{
	width:30px;
	height:30px;
	float:left;
	cursor:pointer;
	background:url(images/pro_select.png);
}
#find_teamer{
	width:50px;
	height:50px;
	position:absolute;
	top:10px;
	right:-40px;
	cursor:pointer;
	background:url(images/find_project.png) no-repeat;
}
#find_teamer:hover{
	width:80px;
	height:80px;
	right:-70px;
	background:url(images/find_project1.png) no-repeat;
}

/* 团队创建样式 */
.proView{
	font-size:12px;
}
.proView table td{
	font-size:12px;
}
.teamer_view{
	width:auto;
	height:25px;
	line-height:25px;
}
.teamer_teacher_view{
	margin-top:5px;
	margin-left:40px;
	height:30px;
	line-height:30px;
}
.tea_title_view{
	float:left;
}
.add_teamer_view{
	margin-top:5px;
	position:relative;
}
.add_teamer_btn{
	position:absolute;
	width:25px;
	height:25px;
	top:0px;
	left:210px;
	cursor:pointer;
	background:url(images/add_project_stage.png);
}
.dec_teamer_btn{
	position:absolute;
	width:25px;
	height:25px;
	top:0px;
	left:250px;
	cursor:pointer;
	background:url(images/hidden_project_stage.png);
}
.add_teamer_line{
	width:100%;
	height:25px;
	background:url(images/logo_divider.png) no-repeat 50%;
}
.teamer_people_view{
	margin-top:5px;
	margin-left:57px;
	height:30px;
	line-height:30px;
}
.teamer_errorInfor{
	position:relative;
	float:left;
	width:200px;
}
.teamers_select{
	position:absolute;
	width:200px;
	border: 1px solid #c3c4c5;
	background: white;
	border-radius:5px;
	box-shadow:3px 3px 2px #000;
	z-index:100;
}
input[type="text"]{
	width:180px;
	height:20px;
	margin-top:5px;
	margin-left:7px;
	line-height:20px;
	font-size:13px;
	font-family:Verdana,Tahoma,Arial;
	border:0 none;
}
.team_button_view{
	margin:15px 0px 0px 40px;
}
.project_button{
	width:102px;
	height:29px;
	
	margin-top:auto;
	margin-left:7px;
	margin-right:50px;
	font-size:13px;
	font-weight:bold;
	line-height:29px;
	color:white;
	cursor:pointer;
	background:url(images/frame_button0.png) no-repeat;
	border:0px none;
}
.project_button:hover{
	background:url(images/frame_button1.png) no-repeat;
}
.pro_createrName{
	cursor:pointer;
	font-weight:bold;
	font-size:13px;
	color: #666;
	text-decoration:none;
}
.pro_createrName:hover{
	color:#A5A5A5;
}
.title_view_style {
	font-size: 18px;
	font-family: 华文行楷;
}
</style>
<script>
var manageTeam = null;
function init(){
	if($("teamer_infors_out").offsetHeight < 300){
		var iframe_name = "main_body";
		var frame = parent.document.getElementById(iframe_name);
		
		frame.style.marginTop = 0;
		frame.style.marginBottom = 0;
		frame.style.height = document.body.clientHeight+ 150 + "px";
	}else{
		suit_Page();
	}
	
	manageTeam = new manageTeamObj($("find_teamer") , $("part_num").value, $("project_id").value, $("pro_name").value, $("pro_createrName").value);
	manageTeam.initObj();
}

function showTeamerInfor(relationId){
	var url = "TeamManageServlet?type=manage_studentTeamer&rel_id="+relationId;
	window.open(url , "_self");
}

function showTeacherInfor(relationId){
	var url = "TeamManageServlet?type=manage_teacherTeamer&rel_id="+relationId;
	window.open(url , "_self");
}

/*
 * 团队人员信息保存对象
 * userId:用户编号
 * userName:用户姓名
 * userCollege:用户学院
 */
function teamerObj(userId , userName, userCollege){
	this.userId = userId;
	this.userName = userName;
	this.userCollege = userCollege;
	
	this.peopleView = null;//用于保存显示用户对象
	this.errorView = null;//用于存放错误信息的框架
	this.inputObj = null;//用于存放输入数据对象
}

/* 课题团队创建操作
 * createBtn:事件触发按钮对象
 * teamNum:团队人员数目
 * proId:课题编号
 */
var selectEvent = false;//用于标记当前用户正在选择对象
function manageTeamObj(createBtn , teamNum, proId, proName, proCreateName){
	this.createBtn = createBtn;
	this.teamNum = teamNum;
	this.proId = proId;
	this.proName = proName;
	this.proCreateName = proCreateName;
	this.peopleNum = 1;//团队人员数
	this.teacherObj = new teamerObj();//指导教师信息内容
	this.oldTeacher = false;//是否已经创建教师
	this.peopleArray = new Array();
	
	this.mWindow = null;//移动窗口对象
}
manageTeamObj.prototype.initObj = function(){
	addEvent(this.createBtn , "click", this.cClickEvent(this));
	this.queryTeamerNumber();
};
manageTeamObj.prototype.queryTeamerNumber = function(){//查询当前团队人员数目
	//学生信息注入
	var stuTeamers = document.getElementsByName("stu_teamer");
	
	for(var i=0; i<stuTeamers.length; i++){
		var nodeObjs = stuTeamers[i].childNodes;
		
		for(var j=0; j<nodeObjs.length; j++){
			if(nodeObjs[j].nodeName.toLowerCase() == "input"){
				nodeObjs[j].value == "T" ? this.peopleNum++ : "";
				break;
			}
		}
	}
	
	//教师信息注入
	var teaTeamers = document.getElementsByName("tea_teamer");
	for(var i=0; i<teaTeamers.length; i++){
		var nodeObjs = teaTeamers[i].childNodes;
		
		for(var j=0; j<nodeObjs.length; j++){
			if(nodeObjs[j].nodeName.toLowerCase() == "input"){
				if(nodeObjs[j].value == "T"){
					this.oldTeacher = true;
					var n=0;
					for(j=j+1; j<nodeObjs.length; j++){
						if(nodeObjs[j].nodeName.toLowerCase() == "input"){
							if(n == 0){
								this.teacherObj.userName = nodeObjs[j].value;
								n++;
							}else if(n == 1){
								this.teacherObj.userCollege = nodeObjs[j].value;
							}
						}
					}
				}
				break;
			}
		}
	}
};
manageTeamObj.prototype.cClickEvent = function(manageObj){
	return function(){
		if(manageObj.mWindow == null){
			var titleClose = new Window_close();
			titleClose.close_Click = manageObj.closeClick;
			var title = new Window_titleview(null , null, new Window_title("添加团队人员"), null, null, false, null, null, titleClose, null);//设置标题信息
			
			var margin_Left = (document.body.clientWidth - 500)/2;
			var frame = new Window_frame(500 , 230, 100, margin_Left, null, null, null, null, null, true);
			
			manageObj.mWindow = new moveWindow(frame , title, null, null, null, null, true, 1, null, null);
			manageObj.mWindow.create_View();
			
			manageObj.createView(manageObj);
			
		}else{
			manageObj.mWindow.displayWindow();;
		}
	};
};
manageTeamObj.prototype.createView = function(manageObj){
	var viewFrame = document.createElement("div");

	//课题信息
	var proView = document.createElement("div");
	proView.className = "proView";
	proView.innerHTML = "<table width='100%' border='0'>"
						+"<tr><td width='25%' height='25px' align='right'>课题名称：</td>"
 						+"<td width='25%' align='left'>"+manageObj.proName+"</td>"
 						+"<td width='25%' align='right'>团队人员：</td>"
 						+"<td width='25%' align='left'><span style='color:green'>"+manageObj.peopleNum+"</span>人</td><tr>"
						+"<tr><td width='25%' height='25px' align='right'>出题人：</td>"
 						+"<td width='25%' align='left'>"+manageObj.proCreateName+"</td>"
 						+"<td width='25%' align='right'>参与人数限定：</td>"
 						+"<td width='25%' align='left'><span style='color:red'>"+manageObj.teamNum+"</span>人</td></tr>"
 						+"<tr><td colspan='4' align='right'><hr style='border:1px dashed #c3c4c5;'/></td></tr></table>";
 	
 	//团队人员信息
 	var teamView = document.createElement("div");
 	/*
 	var masterName = new userNameObj().readTrueName();
 	var masterView = document.createElement("div");
 	masterView.className = "teamer_view";
 	masterView.innerHTML = "<span style='margin-left:50px;'>团队创建人：</span><span style='font-weight:bold;'>"+masterName+"</span>";
 	*/
 	
 	//指导教师确定
 	var teacherView = document.createElement("div");
 	teacherView.className = "teamer_teacher_view";
 	manageObj.createTeacher(teacherView , manageObj);
 	
 	//团队添加人员模块
 	var teamersView = document.createElement("div");
 	manageObj.createTeamer(teamersView);
 	
 	//按钮处理对象
 	var buttonView = document.createElement("div");
 	buttonView.className = "team_button_view";
 	manageObj.createButtons(buttonView);
 	
 	viewFrame.appendChild(proView);
 	//teamView.appendChild(masterView);
 	teamView.appendChild(teacherView);
 	teamView.appendChild(teamersView);
 	viewFrame.appendChild(teamView);
 	viewFrame.appendChild(buttonView);
 	manageObj.mWindow.Win_view.add_Child(viewFrame);
 	
 	//手动调用验证指导教师信息内容
 	!manageObj.oldTeacher ? manageObj.initCheck(manageObj.teacherObj.inputObj) : "";
};
manageTeamObj.prototype.createTeacher = function(teacherView , manageObj){//指导教师确认
	if(manageObj.teacherObj.userName == null){//如果指导教师不存在显示
		var titleView = document.createElement("div");
		titleView.className = "tea_title_view";
		titleView.innerHTML = "指导教师：";
	
		var inputFrame = document.createElement("div");
		inputFrame.className = "input_frame";
		
		var inputDid = document.createElement("input");
		inputDid.type = "text";
		inputDid.value = this.proCreateName;
		this.teacherObj.inputObj = inputDid;
		
		//显示返回结果信息
		var errorInfor = document.createElement("div");
		errorInfor.className = "teamer_errorInfor";
		errorInfor.innerHTML = "<span style='color:red;margin-left:10px;'>该教师已达指导人数上限！</span>";
		this.teacherObj.errorView = errorInfor;
		
		inputFrame.appendChild(inputDid);
		teacherView.appendChild(titleView);
		teacherView.appendChild(inputFrame);
		teacherView.appendChild(errorInfor);
		
		var tNameObj = new inputElementObj(inputDid); 
		tNameObj.onblurEvent = this.checkTeacherInfor;
		tNameObj.createView();
	}else{
		teacherView.style.marginLeft = "0px";
		teacherView.innerHTML = "<table width='100%' border='0'>"
								+"<tr><td width='25%' height='25px' align='right'>指导教师：</td>"
		 						+"<td width='25%' align='left'>"+manageObj.teacherObj.userName+"</td>"
		 						+"<td width='25%' align='right'>院系类别：</td>"
		 						+"<td width='25%' align='left'>"+manageObj.teacherObj.userCollege+"</td><tr></table>";
	}
};
manageTeamObj.prototype.initCheck = function(inputObj){
	inputObj.parentNode.className = "input_frame";
	
	var errorObj = manageTeam.teacherObj.errorView;
	if(inputObj.value == (null || "")){
		errorObj.innerHTML = "<span style='color:red;margin-left:10px;'>请输入指导教师姓名...</span>";
	}else{
		if(!selectEvent){
			selectEvent = true;
			errorObj.innerHTML = "<span style='color:green'>系统正在检索信息...</span>";
			
			//初始化对象信息
			manageTeam.teacherObj.userId = null;
			manageTeam.teacherObj.userName = null;
			manageTeam.teacherObj.userCollege = null;
			manageTeam.checkTeacher(inputObj , manageTeam.teacherObj);
		}
	}
};
manageTeamObj.prototype.checkTeacherInfor = function(inputObj){
	return function(){
		inputObj.parentNode.className = "input_frame";
		
		var errorObj = manageTeam.teacherObj.errorView;
		if(inputObj.value == (null || "")){
			errorObj.innerHTML = "<span style='color:red;margin-left:10px;'>请输入指导教师姓名...</span>";
		}else{
			if(!selectEvent){
				selectEvent = true;
				errorObj.innerHTML = "<span style='color:green'>系统正在检索信息...</span>";
				
				//初始化对象信息
				manageTeam.teacherObj.userId = null;
				manageTeam.teacherObj.userName = null;
				manageTeam.teacherObj.userCollege = null;
				manageTeam.checkTeacher(inputObj , manageTeam.teacherObj);
			}
		}
	};
};
manageTeamObj.prototype.checkTeacher = function(inputObj , peopleObj){
	DWRTeamManage.findTeamTeacher(inputObj.value , $("school_id").value, function(teacherList){
		if(teacherList.length > 0){
			var studentsFrame = document.createElement("div");
			studentsFrame.className = "teamers_select";
			
			var peopleInfor = document.createElement("div");
			var htmlView = "<table width='100%' border='0'>"
			for(var i=0; i<teacherList.length; i++){
				if(i < teacherList.length-1){
					htmlView += "<tr><td height='25px' style='font-size:12px' align='center'>"
								+"<input name='teamerSelect' type='radio' "+(teacherList[i].aduitNumber == 1 ? "" : "disabled")+" value='"+i+"'/></td>"
								+"<td style='font-size:12px' align='center'>"+teacherList[i].realName+"</td>"
								+"<td style='font-size:12px' align='left'>"+teacherList[i].userName+"</td></tr>";
				}else{
					htmlView += "<tr><td height='25px' style='font-size:12px' align='center'>"
								+"<input name='teamerSelect' type='radio' "+(teacherList[i].aduitNumber == 1 ? "" : "disabled")+" value='"+i+"'/></td>"
								+"<td style='font-size:12px' align='center'>"+teacherList[i].realName+"</td>"
								+"<td style='font-size:12px' align='left'>"+teacherList[i].userName
								+"<input style='margin-left:10px;cursor:pointer;width:50px;' id='select_btn' type='button' value='确认'/></td></tr>";
				}
			}
			htmlView += "</table>";
			peopleInfor.innerHTML = htmlView;
			
			studentsFrame.appendChild(peopleInfor);
			peopleObj.errorView.innerHTML = "";
			peopleObj.errorView.appendChild(studentsFrame);
			
			//为button注入事件
			var radioObj = document.getElementsByName("teamerSelect");
			addEvent($("select_btn") , "click", manageTeam.selectTeacherNum(radioObj , teacherList, peopleObj));
		}else{
			selectEvent = false;
			peopleObj.errorView.innerHTML = "<span style='color:red;margin-left:10px;'>未找到对应的教师信息...</span>";
		}
	});
};
manageTeamObj.prototype.selectTeacherNum = function(radioObj , teacherList, peopleObj){//从多个队员中选择一个队员
	return function(){
		for(var i=0; i<radioObj.length; i++){
			if(radioObj[i].checked){
				peopleObj.inputObj.value = teacherList[i].realName;
				peopleObj.errorView.innerHTML = "<div style='width:60px;float:left;margin-left:20px;'>院系类别：</div><div style='float:left;'>"+teacherList[i].college+"</div>";
				
				//将对象属性注入peopleObj对象中
				peopleObj.userId = teacherList[i].id;
				peopleObj.userName = teacherList[i].realName;
				peopleObj.userCollege = teacherList[i].college;
				
				selectEvent = false;
				return true;
			}
		}
		
		selectEvent = false;
		peopleObj.errorView.innerHTML = "<span style='color:red;margin-left:10px;'>该教师已达指导课题上限...</span>";
	};
};
manageTeamObj.prototype.createTeamer = function(teamersView){//团队人员添加操作
	if(this.teamNum > 1){
		var teamersFrame = document.createElement("div");
		
		var addTeamerView = document.createElement("div");
		addTeamerView.className = "add_teamer_view";
		
		var addBtn = document.createElement("div");
		addBtn.className = "add_teamer_btn";
		addBtn.title = "新增团队人员";
		addEvent(addBtn , "click", this.addTeamerEvent(this , teamersFrame));
		
		var decBtn = document.createElement("div");
		decBtn.className = "dec_teamer_btn";
		decBtn.title = "删除团队人员";
		addEvent(decBtn , "click", this.decTeamerEvent(this , teamersFrame));
		
		var lineView = document.createElement("div");
		lineView.className = "add_teamer_line";
		
		addTeamerView.appendChild(lineView);
		addTeamerView.appendChild(addBtn);
		addTeamerView.appendChild(decBtn);
		
		teamersView.appendChild(teamersFrame);
		teamersView.appendChild(addTeamerView);
	}
};
manageTeamObj.prototype.createButtons = function(buttonView){
	var commitBtn = document.createElement("input");
	commitBtn.type = "button";
	commitBtn.className = "project_button";
	commitBtn.value = "新增人员";
	
	var cancelBtn = document.createElement("input");
	cancelBtn.type = "button";
	cancelBtn.className = "project_button";
	cancelBtn.value = "取消";
	
	addEvent(commitBtn , "click", this.submitTeamInfor());
	addEvent(cancelBtn , "click", this.cancelAction);
	
	buttonView.appendChild(commitBtn);
	buttonView.appendChild(cancelBtn);
};
manageTeamObj.prototype.addTeamerEvent = function(manageObj , teamersFrame){//添加团队人员
	return function(){
		if(manageObj.teamNum > manageObj.peopleNum && !selectEvent){
			//此处需要使用队列思想来管理操作
			var teamerView = document.createElement("div");
			teamerView.className = "teamer_people_view";
			
			//标题
			var titleView = document.createElement("div");
			titleView.className = "tea_title_view";
			titleView.innerHTML = "队员"+(manageObj.peopleNum++)+"：";
			
			//输入用户名信息内容
			var inputFrame = document.createElement("div");
			inputFrame.className = "input_frame";
			var inputDid = document.createElement("input");
			inputDid.type = "text";
			
			//显示返回结果信息
			var errorInfor = document.createElement("div");
			errorInfor.className = "teamer_errorInfor";
			
			inputFrame.appendChild(inputDid);
			teamerView.appendChild(titleView);
			teamerView.appendChild(inputFrame);
			teamerView.appendChild(errorInfor);
			
			var teamerNameObj = new inputElementObj(inputDid);
			teamerNameObj.onblurEvent = manageObj.checkTeamerInfor;
			teamerNameObj.createView();

			teamersFrame.appendChild(teamerView);			
			manageObj.mWindow.setWindowHeight(manageObj.mWindow.getWindowHeight()+35);
			
			var peopleObj = new teamerObj();
			peopleObj.peopleView = teamerView;
			peopleObj.errorView = errorInfor;
			peopleObj.inputObj = inputDid;
			manageObj.peopleArray.push(peopleObj);
		}
	};
};
manageTeamObj.prototype.checkTeamerInfor = function(inputObj){//检测用户是否已经参加其他团队
	return function(){
		manageTeam.checkTeamer(inputObj);
	};
};
manageTeamObj.prototype.findInputObj = function(inputObj){
	for(var i=0; i<this.peopleArray.length; i++){
		if(inputObj == this.peopleArray[i].inputObj){
			return this.peopleArray[i];
		}
	}
	
	return null;
};
manageTeamObj.prototype.checkTeamer = function(inputObj){
	inputObj.parentNode.className = "input_frame";
	
	var peopleObj = manageTeam.findInputObj(inputObj);
	var errorObj = peopleObj.errorView;
	if(inputObj.value == (null || "")){
		errorObj.innerHTML = "<span style='color:red;margin-left:10px;'>请输入团队人员姓名...</span>";
	}else{
		if(!selectEvent){
			selectEvent = true;
			errorObj.innerHTML = "<span style='color:green'>系统正在检索信息...</span>";
			
			//初始化对象信息
			peopleObj.userId = null;
			peopleObj.userName = null;
			peopleObj.userCollege = null;
			manageTeam.checkTeamerName(inputObj , peopleObj);
		}
	}
};
manageTeamObj.prototype.checkTeamerName = function(inputObj , peopleObj){//为了方便直接使用DWR框架了
	DWRTeamManage.findTeamStudents(inputObj.value , $("school_id").value, function(studentList){
		if(studentList.length > 0){
			var studentsFrame = document.createElement("div");
			studentsFrame.className = "teamers_select";
			
			var peopleInfor = document.createElement("div");
			var htmlView = "<table width='100%' border='0'>"
			for(var i=0; i<studentList.length; i++){
				if(i < studentList.length-1){
					htmlView += "<tr><td height='25px' style='font-size:12px' align='center'>"
								+"<input name='teamerSelect' type='radio' "+(studentList[i].teamId == 0 && studentList[i].id != $("user_id").value ? "" : "disabled")+" value='"+i+"'/></td>"
								+"<td style='font-size:12px' align='center'>"+studentList[i].realName+"</td>"
								+"<td style='font-size:12px' align='left'>"+studentList[i].userName+"</td></tr>";
				}else{
					htmlView += "<tr><td height='25px' style='font-size:12px' align='center'>"
								+"<input name='teamerSelect' type='radio' "+(studentList[i].teamId == 0 && studentList[i].id != $("user_id").value ? "" : "disabled")+" value='"+i+"'/></td>"
								+"<td style='font-size:12px' align='center'>"+studentList[i].realName+"</td>"
								+"<td style='font-size:12px' align='left'>"+studentList[i].userName
								+"<input style='margin-left:10px;cursor:pointer' id='select_btn' type='button' value='确认'/></td></tr>";
				}
			}
			htmlView += "</table>";
			peopleInfor.innerHTML = htmlView;
			
			studentsFrame.appendChild(peopleInfor);
			peopleObj.errorView.innerHTML = "";
			peopleObj.errorView.appendChild(studentsFrame);
			
			//为button注入事件
			var radioObj = document.getElementsByName("teamerSelect");
			addEvent($("select_btn") , "click", manageTeam.selectStudentNum(radioObj , studentList, peopleObj));
		}else{
			selectEvent = false;
			peopleObj.errorView.innerHTML = "<span style='color:red;margin-left:10px;'>未找到对应的人员信息...</span>";
		}
	});
};
manageTeamObj.prototype.selectStudentNum = function(radioObj , studentList, peopleObj){//从多个队员中选择一个队员
	return function(){
		for(var i=0; i<radioObj.length; i++){
			if(radioObj[i].checked){
				peopleObj.inputObj.value = studentList[i].realName;
				peopleObj.errorView.innerHTML = "<div style='width:60px;float:left;margin-left:20px;'>专业类别：</div><div style='float:left;'>"+studentList[i].major+"</div>";
				
				//将对象属性注入peopleObj对象中
				peopleObj.userId = studentList[i].id;
				peopleObj.userName = studentList[i].realName;
				peopleObj.userCollege = studentList[i].college;
				
				selectEvent = false;
				return true;
			}
		}
		
		selectEvent = false;
		peopleObj.errorView.innerHTML = "<span style='color:red;margin-left:10px;'>未找到符合要求的用户...</span>";
	};
};
manageTeamObj.prototype.decTeamerEvent = function(manageObj , teamersFrame){//删除团队人员
	return function(){
		if(manageObj.peopleNum > 1 && !selectEvent){
			manageObj.peopleNum--;
			teamersFrame.removeChild(manageObj.peopleArray.pop().peopleView);//从显示对象中去除团队人员信息
			
			manageObj.mWindow.setWindowHeight(manageObj.mWindow.getWindowHeight()-35);
		}
	};
};
manageTeamObj.prototype.submitTeamInfor = function(){//实现团队信息内容提交操作处理
	return function(){
		if(manageTeam.repeatDataCheck() && manageTeam.nullCheck() && manageTeam.collegeCheck()){
			var teamers = "[";
			//团队学生操作
			for(var i=0; i<manageTeam.peopleArray.length; i++){
				if(i == manageTeam.peopleArray.length-1){
					if(!manageTeam.oldTeacher){//新添加的教师信息
						teamers += "{teamerType:'S',teamerId:"+manageTeam.peopleArray[i].userId+"},";
						teamers += "{teamerType:'T',teamerId:"+manageTeam.teacherObj.userId+"}]";
					}else{
						teamers += "{teamerType:'S',teamerId:"+manageTeam.peopleArray[i].userId+"}]";
					}
				}else{
					teamers += "{teamerType:'S',teamerId:"+manageTeam.peopleArray[i].userId+"},";
				}
			}
			
			if(manageTeam.peopleArray.length == 0){
				teamers += manageTeam.oldTeacher ? "]" : "{teamerType:'T',teamerId:"+manageTeam.teacherObj.userId+"}]";
			}
			
			DWRTeamManage.addTeamers($("user_id").value , eval(teamers), function(result){
				if(result){
					//表示创建成功&人员添加成功
					var promptWin = new promptWindow();
					promptWin.confirmButtonEvent = manageTeam.closeAllEvent(promptWin);
					promptWin.createConfirmView("<span style='color:green;'>添加人员成功！<span style='color:#aaaaaa;font-weight:normal;'>(系统已向指导教师&队员发送请求)</span></span>" , "确定");
				}else{
					//人员添加有问题
					var promptWin = new promptWindow();
					promptWin.confirmButtonEvent = manageTeam.errorEvent(promptWin);
					promptWin.createConfirmView("<span style='color:red;'>创建团队出现异常请重新尝试！</span>" , "确定");
				}
			});
		}
	};
};
manageTeamObj.prototype.nullCheck = function(){//团队人员空数据检验
	var result1 = true;
	for(var i=0; i<this.peopleArray.length; i++){
		if(this.peopleArray[i].userId == null){
			this.peopleArray[i].errorView.innerHTML = "<span style='color:red;margin-left:10px;'>请输入正确的队员信息...</span>";
			
			result1 = false;
			break;
		}
	}
	
	var result2 = true;
	if(this.teacherObj.userId == null && !this.oldTeacher){
		this.teacherObj.errorView.innerHTML = "<span style='color:red;margin-left:10px;'>请输入正确的指导教师姓名...</span>";
		result2 = false;
	}
	
	return result1 & result2;
};
manageTeamObj.prototype.collegeCheck = function(){//团队人员院系是否符合课题要求检验
	var pro_college = $("pro_college").value;
	if(pro_college == "null"){
		return true;
	}else{
		var result1 = true;
		for(var i=0; i<this.peopleArray.length; i++){
			if(this.peopleArray[i].userCollege != pro_college){
				this.peopleArray[i].errorView.innerHTML = "<span style='color:red;margin-left:10px;'>该学生不符合课题院系限定...</span>";
				
				result1 = false;
				break;
			}
		}
		
		var result2 = true;
		if(this.teacherObj.userCollege != pro_college){
			this.teacherObj.errorView.innerHTML = "<span style='color:red;margin-left:10px;'>该指导教师不符合课题院系限定...</span>";
			result2 = false;
		}
		
		return result1 & result2;
	}
};
manageTeamObj.prototype.repeatDataCheck = function(){//重复数据对象查询(用于检测用户是否多次添加同一个用户)
	for(var i=this.peopleArray.length-1; i>=0; i--){
		for(var j=0; j<this.peopleArray.length; j++){
			if(this.peopleArray[i] != this.peopleArray[j] && this.peopleArray[i].userId == this.peopleArray[j].userId){
				this.peopleArray[i].errorView.innerHTML = "<span style='color:red;margin-left:10px;'>该用户已经添加到团队...</span>";
				
				return false;
			}
		}
	}
	
	return true;
};
manageTeamObj.prototype.closeClick = function(parentObj){
	return function(){
		//判断该对象是否打开了遮罩层
		if(!parentObj.getParentObj().Win_closeC){
			parentObj.getParentObj().Win_cover.hiddenView();//隐藏遮罩对象
		}
		parentObj.getParentObj().Win_frame.hiddenView();//影藏对象
	};
};
manageTeamObj.prototype.cancelAction = function(){//隐藏遮罩对象
	if(!manageTeam.mWindow.Win_closeC){
		manageTeam.mWindow.Win_cover.hiddenView();
	}
	
	manageTeam.mWindow.Win_frame.hiddenView();
};
manageTeamObj.prototype.errorEvent = function(promptWin){
	return function(){
		promptWin.closeWindow();
	}
};
manageTeamObj.prototype.closeAllEvent = function(promptWin){
	return function(){
		promptWin.closeWindow();
		
		//关闭显示团队创建窗口对象
		if(!manageTeam.mWindow.Win_closeC){
			manageTeam.mWindow.Win_cover.close_Cover();
		}
		
		manageTeam.mWindow.closeWindow();
		
		//从新获取最新团队管理信息内容（实现跳转操作）
		window.open("TeamManageServlet?type=manage_teamers_infor" , "main_body");
	}
};
</script>
</head>

<body onload="init()">
<div class="teamer_infor_body">
	<div id="teamer_infors_out">
		<input type="hidden" id="user_id" value="${user_id }"/>
		<input type="hidden" id="project_id" value="${projectInfor.id }"/>
		<input type="hidden" id="part_num" value="${projectInfor.partNum }"/>
		<input type="hidden" id="pro_college" value="${projectInfor.college }"/>
		<input type="hidden" id="school_id" value="${projectInfor.schoolId }"/>
		<input type="hidden" id="pro_createrName" value="${projectInfor.createrName }"/>
		<input type="hidden" id="pro_name" value="${projectInfor.projectName }"/>
		
		<div class="body_frame" id="teamer_inforView">
			<table width="100%" style="font-size:13px;" border="0">
			  <tr><td colspan="4" height="15px"></td></tr>
              <tr>
                <td width="32%" height="30px" align="right">题目名称：</td>
                <td width="18%" align="left"><span>《${projectInfor.projectName }》</span></td>
                <td width="15%" align="right">出题人：</td>
                <td width="35%" align="left">
                	<a class="pro_createrName" href="ProjectManagerServlet?type=query_creater_infor&creater_id=${projectInfor.createrId }">${projectInfor.createrName }</a>
                </td>
              </tr>
              
              <tr>
                <td height="30px" align="right">参与人数限定：</td>
                <td align="left"><span>${projectInfor.partNum }&nbsp;人</span></td>
                <td align="right">工作量大小：</td>
                <td align="left"><span>${projectInfor.workload eq "1" ? "工作量较轻" : (projectInfor.workload eq "2" ? "工作量较重" : "工作量很重")}</span></td>
              </tr>
              
              <tr>
                <td height="30px" align="right">院系限定：</td>
                <td align="left"><span>${projectInfor.college eq "null" ? "无院系限定" : projectInfor.college}</span></td>
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
			  </tr>
			  
			  <tr>
                <td height="30px" align="center" class="title_view_style">团队信息</td>
                <td align="left">&nbsp;</td>
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
			  </tr>
            </table>
			
			<hr style="border:1px dashed #c3c4c5;clear:both;"/>
			<c:forEach items="${studentList}" var="stuInfor" varStatus="status">
			<div class="pro_frameout" name="stu_teamer">
				<input type="hidden" value="${stuInfor.replyResult}"/>
				<div class="pro_frame">
					<div class="frame_title">队员</div>
					<div class="frame_body">
						<div class="pro_picture" style="background:url(headPictures/${stuInfor.commonUser.userHead })"></div>
						<div class="pro_infor">
						<table width='100%' height='115' border='0'>
							<tr>
								<td width='45%' align='right'>姓名：</td>
								<td width='55%' align='left'>${stuInfor.realName }</td>
							</tr>
							<tr>
								<td align='right'>院系类别：</td>
								<td align='left'>${stuInfor.college }</td>
							</tr>
							<tr>
								<td align='right'>专业类别：</td>
								<td align='left'>${stuInfor.major }</td>
							</tr>
							<tr>
								<td align='right'>性别：</td>
								<td align='left'>${stuInfor.sex eq 'M' ? '男' : '女' }</td>
							</tr>
						</table>
						</div>
					</div>
					<div class="team_stage_view" style="background:url(${stuInfor.replyResult eq 'T' ? 'images/req_team_success.png' : stuInfor.replyResult eq 'F' ? 'images/req_team_fail.png' : 'images/req_team_wait.png'}) no-repeat 50%"></div>
				</div>
				<div class="pro_select" title="详细信息" onclick="showTeamerInfor(${stuInfor.relationId })"></div>
			</div>
			</c:forEach>
			
			<!-- 教师信息 -->
			<c:forEach items="${teacherList}" var="teaInfor" varStatus="status">
			<div class="pro_frameout" name="tea_teamer">
				<input type="hidden" id="replyResult" value="${teaInfor.replyResult}"/>
				<input type="hidden" id="realName" value="${teaInfor.realName}"/>
				<input type="hidden" id="teaCollege" value="${teaInfor.college}"/>
				<div class="pro_frame">
				<div class="frame_title">指导老师</div>
					<div class="frame_body">
						<div class="pro_picture" style="background:url(headPictures/${teaInfor.commonUser.userHead })"></div>
						<div class="pro_infor">
						<table width='100%' height='115' border='0'>
							<tr>
								<td width='45%' align='right'>姓名：</td>
								<td width='55%' align='left'>${teaInfor.realName }</td>
							</tr>
							<tr>
								<td align='right'>院系类别：</td>
								<td align='left'>${teaInfor.college }</td>
							</tr>
							<tr>
								<td align='right'>职位：</td>
								<td align='left'>${teaInfor.position }</td>
							</tr>
							<tr>
								<td align='right'>性别：</td>
								<td align='left'>${teaInfor.sex eq 'M' ? '男' : '女' }</td>
							</tr>
						</table>
						</div>
						<div class="team_stage_view" style="background:url(${teaInfor.replyResult eq 'T' ? 'images/req_team_success.png' : teaInfor.replyResult eq 'F' ? 'images/req_team_fail.png' : 'images/req_team_wait.png'}) no-repeat 50%"></div>
					</div>
				</div>
				<div class="pro_select" title="详细信息" onclick="showTeacherInfor(${teaInfor.relationId })"></div>
			</div>
			</c:forEach>
		</div>
	</div>
	
	<div id="find_teamer" title="添加团队人员"></div>
</div>
</body>
</html>
