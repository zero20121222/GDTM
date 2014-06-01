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
<title>课题阶段开始操作</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
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
	width:550px;
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
	margin-top:8px;
	height:15px;
	float:left;
}
</style>
<script>
var manageTeam = null;
function init(){
    suit_Page();
	if($("teamer_infors_out").offsetHeight < 350){
        var frame = parent.document.getElementById("main_body");

        var winHeight = windowHeight() < 600 ? 686 : windowHeight();
        var marginlength = (winHeight - (frame.offsetHeight+205))/2 + "px";

        //是登入界面居中显示
        frame.style.marginTop = marginlength;
        frame.style.marginBottom = marginlength;
	}
	
	new proStageSchedule($("find_teamer") , $("project_id").value).initObj();
	new stageStartObj($("commit_start")).initObj();
	
	//返回上一页
	$("break_old_page").onclick = function(){
		window.history.back();
	};
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
			var title = new Window_titleview(null , null, new Window_title("课题预期进度"), null, null, false, null, null, titleClose, null);//设置标题信息
			
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
	ProjectStageDeal.queryProjectStages(this.projectId , function(stageInfors){
		var allTime = 0;//整个设计的总时间
		var timeLength = 0;//每个时间段的长度
		
		for(var i=0; i<stageInfors.length; i++){
			allTime += stageInfors[i].timeLimit;
		}
		timeLength = 460/allTime;	//450为显示甘特图的最大长度
		
		var viewFrame = document.createElement("div");
	
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
		
		var baseDay = Math.round(20/timeLength);//天数相加基数
		for(var i=0; i<23; i++){//460/20~23
			if(i <= allTime){
				var dateView = document.createElement("div");
				dateView.className = "date_infor_view";	//大小控制在20px
				
				var monthEndDay = new Date(dateYear,dateMonth,0).getDate();
				if(dateDay <= monthEndDay){
					dateView.innerHTML = dateDay;
					dateDay = dateDay+baseDay;
				}else{
					dateMonth++;
					dateDay=1;
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
			timeView.style.background = "blue";

			var timeWidth = timeLength*stageInfors[i].timeLimit;
			timeView.style.width = timeWidth+"px";
			timeView.style.marginLeft = leftLength+"px";
			
			leftLength += timeWidth;
			
			outFrame.appendChild(titleView);
			outFrame.appendChild(timeView);
			viewFrame.appendChild(outFrame);
			scheduleObj.mWindow.setWindowHeight(scheduleObj.mWindow.getWindowHeight()+35);
		}
	 	
	 	viewFrame.appendChild(proView);
	 	scheduleObj.mWindow.Win_view.add_Child(viewFrame);
		
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
 * 阶段控制开始操作
 */
function stageStartObj(buttonObj){
	this.buttonObj = buttonObj;
	
	this.commit = false;	//防止多次提交
}
stageStartObj.prototype.initObj = function(){
	addEvent(this.buttonObj , "click", this.commitStart(this));
}
stageStartObj.prototype.commitStart = function(startObj){
	return function(){
		if(!startObj.commit){
			startObj.commit = true;
			ProjectStageDeal.startProjectStage($("stage_id").value, $("user_id").value, function(result){
				if(result){
					//阶段开始提交成功
					var promptWin = new promptWindow();
					promptWin.confirmButtonEvent = startObj.refEvent(promptWin);
					promptWin.createConfirmView("<span style='color:green;'>该阶段已成功提交开始请求！</span>" , "确定");
				}else{
					//提交失败
					var promptWin = new promptWindow();
					promptWin.confirmButtonEvent = startObj.errorEvent(promptWin);
					promptWin.createConfirmView("<span style='color:red;'>该阶段已开始无法再提交开始请求！</span>" , "确定");
					
					startObj.commit = false;
				}
			});
		}
	}
}
stageStartObj.prototype.errorEvent = function(promptWin){
	return function(){
		promptWin.closeWindow();
	}
};
stageStartObj.prototype.refEvent = function(promptWin){
	return function(){
		promptWin.closeWindow();
		
		//重新刷新数据信息内容
		window.open("StageManageServlet?type=query_team_stage&stageId="+$("stage_id").value , "main_body");
	}
};
</script>
</head>

<body onload="init()">
<div class="teamer_infor_body">
	<div id="teamer_infors_out">
		<input type="hidden" id="user_id" value="${user_id }"/>
		<input type="hidden" id="project_id" value="${projectInfor.id }"/>
		<input type="hidden" id="stage_id" value="${stageInfor.id }"/>
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
                <td height="30px" align="center" class="title_view_style">${stageInfor.stageName }</td>
                <td align="left">&nbsp;</td>
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
			  </tr>
            </table>
			
			<hr style="border:1px dashed #c3c4c5;clear:both;"/>
			<table width="100%" style="font-size:13px;" border="0">
			  <tr><td colspan="4" height="15px" style="position:relative;" align="right">
			  	<div class='audit_result' style="background:url(images/no_commit_stage.png) no-repeat 50%"></div>
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
                <td colspan="3" align="left"><span style='color:red'>${stageInfor.timeLimit}</span>&nbsp;天</td>
			  </tr>
            </table>
            
            <div style='height:40px;padding-top:10px;'>
            	<input type="button" style="margin-left:100px;" class="project_button" id="commit_start" value="阶段开始"/>
	            <input type="button" class="project_button" id="break_old_page" value="上一页"/>
            </div>
		</div>
	</div>
	
	<div id="find_teamer" title="课题预期进度"></div>
</div>
</body>
</html>
