<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.GDT.Model.ProjectInfor" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<!-- 这个是作为一个查看信息内容的页面 -->
<title>学校所选课题显示页面</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script type="text/javascript" src="js/School_User_CL.js"></script>
<script type="text/javascript" src="js/Fade_Slide.js"></script>
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/ProjectStageDeal.js"></script>
<script type="text/javascript" src="dwr/interface/DWRTeamManage.js"></script>
<script>
//用于管理团队创建信息对象
var manageTeam = null;

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
	
	new proStageFrameObj($("project_stages_show")).createView();
	manageTeam = new manageTeamObj($("select_pro_btn") , $("part_num").value, $("project_id").value, $("pro_name").innerHTML, $("pro_createrName").innerHTML);
	manageTeam.initObj();
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
	this.peopleArray = new Array();
	
	this.mWindow = null;//移动窗口对象
}
manageTeamObj.prototype.initObj = function(){
	addEvent(this.createBtn , "click", this.cClickEvent(this));
};
manageTeamObj.prototype.cClickEvent = function(manageObj){
	return function(){
		//对于用户是否已经参加过其他团队的判断
		DWRTeamManage.ifAttendTeam($("user_id").value, function(attendRes){
			if(!attendRes){//未参加团队
				if(manageObj.mWindow == null){
					var titleClose = new Window_close();
					titleClose.close_Click = manageObj.closeClick;
					var title = new Window_titleview(null , null, new Window_title("课题团队创建"), null, null, false, null, null, titleClose, null);//设置标题信息
					
					var margin_Left = (document.body.clientWidth - 500)/2;
					var frame = new Window_frame(500 , 230, 100, margin_Left, null, null, null, null, null, true);
					
					manageObj.mWindow = new moveWindow(frame , title, null, null, null, null, true, 1, null, null);
					manageObj.mWindow.create_View();
					
					manageObj.createView(manageObj);
				}else{
					manageObj.mWindow.displayWindow();;
				}
			}else{//已有参加的团队
				var promptWin = new promptWindow();
				promptWin.confirmButtonEvent = manageObj.errorEvent(promptWin);
				promptWin.createConfirmView("<span style='color:red;'>您已有需要完成的课题了,无法再创建！</span>" , "确定");
			}
		});
	};
};
manageTeamObj.prototype.createView = function(manageObj){
	var viewFrame = document.createElement("div");

	//课题信息
	var proView = document.createElement("div");
	proView.className = "proView";
	proView.innerHTML = "<table width='100%' border='0'>"
						+"<tr><td width='25%' height='25px' align='right'>课题名称：</td>"
 						+"<td colspan='3'>"+manageObj.proName+"</td><tr>"
						+"<tr><td width='25%' height='25px' align='right'>出题人：</td>"
 						+"<td width='25%' align='left'>"+manageObj.proCreateName+"</td>"
 						+"<td width='25%' align='right'>参与人数限定：</td>"
 						+"<td width='25%' align='left'><span style='color:red'>"+manageObj.teamNum+"</span>人</td></tr>"
 						+"<tr><td colspan='4' align='right'><hr style='border:1px dashed #c3c4c5;'/></td></tr></table>";
 	
 	//团队人员信息
 	var teamView = document.createElement("div");
 	var masterName = new userNameObj().readTrueName();
 	var masterView = document.createElement("div");
 	masterView.className = "teamer_view";
 	masterView.innerHTML = "<span style='margin-left:50px;'>团队创建人：</span><span style='font-weight:bold;'>"+masterName+"</span>";
 	
 	//指导教师确定
 	var teacherView = document.createElement("div");
 	teacherView.className = "teamer_teacher_view";
 	manageObj.createTeacher(teacherView);
 	
 	//团队添加人员模块
 	var teamersView = document.createElement("div");
 	manageObj.createTeamer(teamersView);
 	
 	//按钮处理对象
 	var buttonView = document.createElement("div");
 	buttonView.className = "team_button_view";
 	manageObj.createButtons(buttonView);
 	
 	viewFrame.appendChild(proView);
 	teamView.appendChild(masterView);
 	teamView.appendChild(teacherView);
 	teamView.appendChild(teamersView);
 	viewFrame.appendChild(teamView);
 	viewFrame.appendChild(buttonView);
 	manageObj.mWindow.Win_view.add_Child(viewFrame);
 	
 	//手动调用验证指导教师信息内容
 	manageObj.initCheck(manageObj.teacherObj.inputObj);
};
manageTeamObj.prototype.createTeacher = function(teacherView){//指导教师确认
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
								+"<td style='font-size:12px'>"+teacherList[i].userName+"</td></tr>";
				}else{
					htmlView += "<tr><td height='25px' style='font-size:12px' align='center'>"
								+"<input name='teamerSelect' type='radio' "+(teacherList[i].aduitNumber == 1 ? "" : "disabled")+" value='"+i+"'/></td>"
								+"<td style='font-size:12px' align='center'>"+teacherList[i].realName+"</td>"
								+"<td style='font-size:12px'>"+teacherList[i].userName
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
	commitBtn.value = "创建团队";
	
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
								+"<td style='font-size:12px'>"+studentList[i].userName+"</td></tr>";
				}else{
					htmlView += "<tr><td height='25px' style='font-size:12px' align='center'>"
								+"<input name='teamerSelect' type='radio' "+(studentList[i].teamId == 0 && studentList[i].id != $("user_id").value ? "" : "disabled")+" value='"+i+"'/></td>"
								+"<td style='font-size:12px' align='center'>"+studentList[i].realName+"</td>"
								+"<td style='font-size:12px'>"+studentList[i].userName
								+"<input style='margin-left:10px;cursor:pointer;' id='select_btn' type='button' value='确认'/></td></tr>";
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
				teamers += "{teamerType:'S',teamerId:"+manageTeam.peopleArray[i].userId+"},";
			}
			//团队教师操作
			teamers += "{teamerType:'T',teamerId:"+manageTeam.teacherObj.userId+"}]";
			
			//团队信息内容
			var teamInfor = {managerId:$("user_id").value, projectId:manageTeam.proId};
			
			DWRTeamManage.createTeam(teamInfor , eval(teamers), function(result){
				if(result = 1){
					//表示创建成功&人员添加成功
					var promptWin = new promptWindow();
					promptWin.confirmButtonEvent = manageTeam.closeAllEvent(promptWin);
					promptWin.createConfirmView("<span style='color:green;'>成功创建团队！<span style='color:#aaaaaa;font-weight:normal;'>(系统已向指导教师&队员发送请求)</span></span>" , "确定");
				}else if(result = 0){
					//表示课题已被其他人选择无法再选
					var promptWin = new promptWindow();
					promptWin.confirmButtonEvent = manageTeam.errorEvent(promptWin);
					promptWin.createConfirmView("<span style='color:red;'>抱歉该课题已达可选上限!</span>" , "确定");
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
	if(this.teacherObj.userId == null){
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
	}
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
	margin:15px 0px 0px 100px;
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
						<input type="hidden" id="user_id" value="${user_id }"/>
						<input type="hidden" id="project_id" value="${projectInfor.id }"/>
						<input type="hidden" id="part_num" value="${projectInfor.partNum }"/>
						<input type="hidden" id="pro_college" value="${projectInfor.college }"/>
						<input type="hidden" id="school_id" value="${projectInfor.schoolId }"/>
						<input type="hidden" id="creater_id" value="${projectInfor.createrId }"/>
						<input type="hidden" id="picture_name" value="${projectInfor.picture }"/>
					</div>
				</td>
              </tr>
              <tr>
                <td align="right">题目名称：</td>
                <td align="left">
					<span id="pro_name">${projectInfor.projectName }</span>
				</td>
              </tr>
              <tr>
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
              </tr>
              <tr>
                <td align="right">出题人：</td>
                <td align="left">
                	<a class="pro_createrName" id="pro_createrName" href="ProjectManagerServlet?type=query_creater_infor&creater_id=${projectInfor.createrId }">${projectInfor.createrName }</a>
				</td>
              </tr>
              <tr>
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
              </tr>
              <tr>
                <td align="right">参与人数限定：</td>
                <td align="left">
                	<span>${projectInfor.partNum }&nbsp;人</span>
                </td>
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
                	<input type="button" class="project_button" id="select_pro_btn" value="确认课题"/>
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
</div>
</body>
</html>