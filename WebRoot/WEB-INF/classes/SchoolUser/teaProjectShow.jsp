<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>教师毕业课题显示页面</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script type="text/javascript" src="js/Fade_Slide.js"></script>
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/ProjectStageDeal.js"></script>
<script>
function init(){
	suit_Page();
	initView();
}

function initView(){//初始化页面显示信息内容（图片)
	//上传图片的显示
	var school_id = $("school_id").value;
	var creater_id = $("creater_id").value;
	var picture_name = $("picture_name").value;
	var url = picture_name == "null" ? "images/upload_file.png" : "ProjectInfor/"+school_id+"/"+creater_id+"/"+picture_name;
	$("project_picture_frame").style.background = "url("+url+") 50% 50% no-repeat";
	$("project_picture_frame").title = picture_name;
	
	//难易程度的显示
	var pro_hardNum = $("pro_hardNum").value;
	var project_hardNum = $("project_hardNum");
	for(var i=0 ; i<5; i++){
		var star = document.createElement("div");
		if(i<pro_hardNum){
			star.className = "pro_hardNum_star";
		}else{
			star.className = "pro_hardNum_nostar";
		}
		project_hardNum.appendChild(star);
	}
	
	//资源文件下载设置
	var pro_fileDown = $("pro_fileDown");
	pro_fileDown.href = "FileManageServlet?type=downProjectFile&project_id="+$("project_id").value+"&filename="+$("pro_fileDown").innerHTML;
	
	//返回上一页
	$("break_old_page").onclick = function(){
		window.history.back();
	};
	
	new projectUpdateManager($("project_update_index") , $("project_stage").value).createView();
	new proStageFrameObj($("project_stages_show")).createView();
	new sendProjectAudit($("project_managing_do") , $("project_stage").value).createView();
}


/*
 * 用于显示对于课题更改是否允许的操作处理对象实现
 * updateButton:更改操作按钮
 * projectStage:当前课题的状态信息
 */
function projectUpdateManager(updateButton , projectStage){
	this.updateButton = updateButton;
	this.projectStage = projectStage;
	
	this.promptWin = null;//提示操作处理框
}
projectUpdateManager.prototype.createView = function(){
	addEvent(this.updateButton , "click", this.initlize(this));
};
projectUpdateManager.prototype.initlize = function(updateObj){//根据不同的状态给予不同操作
	return function(){
		if(updateObj.projectStage == "S"){//允许更改
			window.open("ProjectManagerServlet?type=come_update_project&project_id="+$("project_id").value , "_self");
		}else if(updateObj.projectStage == "W"){
			updateObj.promptWin = new promptWindow();
			updateObj.promptWin.confirmButtonEvent = updateObj.errorEvent(updateObj);
			updateObj.promptWin.createConfirmView("<span style='color:red;'>Sorry 当前课题正处于待审核状态无法更改！</span>" , "确定");
		}else if(updateObj.projectStage == "T"){
			updateObj.promptWin = new promptWindow();
		}else if(updateObj.projectStage == "F"){//审核失败允许更改
			
		}else if(updateObj.projectStage == "D"){//删除后需要回复才能更改
			updateObj.promptWin = new promptWindow();
		}
	};
};
projectUpdateManager.prototype.errorEvent = function(updateObj){//错误信息
	return function(){
		updateObj.promptWin.closeWindow();
	};
};

//创建一个课题的提交审核操作信息处理
/*
 * sendButton:需要注册的button对象
 * projectStage:当前课题的处理状态
 */
function sendProjectAudit(sendButton , projectStage){
	this.sendButton = sendButton;
	this.prjectStage = projectStage;
	
	this.promptWin = null;//信息提交时的提示框对象
	this.submitEvent = false;//用于控制提交事件的操作
}
sendProjectAudit.prototype.createView = function(){
	this.initlize();
};
sendProjectAudit.prototype.initlize = function(){//根据课题的状态初始化页面状态
	if(this.prjectStage == "S"){
		this.sendButton.value = "提交审核";
		addEvent(this.sendButton , "click", this.sendAuditing(this));
	}else if(this.prjectStage == "W"){
		this.sendButton.style.display = "none";
	}else if(this.prjectStage == "T"){
		
	}else if(this.prjectStage == "F"){
	
	}else if(this.prjectStage == "D"){
		
	}
};
sendProjectAudit.prototype.sendAuditing = function(sendObj){//课题正在提交审核操作(使用AJAX技术操作)
	return function(){
		if(!sendObj.submitEvent){
			sendObj.submitEvent = true;
			sendObj.promptWin = new promptWindow();
			sendObj.promptWin.createWaitView("正在提交课题信息请等待...");
			
			var sendRequest = newXMLHttpRequest();
			sendRequest.open("post" , "ProjectManagerServlet?type=send_project_audit&project_id="+$("project_id").value, true);
			sendRequest.onreadystatechange = sendObj.sendAuditManage(sendRequest , sendObj);
			
			sendRequest.send(null);
		}
	};
};
sendProjectAudit.prototype.sendAuditManage = function(sendRequest , sendObj){
	return function(){
		if(sendRequest.readyState == 1 || sendRequest.readyState == 2 || sendRequest.readyState == 3){
			
		}else if(sendRequest.readyState == 4){
			if(sendRequest.status == 200){
				var sendResult = sendRequest.responseText;
				
				if(sendResult == "true"){//数据提交审核成功
					sendObj.promptWin.confirmButtonEvent = sendObj.successEvent(sendObj);
					sendObj.promptWin.createConfirmView("<span style='color:green;'>您的课题已成功提交！</span>" , "确定");
				}else if(sendResult == "false"){//数据提交审核失败
					sendObj.promptWin.confirmButtonEvent = sendObj.errorEvent(sendObj);
					sendObj.promptWin.createConfirmView("<span style='color:red;'>Sorry 您的提交操作错误！</span>" , "确定");
				}else if(sendResult == "INFORNOSTAGE"){//没有阶段信息
					var url = "SchoolUser/projectStageCreate.jsp?projectID="+$("project_id").value;
					sendObj.promptWin.leftBtnClick = sendObj.openCreateStage(sendObj , url);//打开阶段创建页面
					sendObj.promptWin.rightBtnClick = sendObj.errorEvent(sendObj);
					sendObj.promptWin.createSelectView("<span style='color:red;font-size:12px;'>Sorry 您还未创建课题阶段！<span style='font-size:11px;color:#666;font-weight:normal;'>(是否创建课题阶段信息?)</span></span>" , "创建阶段", "下次再说");
				}else if(sendResult == "STAGENODETAIL"){//课题阶段数据不详细(这个处理需要考虑对于先获取阶段信息然后再更改阶段信息的操作)
					//var url = "SchoolUser/projectStageCreate.jsp?projectID="+$("project_id").value;
					sendObj.promptWin.leftBtnClick = sendObj.openCreateStage(sendObj , url);
					sendObj.promptWin.rightBtnClick = sendObj.errorEvent(sendObj);
					sendObj.promptWin.createSelectView("<span style='color:red;font-size:12px;'>Sorry 您课题阶段存在问题！<span style='font-size:11px;color:#666;font-weight:normal;'>(是否更改课题阶段信息?)</span></span>" , "创建阶段", "下次再说");
				}else{//课题不存在
					sendObj.promptWin.confirmButtonEvent = sendObj.errorEvent(sendObj);
					sendObj.promptWin.createConfirmView("<span style='color:red;'>Sorry 您提交的课题不存在！</span>" , "确定");
				}
			}
		}
	};
};
sendProjectAudit.prototype.successEvent = function(sendObj){
	return function(){
		sendObj.promptWin.closeWindow();
		window.open("ProjectManagerServlet?type=enter_teacherPros", "main_body");
	};
};
sendProjectAudit.prototype.errorEvent = function(sendObj){
	return function(){
		sendObj.promptWin.closeWindow();
		sendObj.submitEvent = false;
	};
};
sendProjectAudit.prototype.openCreateStage = function(sendObj , url){
	return function(){
		sendObj.promptWin.closeWindow();
		sendObj.submitEvent = false;
		
		var iframe = document.createElement("iframe");
		iframe.style.width = "100%";
		iframe.style.height = "450px";//高度为Window_frame-32
		iframe.style.background = "white";
		iframe.style.border = "0 none";
		iframe.src = url;
		
		var titleClose = new Window_close();
		//关闭了
		var title = new Window_titleview(null , null, new Window_title("毕业课题阶段信息创建"), null, null, false, null, null, titleClose, null);//设置标题信息
		
		var margin_Left = (document.body.clientWidth - 800)/2;
		var frame = new Window_frame(800 , 480, 20, margin_Left, null, null, null, null, null, true);
		
		var mWindow = new moveWindow(frame , title, false, null, null, null, null, null, null, null);
		mWindow.create_View();
		mWindow.Win_view.add_Child(iframe);
	};
};




//对于课题的阶段信息显示的操作
function proStageFrameObj(stageButton){
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
proStageFrameObj.prototype.createView = function(){
	addEvent(this.stageButton , "click", this.queryProStages(this));
};
proStageFrameObj.prototype.queryProStages = function(proStageObj){//获取阶段详细信息内容
	return function(){
		if(proStageObj.mWindow == null){
			var titleClose = new Window_close();
			titleClose.close_Click = proStageObj.close_Click;
			var title = new Window_titleview(null , null, new Window_title("毕业课题阶段信息"), null, null, false, null, null, titleClose, null);//设置标题信息
			
			var margin_Left = (document.body.clientWidth - 650)/2;
			var frame = new Window_frame(650 , 250, 100, margin_Left, null, null, null, null, null, true);
			
			proStageObj.mWindow = new moveWindow(frame , title, null, null, null, null, true, 1, null, null);
			proStageObj.mWindow.create_View();
			
			ProjectStageDeal.queryProjectStages($("project_id").value , function(stageInfors){
				proStageObj.stageLength = stageInfors.length;
				
				//创建一个动态移动的活动div
				if(proStageObj.stageLength > 0){
					proStageObj.frameObj = document.createElement("div");
					proStageObj.frameObj.style.overflow = "hidden";
					proStageObj.frameObj.style.width = proStageObj.stageLength*602+"px";
					proStageObj.frameObj.style.height = "162px";
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
					
					for(var i=0;i<stageInfors.length;i++){
						proStageObj.frameObj.appendChild(proStageObj.createFrame(stageInfors[i] , i+1));
					}
					
					proStageObj.mWindow.Win_view.add_Child(proStageFrameOut);
					proStageObj.slide = new SlideObj("proStageFrameOut" , "proStagesShow", proStageObj.stageLength, proStageObj.args, proStageObj.tween);
					proStageObj.slide.slideRun();
				}else{//不存在课题阶段信息则调用信息操作处理(则提示教师创建课题阶段信息的提示)
					var promptObj = document.createElement("div");
					promptObj.style.cssText = "width:100%;height:auto;position:relative;";
					
					var promptLogo = document.createElement("div");
					promptLogo.style.cssText = "width:50px;height:50px;position:absolute;top:60px;left:150px;background:url(images/prompt_logo.png);";
					promptObj.appendChild(promptLogo);
					
					var promptInfor = document.createElement("div");
					promptInfor.style.cssText = "width:300px;height:30px;font-size:13px;font-weight:bold;position:absolute;left:200px;top:65px;text-align:center;line-height:30px;";
					promptInfor.innerHTML = "<span style='color:red'>您还未创建毕业课题阶段!</span><span style='font-size:12px;font-weight:normal;'>(是否创建课题阶段信息?)</span>";
					promptObj.appendChild(promptInfor);
					
					var promptButton1 = document.createElement("div");
					promptButton1.className = "prompt_button1";
					promptButton1.innerHTML = "创建阶段";
					promptObj.appendChild(promptButton1);
					
					var promptButton2 = document.createElement("div");
					promptButton2.className = "prompt_button2";
					promptButton2.innerHTML = "下次再说";
					promptObj.appendChild(promptButton2);
					
					addEvent(promptButton1 , "mouseover", proStageObj.buttonOver);
					addEvent(promptButton1 , "mouseout", proStageObj.buttonOut);
					addEvent(promptButton1 , "click", proStageObj.openCreateStage(proStageObj));
					addEvent(promptButton2 , "mouseover", proStageObj.buttonOver);
					addEvent(promptButton2 , "mouseout", proStageObj.buttonOut);
					addEvent(promptButton2 , "click", proStageObj.closeStageWin(proStageObj));
					
					proStageObj.mWindow.Win_view.add_Child(promptObj);
				}
			});
		}else{
			proStageObj.mWindow.displayWindow();
		}
	};
};
proStageFrameObj.prototype.buttonOver = function(){
	/*使用css伪类控制
	var event = window.event ? window.event : arguments[0];
	var target = event.target ? event.target : event.srcElement;
	
	target.style.background = "url(images/frame_button1.png) no-repeat";
	*/
};
proStageFrameObj.prototype.buttonOut = function(){
	/*使用css伪类控制
	var event = window.event ? window.event : arguments[0];
	var target = event.target ? event.target : event.srcElement;
	
	target.style.background = "url(images/frame_button0.png) no-repeat";
	*/
};
proStageFrameObj.prototype.closeStageWin = function(proStageObj){
	return function(){
		//判断该对象是否打开了遮罩层
		if(!proStageObj.mWindow.Win_closeC){
			proStageObj.mWindow.Win_cover.hiddenView();//隐藏遮罩对象
		}
		proStageObj.mWindow.Win_frame.hiddenView();//影藏对象
	};
};
proStageFrameObj.prototype.openCreateStage = function(proStageObj){
	return function(){
		if(!proStageObj.mWindow.Win_closeC){
			proStageObj.mWindow.Win_cover.hiddenView();//隐藏遮罩对象
		}
		proStageObj.mWindow.Win_frame.hiddenView();//影藏对象
	
		var iframe = document.createElement("iframe");
		iframe.style.width = "100%";
		iframe.style.height = "450px";//高度为Window_frame-32
		iframe.style.background = "white";
		iframe.style.border = "0 none";
		iframe.src = "SchoolUser/projectStageCreate.jsp?projectID="+$("project_id").value;
		
		var titleClose = new Window_close();
		//关闭了
		var title = new Window_titleview(null , null, new Window_title("毕业课题阶段信息创建"), null, null, false, null, null, titleClose, null);//设置标题信息
		
		var margin_Left = (document.body.clientWidth - 800)/2;
		var frame = new Window_frame(800 , 480, 20, margin_Left, null, null, null, null, null, true);
		
		var mWindow = new moveWindow(frame , title, false, null, null, null, null, null, null, null);
		mWindow.create_View();
		mWindow.Win_view.add_Child(iframe);
	};
};
proStageFrameObj.prototype.createFrame = function(stageInfor , stageNum){//创建阶段框架对象
	var downPath = "FileManageServlet?type=downProjectStageFile&stage_id="+stageInfor.id+"&filename="+stageInfor.stageFiles;

	var stageFrame = document.createElement("div");
	stageFrame.className = "stageFrame";
   	stageFrame.innerHTML = "<table width='100%' border='0'>"
  							+"<tr><td width='25%' height='25px' align='right'>阶段名称：</td>"
    						+"<td width='36%'>"+stageInfor.stageName+"</td>"
   							+"<td width='13%' align='right'>时间限定：</td>"
    						+"<td width='26%'><span style='color:red'>"+stageInfor.timeLimit+"</span>&nbsp;&nbsp天</tr>"
  							+"<tr><td align='right'>阶段要求：</td><td colspan='3' rowspan='4'>"
    						+"<div class='stage_words_style'>"+stageInfor.stageDemand+"</div></td></tr>"
  							+"<tr><td align='right'>&nbsp;</td></tr>"
  							+"<tr><td align='right'>&nbsp;</td></tr>"
  							+"<tr><td align='right'>&nbsp;</td></tr>"
  							+"<tr><td height='25px' align='right'>阶段资料：</td>"
  							+"<td><a class='downStageFile' title='阶段文件下载' href='"+downPath+"'>"+(stageInfor.stageFiles != "null" ? stageInfor.stageFiles : "")+"</a></td>"
    						+"<td align='right'>&nbsp;</td><td>&nbsp;</td></tr></table>";
    						
    var stageNumber = document.createElement("div");
    stageNumber.className = "stageNumber";
    stageNumber.innerHTML = stageNum;
    stageFrame.appendChild(stageNumber);
    return stageFrame;
};
proStageFrameObj.prototype.indexMouseover = function(){//移动到对象上
	var event = window.event ? window.event : arguments[0];
	var target = event.target ? event.target : event.srcElement;
	
	target.style.opacity = "1";
};
proStageFrameObj.prototype.indexMouseout = function(){//移出操作
	var event = window.event ? window.event : arguments[0];
	var target = event.target ? event.target : event.srcElement;
	
	target.style.opacity = "0.2";
};
proStageFrameObj.prototype.rightBtnClick = function(proStageObj){//向右点击事件
	return function(){
		proStageObj.slide.slideNext();
		proStageObj.newindex = proStageObj.slide.nowIndex;
		
		proStageObj.leftIndex.style.display = "block";
		proStageObj.newindex >= (proStageObj.stageLength-1) ? proStageObj.rightIndex.style.display = "none" : "";
	};
};
proStageFrameObj.prototype.leftBtnClick = function(proStageObj){//向左点击事件
	return function(){
		proStageObj.slide.slidePrevious();
		proStageObj.newindex = proStageObj.slide.nowIndex;
		
		proStageObj.rightIndex.style.display = "block";
		proStageObj.newindex <= 0 ? proStageObj.leftIndex.style.display = "none" : "";
	};
};
proStageFrameObj.prototype.close_Click = function(parentObj){
	return function(){
		//判断该对象是否打开了遮罩层
		if(!parentObj.getParentObj().Win_closeC){
			parentObj.getParentObj().Win_cover.hiddenView();//隐藏遮罩对象
		}
		parentObj.getParentObj().Win_frame.hiddenView();//影藏对象
	};
};

</script>
<style>
*{
	margin: 0;
	padding: 0;
	outline: none;
}
body {
	line-height: 1.5em;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #666;
	background: #fff;
}

.all_frame_out{
	width:980px;
	height:auto;
	
	margin: 0 auto;
	position:relative;
}
.create_project_frame {
	clear:both;
	width:900px;
	
	position:relative;
	overflow:hidden;
}
.create_main_body {
	width: 800px;
	margin-top: 30px;
	margin-bottom: 30px;
	margin-left:75px;
	padding: 9px;
	
	overflow:hidden;
	border: 1px solid #c3c4c5;
	background: #d8d7d7;
	border-radius:5px;
	box-shadow:3px 3px 2px #000;
}
.project_main_body{
	width:100%;
	height:auto;
	background:white;
}
.project_picture_frame{
	width:120px;
	height:150px;
	
	overflow:hidden;
	border: 1px solid #c3c4c5;
	border-radius:5px;
	box-shadow:2px 2px 2px #929292;
	background:url(images/upload_file.png) 10% no-repeat;
}
.textarea_frame{
	width:320px;
	height:90px;
	background:url(images/textarea_noenter.png);
}
textarea{
	margin-top:10px;
	margin-left:10px;
	min-width:300px;
	min-height:70px;
	max-width:300px;
	max-height:70px;
	
	color: #666;
	font-size:13px;
	overflow:hidden;
	border:0px none;
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


/* 消息组件样式 */
.promptObj{
	width:100%
	height:100px;
	position:relative;
}
.promptLogo{
	width:50px;
	height:50px;
	position:absolute;
	top:30px;
	left:30px;
	background:url(images/prompt_logo.png);
}
.promptInfor{
	width:auto;
	height:30px;
	font-size:13px;
	font-weight:bold;
	position:absolute;
	left:150px;
	top:40px;
}
.waitingLogo{
	width:39px;
	height:39px;
	position:absolute;
	top:30px;
	left:30px;
	background:url(images/waiting_logo.gif);
}
.prompt_confirm_button{
	width:102px;
	height:29px;
	
	font-size:13px;
	font-weight:bold;
	text-align:center;
	line-height:29px;
	color:white;
	cursor:pointer;
	position:absolute;
	top:80px;
	left:150px;
	background:url(images/frame_button0.png) no-repeat;
}
.prompt_left_button{
	width:102px;
	height:29px;
	
	font-size:13px;
	font-weight:bold;
	text-align:center;
	line-height:29px;
	color:white;
	cursor:pointer;
	position:absolute;
	top:100px;
	left:70px;
	background:url(images/frame_button0.png) no-repeat;
}
.prompt_right_button{
	width:102px;
	height:29px;
	
	font-size:13px;
	font-weight:bold;
	text-align:center;
	line-height:29px;
	color:white;
	cursor:pointer;
	position:absolute;
	top:100px;
	left:230px;
	background:url(images/frame_button0.png) no-repeat;
}
.pro_hardNum_star{
	cursor:auto;
	width:35px;
	height:30px;
	float:left;
	background:url(images/start.png);
}
.pro_hardNum_nostar{
	cursor:auto;
	width:35px;
	height:30px;
	float:left;
	background:url(images/startb.png);
}

tr > td{
	font-size:14px;
}
.error_infor{
	color:red;
	font-size:12px;
	font-weight:bold;
	display:none;
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
#pro_fileDown{
	cursor:pointer;
	font-family: Arial, Helvetica, sans-serif;
	color: #666;
	text-decoration:none;
}
#pro_fileDown:hover{
	color:black;
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
#project_update_index{
	position:absolute;
	cursor:pointer;
	top:100px;
	left:900px;
	width:48px;
	height:48px;
	background:url(images/project_update_index.png) no-repeat;
}
.stageFrame {
	width: 600px;
	height: 160px;
	float: left;
	position: relative;
}
.stageFrame td{
	font-size:12px;
}
.stage_words_style {
	width:440px;
	height:110px;
	text-indent:20px;
	font-size: 12px;
	font-family: 宋体;
}

.stageNumber {
	position: absolute;
	cursor: default;
	top: 5px;
	left: 20px;
	width: 40px;
	height: 40px;
	font-family: 华文行楷;
	font-size: 30px;
	font-weight: bold;
	line-height: 40px;
	text-align: center;
	color: #B4D02D;
}

.proStageFrameOut {
	position: relative;
	width: 602px;
	height: 162px;
	margin: 0px auto;
	margin-top: 20px;
}
.rightIndex{
	position:absolute;
	width:48px;
	height:48px;
	top:50px;
	right:0px;
	opacity:0.2;
	background:url(images/right_index_button.png);
}
.leftIndex{
	position:absolute;
	width:48px;
	height:48px;
	top:50px;
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
.prompt_button1{
	width:102px;
	height:29px;
	font-size:13px;
	font-weight:bold;
	padding-left:30px;
	line-height:29px;
	color:white;
	cursor:pointer;
	position:absolute;
	top:130px;
	left:190px;
	background:url(images/frame_button0.png) no-repeat;
}
.prompt_button1:hover{
	background:url(images/frame_button1.png) no-repeat;
}
.prompt_button2{
	width:102px;
	height:29px;
	font-size:13px;
	font-weight:bold;
	padding-left:30px;
	line-height:29px;
	color:white;
	cursor:pointer;
	position:absolute;
	top:130px;
	left:350px;
	background:url(images/frame_button0.png) no-repeat;
}
.prompt_button2:hover{
	background:url(images/frame_button1.png) no-repeat;
}
</style>
</head>

<body onload="init()">
<div class="all_frame_out">
<div class="create_project_frame">
    <div class="create_main_body">
		<div class="project_main_body">
		  <table width="100%" border="0">
              <tr>
                <td width="29%" align="right">&nbsp;</td>
                <td width="31%" align="left">&nbsp;</td>
                <td width="40%" rowspan="9" align="left">
					<div class="project_picture_frame" id="project_picture_frame">
						<input type="hidden" id="project_id" value="${projectInfor.id }"/>
						<input type="hidden" id="school_id" value="${projectInfor.schoolId }"/>
						<input type="hidden" id="creater_id" value="${projectInfor.createrId }"/>
						<input type="hidden" id="picture_name" value="${projectInfor.picture }"/>
						<input type="hidden" id="project_stage" value="${projectInfor.stage }"/>
					</div>
				</td>
              </tr>
              <tr>
                <td align="right">题目名称：</td>
                <td align="left">
					<span>${projectInfor.projectName }</span>
				</td>
              </tr>
              <tr>
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
              </tr>
              <tr>
                <td align="right">出题人：</td>
                <td align="left">
                	<a class="pro_createrName" href="ProjectManagerServlet?type=query_creater_infor&creater_id=${projectInfor.createrId }">${projectInfor.createrName }</a>                </td>
              </tr>
              <tr>
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
              </tr>
              <tr>
                <td align="right">参与人数限定：</td>
                <td align="left">
                	<span>${projectInfor.partNum }&nbsp;人</span>              	</td>
              </tr>
              <tr>
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
              </tr>
              <tr>
                <td align="right">工作量大小：</td>
                <td align="left">
	            	<span>${projectInfor.workload eq "1" ? "工作量较轻" : (projectInfor.workload eq "2" ? "工作量较重" : "工作量很重")}</span>
	            </td>
              </tr>
              <tr>
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
              </tr>
              <tr>
                <td align="right">院系限定：</td>
                <td colspan="2" align="left">
	                <span>${projectInfor.college eq "null" ? "无院系限定" : projectInfor.college}</span>
	            </td>
			  </tr>
              <tr>
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
                <td align="left">&nbsp;</td>
              </tr>
              <tr>
                <td align="right">难易程度：</td>
				<td colspan="2" align="left">
					<div id="project_hardNum">
						<input type="hidden" id="pro_hardNum" value="${projectInfor.hardNum }" />
					</div>
				</td>
			  </tr>
              <tr>
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
                <td align="left">&nbsp;</td>
              </tr>
              <tr>
                <td align="right" height="30">课题资料文件：</td>
                <td colspan="2" align="left">
                	<a title="资料下载" id="pro_fileDown">${projectInfor.projectFile }</a> 
                </td>
              </tr>
              <tr>
                <td align="right">&nbsp;</td>
                <td colspan="2" align="left">
                	<span class="project_result_view" id="upload_file_result"></span>
                </td>
              </tr>
              <tr>
                <td align="right">课题目的：</td>
                <td colspan="2" align="left"><div class="project_words_style">${projectInfor.purpose }</div></td>
              </tr>
              
              <tr>
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
                <td align="left">&nbsp;</td>
              </tr>
              <tr>
                <td align="right">主要内容：</td>
                <td colspan="2" align="left"><div class="project_words_style">${projectInfor.mainContent }</div></td>
              </tr>
              
              <tr>
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
                <td align="left">&nbsp;</td>
              </tr>
              <tr>
                <td align="right">&nbsp;</td>
                <td align="left" colspan="2">
	                <input type="button" class="project_button" id="project_managing_do"/>
	                <input type="button" class="project_button" id="break_old_page" value="上一页"/>
                </td>
              </tr>
              <tr>
                <td colspan="3" align="right">&nbsp;</td>
              </tr>
            </table>
		</div>
    </div>
</div>
<div id="project_stages_show" title="课题阶段显示"></div>
<div id="project_update_index" title="课题信息更改"></div>
</div>
</body>
</html>
