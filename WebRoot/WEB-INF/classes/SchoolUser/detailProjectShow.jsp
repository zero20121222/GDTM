<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<!-- 这个是作为一个查看信息内容的页面 -->
<title>毕业课题审核信息页面</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script type="text/javascript" src="js/Fade_Slide.js"></script>
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/ProjectStageDeal.js"></script>
<script type="text/javascript" src="dwr/interface/ProjectAuditDeal.js"></script>
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
	$("project_picture_frame").style.background = "url(ProjectInfor/"+school_id+"/"+creater_id+"/"+picture_name+") 50% 50% no-repeat";
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
	
	new projectUpdateManager($("project_update_index")).createView();
	new proStageFrameObj($("project_stages_show")).createView();
	new proAuditFrameObj($("audit_more_infor")).createView();
}


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
					//因为这个后期是针对于那个已经通过审核操作的学校的课题信息的显示操作的，so在这里就先不进行判断操作了
					//后期不会有没有数据的操作的显示这种情况的显示所以暂不考虑
				}
			});
		}else{
			proStageObj.mWindow.displayWindow();
		}
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

/*
 * 用于显示对于课题更改是否允许的操作处理对象实现
 * updateButton:更改操作按钮
 */
function projectUpdateManager(updateButton){
	this.updateButton = updateButton;
	
	this.promptWin = null;//提示操作处理框
}
projectUpdateManager.prototype.createView = function(){
	addEvent(this.updateButton , "click", this.initlize(this));
};
projectUpdateManager.prototype.initlize = function(updateObj){
	return function(){
		//当审核失败时的更改页面跳转
		window.open("ProjectManagerServlet?type=update_fail_project&project_id="+$("project_id").value , "_self");
	};
};
projectUpdateManager.prototype.errorEvent = function(updateObj){//错误信息
	return function(){
		updateObj.promptWin.closeWindow();
	};
};


//课题的全部审核信息显示对象
function proAuditFrameObj(moreButton){
	this.moreButton = moreButton;
	/*缓动参数设置*/
	this.tween = new Tween(10 , 0, 100, 100);
	this.args = new SlideArgs("left" , false, 0, 10, 2000, "bounce");
	this.slide = null;//缓冲对象
	this.newindex = 0;//表示当前索引对象
	
	this.mWindow = null;//移动窗口对象
	this.frameObj = null;
	this.auditLength = 0;//用于标记显示审核数目对象个数
	this.rightIndex = null;//向右索引按钮
	this.leftIndex = null;//向左索引按钮
}
proAuditFrameObj.prototype.createView = function(){
	addEvent(this.moreButton , "click", this.queryProAudits(this));
};
proAuditFrameObj.prototype.queryProAudits = function(proAuditObj){//获取全部审核详细信息内容
	return function(){
		if(proAuditObj.mWindow == null){
			var titleClose = new Window_close();
			titleClose.close_Click = proAuditObj.close_Click;
			var title = new Window_titleview(null , null, new Window_title("毕业课题审核信息"), null, null, false, null, null, titleClose, null);//设置标题信息
			
			var margin_Left = (document.body.clientWidth - 850)/2;
			var frame = new Window_frame(850 , 450, 100, margin_Left, null, null, null, null, null, true);
			
			proAuditObj.mWindow = new moveWindow(frame , title, null, null, null, null, true, 1, null, null);
			proAuditObj.mWindow.create_View();
			
			ProjectAuditDeal.queryProjectAudits($("project_id").value , function(auditInfors){
				proAuditObj.auditLength = auditInfors.length;
				
				//创建一个动态移动的活动div
				if(proAuditObj.auditLength > 0){
					proAuditObj.frameObj = document.createElement("div");
					proAuditObj.frameObj.style.overflow = "hidden";
					proAuditObj.frameObj.style.width = proAuditObj.auditLength*802+"px";
					proAuditObj.frameObj.style.height = "352px";
					proAuditObj.frameObj.id = "proAuditsShow";
					
					proAuditObj.rightIndex = document.createElement("div");
					proAuditObj.rightIndex.className = "rightBtnIndex";
					proAuditObj.rightIndex.style.display = proAuditObj.auditLength > 1 ? "block" : "none";
					addEvent(proAuditObj.rightIndex , "mouseover", proAuditObj.indexMouseover);
					addEvent(proAuditObj.rightIndex , "mouseout", proAuditObj.indexMouseout);
					addEvent(proAuditObj.rightIndex , "click", proAuditObj.rightBtnClick(proAuditObj));
					
					proAuditObj.leftIndex = document.createElement("div");
					proAuditObj.leftIndex.className = "leftBtnIndex";
					addEvent(proAuditObj.leftIndex , "mouseover", proAuditObj.indexMouseover);
					addEvent(proAuditObj.leftIndex , "mouseout", proAuditObj.indexMouseout);
					addEvent(proAuditObj.leftIndex , "click", proAuditObj.leftBtnClick(proAuditObj));
					
					var proStageFrameOut = document.createElement("div");
					proStageFrameOut.className = "proAuditFrameOut";
					proStageFrameOut.id = "proAuditFrameOut";
					proStageFrameOut.appendChild(proAuditObj.frameObj);
					proStageFrameOut.appendChild(proAuditObj.rightIndex);
					proStageFrameOut.appendChild(proAuditObj.leftIndex);
					
					for(var i=0;i<auditInfors.length;i++){
						proAuditObj.frameObj.appendChild(proAuditObj.createFrame(auditInfors[i] , i+1, proAuditObj));
					}
					
					proAuditObj.mWindow.Win_view.add_Child(proStageFrameOut);
					proAuditObj.slide = new SlideObj("proAuditFrameOut" , "proAuditsShow", proAuditObj.auditLength, proAuditObj.args, proAuditObj.tween);
					proAuditObj.slide.slideRun();
				}else{
					
				}
			});
		}else{
			proAuditObj.mWindow.displayWindow();
		}
	};
};
proAuditFrameObj.prototype.createFrame = function(auditInfor , stageNum, proAuditObj){//创建阶段框架对象
	
	var stageFrame = document.createElement("div");
	stageFrame.className = "auditFrame";
   	stageFrame.innerHTML = "<table width='100%' class='audit_table_style' border=0>"
						+"<tr class='audit_title'><td width='137' align='center'>审核人</td><td width='109' align='center'>审核状态</td>"
						+"<td width='137' align='center'>审核时间</td><td width='321' align='center'>审核评语</td></tr>"
						//审核人1
						+"<tr style='display:"+(auditInfor.auditerName1 == null ? 'none' : '')+";'><td align='center'>"+auditInfor.auditerName1+"</td>"
						+"<td align='center'><span style='color:"+(auditInfor.deal1=='T' ? 'green' : 'red')+"'>"+(auditInfor.deal1=='T' ? '通过' : '不通过')+"</span></td>"
						+"<td align='center'>"+proAuditObj.getDateString(new Date(auditInfor.time1))+"</td><td align='left' style='text-indent:20px'>"+auditInfor.remark1+"</td></tr>"
						//审核人2
						+"<tr style='background:#EFEFEF;display:"+(auditInfor.auditerName2 == null ? 'none' : '')+";'><td align='center'>"+auditInfor.auditerName2+"</td>"
						+"<td align='center'><span style='color:"+(auditInfor.deal2=='T' ? 'green' : 'red')+"'>"+(auditInfor.deal2=='T' ? '通过' : '不通过')+"</span></td>"
						+"<td align='center'>"+proAuditObj.getDateString(new Date(auditInfor.time2))+"</td><td align='left' style='text-indent:20px'>"+auditInfor.remark2+"</td></tr>"
						//审核人3
						+"<tr style='display:"+(auditInfor.auditerName3 == null ? 'none' : '')+";'><td align='center'>"+auditInfor.auditerName3+"</td>"
						+"<td align='center'><span style='color:"+(auditInfor.deal3=='T' ? 'green' : 'red')+"'>"+(auditInfor.deal3=='T' ? '通过' : '不通过')+"</span></td>"
						+"<td align='center'>"+proAuditObj.getDateString(new Date(auditInfor.time3))+"</td><td align='left' style='text-indent:20px'>"+auditInfor.remark3+"</td></tr></table>";

    var stageNumber = document.createElement("div");
    stageNumber.className = "stageNumber";
    stageNumber.innerHTML = stageNum;
    stageFrame.appendChild(stageNumber);
    return stageFrame;
};
proAuditFrameObj.prototype.getDateString = function(dateTime) { 
    var year = dateTime.getFullYear(); 
    var month = dateTime.getMonth() + 1; 
    var date = dateTime.getDate(); 
    
    if(month < 10){
    	month = "0" + month;
    } 
    if(date < 10){ 
    	date = "0" + date;
    }
    return year+"-"+month+"-"+date;
};
proAuditFrameObj.prototype.indexMouseover = function(){//移动到对象上
	var event = window.event ? window.event : arguments[0];
	var target = event.target ? event.target : event.srcElement;
	
	target.style.opacity = "1";
};
proAuditFrameObj.prototype.indexMouseout = function(){//移出操作
	var event = window.event ? window.event : arguments[0];
	var target = event.target ? event.target : event.srcElement;
	
	target.style.opacity = "0.2";
};
proAuditFrameObj.prototype.rightBtnClick = function(proAuditObj){//向右点击事件
	return function(){
		proAuditObj.slide.slideNext();
		proAuditObj.newindex = proAuditObj.slide.nowIndex;
		
		proAuditObj.leftIndex.style.display = "block";
		proAuditObj.newindex >= (proAuditObj.auditLength-1) ? proAuditObj.rightIndex.style.display = "none" : "";
	};
};
proAuditFrameObj.prototype.leftBtnClick = function(proAuditObj){//向左点击事件
	return function(){
		proAuditObj.slide.slidePrevious();
		proAuditObj.newindex = proAuditObj.slide.nowIndex;
		
		proAuditObj.rightIndex.style.display = "block";
		proAuditObj.newindex <= 0 ? proAuditObj.leftIndex.style.display = "none" : "";
	};
};
proAuditFrameObj.prototype.close_Click = function(parentObj){
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
* {
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

.all_frame_out {
	width: 980px;
	height: auto;
	margin: 0 auto;
	position: relative;
}

.create_project_frame {
	clear: both;
	width: 900px;
	position: relative;
	overflow: hidden;
}

.create_main_body {
	width: 800px;
	margin-top: 30px;
	margin-bottom: 30px;
	margin-left: 75px;
	padding: 9px;
	overflow: hidden;
	border: 1px solid #c3c4c5;
	background: #d8d7d7;
	border-radius: 5px;
	box-shadow: 3px 3px 2px #000;
}

.project_main_body {
	width: 100%;
	height: auto;
	background: white;
}

.project_picture_frame {
	width: 120px;
	height: 150px;
	overflow: hidden;
	border: 1px solid #c3c4c5;
	border-radius: 5px;
	box-shadow: 2px 2px 2px #929292;
	background: url(images/upload_file.png) 10% no-repeat;
}

.textarea_frame {
	width: 320px;
	height: 90px;
	background: url(images/textarea_noenter.png);
}

textarea {
	margin-top: 10px;
	margin-left: 10px;
	min-width: 300px;
	min-height: 70px;
	max-width: 300px;
	max-height: 70px;
	color: #666;
	font-size: 13px;
	overflow: hidden;
	border: 0px none;
}

.pro_createrName {
	cursor: pointer;
	font-weight: bold;
	font-size: 13px;
	color: #666;
	text-decoration: none;
}

.pro_createrName:hover {
	color: #A5A5A5;
}

/* 消息组件样式 */
.promptObj {
	width: 100% height : 100px;
	position: relative;
}

.promptLogo {
	width: 50px;
	height: 50px;
	position: absolute;
	top: 30px;
	left: 30px;
	background: url(images/prompt_logo.png);
}

.promptInfor {
	width: auto;
	height: 30px;
	font-size: 13px;
	font-weight: bold;
	position: absolute;
	left: 150px;
	top: 40px;
}

.waitingLogo {
	width: 39px;
	height: 39px;
	position: absolute;
	top: 30px;
	left: 30px;
	background: url(images/waiting_logo.gif);
}

.prompt_confirm_button {
	width: 102px;
	height: 29px;
	font-size: 13px;
	font-weight: bold;
	text-align: center;
	line-height: 29px;
	color: white;
	cursor: pointer;
	position: absolute;
	top: 80px;
	left: 150px;
	background: url(images/frame_button0.png) no-repeat;
}

.prompt_left_button {
	width: 102px;
	height: 29px;
	font-size: 13px;
	font-weight: bold;
	text-align: center;
	line-height: 29px;
	color: white;
	cursor: pointer;
	position: absolute;
	top: 100px;
	left: 70px;
	background: url(images/frame_button0.png) no-repeat;
}

.prompt_right_button {
	width: 102px;
	height: 29px;
	font-size: 13px;
	font-weight: bold;
	text-align: center;
	line-height: 29px;
	color: white;
	cursor: pointer;
	position: absolute;
	top: 100px;
	left: 230px;
	background: url(images/frame_button0.png) no-repeat;
}

.pro_hardNum_star {
	cursor: auto;
	width: 35px;
	height: 30px;
	float: left;
	background: url(images/start.png);
}

.pro_hardNum_nostar {
	cursor: auto;
	width: 35px;
	height: 30px;
	float: left;
	background: url(images/startb.png);
}

tr>td {
	font-size: 14px;
}

.error_infor {
	color: red;
	font-size: 12px;
	font-weight: bold;
	display: none;
}

.project_button {
	width: 102px;
	height: 29px;
	margin-top: auto;
	margin-left: 20px;
	margin-right: 50px;
	font-size: 13px;
	font-weight: bold;
	line-height: 29px;
	color: white;
	cursor: pointer;
	background: url(images/frame_button0.png) no-repeat;
	border: 0px none;
}

.project_button:hover {
	background: url(images/frame_button1.png) no-repeat;
}

#pro_fileDown {
	cursor: pointer;
	font-family: Arial, Helvetica, sans-serif;
	color: #666;
	text-decoration: none;
}

#pro_fileDown :hover {
	color: black;
}

#project_stages_show {
	position: absolute;
	cursor: pointer;
	top: 40px;
	left: 900px;
	width: 48px;
	height: 48px;
	background: url(images/pro_stage_show.png) no-repeat;
}
.project_words_style {
	width:500px;
	text-indent:20px;
	font-size: 12px;
	font-family: 宋体;
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

.rightIndex {
	position: absolute;
	width: 48px;
	height: 48px;
	top: 50px;
	right: 0px;
	opacity: 0.2;
	background: url(images/right_index_button.png);
}

.leftIndex {
	position: absolute;
	width: 48px;
	height: 48px;
	top: 50px;
	left: 0px;
	opacity: 0.2;
	display: none;
	background: url(images/left_index_button.png);
}

.downStageFile {
	font-size: 13px;
	color: #666;
	text-decoration: none;
}

.downStageFile:hover {
	color: black;
	font-weight: bold;
}

.audit_style {
	float:left;
	margin-left:30px;
	font-size: 18px;
	font-family: 华文行楷;
}

.audit_table_style td{
	font-size: 12px;
}
.audit_title{
	font-weight:bold; 
	font-style:normal; 
	background:#eeeeee;
}
.audit_title td{
	font-size: 14px;
	font-family: 华文行楷;
}
.audit_main_body{
	overflow: hidden;
	border: 1px solid #c3c4c5;
	border-radius: 5px;
}
.audit_result_img0{
	position:absolute;
	top:-15px;
	right:20px;
	width:80px;
	height:80px;
	z-index:100;
	background:url(images/pro_audit_wait.png) no-repeat 50%;
}
.audit_result_img1{
	position:absolute;
	top:-15px;
	right:20px;
	width:80px;
	height:80px;
	z-index:100;
	background:url(images/pro_audit_success.png) no-repeat 50%;
}
.audit_result_img2{
	position:absolute;
	top:-15px;
	right:20px;
	width:80px;
	height:80px;
	z-index:100;
	background:url(images/pro_audit_failed.png) no-repeat 50%;
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
.audit_more_infor{
	width:auto;
	height:20px;
	float:left;
	cursor:pointer;
	color:red;
	line-height:20px;
	font-size:12px;
	margin-left:10px;
	padding-left:10px;
	background:url(images/more_infor_img.gif) no-repeat 0% 50%;
}
.audit_more_infor:hover{
	font-weight:bold;
}

/* 课题的全部审核信息显示框架 */
.proAuditFrameOut {
	position: relative;
	width: 802px;
	height: 352px;
	margin: 0px auto;
	margin-top: 20px;
}
.auditFrame {
	width: 800px;
	height: 350px;
	float: left;
	position: relative;
	border: 1px solid #c3c4c5;
	border-radius: 5px;
}
.rightBtnIndex {
	position: absolute;
	width: 48px;
	height: 48px;
	top: 150px;
	right: 0px;
	opacity: 0.2;
	background: url(images/right_index_button.png);
}

.leftBtnIndex {
	position: absolute;
	width: 48px;
	height: 48px;
	top: 150px;
	left: 0px;
	opacity: 0.2;
	display: none;
	background: url(images/left_index_button.png);
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
	            	<span>${projectInfor.workload eq '1' ? '工作量较轻' : (projectInfor.workload eq '2' ? '工作量较重' : '工作量很重')}</span>
	            </td>
              </tr>
              <tr>
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
              </tr>
              <tr>
                <td align="right">院系限定：</td>
                <td colspan="2" align="left">
	                <span>${projectInfor.college eq 'null' ? '无院系限定' : projectInfor.college}</span>
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
			  
			  <!-- 审核情况start -->
			  <tr>
                <td align="center">&nbsp;</td>
                <td align="left">&nbsp;</td>
                <td align="left">&nbsp;</td>
              </tr>
              <tr>
                <td align="center">
                	<span class="audit_style">审核情况</span>
                	<div class="audit_more_infor" id="audit_more_infor" title="更多审核信息">More</div>
                </td>
                <td align="left">&nbsp;</td>
                <td align="left" style="position:relative;">
                	<div class="${projectInfor.stage eq 'W' ? 'audit_result_img0' : (projectInfor.stage eq 'T' ? 'audit_result_img1' : 'audit_result_img2') }"></div>
                </td>
              </tr>
              <tr>
                <td colspan="3" align="right"><hr style="border:1px dashed #c3c4c5;" /></td>
              </tr>
			  <tr>
                <td colspan="3" align="center">
                <div class="audit_main_body">
				<table width="100%" class="audit_table_style" border=0>
                  <tr class="audit_title">
                    <td width="137" align="center">审核人</td>
                    <td width="109" align="center">审核状态</td>
                    <td width="137" align="center">审核时间</td>
                    <td width="321" align="center">审核评语</td>
                  </tr>
                  <tr>
                    <td align="center">${auditInfor.auditerName1 }</td>
                    <td align="center">
                    	<span style="color:${auditInfor.deal1 eq 'T' ? 'green' : 'red' };">
                    		${auditInfor.deal1 eq 'W' ? null : (auditInfor.deal1 eq 'T' ? '通过' : '不通过')}
                    	</span>
                    </td>
                    <td align="center">${auditInfor.time1 }</td>
                    <td align="left" style="text-indent:20px">${auditInfor.remark1 }</td>
                  </tr>
                  <tr style="background:#EFEFEF">
                    <td align="center">${auditInfor.auditerName2 }</td>
                    <td align="center">
                    	<span style="color:${auditInfor.deal2 eq 'T' ? 'green' : 'red' };">
                    		${auditInfor.deal2 eq 'W' ? null : (auditInfor.deal2 eq 'T' ? '通过' : '不通过')}
                    	</span>
                    </td>
                    <td align="center">${auditInfor.time2 }</td>
                    <td align="left" style="text-indent:20px">${auditInfor.remark2 }</td>
                  </tr>
                  <tr>
                    <td align="center">${auditInfor.auditerName3 }</td>
                    <td align="center">
                    	<span style="color:${auditInfor.deal3 eq 'T' ? 'green' : 'red' };">
                    		${auditInfor.deal3 eq 'W' ? null : (auditInfor.deal3 eq 'T' ? '通过' : '不通过')}
                    	</span>
                    </td>
                    <td align="center">${auditInfor.time3 }</td>
                    <td align="left" style="text-indent:20px">${auditInfor.remark3 }</td>
                  </tr>
                </table>
                </div>
				</td>
              </tr>
			  <!-- 审核情况end -->
			  
			  <tr>
                <td align="center">&nbsp;</td>
                <td align="left">&nbsp;</td>
                <td align="left">&nbsp;</td>
              </tr>
              <tr>
                <td align="right">&nbsp;</td>
                <td align="left" colspan="2">
	                <input type="button" class="project_button" id="break_old_page" value="上一页"/>
				</td>
              </tr>
              <tr>
                <td align="center">&nbsp;</td>
                <td align="left">&nbsp;</td>
                <td align="left">&nbsp;</td>
              </tr>
            </table>
		</div>
    </div>
</div>
<div id="project_stages_show" title="课题阶段显示"></div>
<div id="project_update_index" style="display:${projectInfor.stage eq 'W' ? 'none' : (projectInfor.stage eq 'T' ? 'none' : 'block') }" title="课题信息更改"></div>
</div>
</body>
</html>
