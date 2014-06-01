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
<title>课题阶段指导操作</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script type="text/javascript" src="js/Fade_Slide.js"></script>
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

#project_stages_show{
	position:absolute;
	cursor:pointer;
	top:40px;
	left:900px;
	width:48px;
	height:48px;
	background:url(images/pro_stage_show.png) no-repeat;
}
.stageFrame{
	font-size:12px;
	width:700px;
	height:300px;
	float:left;
	position:relative;
}
.stageFrame table td{
	font-size:12px;
}
.stageNumber{
	position:absolute;
	cursor:default;
	top:5px;
	left:20px;
	width:40px;
	height:40px;
	font-family:华文行楷;
	font-size:30px;
	font-weight:bold;
	line-height:40px;
	text-align:center;
	color:#B4D02D;
}
.proStageFrameOut{
	position:relative;
	width:702px;
	height:302px;
	margin:0px auto;
	margin-top:20px;
}
.rightIndex{
	position:absolute;
	width:48px;
	height:48px;
	top:100px;
	right:0px;
	opacity:0.2;
	background:url(images/right_index_button.png);
}
.leftIndex{
	position:absolute;
	width:48px;
	height:48px;
	top:100px;
	left:0px;
	opacity:0.2;
	display:none;
	background:url(images/left_index_button.png);
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
.project_words_style {
	width:500px;
	text-indent:20px;
	font-size: 12px;
	font-family: 宋体;
}
</style>
<script>
var manageTeam = null;
var stageMore = null;
function init(){
	suit_Page();
    if($("teamer_infors_out").offsetHeight < 500){
        var frame = parent.document.getElementById("main_body");

        var winHeight = windowHeight() < 600 ? 686 : windowHeight();
        var marginlength = (winHeight - (frame.offsetHeight+205))/2 + "px";

        //是登入界面居中显示
        frame.style.marginTop = marginlength;
        frame.style.marginBottom = marginlength;
    }
	
	new proStageSchedule($("find_teamer") , $("project_id").value).initObj();
	new stageAuditObj($("commit_stageAudit")).initObj();
	//new proStageReqObj($("stage_req") , $("stage_id").value).initObj();
	new proStageGuideObj($("stage_req")).createView();
	new proStageFileObj($("stage_file") , $("stage_id").value).initObj();
	
	predictEndTime();
	
	//返回上一页
	$("break_old_page").onclick = function(){
		window.history.back();
	};
	
	//设置添加更多阶段信息
	stageMore = new stageMoreReq($("stage_guides_more") , $("stage_guide_frame"), $("stage_id").value);
	stageMore.initObj();
	stageMore.flushFrame(stageMore);
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
	
	ProjectStageDeal.queryStageMSByTeamId($("team_id").value , function(manageLists){
		ProjectStageDeal.queryProjectStages(scheduleObj.projectId , function(guideList){
			//去除加载等待时间
			viewFrame.removeChild(viewFrame.firstChild);
			
			var allTime = 0;	
			var scheduleTime = 0;	//整个设计的预定总时间
			var actualTime = 0;	 	//实际设计总时间
			var timeLength = 0;	 	//每个时间段的长度
			
			for(var i=0; i<guideList.length; i++){
				scheduleTime += guideList[i].timeLimit;
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
			for(var i=0; i<guideList.length; i++){
				var outFrame = document.createElement("div");
				outFrame.className = "time_out_frame";
				
				var titleView = document.createElement("div");
				titleView.className = "time_title";
				titleView.innerHTML = guideList[i].stageName;
				
				var timeView = document.createElement("div");
				timeView.className = "time_view";
				
				var scheduleLine = document.createElement("div");
				scheduleLine.className = "time_line_view";
				scheduleLine.title = "预期时间";

                var timeWidth = timeLength*guideList[i].timeLimit;
				scheduleLine.style.background = "blue";
				scheduleLine.style.width = timeWidth+"px";
				scheduleLine.style.marginLeft = leftLength+"px";
				
				var actualLine = document.createElement("div");
				actualLine.className = "time_line_view";
				if(i<manageLists.length){
					var actualDay = manageLists[i].endTime!=null ? (new Date(manageLists[i].endTime) - new Date(manageLists[i].startTime))/(1000*24*3600) : (new Date() - new Date(manageLists[i].startTime))/(1000*24*3600);
					var leftMargin = (new Date(manageLists[i].startTime) - timeObj)/(1000*24*3600);
					
					if(actualDay > guideList[i].timeLimit){
						var overDay = (actualDay-guideList[i].timeLimit+" ").split(".");
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
		var title = new Window_titleview(null , null, new Window_title("课题阶段指导"), null, null, false, null, null, titleClose, null);//设置标题信息
		
		var margin_Left = (document.body.clientWidth - 560)/2;
		var frame = new Window_frame(560 , 210, 100, margin_Left, null, null, null, null, null, true);
		
		scheduleObj.mWindow = new moveWindow(frame , title, null, null, null, null, true, 1, null, null);
		scheduleObj.mWindow.create_View();
		
		scheduleObj.createView(scheduleObj);
	};
};
proStageReqObj.prototype.createView = function(scheduleObj){
	//添加滑动操作处理
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


//对于课题的阶段指导信息的操作
function proStageGuideObj(stageButton){
	this.stageButton = stageButton;
	/*缓动参数设置*/
	this.tween = new Tween(10 , 0, 100, 100);
	this.args = new SlideArgs("left" , false, 0, 10, 2000, "bounce");
	this.slide = null;//缓冲对象
	this.newindex = 0;//表示当前索引对象
	
	this.mWindow = null;//移动窗口对象
	this.frameObj = null;
	this.stageLength = 0;//用于标记显示的阶段数目对象个数
	this.rightIndex = null;//向右索引按钮
	this.leftIndex = null;//向左索引按钮
}
proStageGuideObj.prototype.createView = function(){
	addEvent(this.stageButton , "click", this.queryProStages(this));
};
proStageGuideObj.prototype.queryProStages = function(proStageObj){//获取阶段详细信息内容
	return function(){
		if(proStageObj.mWindow == null){
			var titleClose = new Window_close();
			titleClose.close_Click = proStageObj.close_Click;
			var title = new Window_titleview(null , null, new Window_title("待处理的阶段问题"), null, null, false, null, null, titleClose, null);//设置标题信息
			
			var margin_Left = (document.body.clientWidth - 750)/2;
			var frame = new Window_frame(750 , 360, 100, margin_Left, null, null, null, null, null, true);
			
			proStageObj.mWindow = new moveWindow(frame , title, null, null, null, null, true, 1, null, null);
			proStageObj.mWindow.create_View();
			
			ProjectStageDeal.queryStageGuidesNoDeal($("stage_id").value , function(guideList){
				proStageObj.stageLength = guideList.length;
				
				//创建一个动态移动的活动div
				if(proStageObj.stageLength > 0){
					proStageObj.frameObj = document.createElement("div");
					proStageObj.frameObj.style.overflow = "hidden";
					proStageObj.frameObj.style.width = proStageObj.stageLength*702+"px";
					proStageObj.frameObj.style.height = "312px";
					proStageObj.frameObj.id = "proStagesShow";
					
					proStageObj.rightIndex = document.createElement("div");
					proStageObj.rightIndex.className = "rightIndex";
					addEvent(proStageObj.rightIndex , "mouseover", proStageObj.indexMouseover);
					addEvent(proStageObj.rightIndex , "mouseout", proStageObj.indexMouseout);
					addEvent(proStageObj.rightIndex , "click", proStageObj.rightBtnClick(proStageObj));
					
					proStageObj.leftIndex = document.createElement("div");
					proStageObj.leftIndex.className = "leftIndex";
					addEvent(proStageObj.leftIndex , "mouseover", proStageObj.indexMouseover);
					addEvent(proStageObj.leftIndex , "mouseout", proStageObj.indexMouseout);
					addEvent(proStageObj.leftIndex , "click", proStageObj.leftBtnClick(proStageObj));
					
					var proStageFrameOut = document.createElement("div");
					proStageFrameOut.className = "proStageFrameOut";
					proStageFrameOut.id = "proStageFrameOut";
					proStageFrameOut.appendChild(proStageObj.frameObj);
					proStageFrameOut.appendChild(proStageObj.rightIndex);
					proStageFrameOut.appendChild(proStageObj.leftIndex);
					
					for(var i=0;i<guideList.length;i++){
						proStageObj.frameObj.appendChild(proStageObj.createFrame(guideList[i] , i+1));
					}
					
					proStageObj.mWindow.Win_view.add_Child(proStageFrameOut);
					proStageObj.slide = new SlideObj("proStageFrameOut" , "proStagesShow", proStageObj.stageLength, proStageObj.args, proStageObj.tween);
					proStageObj.slide.slideRun();
				}else{//不存在课题阶段信息则调用信息操作处理(则提示教师创建课题阶段信息的提示)
					var errorView = document.createElement("div");
					errorView.innerHTML = "<div style='color:red;font-size:14px;margin-top:100px;'>不存在需要处理的阶段问题!</div>";
					
					proStageObj.mWindow.Win_view.add_Child(errorView);
				}
			});
		}else{
			proStageObj.mWindow.displayWindow();
		}
	};
};
proStageGuideObj.prototype.createFrame = function(guideInfor , stageNum){//创建阶段框架对象
	var stageFrame = document.createElement("div");
	stageFrame.className = "stageFrame";
   	stageFrame.innerHTML = "<table width='100%' border='0'>"
						+"<tr><td width='20%' height='30px' align='right'>提问人：</td>"
 						+"<td width='30%' align='left'>"+guideInfor.requestName+"</td>"
 						+"<td width='20%' align='right'>提问时间：</td><td width='30%' align='left'>"+guideInfor.requestTime+"</td></tr>"
 						+"<tr height='90px'><td width='20%' align='right'>问题内容：</td>"
 						+"<td colspan='3' align='left'><div class='project_words_style'>"+guideInfor.requestContent+"</div></td></tr>"
						+"<tr><td width='20%' height='30px' align='right'>解答人：</td>"
 						+"<td colspan='3' align='left'>"+new userNameObj().readTrueName()+"</td></tr></table>";
 	
 	var answerView = document.createElement("div");
 	answerView.style.width = "600px";
 	answerView.style.height = "95px";
 	answerView.innerHTML = "<div style='float:left;margin-left:80px;margin-top:30px;'>回答内容：</div>";
 	
 	var textFrame = document.createElement("div");
 	textFrame.style.cssFloat = "left";
 	var textAreaView = document.createElement("div");
 	textAreaView.className = "textarea_frame";
 	var answerText = document.createElement("textarea");
 	textFrame.appendChild(textAreaView);
 	textAreaView.appendChild(answerText);
 	answerView.appendChild(textFrame);
    stageFrame.appendChild(answerView);
    
    var stageNumber = document.createElement("div");
    stageNumber.className = "stageNumber";
    stageNumber.innerHTML = stageNum;
    stageFrame.appendChild(stageNumber);
    
	//提交按钮组建
    var errorView = document.createElement("div");
	errorView.className = "stage_req_error";
	errorView.style.display = "none";
	
	var stageButtons = document.createElement("div");
	stageButtons.style.width = "600px";
	stageButtons.style.marginTop = "5px";
	var commitBtn = document.createElement("input");
	commitBtn.type = "button";
	commitBtn.className = "project_button";
	commitBtn.style.marginLeft = "150px";
	commitBtn.style.marginRight = "100px";
	commitBtn.value = "解决问题";
	
	var cancelBtn = document.createElement("input");
	cancelBtn.type = "button";
	cancelBtn.className = "project_button";
	cancelBtn.value = "取消";
	stageButtons.appendChild(commitBtn);
	stageButtons.appendChild(cancelBtn);
	
	stageFrame.appendChild(errorView);
	stageFrame.appendChild(stageButtons);
	
	//注册按钮事件
	addEvent(commitBtn , "click", this.commitEvent(this , errorView, guideInfor.id, answerText));
	addEvent(cancelBtn , "click", this.cancelEvent(this));
    
    //注册textarea事件
    var resultArea = new textareaElementObj(answerText , 200);
	resultArea.createView();
	
    return stageFrame;
};
proStageGuideObj.prototype.indexMouseover = function(){//移动到对象上
	var event = window.event ? window.event : arguments[0];
	var target = event.target ? event.target : event.srcElement;
	
	target.style.opacity = "1";
};
proStageGuideObj.prototype.indexMouseout = function(){//移出操作
	var event = window.event ? window.event : arguments[0];
	var target = event.target ? event.target : event.srcElement;
	
	target.style.opacity = "0.2";
};
proStageGuideObj.prototype.rightBtnClick = function(proStageObj){//向右点击事件
	return function(){
		proStageObj.slide.slideNext();
		proStageObj.newindex = proStageObj.slide.nowIndex;
		
		proStageObj.leftIndex.style.display = "block";
		proStageObj.newindex >= (proStageObj.stageLength-1) ? proStageObj.rightIndex.style.display = "none" : "";
	};
};
proStageGuideObj.prototype.leftBtnClick = function(proStageObj){//向左点击事件
	return function(){
		proStageObj.slide.slidePrevious();
		proStageObj.newindex = proStageObj.slide.nowIndex;
		
		proStageObj.rightIndex.style.display = "block";
		proStageObj.newindex <= 0 ? proStageObj.leftIndex.style.display = "none" : "";
	};
};
proStageGuideObj.prototype.commitEvent = function(stageReqObj , errorView, guideId, answerText){
	return function(){
		errorView.style.display = "";
		if(answerText.value==""){
			errorView.innerHTML = "<span style='color:red'>请输入回复问题内容...</span>";
		}else{
			errorView.innerHTML = "<span style='color:green'>系统正在提交信息...</span>";
			ProjectStageDeal.answerStageGuide(guideId, answerText.value, function(commitRes){
				if(commitRes){
					errorView.innerHTML = "<span style='color:green'>阶段回复问题提交成功!</span>";
					//实现异步刷新阶段信息内容
					stageMore.flushFrame(stageMore);
				}else{
					errorView.innerHTML = "<span style='color:red'>阶段回复问题提交失败!</span>";
				}
			});
		}
	}
};
proStageGuideObj.prototype.cancelEvent = function(stageReqObj){
	return function(){
		stageReqObj.mWindow.Win_frame.hiddenView();//影藏对象
	}
};
proStageGuideObj.prototype.close_Click = function(parentObj){
	return function(){
		//判断该对象是否打开了遮罩层
		if(!parentObj.getParentObj().Win_closeC){
			parentObj.getParentObj().Win_cover.hiddenView();//隐藏遮罩对象
		}
		parentObj.getParentObj().Win_frame.hiddenView();//影藏对象
	};
};

/*
 * 课题阶段文档管理
 */
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
		var title = new Window_titleview(null , null, new Window_title("课题阶段文档"), null, null, false, null, null, titleClose, null);//设置标题信息
		
		var margin_Left = (document.body.clientWidth - 600)/2;
		var frame = new Window_frame(600 , 20, 100, margin_Left, null, null, null, null, null, true);
		
		scheduleObj.mWindow = new moveWindow(frame , title, null, null, null, null, true, 1, null, null);
		scheduleObj.mWindow.create_View();
		
		scheduleObj.createView(scheduleObj);
	};
};
proStageFileObj.prototype.createView = function(scheduleObj){
	var viewFrame = document.createElement("div");
	
	this.errorView = document.createElement("div");
	this.errorView.className = "stage_req_error";
	this.errorView.style.display = "none";
	this.errorView.innerHTML = "<iframe name='upload_iframe' style='display:none'></iframe>";
	
	var filesLine = document.createElement("div");
	filesLine.className = "show_files_line";
	
	this.stageFileView = document.createElement("div");
	this.stageFileView.className = "stage_files_frame";
	
	viewFrame.appendChild(this.errorView);
	viewFrame.appendChild(filesLine);
	viewFrame.appendChild(this.stageFileView);
	this.loadStageFiles(this);
	scheduleObj.mWindow.Win_view.add_Child(viewFrame);
};
proStageFileObj.prototype.loadStageFiles = function(stageFileObj){
	ProjectStageDeal.queryStageFiles( $("stage_id").value, function(fileList){
		if(fileList.length > 0){
			stageFileObj.stageFileView.firstChild ? stageFileObj.stageFileView.removeChild(stageFileObj.stageFileView.firstChild) : "";
			if(fileList.length > 4){
				stageFileObj.stageFileView.style.height = "140px";
				stageFileObj.mWindow.setWindowHeight(50+4*36);
			}else{
				stageFileObj.stageFileView.style.height = fileList.length*36+5+"px";
				stageFileObj.mWindow.setWindowHeight(50+fileList.length*36);
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
		}else{
			stageFileObj.mWindow.setWindowHeight(50+26);
			
			var filesView = document.createElement("div");
			filesView.innerHTML = "<span style='color:red'>还未提交任何阶段文档</span>";
			stageFileObj.stageFileView.appendChild(filesView);
		}
	});
};
proStageFileObj.prototype.fileDownload = function(stageFileObj , fileName){
	return function(){
		window.open("FileManageServlet?type=stageFileDownload&team_id="+$("team_id").value+"&stage_id="+$("stage_id").value+"&filename="+encodeURI(encodeURI(fileName)) , "upload_iframe");
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

/*
 * 阶段审核操作
 */
function stageAuditObj(buttonObj){
	this.buttonObj = buttonObj;
	
	this.commit = false;	//防止多次提交
}
stageAuditObj.prototype.initObj = function(){
	addEvent(this.buttonObj , "click", this.commitStart(this));
};
stageAuditObj.prototype.commitStart = function(auditObj){
	return function(){
		var titleClose = new Window_close();
		titleClose.close_Click = auditObj.closeClick;
		var title = new Window_titleview(null , null, new Window_title("课题阶段审核"), null, null, false, null, null, titleClose, null);//设置标题信息
		
		var margin_Left = (document.body.clientWidth - 600)/2;
		var frame = new Window_frame(600 , 320, 100, margin_Left, null, null, null, null, null, true);
		
		auditObj.mWindow = new moveWindow(frame , title, null, null, null, null, true, 1, null, null);
		auditObj.mWindow.create_View();
		
		auditObj.createView(auditObj);
	};
};
stageAuditObj.prototype.createView = function(auditObj){
	//添加滑动操作处理
	var viewFrame = document.createElement("div");
	
	//请求信息
	var proView = document.createElement("div");
	proView.className = "proView";
	proView.innerHTML = "<table width='100%' border='0'>"
						+"<tr height='30px'><td width='25%' align='right'>审核人：</td><td colspan='3' align='left'>"+new userNameObj().readTrueName()+"</td></tr>"
 						+"<tr height='30px'><td width='25%' align='right'>审核结果：</td>"
 						+"<td colspan='3' align='left'><input type='radio' style='margin-right:5px;' checked='checked' name='audit_result' value='T'/><span style='color:green'>通过</span>"
 						+"<input type='radio' style='margin-left:20px;margin-right:5px;' name='audit_result' value='F'/><span style='color:red'>不通过</span></td></tr>"
 						+"<tr><td width='25%' align='right'>阶段评语：</td>"
 						+"<td colspan='3' align='left'><div class='textarea_frame'>"
 						+"<textarea id='stage_audit_infor' name='stage_request'></textarea></div></td></tr>"
 						+"<tr height='25px'><td width='25%' align='right'><input id='audit_check0' type='checkbox' style='margin-right:5px;'/></td>"
 						+"<td colspan='3' align='left'>已审核阶段进度信息</td></tr>"
 						+"<tr height='25px'><td width='25%' align='right'><input id='audit_check1' type='checkbox' style='margin-right:5px;'/></td>"
 						+"<td colspan='3' align='left'>已审核学生对于阶段的提交问题内容</td></tr>"
 						+"<tr height='25px'><td width='25%' align='right'><input id='audit_check2' type='checkbox' style='margin-right:5px;'/></td>"
 						+"<td colspan='3' align='left'>已浏览阶段文档信息内容</td></tr></table>";
	
	var errorView = document.createElement("div");
	errorView.className = "stage_req_error";
	errorView.style.display = "none";
	
	//提交按钮组建
	var stageButtons = document.createElement("div");
	stageButtons.style.marginTop = "5px";
	var commitBtn = document.createElement("input");
	commitBtn.type = "button";
	commitBtn.className = "project_button";
	commitBtn.style.marginLeft = "70px";
	commitBtn.value = "提交审核";
	
	var cancelBtn = document.createElement("input");
	cancelBtn.type = "button";
	cancelBtn.className = "project_button";
	cancelBtn.value = "取消";
	stageButtons.appendChild(commitBtn);
	stageButtons.appendChild(cancelBtn);
	
	viewFrame.appendChild(proView);
	viewFrame.appendChild(errorView);
	viewFrame.appendChild(stageButtons);
	auditObj.mWindow.Win_view.add_Child(viewFrame);
	
	//注册按钮事件
	addEvent(commitBtn , "click", this.commitEvent(this , errorView));
	addEvent(cancelBtn , "click", this.cancelEvent(this));
	
	var resultArea = new textareaElementObj($("stage_audit_infor") , 200);
	resultArea.createView();
};
stageAuditObj.prototype.closeClick = function(parentObj){
	return function(){
		//判断该对象是否打开了遮罩层
		if(!parentObj.getParentObj().Win_closeC){
			parentObj.getParentObj().Win_cover.hiddenView();//隐藏遮罩对象
		}
		parentObj.getParentObj().closeWindow();//影藏对象
	};
};
stageAuditObj.prototype.commitEvent = function(auditObj , errorView){
	return function(){
		if(!auditObj.commit){
			errorView.style.display = "";
			if($("stage_audit_infor").value==""){
				errorView.innerHTML = "<span style='color:red'>请输入阶段评语信息...</span>";
			}else{
				if($("audit_check0").checked && $("audit_check1").checked && $("audit_check2").checked){
					auditObj.commit = true;
					errorView.innerHTML = "<span style='color:green'>系统正在提交信息...</span>";
					
					var auditRes = null;
					var auditRess = document.getElementsByName("audit_result");
					for(var i=0; i<auditRess.length; i++){
						if(auditRess[i].checked){
							auditRes = auditRess[i].value;
							break;
						}
					}
					
					ProjectStageDeal.commitStageAudit($("team_id").value, $("stage_id").value, auditRes, $("stage_audit_infor").value, function(commitRes){
						if(commitRes){
							errorView.innerHTML = "<span style='color:green'>课题阶段审核处理提交成功！</span>";
							window.open("StageManageServlet?type=query_stage_guide&stageId="+$("stage_id").value+"&teamId="+$("team_id").value , "main_body");
						}else{
							errorView.innerHTML = "<span style='color:red'>课题阶段审核处理提交失败！</span>";
						}
					});
				}else{
					errorView.innerHTML = "<span style='color:red'>请先浏览学生提交的阶段信息资料...</span>";
				}
			}
		}
	}
};
stageAuditObj.prototype.cancelEvent = function(stageReqObj){
	return function(){
		stageReqObj.mWindow.Win_frame.hiddenView();//影藏对象
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
		ProjectStageDeal.queryDealGuides( moreReqObj.stageId, ++moreReqObj.reqPageNow, function(guideList){
			if(guideList.length == 0){
				moreReqObj.btnObj.style.display = "none";
			}else{
				moreReqObj.btnObj.style.display = "";
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
stageMoreReq.prototype.flushFrame = function(moreReqObj){//获取最新的阶段信息内容
	ProjectStageDeal.queryDealGuides( moreReqObj.stageId, 0, function(guideList){
		//去除组建内的全部阶段信息内容
		var guideChilds = moreReqObj.frameObj.children;
		for(var i=0; i<guideChilds.length;){
			moreReqObj.frameObj.removeChild(guideChilds[i]);
		}
		
		if(guideList.length == 0){
			moreReqObj.btnObj.style.display = "none";
		}else{
			moreReqObj.btnObj.style.display = "";
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
			  
			  <tr style="display:${stageManage.auditTime==null ? 'none' : '' }">
                <td width="25%" height="30px" align="right">阶段评语：</td>
                <td colspan="3" align="left"><div class="project_words_style">${stageManage.auditInfor }</div></td>
			  </tr>
            </table>
            
            <div style="height:40px;padding-top:10px;display:${stageManage.auditResult=='W' ? '' : 'none' }">
            	<input type="button" style="margin-left:50px;" class="project_button" id="commit_stageAudit" value="审核阶段"/>
	            <input type="button" class="project_button" id="break_old_page" value="上一页"/>
            </div>
            
            <div id="stage_guide_view">
            <div class="title_view_style" style="margin-left:100px;text-align:left;">阶段指导信息</div>
            <hr style="border:1px dashed #c3c4c5;clear:both;"/>
            <div id="stage_guide_frame"></div>
            <div class="guides_more_view"><span id="stage_guides_more" style="display:none" title="查看更多信息">更多指导信息...</span></div>
            </div>
		</div>
	</div>
	
	<div id="find_teamer" title="阶段进度比较"></div>
	<div id="stage_req" title="阶段指导"></div>
	<div id="stage_file" title="阶段文档"></div>
</div>
</body>
</html>