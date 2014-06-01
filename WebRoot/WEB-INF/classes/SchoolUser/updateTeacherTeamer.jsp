<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>教师用户信息</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script type="text/javascript" src="js/Fade_Slide.js"></script>
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/DWRTeamManage.js"></script>
<script>
function init(){
	suit_Page();
	
	//详细恢复信息内容
	new teamReqFrameObj($("audit_more_infor")).createView();
	
	//从新提交团队请求
	new repeatTeamerObj($("repeatButton") , $("relationId").value).createView();
	
	//注册返回上一页的事件操作
	$("break_old_page").onclick = function(){
		window.history.back();
	};
}

//从新团队请求操作
function repeatTeamerObj(buttonObj , relationId){
	this.buttonObj = buttonObj;
	this.relationId = relationId;//队员关系编号
	
	this.promptWin = null;
	this.submitSend = false;//防止用户多次提交操作
}
repeatTeamerObj.prototype.createView = function(){
	addEvent(this.buttonObj , "click", this.repeatCommit(this));
};
repeatTeamerObj.prototype.repeatCommit = function(repeatObj){//再次团队请求提交操作
	return function(){
		if(!repeatObj.submitSend){
			repeatObj.submitSend = true;
			repeatObj.promptWin = new promptWindow();
			repeatObj.promptWin.createWaitView("正在提交团队请求请等待...");
			
			DWRTeamManage.repeatCommitTeacher(repeatObj.relationId , function(result){
				if(result == -1){//已有指导教师
					repeatObj.promptWin.confirmButtonEvent = repeatObj.errorEvent(repeatObj);
					repeatObj.promptWin.createConfirmView("<span style='color:red;'>您已有指导教师了无法再邀请！</span>" , "确定");
					
					repeatObj.submitSend = false;
				}else if(result == 0){//已达指导数目已达上限
					repeatObj.promptWin.confirmButtonEvent = repeatObj.errorEvent(repeatObj);
					repeatObj.promptWin.createConfirmView("<span style='color:red;'>该指导老师已达指导数目已达上限！</span>" , "确定");
					
					repeatObj.submitSend = false;
				}else if(result == 1){//提交团队请求成功
					repeatObj.promptWin.confirmButtonEvent = repeatObj.errorEvent(repeatObj);
					repeatObj.promptWin.createConfirmView("<span style='color:green;'>您的指导教师请求提交成功！</span>" , "确定");
				}else if(result == 2){//提交团队请求失败
					repeatObj.promptWin.confirmButtonEvent = repeatObj.errorEvent(repeatObj);
					repeatObj.promptWin.createConfirmView("<span style='color:red;'>Sorry 您的提交操作失败！</span>" , "确定");
					
					repeatObj.submitSend = false;
				}
			});
		}
	};
};
repeatTeamerObj.prototype.errorEvent = function(repeatObj){//错误信息
	return function(){
		repeatObj.promptWin.closeWindow();
	};
};

//用户的全部恢复信息内容（管理员根据信息判断是否再邀请用户）
function teamReqFrameObj(moreButton){
	this.moreButton = moreButton;
	/*缓动参数设置*/
	this.tween = new Tween(10 , 0, 100, 100);
	this.args = new SlideArgs("left" , false, 0, 10, 2000, "bounce");
	this.slide = null;//缓冲对象
	this.newindex = 0;//表示当前索引对象
	
	this.mWindow = null;//移动窗口对象
	this.frameObj = null;
	this.relationLength = 0;
	this.rightIndex = null;//向右索引按钮
	this.leftIndex = null;//向左索引按钮
}
teamReqFrameObj.prototype.createView = function(){
	addEvent(this.moreButton , "click", this.queryProAudits(this));
};
teamReqFrameObj.prototype.queryProAudits = function(proAuditObj){
	return function(){
		if(proAuditObj.mWindow == null){
			var titleClose = new Window_close();
			titleClose.close_Click = proAuditObj.close_Click;
			var title = new Window_titleview(null , null, new Window_title("详细回复信息"), null, null, false, null, null, titleClose, null);//设置标题信息
			
			var margin_Left = (document.body.clientWidth - 450)/2;
			var frame = new Window_frame(550 , 200, 100, margin_Left, null, null, null, null, null, true);
			
			proAuditObj.mWindow = new moveWindow(frame , title, null, null, null, null, true, 1, null, null);
			proAuditObj.mWindow.create_View();
			
			DWRTeamManage.queryTeamRelations($("relationId").value , function(relationList){
				proAuditObj.relationLength = relationList.length;
				
				//创建一个动态移动的活动div
				if(proAuditObj.relationLength > 0){
					proAuditObj.frameObj = document.createElement("div");
					proAuditObj.frameObj.style.overflow = "hidden";
					proAuditObj.frameObj.style.width = proAuditObj.relationLength*502+"px";
					proAuditObj.frameObj.style.height = "152px";
					proAuditObj.frameObj.id = "proAuditsShow";
					
					proAuditObj.rightIndex = document.createElement("div");
					proAuditObj.rightIndex.className = "rightBtnIndex";
					proAuditObj.rightIndex.style.display = proAuditObj.relationLength > 1 ? "block" : "none";
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
					
					for(var i=0;i<relationList.length;i++){
						proAuditObj.frameObj.appendChild(proAuditObj.createFrame(relationList[i] , i+1, proAuditObj));
					}
					
					proAuditObj.mWindow.Win_view.add_Child(proStageFrameOut);
					proAuditObj.slide = new SlideObj("proAuditFrameOut" , "proAuditsShow", proAuditObj.relationLength, proAuditObj.args, proAuditObj.tween);
					proAuditObj.slide.slideRun();
				}else{
					
				}
			});
		}else{
			proAuditObj.mWindow.displayWindow();
		}
	};
};
teamReqFrameObj.prototype.createFrame = function(relationInfor , stageNum, proAuditObj){
	
	var stageFrame = document.createElement("div");
	stageFrame.className = "auditFrame";
   	stageFrame.innerHTML = "<div class='answer_stage' style='background:url("+(relationInfor.answer=='T' ? 'images/req_team_success.png' : (relationInfor.answer=='F' ? 'images/req_team_fail.png' : 'images/req_team_wait.png'))+") no-repeat 50%'></div>"
							+"<table width='100%' border='0'>"
							+"<tr><td colspan='4' align='right'>&nbsp;</td></tr>"
							+"<tr><td width='25%' align='right'>队员姓名：</td><td width='25%' align='left'>"+relationInfor.teamerName+"</td>"
							+"<td width='25%' align='right'>回复时间：</td><td width='25%' align='left'>"+(relationInfor.answerTime == null ? "" : proAuditObj.getDateString(new Date(relationInfor.answerTime)))+"</td></tr>"
							+"<tr><td align='right' colspan='4'>&nbsp;</td></tr>"
							+"<tr><td align='right'>回复信息：</td>"
			                +"<td colspan='3' align='left'><div class='request_words_style'>"+(relationInfor.answerInfor == null ? "" : relationInfor.answerInfor)+"</div></td></tr></table>";

    var stageNumber = document.createElement("div");
    stageNumber.className = "stageNumber";
    stageNumber.innerHTML = stageNum;
    stageFrame.appendChild(stageNumber);
    return stageFrame;
};
teamReqFrameObj.prototype.getDateString = function(dateTime) { 
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
teamReqFrameObj.prototype.indexMouseover = function(){//移动到对象上
	var event = window.event ? window.event : arguments[0];
	var target = event.target ? event.target : event.srcElement;
	
	target.style.opacity = "1";
};
teamReqFrameObj.prototype.indexMouseout = function(){//移出操作
	var event = window.event ? window.event : arguments[0];
	var target = event.target ? event.target : event.srcElement;
	
	target.style.opacity = "0.2";
};
teamReqFrameObj.prototype.rightBtnClick = function(proAuditObj){//向右点击事件
	return function(){
		proAuditObj.slide.slideNext();
		proAuditObj.newindex = proAuditObj.slide.nowIndex;
		
		proAuditObj.leftIndex.style.display = "block";
		proAuditObj.newindex >= (proAuditObj.relationLength-1) ? proAuditObj.rightIndex.style.display = "none" : "";
	};
};
teamReqFrameObj.prototype.leftBtnClick = function(proAuditObj){//向左点击事件
	return function(){
		proAuditObj.slide.slidePrevious();
		proAuditObj.newindex = proAuditObj.slide.nowIndex;
		
		proAuditObj.rightIndex.style.display = "block";
		proAuditObj.newindex <= 0 ? proAuditObj.leftIndex.style.display = "none" : "";
	};
};
teamReqFrameObj.prototype.close_Click = function(parentObj){
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
.project_creater_frame{
	clear: both;
	width: 980px;
	margin: 0 auto;
	
	overflow:hidden;
}
.project_creater_body {
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
.tea_logon_frame{
	width:100%;
	background:white;
}
.project_creater_infor_frame{
	position:relative;
	width:500px;
	margin:0px auto;
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
.button_view{
	width:102px;
	height:29px;
	
	font-size:13px;
	font-weight:bold;
	line-height:29px;
	margin-left:15px;
	margin-right:15px;
	color:white;
	cursor:pointer;
	background:url(images/frame_button0.png) no-repeat;
	border:0px none;
}
.button_view:hover{
	background:url(images/frame_button1.png) no-repeat;
}
.sex_radio{
	width:auto;
	height:auto;
	margin-top:5px;
	margin-left:7px;
	margin-right:4px;
}
tr > td{
	font-size:14px;
}
.textarea_frame{
	width:320px;
	height:90px;
	background:url(images/textarea_noenter.png);
}
.user_resume{
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
.project_creater_log{
	width:128px;
	height:128px;
	position:absolute;
	top:20px;
	right:20px;
	background:url(images/teacher_logon_log.png);
}
.project_words_style {
	width:400px;
	text-indent:20px;
	font-size: 12px;
	font-family: 宋体;
}
.audit_style {
	float:left;
	margin-left:30px;
	font-size: 18px;
	font-family: 华文行楷;
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
.answerView{
	position:relative;
	width:650px;
	margin:0px auto;
	background:white;
}
.answerView td{
	font-size:12px;
}
.button_frame{
	width:100%;
	height:45px;
	margin-top:5px;
}
.answer_stage{
	width:60px;
	height:60px;
	position:absolute;
	top:0px;
	right:20px;
}

/* 显示详细请求信息 */
.rightBtnIndex {
	position: absolute;
	width: 48px;
	height: 48px;
	top: 50px;
	right: 0px;
	opacity: 0.2;
	background: url(images/right_index_button.png);
}
.leftBtnIndex {
	position: absolute;
	width: 48px;
	height: 48px;
	top: 50px;
	left: 0px;
	opacity: 0.2;
	display: none;
	background: url(images/left_index_button.png);
}
.proAuditFrameOut {
	position: relative;
	width: 502px;
	height: 152px;
	margin: 0px auto;
	margin-top: 15px;
}
.auditFrame {
	width: 500px;
	height: 140px;
	float: left;
	position: relative;
	border: 1px solid #c3c4c5;
	border-radius: 5px;
}
.auditFrame td{
	font-size:12px;
}
.stageNumber {
	position: absolute;
	cursor: default;
	top: 5px;
	left: 10px;
	width: 40px;
	height: 40px;
	font-family: 华文行楷;
	font-size: 30px;
	font-weight: bold;
	line-height: 40px;
	text-align: center;
	color: #B4D02D;
}
.request_words_style {
	width:auto;
	text-indent:20px;
	font-size: 12px;
	font-family: 宋体;
}
</style>
</head>

<body onload="init()">
	<div class="project_creater_frame">
		<div class="project_creater_body">
			<div class="tea_logon_frame">
				<div class="project_creater_infor_frame">
				<div class="project_creater_log"></div>
				<table width="100%" border="0">
				<tr>
				  <td colspan="3" align="right">&nbsp;</td>
				</tr>
				<tr>
				  <td width="21%" align="right">真实姓名：</td>
				  <td width="76%" align="left">${teacherInfor.realName }</td>
				</tr>
				<tr>
				  <td align="right">&nbsp;</td>
				  <td align="left">&nbsp;</td>
				</tr>
				<tr>
				  <td align="right">院系类别：</td>
				  <td align="left">${teacherInfor.college }</td>
				</tr>
				<tr>
				  <td align="right">&nbsp;</td>
				  <td align="left">&nbsp;</td>
				</tr>
				
				<tr>
				  <td align="right">学位：</td>
				  <td align="left">${teacherInfor.degree }</td>
				</tr>
				<tr>
				  <td align="right">&nbsp;</td>
				  <td align="left">&nbsp;</td>
				</tr>
				
				<tr>
				  <td align="right">职位：</td>
				  <td align="left">${teacherInfor.position }</td>
				</tr>
				<tr>
				  <td align="right">&nbsp;</td>
				  <td align="left">&nbsp;</td>
				</tr>
				
				<tr>
				  <td align="right">办公室：</td>
				  <td align="left">${teacherInfor.office }</td>
				</tr>
				<tr>
				  <td align="right">&nbsp;</td>
				  <td align="left">&nbsp;</td>
				</tr>
				
				<tr>
				  <td align="right">email：</td>
				  <td align="left">${teacherInfor.email }</td>
				</tr>
				<tr>
				  <td align="right">&nbsp;</td>
				  <td align="left">&nbsp;</td>
				</tr>
				
				<tr>
				  <td align="right">年龄：</td>
				  <td align="left">${teacherInfor.age }</td>
				</tr>
				<tr>
				  <td align="right">&nbsp;</td>
				  <td align="left">&nbsp;</td>
				</tr>
				<tr>
				  <td align="right">性别：</td>
				  <td align="left">
				  	<input type="radio" disabled="disabled" name="user_sex" ${teacherInfor.sex eq "M" ? "checked='checked'" : ""} class="sex_radio" value="M"/>男
				  	<input type="radio" disabled="disabled" name="user_sex" ${teacherInfor.sex eq "F" ? "checked='checked'" : ""} class="sex_radio" value="F"/>女
				  </td>
				</tr>
				<tr>
				  <td align="right">&nbsp;</td>
				  <td align="left">&nbsp;</td>
				</tr>
				<tr>
				  <td align="right">手机：</td>
				  <td align="left">${teacherInfor.phone }</td>
				</tr>
				<tr>
				  <td align="right">&nbsp;</td>
				  <td align="left">&nbsp;</td>
				</tr>
				<tr>
				  <td align="right">qq：</td>
				  <td align="left">${teacherInfor.qq }</td>
				</tr>
				<tr>
				  <td align="right">&nbsp;</td>
				  <td align="left">&nbsp;</td>
				</tr>
				
				<tr>
				  <td align="right">个人简介：</td>
                  <td colspan="2" align="left"><div class="project_words_style">${teacherInfor.resume }</div></td>
				</tr>
				
				<tr>
				  <td align="right">&nbsp;</td>
				  <td align="left">&nbsp;</td>
				</tr>
				</table>
				</div>
				
				<div style="text-align:left;">
					<div class="audit_style">请求信息回复</div>
                	<div class="audit_more_infor" id="audit_more_infor" title="更多审核信息">More</div>
                </div>
				<hr style="border:1px dashed #c3c4c5;clear:both;"/>
				<div class="answerView">
					<div class="answer_stage" style="background:url(${teamRelation.answer eq 'T' ? 'images/req_team_success.png' : teamRelation.answer eq 'F' ? 'images/req_team_fail.png' : 'images/req_team_wait.png'}) no-repeat 50%"></div>
					<table width="100%" border="0">
					<tr>
					  <td colspan="4" align="right">&nbsp;</td>
					</tr>
					<tr>
					  <td width="25%" align="right">教师姓名：</td>
					  <td width="25%" align="left">${teamRelation.teamerName }</td>
					  <td width="25%" align="right">回复时间：</td>
					  <td width="25%" align="left">${teamRelation.answerTime }</td>
					</tr>
					<tr>
					  <td align="right" colspan="4">&nbsp;</td>
					</tr>
					<tr>
					  <td align="right">回复信息：</td>
	                  <td colspan="3" align="left"><div class="project_words_style">${teamRelation.answerInfor }</div></td>
					</tr>
					</table>
				</div>
				
				<div class="button_frame">
					<input type="hidden" value="${teamRelation.id }" id="relationId"/>
					<input type="button" style="display:${teamRelation.answer eq 'F' ? '' : 'none'}" class="button_view" id="repeatButton" value="重新请求"/>
					<input type="button" class="button_view" id="break_old_page" value="上一页"/>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
