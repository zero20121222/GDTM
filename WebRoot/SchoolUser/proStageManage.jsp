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
<title>课题阶段管理操作</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script type="text/javascript" src="js/School_User_CL.js"></script>
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/ProjectStageDeal.js"></script>
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
#stage_req{
	width:50px;
	height:50px;
	position:absolute;
	top:70px;
	right:-40px;
	cursor:pointer;
	background:url(images/stage_reqs_min.png) no-repeat;
}
#stage_req:hover{
	width:80px;
	height:80px;
	right:-70px;
	background:url(images/stage_reqs_max.png) no-repeat;
}
#stage_file{
	width:50px;
	height:50px;
	position:absolute;
	top:140px;
	right:-40px;
	cursor:pointer;
	background:url(images/stage_file_min.png) no-repeat 50%;
}
#stage_file:hover{
	width:80px;
	height:80px;
	right:-70px;
	background:url(images/stage_file_max.png) no-repeat 50%;
}

.proView{
	font-size:12px;
}
.proView table td{
	font-size:12px;
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
.title_number_style {
	font-size: 12px;
	font-family:宋体;
}
.project_words_style {
	width:500px;
	text-indent:20px;
	font-size: 12px;
	font-family: 宋体;
}
.downStageFile{
	font-size: 13px;
	color: #666;
	text-decoration:none;
}
.downStageFile:hover{
	color:black;
	font-weight:bold;
}
.audit_result{
	position:absolute;
	width:80px;
	height:80px;
	top:-40px;
	right:20px;
}
.date_out_frame{
	width:560px;
	margin-left:25px;
	margin-top:5px;
}
.date_title{
	width:80px;
	height:40px;
	float:left;
	line-height:40px;
}
.date_view{
	border-right:1px solid #d8d7d7;
	height:40px;
	float:left;
}
.date_yearm_view{
	height:20px;
	line-height:20px;
}
.date_day_view{
	height:20px;
	line-height:20px;
}
.date_infor_view{
	float:left;
	width:20px;
	overflow:hidden;
}
.time_out_frame{
	width:550px;
	margin-left:25px;
	margin-top:5px;
	overflow:hidden;
}
.time_title{
	width:80px;
	height:30px;
	float:left;
	text-align:center;
	line-height:30px;
	overflow:hidden;
	text-overflow:ellipsis;
	white-space:nowrap;
	cursor:pointer;
}
.time_view{
	height:30px;
	float:left;
}
.time_line_view{
	cursor:pointer;
	margin-top:4px;
	height:10px;
}
.stage_req_error{
	width:100%;
	height:15px;
	line-height:15px;
}
textarea{
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
#stage_guide_view{
	margin-top:15px;
}
#stage_guide_frame{
	width:800px;
	height:auto;
	margin:10px auto;
}
.guide_view{
	width:700px;
	height:auto;
	position:relative;
	
	margin:10px auto;
	overflow:hidden;
	border:2px solid #d8d7d7;
	background:white;
	border-radius:5px;
	box-shadow:3px 3px 2px #000;
}
.requester_head{
	position:absolute;
	top:10px;
	left:10px;
	width:48px;
	height:48px;
}
.guides_more_view{
	margin-top:10px;
	margin-bottom:10px;
	font-size:14px;
	font-weight:bold;
	color:blue;
}
#stage_guides_more{
	cursor:pointer;
}
.show_files_line{
	width:100%;
	height:10px;
	background:url(images/logo_divider.png) no-repeat 50%;
}
.stage_files_frame{
	width:550px;
	height:auto;
	
	margin:5px auto;
	overflow-y:auto;
}
.stage_file_view{
	position:relative;
	width:100%;
	height:35px;
	line-height:35px;
	
	cursor:pointer;
	border-bottom:1px solid #d8d7d7;
}
.file_type_view{
	position:absolute;
	width:30px;
	height:30px;
	
	background:url(images/file_types.png);
}
.file_name_view{
	width:270px;
	height:35px;
	margin-left:35px;
	
	overflow:hidden;
	font-weight:bold;
	font-family:宋体;
}
</style>
<script>
var manageTeam = null;
function init(){
	suit_Page();
	
	new proStageSchedule($("find_teamer") , $("project_id").value).initObj();
	new stageAuditObj($("commit_audit")).initObj();
	new proStageReqObj($("stage_req") , $("stage_id").value).initObj();
	new proStageFileObj($("stage_file") , $("stage_id").value).initObj();
	
	predictEndTime();
	
	//返回上一页
	$("break_old_page").onclick = function(){
		window.history.back();
	};
	
	//设置添加更多阶段信息
	new stageMoreReq($("stage_guides_more") , $("stage_guide_frame"), $("stage_id").value).initObj();
}

/*
 * 课题进度管理操作
 */
function proStageSchedule(buttonObj , projectId){
	this.buttonObj = buttonObj;
	this.projectId = projectId;
	
	this.mWindow = null;
}
proStageSchedule.prototype.initObj = function(){
	addEvent(this.buttonObj , "click", this.cClickEvent(this));
	
}
proStageSchedule.prototype.cClickEvent = function(scheduleObj){
	return function(){
		if(scheduleObj.mWindow == null){
			var titleClose = new Window_close();
			titleClose.close_Click = scheduleObj.closeClick;
			var title = new Window_titleview(null , null, new Window_title("阶段进度比较"), null, null, false, null, null, titleClose, null);//设置标题信息
			
			var margin_Left = (document.body.clientWidth - 600)/2;
			var frame = new Window_frame(600 , 80, 100, margin_Left, null, null, null, null, null, true);
			
			scheduleObj.mWindow = new moveWindow(frame , title, null, null, null, null, true, 1, null, null);
			scheduleObj.mWindow.create_View();
			
			scheduleObj.createView(scheduleObj);
			
		}else{
			scheduleObj.mWindow.displayWindow();;
		}
	};
};
proStageSchedule.prototype.createView = function(scheduleObj){
	var viewFrame = document.createElement("div");
	viewFrame.innerHTML = "Loading...";
	scheduleObj.mWindow.Win_view.add_Child(viewFrame);
	
	ProjectStageDeal.queryStageManages($("user_id").value , function(manageLists){
		ProjectStageDeal.queryProjectStages(scheduleObj.projectId , function(stageInfors){
			//去除加载等待时间
			viewFrame.removeChild(viewFrame.firstChild);
			
			var allTime = 0;	
			var scheduleTime = 0;	//整个设计的预定总时间
			var actualTime = 0;	 	//实际设计总时间
			var timeLength = 0;	 	//每个时间段的长度
			
			for(var i=0; i<stageInfors.length; i++){
				scheduleTime += stageInfors[i].timeLimit;
			}
			
			var minTime = new Date(manageLists[0].startTime);
			var maxTime = manageLists[0].endTime==null ? null : new Date(manageLists[0].endTime);
			for(var i=1; i<manageLists.length; i++){
				minTime = minTime > new Date(manageLists[i].startTime) ? new Date(manageLists[i].startTime) : minTime;
				
				if(manageLists[i].endTime != null){
					if(maxTime == null){
						maxTime = new Date(manageLists[i].endTime);
					}else{
						maxTime = maxTime < new Date(manageLists[i].endTime) ? new Date(manageLists[i].endTime) : maxTime;
					}
				}
			}
			
			actualTime = maxTime==null ? 0 : (maxTime-minTime)/(1000*24*3600);
			allTime = scheduleTime > actualTime ? scheduleTime : actualTime;
			
			timeLength = 460/allTime;	//460为显示甘特图的最大长度
		
			//阶段进度
			var proView = document.createElement("div");
			proView.className = "proView";
			
			//标题信息内容显示
			//获取当期时间
			var timeObj = $("startTime").value=="" ? new Date() : new Date($("startTime").value);
			var dateYear = timeObj.getFullYear();
			var dateDay = timeObj.getDate();
			var dateMonth = timeObj.getMonth()+1;
			
			var dateOutFrame = document.createElement("div");
			dateOutFrame.className = "date_out_frame";
			
			var dateTitleFrame = document.createElement("div");
			dateTitleFrame.className = "date_title";
			dateTitleFrame.innerHTML = "阶段名称";
			dateOutFrame.appendChild(dateTitleFrame);
			
			var titleInfor = document.createElement("div");
			titleInfor.className = "date_view";
			dateOutFrame.appendChild(titleInfor);
			
			//显示年月信息
			var yearMView = document.createElement("div");
			yearMView.className = "date_yearm_view";
			yearMView.innerHTML = dateYear+"年"+dateMonth+"月";
			
			var daysView = document.createElement("div");
			daysView.className = "date_day_view";
			titleInfor.appendChild(yearMView);
			titleInfor.appendChild(daysView);
			
			var baseDay = Math.round(20/timeLength) > 2 ? Math.round(20/timeLength) : 2;//天数相加基数
			for(var i=0; i<23; i++){//460/20~23
				if(i < (allTime/baseDay)){
					var dateView = document.createElement("div");
					dateView.className = "date_infor_view";	//大小控制在20px
					
					var monthEndDay = new Date(dateYear,dateMonth,0).getDate();
					if(dateDay <= monthEndDay){
						dateView.innerHTML = dateDay;
						dateView.style.marginRight = (460/(allTime/baseDay)-20)+"px";
						dateDay = dateDay+baseDay;
					}else{
						dateMonth++;
						dateDay=dateDay%monthEndDay;
						dateView.innerHTML = dateDay;
						dateDay = dateDay+baseDay;
						
						titleInfor = document.createElement("div");
						titleInfor.className = "date_view";
						dateOutFrame.appendChild(titleInfor);
						
						//显示年月信息
						yearMView = document.createElement("div");
						yearMView.className = "date_yearm_view";
						yearMView.innerHTML = dateYear+"年"+dateMonth+"月";
						
						daysView = document.createElement("div");
						daysView.className = "date_day_view";
						titleInfor.appendChild(yearMView);
						titleInfor.appendChild(daysView);
					}
					
					daysView.appendChild(dateView);
				}else{
					break;
				}
			}
			viewFrame.appendChild(dateOutFrame);
			
			var leftLength = 0;
			for(var i=0; i<stageInfors.length; i++){
				var outFrame = document.createElement("div");
				outFrame.className = "time_out_frame";
				
				var titleView = document.createElement("div");
				titleView.className = "time_title";
				titleView.innerHTML = stageInfors[i].stageName;
				
				var timeView = document.createElement("div");
				timeView.className = "time_view";
				
				var scheduleLine = document.createElement("div");
				scheduleLine.className = "time_line_view";
				scheduleLine.title = "预期时间";

				var timeWidth = timeLength*stageInfors[i].timeLimit;
				scheduleLine.style.background = "blue";
				scheduleLine.style.width = timeWidth+"px";
				scheduleLine.style.marginLeft = leftLength+"px";
				
				var actualLine = document.createElement("div");
				actualLine.className = "time_line_view";
				if(i<manageLists.length){
					var actualDay = manageLists[i].endTime!=null ? (new Date(manageLists[i].endTime) - new Date(manageLists[i].startTime))/(1000*24*3600) : (new Date() - new Date(manageLists[i].startTime))/(1000*24*3600);
					var leftMargin = (new Date(manageLists[i].startTime) - timeObj)/(1000*24*3600);
					
					if(actualDay > stageInfors[i].timeLimit){
						var overDay = (actualDay-stageInfors[i].timeLimit+" ").split(".");
						var floatDay = overDay[1].substr(0 , 2);
						
						actualLine.style.background = "red";
						actualLine.title = "超过预定期限:"+overDay[0]+"."+floatDay+"天";
					}else{
						actualLine.style.background = "yellow";
						actualLine.title = "实际时间:"+manageLists[i].startTime+"~"+(manageLists[i].endTime==null ? "" : manageLists[i].endTime);
					}
					actualLine.style.width = (actualDay*timeLength > 460 ? 460 : actualDay*timeLength)+"px";
					actualLine.style.marginLeft = leftMargin*timeLength+"px";
				}else{
					actualLine.style.width = "0px";
				}
				timeView.appendChild(scheduleLine);
				timeView.appendChild(actualLine);
				
				leftLength += timeWidth;
				
				outFrame.appendChild(titleView);
				outFrame.appendChild(timeView);
				viewFrame.appendChild(outFrame);
				scheduleObj.mWindow.setWindowHeight(scheduleObj.mWindow.getWindowHeight()+35);
			}
		 	
		 	viewFrame.appendChild(proView);
		});
	});
};
proStageSchedule.prototype.closeClick = function(parentObj){
	return function(){
		//判断该对象是否打开了遮罩层
		if(!parentObj.getParentObj().Win_closeC){
			parentObj.getParentObj().Win_cover.hiddenView();//隐藏遮罩对象
		}
		parentObj.getParentObj().Win_frame.hiddenView();//影藏对象
	};
};


/*
 * 课题阶段指导请求
 */
function proStageReqObj(buttonObj , stageId){
	this.buttonObj = buttonObj;
	this.stageId = stageId;
	
	this.mWindow = null;
	this.commitStage = false;	//控制提交状态
}
proStageReqObj.prototype.initObj = function(){
	addEvent(this.buttonObj , "click", this.cClickEvent(this));
}
proStageReqObj.prototype.cClickEvent = function(scheduleObj){
	return function(){
		var titleClose = new Window_close();
		titleClose.close_Click = scheduleObj.closeClick;
		var title = new Window_titleview(null , null, new Window_title("课题阶段文档"), null, null, false, null, null, titleClose, null);//设置标题信息
		
		var margin_Left = (document.body.clientWidth - 560)/2;
		var frame = new Window_frame(560 , 210, 100, margin_Left, null, null, null, null, null, true);
		
		scheduleObj.mWindow = new moveWindow(frame , title, null, null, null, null, true, 1, null, null);
		scheduleObj.mWindow.create_View();
		
		scheduleObj.createView(scheduleObj);
	};
};
proStageReqObj.prototype.createView = function(scheduleObj){
	var viewFrame = document.createElement("div");
	
	//请求信息
	var proView = document.createElement("div");
	proView.className = "proView";
	proView.innerHTML = "<table width='100%' border='0'>"
						+"<tr><td width='25%' height='30px' align='right'>阶段名称：</td>"
 						+"<td width='25%' align='left'>"+$("stage_name").innerHTML+"</td>"
 						+"<td width='20%' align='right'>提问人：</td><td width='30%' align='left'>"+new userNameObj().readTrueName()+"</td></tr>"
 						+"<tr><td width='25%' align='right'>问题内容：</td>"
 						+"<td colspan='3' align='left'><div class='textarea_frame'>"
 						+"<textarea id='stage_request' name='stage_request'></textarea></div></td></tr></table>";
	
	var errorView = document.createElement("div");
	errorView.className = "stage_req_error";
	
	//提交按钮组建
	var stageButtons = document.createElement("div");
	stageButtons.style.marginTop = "5px";
	var commitBtn = document.createElement("input");
	commitBtn.type = "button";
	commitBtn.className = "project_button";
	commitBtn.style.marginLeft = "70px";
	commitBtn.value = "提交问题";
	
	var cancelBtn = document.createElement("input");
	cancelBtn.type = "button";
	cancelBtn.className = "project_button";
	cancelBtn.value = "取消";
	stageButtons.appendChild(commitBtn);
	stageButtons.appendChild(cancelBtn);
	
	viewFrame.appendChild(proView);
	viewFrame.appendChild(errorView);
	viewFrame.appendChild(stageButtons);
	scheduleObj.mWindow.Win_view.add_Child(viewFrame);
	
	//注册按钮事件
	addEvent(commitBtn , "click", this.commitEvent(this , errorView));
	addEvent(cancelBtn , "click", this.cancelEvent(this));
	
	var resultArea = new textareaElementObj($("stage_request") , 200);
	resultArea.createView();				
};
proStageReqObj.prototype.commitEvent = function(stageReqObj , errorView){
	return function(){
		if(!stageReqObj.commitStage){
			if($("stage_request").value==""){
				errorView.innerHTML = "<span style='color:red'>请输入需要询问的问题内容...</span>";
			}else{
				errorView.innerHTML = "<span style='color:green'>系统正在提交信息...</span>";
				stageReqObj.commitStage = true;
				ProjectStageDeal.createStageGuide($("stage_id").value, $("user_id").value , $("stage_request").value, function(commitRes){
					if(commitRes){
						errorView.innerHTML = "<span style='color:green'>课题阶段指导问题提交成功...</span>";
						window.open("StageManageServlet?type=query_team_stage&stageId="+$("stage_id").value , "main_body");
					}else{
						errorView.innerHTML = "<span style='color:red'>课题阶段指导问题提交失败...</span>";
					}
					stageReqObj.commitStage = false;
				});
			}
		}
	}
};
proStageReqObj.prototype.cancelEvent = function(stageReqObj){
	return function(){
		stageReqObj.commitStage = false;
		
		stageReqObj.mWindow.closeWindow();
	}
};
proStageReqObj.prototype.closeClick = function(parentObj){
	return function(){
		//判断该对象是否打开了遮罩层
		if(!parentObj.getParentObj().Win_closeC){
			parentObj.getParentObj().Win_cover.hiddenView();//隐藏遮罩对象
		}
		parentObj.getParentObj().closeWindow();//影藏对象
	};
};


/*
 * 课题阶段文档管理
 */
var upfileObj = null;
function proStageFileObj(buttonObj , stageId){
	this.buttonObj = buttonObj;
	this.stageId = stageId;
	
	this.mWindow = null;
	this.errorView = null;
	this.stageFileView = null;
	this.commitStage = false;	//控制提交状态
}
proStageFileObj.prototype.initObj = function(){
	addEvent(this.buttonObj , "click", this.cClickEvent(this));
}
proStageFileObj.prototype.cClickEvent = function(scheduleObj){
	return function(){
		var titleClose = new Window_close();
		titleClose.close_Click = scheduleObj.closeClick;
		var title = new Window_titleview(null , null, new Window_title("课题阶段指导"), null, null, false, null, null, titleClose, null);//设置标题信息
		
		var margin_Left = (document.body.clientWidth - 600)/2;
		var frame = new Window_frame(600 , 100, 100, margin_Left, null, null, null, null, null, true);
		
		scheduleObj.mWindow = new moveWindow(frame , title, null, null, null, null, true, 1, null, null);
		scheduleObj.mWindow.create_View();
		
		scheduleObj.createView(scheduleObj);
	};
};
proStageFileObj.prototype.createView = function(scheduleObj){
	var viewFrame = document.createElement("div");
	
	//请求信息
	var proView = document.createElement("div");
	proView.className = "proView";
	proView.innerHTML = "<table width='100%' border='0'>"
						+"<tr><td width='30%' height='30px' align='right'>上传人：</td>"
 						+"<td width='25%' align='left'>"+new userNameObj().readTrueName()+"</td>"
 						+"<td width='20%' align='right'>&nbsp;</td><td width='25%' align='left'>&nbsp;</td></tr>"
 						+"<tr><td width='25%' align='right'>阶段文档：</td>"
 						+"<td colspan='3' align='left'><form id='stage_file_form' target='upload_iframe' class='upload_form' enctype='multipart/form-data' method='post'>"
						+"<div class='input_frame'><input type='file' id='stage_file_input' class='upload_file_input' hidefocus='hidefocus' name='project_file'/>"
						+"<input type='text' id='invented_stage_file' name='invented_stage_file' readonly/><div class='select_upload'></div></div>"
						+"<input type='button' id='file_send_submit' class='upload_submit' value='发送'/>"
						+"<iframe name='upload_iframe' style='display:none'></iframe></form></td></tr></table>";
	
	this.errorView = document.createElement("div");
	this.errorView.className = "stage_req_error";
	this.errorView.style.display = "none";
	
	var filesLine = document.createElement("div");
	filesLine.className = "show_files_line";
	
	this.stageFileView = document.createElement("div");
	this.stageFileView.className = "stage_files_frame";
	
	viewFrame.appendChild(proView);
	viewFrame.appendChild(this.errorView);
	viewFrame.appendChild(filesLine);
	viewFrame.appendChild(this.stageFileView);
	this.loadStageFiles(this);
	scheduleObj.mWindow.Win_view.add_Child(viewFrame);
	
	//注册上传文件插件
	upfileObj = new uploadFileObj($("stage_file_input") , $("invented_stage_file"), $("stage_file_form"), $("file_send_submit"), 
	"FileManageServlet?type=stageFileUpload&team_id="+$("team_id").value+"&stage_id="+$("stage_id").value, "file", this);
	upfileObj.createView();
};
proStageFileObj.prototype.loadStageFiles = function(stageFileObj){
	ProjectStageDeal.queryStageFiles( $("stage_id").value, function(fileList){
		if(fileList.length > 0){
			stageFileObj.stageFileView.firstChild ? stageFileObj.stageFileView.removeChild(stageFileObj.stageFileView.firstChild) : "";
			if(fileList.length > 4){
				stageFileObj.stageFileView.style.height = "140px";
				stageFileObj.mWindow.setWindowHeight(130+4*36);
			}else{
				stageFileObj.stageFileView.style.height = fileList.length*36+5+"px";
				stageFileObj.mWindow.setWindowHeight(130+fileList.length*36);
			}
			
			var filesView = document.createElement("div");
			for(var i=0; i<fileList.length; i++){
				var fileSplits = fileList[i].fileName.split(".");
				var file_type = fileSplits[fileSplits.length-1];
				var fileTypeLoc = null;
				
				if(file_type == "zip"){
					fileTypeLoc = "background-position:0px 0px; ";
				}else if(file_type == "rar"){
					fileTypeLoc = "background-position:-30px 0px; ";
				}else if(file_type == "txt"){
					fileTypeLoc = "background-position:-60px 0px; ";
				}else if(file_type == "doc" || file_type =="docx"){
					fileTypeLoc = "background-position:-90px 0px; ";
				}else if(file_type == "ppt" || file_type =="pptx"){
					fileTypeLoc = "background-position:-120px 0px; ";
				}else{
					fileTypeLoc = "background-position:-60px 0px; ";
				}
				
				var fileView = document.createElement("div");
				fileView.className = "stage_file_view";
				fileView.title = fileList[i].fileName+"-文件下载";
				fileView.innerHTML = "<table width='100%' border='0'>"
									+"<tr><td width='65%' align='left'><div class='file_type_view' style='"+fileTypeLoc+"'></div><div class='file_name_view'>"+fileList[i].fileName+"</div></td>"
			 						+"<td width='15%' align='center'>"+fileList[i].senderName+"</td>"
			 						+"<td width='20%' align='center'>"+fileList[i].sendTime.split(" ")[0]+"</td></tr></table>";
			 	
			 	addEvent(fileView , "click", stageFileObj.fileDownload(stageFileObj , fileList[i].fileName));
				filesView.appendChild(fileView);
			}
			stageFileObj.stageFileView.appendChild(filesView);
		}
	});
};
proStageFileObj.prototype.fileDownload = function(stageFileObj , fileName){
	return function(){
		window.open("FileManageServlet?type=stageFileDownload&team_id="+$("team_id").value+"&stage_id="+$("stage_id").value+"&filename="+fileName , "upload_iframe");
	};
};
proStageFileObj.prototype.closeClick = function(parentObj){
	return function(){
		//判断该对象是否打开了遮罩层
		if(!parentObj.getParentObj().Win_closeC){
			parentObj.getParentObj().Win_cover.hiddenView();//隐藏遮罩对象
		}
		parentObj.getParentObj().closeWindow();//影藏对象
	};
};


function uploadFileObj(uploadObj, enterObj, frameObj , submitObj, upurl, filetype, stageFileObj){
	this.uploadObj = uploadObj;
	this.enterObj = enterObj;
	this.frameObj = frameObj;
	this.submitObj = submitObj;
	
	this.upurl = upurl;
	this.filetype = filetype == null || undefined ? "file" : filetype;
	this.stageFileObj = stageFileObj;
	
	this.uploadFileName = null;//用于记录上传的文件名
	this.submitEvent = false;
	this.uploadSuccess = false;//上传文件结果
}
uploadFileObj.prototype.createView = function(){
	addEvent(this.uploadObj , "change", this.onchangeEvent(this));
	addEvent(this.submitObj , "click", this.uploadFile(this));
};
uploadFileObj.prototype.onchangeEvent = function(upfileObj){//当输入的文档路径更改时调用
	return function(){
		if(upfileObj.stageFileObj.errorView.style.display == "block"){
			upfileObj.stageFileObj.mWindow.setWindowHeight(upfileObj.stageFileObj.mWindow.getWindowHeight()-15);
		}
		upfileObj.enterObj.value = upfileObj.uploadObj.value;
		upfileObj.stageFileObj.errorView.style.display = "none";
	};
};
uploadFileObj.prototype.uploadFile = function(upfileObj){
	return function(){
		if(upfileObj.upurl == null || undefined){
			
		}else{
			upfileObj.frameObj.action = upfileObj.upurl+"&oldFileName="+encodeURI(encodeURI(upfileObj.uploadFileName));
			
			if(upfileObj.filetype == "file" && !upfileObj.submitEvent && upfileObj.checkFileType()){
				upfileObj.submitEvent = true;
				
				upfileObj.resultView("文件正在上传请等待...");
				upfileObj.uploadFileName = upfileObj.getUploadFileName();
				upfileObj.frameObj.submit();
			}else if(upfileObj.filetype == "picture" && !upfileObj.submitEvent && upfileObj.checkFileType()){
				upfileObj.submitEvent = true;
				
				upfileObj.resultView("图片正在上传请等待...");
				upfileObj.uploadFileName = upfileObj.getUploadFileName();
				upfileObj.frameObj.submit();
			}
		}
	}
};
uploadFileObj.prototype.uploadFileName = function(){//获取上传文档的名称
	var nameObj = upfileObj.enterObj.value.split("\\");
	var filename = nameObj[nameObj.length-1];
	
	return filename;
};
uploadFileObj.prototype.reflashButtonEvent = function(){//刷新控件事件锁定
	this.submitEvent = false;
};
uploadFileObj.prototype.checkFileType = function(){//这个方法可以通过复写来实现不同文件格式的判断
	if(this.uploadObj.value != "" && this.enterObj.value != ""){
		return true;
	}else{
		this.errorView("请输入需要上传的文件...");
		return false;
	}
};
uploadFileObj.prototype.checkResult = function(){
	if(this.uploadSuccess && !this.submitEvent){
		return true;
	}else if(this.submitEvent){
		this.resultView("文件正在上传请等待...");
	}else{
		this.errorView("请上传课题的相关文件...");
	}
};
uploadFileObj.prototype.resultView = function(str){
	if(this.stageFileObj.errorView.style.display != "block"){
		this.stageFileObj.mWindow.setWindowHeight(this.stageFileObj.mWindow.getWindowHeight()+15);
	}
	this.stageFileObj.errorView.style.display = "block";
	this.stageFileObj.errorView.style.color = "green";
	this.stageFileObj.errorView.innerHTML = str;
};
uploadFileObj.prototype.successUpload = function(str){
	if(this.stageFileObj.errorView.style.display != "block"){
		this.stageFileObj.mWindow.setWindowHeight(this.stageFileObj.mWindow.getWindowHeight()+15);
	}
	this.stageFileObj.errorView.style.display = "block";
	this.stageFileObj.errorView.style.color = "green";
	this.stageFileObj.errorView.innerHTML = str;
	
	this.reflashButtonEvent();
	this.uploadSuccess = true;
};
uploadFileObj.prototype.errorView = function(str){//文件格式问题
	if(this.stageFileObj.errorView.style.display != "block"){
		this.stageFileObj.mWindow.setWindowHeight(this.stageFileObj.mWindow.getWindowHeight()+15);
	}
	this.stageFileObj.errorView.style.display = "block";
	this.stageFileObj.errorView.style.color = "red";
	this.stageFileObj.errorView.innerHTML = str;
	this.reflashButtonEvent();
};
uploadFileObj.prototype.getUploadFileName = function(){//获取上传文件名称
	if(this.enterObj.value != ""){
		var nameObj = this.enterObj.value.split("\\");
		
		return nameObj[nameObj.length-1];//返回上传文件名
	}
};

/*
 * 阶段审核操作
 */
function stageAuditObj(buttonObj){
	this.buttonObj = buttonObj;
	
	this.commit = false;	//防止多次提交
}
stageAuditObj.prototype.initObj = function(){
	addEvent(this.buttonObj , "click", this.commitStart(this));
}
stageAuditObj.prototype.commitStart = function(startObj){
	return function(){
		var promptWin = new promptWindow();
		promptWin.leftBtnClick = startObj.commitEvent(promptWin);
		promptWin.rightBtnClick = startObj.errorEvent(promptWin);
		promptWin.createSelectView("<span style='color:red;font-size:12px;'>你确认要提交该阶段审核？</span><span style='font-size:10px;font-weight:normal;'>(提交后无法更改!)</span>" , "确定" , "取消");
		promptWin.mWindow.setWindowX(500);
		promptWin.mWindow.setWindowY(300);
	}
}
stageAuditObj.prototype.errorEvent = function(promptWin){
	return function(){
		promptWin.closeWindow();
	}
};
stageAuditObj.prototype.commitEvent = function(promptWin){
	return function(){
		promptWin.closeWindow();
		
		//重新刷新数据信息内容(提交阶段审核开始操作)
		window.open("StageManageServlet?type=stage_start_audit&stageId="+$("stage_id").value+"&teamId="+$("team_id").value , "main_body");
	}
};

/*
 * 设置预计阶段结束时间
 */
function predictEndTime(){
	var startTime = new Date($("stage_startTime").innerHTML);
	startTime.setDate(startTime.getDate()+Number($("limit_Day").innerHTML));
	
	$("predict_endTime").innerHTML = startTime.getFullYear()+"-"+(startTime.getMonth()+1)+"-"+startTime.getDate();
}

/*
 * 获取更多的阶段问题信息
 */
function stageMoreReq(btnObj , frameObj, stageId){
	this.btnObj = btnObj;
	this.frameObj = frameObj;
	this.stageId = stageId;
	
	this.reqPageNow = 0;//用于控制当前是第几页
}
stageMoreReq.prototype.initObj = function(){
	addEvent(this.btnObj , "click", this.addMoreReq(this));
};
stageMoreReq.prototype.addMoreReq = function(moreReqObj){
	return function(){
		ProjectStageDeal.queryStageGuides( moreReqObj.stageId, ++moreReqObj.reqPageNow, function(guideList){
			if(guideList.length == 0){
				moreReqObj.btnObj.style.display = "none";
			}else{
				for(var i=0; i<guideList.length; i++){
					var guideView = document.createElement("div");
					guideView.className = "guide_view";
					
					guideView.innerHTML = "<div class='requester_head' style='background:url(headPictures/"+guideList[i].requestHead+")'></div>"
										 +"<table width='100%' style='font-size:13px;' border='0'><tr>"
									     +"<td width='20%' height='30px' align='right'>提问人：</td><td width='20%' align='left'>"+guideList[i].requestName+"</td>"
									     +"<td width='20%' align='right'>提问时间：</td><td width='40%' align='left'>"+guideList[i].requestTime+"</td></tr>"
										 +"<tr><td height='30px' align='right'>问题内容：</td>"
										 +"<td align='left' colspan='3'><div class='project_words_style'>"+guideList[i].requestContent+"</div></td></tr>"
										 +"<tr style='display:"+(guideList[i].answerTime==null ? 'none' : '' )+"'><td height='30px' align='right'>回复人：</td><td align='left'>"+guideList[i].answerName+"</td>"
										 +"<td align='right'>回复时间：</td><td align='left'>"+guideList[i].answerTime+"</td></tr>"
  										 +"<tr style='display:"+(guideList[i].answerTime==null ? 'none' : '' )+"'><td height='30px' align='right'>回复内容：</td>"
										 +"<td align='left' colspan='3'><div class='project_words_style'>"+guideList[i].answerContent+"</div></td></tr></table>";
					
					moreReqObj.frameObj.appendChild(guideView);
				}
				
				//当不存在问题信息时关闭
				moreReqObj.btnObj.style.display = guideList.length<3 ? 'none' : '';
				suit_Page();
			}
		});
	};
};
</script>
</head>

<body onload="init()">
<div class="teamer_infor_body">
	<div id="teamer_infors_out">
		<input type="hidden" id="user_id" value="${user_id }"/>
		<input type="hidden" id="project_id" value="${projectInfor.id }"/>
		<input type="hidden" id="stage_id" value="${stageInfor.id }"/>
		<input type="hidden" id="team_id" value="${stageManage.teamId }"/>
		<input type="hidden" id="startTime" value="${startTime }"/>
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
                <td height="30px" align="center" id="stage_name" class="title_view_style">${stageInfor.stageName }</td>
                <td align="left">&nbsp;</td>
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
			  </tr>
            </table>
			
			<hr style="border:1px dashed #c3c4c5;clear:both;"/>
			<table width="100%" style="font-size:13px;" border="0">
			  <tr><td colspan="4" height="15px" style="position:relative;" align="right">
			  	<div class='audit_result' style="background:url(images/${stageManage==null ? 'no_commit_stage.png' : (stageManage.auditResult=='S' ? 'stage_start.png' : (stageManage.auditResult=='W' ? 'stage_wait.png' : (stageManage.auditResult=='T' ? 'stage_success.png' : 'stage_faile.png'))) }) no-repeat 50%"></div>
			  </td></tr>
              <tr>
                <td width="25%" height="30px" align="right">阶段要求：</td>
                <td align="left" colspan="3"><div class="project_words_style">${stageInfor.stageDemand }</div></td>
              </tr>
              
              <tr>
                <td height="30px" align="right">阶段资料：</td>
                <td align="left" colspan="3">
                	<a class="downStageFile" title="阶段资料下载" href="FileManageServlet?type=downProjectStageFile&stage_id=${stageInfor.id }&filename=${stageInfor.stageFiles }">
                		${stageInfor.stageFiles }
                	</a>
                </td>
              </tr>
              
              <tr>
                <td height="30px" align="right">时间限定：</td>
                <td colspan="3" align="left"><span id="limit_Day" style='color:red'>${stageInfor.timeLimit}</span>&nbsp;天</td>
			  </tr>
            </table>
            
            <table width="100%" style="font-size:13px;display:${stageManage==null ? 'none' : '' }" border="0">
              <tr>
                <td width="25%" height="30px" align="right">阶段开始时间：</td>
                <td align="left" colspan="3"><span id="stage_startTime">${stageManage.startTime }</span></td>
              </tr>
              
              <tr>
                <td height="30px" align="right">阶段结束时间：</td>
                <td align="left" colspan="3">${stageManage.endTime }(预计:<span id="predict_endTime" style="color:red">2014-2-14</span>)</td>
              </tr>
              
              <tr style="display:${stageManage.auditTime==null ? 'none' : '' }">
                <td width="25%" height="30px" align="right">阶段成绩：</td>
                <td width="20%" align="left">${stageManage.auditScore }</td>
                <td width="20%" align="right">阶段审核时间：</td>
                <td width="35%" align="left">${stageManage.auditTime }</td>
			  </tr>
            </table>
            
            <div style="height:40px;padding-top:10px;display:${stageManage.auditResult != 'S' ? 'none' : '' }">
            	<input type="button" style="margin-left:50px;" class="project_button" id="commit_audit" value="提交审核"/>
	            <input type="button" class="project_button" id="break_old_page" value="上一页"/>
            </div>
            
            <div id="stage_guide_view">
            <div class="title_view_style" style="margin-left:100px;text-align:left;">教师指导信息<span class="title_number_style">(信息条数:<span style="color:red">${guideNums }</span>)</span></div>
            <hr style="border:1px dashed #c3c4c5;clear:both;"/>
            <div id="stage_guide_frame">
            	<c:forEach items="${guideList}" var="guideInfor" varStatus="status">
				<div class="guide_view">
					<div class="requester_head" style="background:url(headPictures/${guideInfor.requestHead })"></div>
					<table width="100%" style="font-size:13px;" border="0">
		              <tr>
		                <td width="20%" height="30px" align="right">提问人：</td>
		                <td width="20%" align="left">${guideInfor.requestName }</td>
		                <td width="20%" align="right">提问时间：</td>
		                <td width="40%" align="left">${guideInfor.requestTime }</td>
		              </tr>
		              <tr>
		                <td height="30px" align="right">问题内容：</td>
		                <td align="left" colspan="3"><div class="project_words_style">${guideInfor.requestContent }</div></td>
		              </tr>
		              
		              <tr style="display:${guideInfor.answerTime==null ? 'none' : '' }">
		                <td height="30px" align="right">回复人：</td>
		                <td align="left">${guideInfor.answerName }</td>
		                <td align="right">回复时间：</td>
		                <td align="left">${guideInfor.answerTime }</td>
		              </tr>
		              
		              <tr style="display:${guideInfor.answerTime==null ? 'none' : '' }">
		                <td height="30px" align="right">回复内容：</td>
		                <td align="left" colspan="3"><div class="project_words_style">${guideInfor.answerContent }</div></td>
		              </tr>
		            </table>
				</div>
				</c:forEach>
            </div>
            <div class="guides_more_view" style="display:${guideNums>3 ? '' : 'none'}"><span id="stage_guides_more" title="查看更多信息">更多指导信息...</span></div>
            </div>
		</div>
	</div>
	
	<div id="find_teamer" title="阶段进度比较"></div>
	<div id="stage_req" title="阶段指导"></div>
	<div id="stage_file" title="阶段文档"></div>
</div>
</body>
</html>