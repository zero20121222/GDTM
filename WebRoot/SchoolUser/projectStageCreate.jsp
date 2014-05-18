<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

    int projectID = Integer.parseInt(request.getParameter("projectID"));
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<title>课题阶段创建</title>
<script>

var stageFrameObj = null;
var stageParamsObj = null;
var stageHelpFrame = null;//阶段提示信息框架
var uploadFactory = null;//上传组件数组对象
function init(){
	uploadFactory = new moveUploadFactory();
	stageParamsObj = new projectStageParamObj();
	stageParamsObj.initQuery();
	
	stageFrameObj = new projectStageFrameObj($("project_stage_Views") , $("add_projectStage"), $("hidden_projectStage"), $("show_projectStages"), $("stages_errors_view"));
	stageFrameObj.initProjectStage();
	
	var stageSubmit = new projectStageSaveObj($("project_stage_submit"));
	stageSubmit.createView();
}


//添加一个获取学校课题阶段参数的AJAX操作函数明天
/*
 * stageUpTime->>课题阶段总时间上限
 * stageUpLimit->>课题阶段上限
 * stageFlLimit->>课题阶段下限
 */
function projectStageParamObj(){
	this.stageUpTime = null;
	this.stageUpLimit = null;
	this.stageFlLimit = null;
	
	this.stageLimitError = null;//错误信息对象
	this.stageTimerError = null;
}
projectStageParamObj.prototype.initQuery = function(){
	var stageRequest = newXMLHttpRequest();
	stageRequest.open("post" , "ProjectManagerServlet?type=query_stage_params", true);
	stageRequest.onreadystatechange = this.queryParams(stageRequest , this);
	
	stageRequest.send(null);
};
projectStageParamObj.prototype.queryParams = function(stageRequest , paramObj){//查询参数信息
	return function(){
		if(stageRequest.readyState == 1 || stageRequest.readyState == 2 || stageRequest.readyState == 3){
			
		}else if(stageRequest.readyState == 4){
			if(stageRequest.status == 200){
				var params = eval(stageRequest.responseText)[0];
				paramObj.stageUpTime = params.stageUpperTime;
				paramObj.stageUpLimit = params.stageUpperLimit;
				paramObj.stageFlLimit = params.stageFloorLimit;
				
				var forms = document.getElementsByTagName("form");
				//为当前已经存在的表单中的stage_timeLimit设置值
				for(var n=0;n<forms.length;n++){
					for(var i=0;i<paramObj.stageUpTime;i++){
						var option = new Option(i+1 , i+1);
						forms[n].elements["stage_timeLimit"].options[i] = option;
					}
				}
				
				//为project_stage_params添加关于阶段的参数信息数据
				stageHelpFrame = new stageParamsFrame($("project_stage_params")).createView(paramObj);
			}
		}
	};
};
projectStageParamObj.prototype.checkLimitError = function(){
	if(stageFrameObj.projectStageArray.length < this.stageFlLimit){
		if(this.stageLimitError == null){
			this.stageLimitError = document.createElement("div");
			this.stageLimitError.className = "stage_error_type";
			stageFrameObj.addStageError(this.stageLimitError);
		}
		
		this.stageLimitError.innerHTML = "课题阶段数目必需大于"+this.stageFlLimit+"个";
	}else if(stageFrameObj.projectStageArray.length > this.stageUpLimit){
		if(this.stageLimitError == null){
			this.stageLimitError = document.createElement("div");
			this.stageLimitError.className = "stage_error_type";
			stageFrameObj.addStageError(this.stageLimitError);
		}
		
		this.stageLimitError.innerHTML = "课题阶段数目必需小于"+this.stageUpLimit+"个";
		return false;
	}else{
		stageFrameObj.removeStageError(this.stageLimitError);
		this.stageLimitError = null;
		return true;
	}
};
projectStageParamObj.prototype.checkTimerError = function(){
	var allTimes = 0;//课题阶段总时间
	for(var i=0;i<stageFrameObj.projectStageArray.length;i++){
		allTimes += parseInt(stageFrameObj.projectStageArray[i].stageForm.elements["stage_timeLimit"].value);
	}
	
	if(allTimes > this.stageUpTime){
		if(this.stageTimerError == null){
			this.stageTimerError = document.createElement("div");
			this.stageTimerError.className = "stage_error_type";
			stageFrameObj.addStageError(this.stageTimerError);
		}
		
		this.stageTimerError.innerHTML = "课题的阶段总时间上限为"+this.stageUpTime+"天";
		return false;
	}else{
		stageFrameObj.removeStageError(this.stageTimerError);
		this.stageTimerError = null;
		return true;
	}
};
projectStageParamObj.prototype.checkStageParams = function(){//对于课题阶段的参数是否符合判断
	if(this.checkLimitError() && this.checkTimerError()){
		return true;
	}
	
	return false;
};

//创建一个用于显示学校课题阶段信息
function stageParamsFrame(paramsObj){
	this.paramsObj = paramsObj;
	
	this.showObj = null;//显示的对象
	this.ifopen = false;//用于判断当前参数信息是否打开
}
stageParamsFrame.prototype.createView = function(params){
	this.showObj = document.createElement("div");
	this.showObj.className = "stage_params_infor";
	
	var stageUpLimit = document.createElement("div");
	stageUpLimit.innerHTML = "课题阶段数目下限:<span style='color:red'>"+params.stageFlLimit+"</span>个";
	
	var stageFlLimit = document.createElement("div");
	stageFlLimit.innerHTML = "课题阶段数目上限:<span style='color:red'>"+params.stageUpLimit+"</span>个";
	
	var stageUpTime = document.createElement("div");
	stageUpTime.innerHTML = "课题阶段总时间上限:<span style='color:red'>"+params.stageUpTime+"</span>天";	
	
	this.showObj.appendChild(stageUpLimit);
	this.showObj.appendChild(stageFlLimit);
	this.showObj.appendChild(stageUpTime);
	
	this.paramsObj.appendChild(this.showObj);
	
	addEvent(this.paramsObj , "click", this.clickEvent(this));
};
stageParamsFrame.prototype.clickEvent = function(sParamsObj){
	return function(){
		if(sParamsObj.ifopen){
			sParamsObj.showObj.style.display = "none";
			sParamsObj.ifopen = false;
		}else{	
			sParamsObj.showObj.style.display = "block";
			sParamsObj.ifopen = true;
		}
	};
};

//组件框架对象()
function projectStageFrameObj(stageFrame , add_Stage, hidden_Stage, show_Stages, error_views){
	this.stageFrame = stageFrame;//整体组件对象
	this.add_Stage = add_Stage;//添加组件对象按钮
	this.hidden_Stage = hidden_Stage;//隐藏阶段对象按钮
	this.show_Stages = show_Stages;//显示全部隐藏的对象元素
	this.error_views = error_views;//这个是一个用于显示用户创建课题阶段时的一些错误信息
	
	this.projectStageArray = new Array();//用于保存框架中的对象
	this.showStageArray = new Array();//用于显示框架组件内容的数组对象
}
projectStageFrameObj.prototype.initProjectStage = function(){
	new StageCreateWindow(this.stageFrame , 0, 0).createWindow();
	
	addEvent(this.add_Stage , "click", this.addStage(this));//注册添加对象组件的操作处理事件
	addEvent(this.hidden_Stage , "click", this.hiddenStage(this));//注册添加对象组件的操作处理事件
	addEvent(this.show_Stages , "click", this.showStages(this));//注册添加对象组件的操作处理事件
};
projectStageFrameObj.prototype.adjustFrame = function(old_rank , now_rank, stageObj){//调整框架组件对象
	var swapObj = this.showStageArray[now_rank];
	swapObj.mWindow.setWindowY(stageObj.old_location_Y);
	
	var swapRank = stageObj.old_rank;
	stageObj.old_rank = swapObj.old_rank;
	swapObj.old_rank = swapRank;
	
	var swapLocationY = stageObj.old_location_Y;
	stageObj.old_location_Y = swapObj.old_location_Y;
	swapObj.old_location_Y = swapLocationY;
	
	this.showStageArray[now_rank] = stageObj;
	this.showStageArray[old_rank] = swapObj;
	this.showStageArray[now_rank].alterTitleText("课题阶段"+(stageObj.old_rank+1));
	this.showStageArray[old_rank].alterTitleText("课题阶段"+(swapObj.old_rank+1));
	
	//原始对象数据交换
	var oldSwap = null;
	var newSwap = null;
	for(var i=0;i<this.projectStageArray.length;i++){
		if(this.projectStageArray[i].mWindow == this.showStageArray[old_rank].mWindow){
			oldSwap = i;
			break;
		}
	}

	for(var i=0;i<this.projectStageArray.length;i++){
		if(this.projectStageArray[i].mWindow == this.showStageArray[now_rank].mWindow){
			newSwap = i;
			break;
		}
	}
	//位置交换
	var stageswapObj = this.projectStageArray[oldSwap];
	this.projectStageArray[oldSwap] = this.projectStageArray[newSwap];
	this.projectStageArray[newSwap] = stageswapObj;
};
projectStageFrameObj.prototype.addStage = function(stageFrameObj){//添加课题阶段组件
	return function(){
		//扩大div高度属性
		stageFrameObj.stageFrame.style.height = stageFrameObj.stageFrame.offsetHeight + 200+"px";
		new StageCreateWindow(stageFrameObj.stageFrame , stageFrameObj.projectStageArray.length, stageFrameObj.showStageArray.length*200).createWindow();
		
		stageFrameObj.resetStageLocation();
	}
};
projectStageFrameObj.prototype.hiddenStage = function(stageFrameObj){//将特定的阶段组件对象隐藏hideWindow
	return function(){
		//扩大div高度属性
		stageFrameObj.stageFrame.style.height = stageFrameObj.stageFrame.offsetHeight - 200+"px";
		
		stageFrameObj.showStageArray[0].mWindow.hideWindow();
		
		for(var i=0; i<stageFrameObj.showStageArray.length-1; i++){
			stageFrameObj.showStageArray[i] = stageFrameObj.showStageArray[i+1];
			//stageFrameObj.showStageArray[i].old_rank = i;
			stageFrameObj.showStageArray[i].old_location_Y = i*200;
			stageFrameObj.showStageArray[i].setLocationY(i*200);
		}
		
		stageFrameObj.showStageArray.pop(stageFrameObj.showStageArray.length-1);
		stageFrameObj.resetStageLocation();
	}
};
projectStageFrameObj.prototype.showStages = function(stageFrameObj){//显示全部隐藏对象
	return function(){
		for(var i=0;i<stageFrameObj.projectStageArray.length;i++){
			stageFrameObj.showStageArray[i] = stageFrameObj.projectStageArray[i];
		}
		stageFrameObj.stageFrame.style.height = stageFrameObj.showStageArray.length*200+"px";
		
		stageFrameObj.resetStageLocation();
		stageFrameObj.showArrayNewLayout();
	}
};
projectStageFrameObj.prototype.resetStageLocation = function(){//重置对象的移动范围信息数据
	for(var i=0;i<this.showStageArray.length;i++){
		this.showStageArray[i].mWindow.installLimitY(this.stageFrame.offsetHeight);
	}
};
projectStageFrameObj.prototype.deleteStage = function(rank){//删除某个阶段对象showStageArray
	this.stageFrame.style.height = this.stageFrame.offsetHeight - 200+"px";
	
	//删除原始数据对象
	//this.projectStageArray.length == 1 ? this.projectStageArray.pop(0) : "";
	for(var i=0;i<this.projectStageArray.length;i++){
		if(this.projectStageArray[i] == this.showStageArray[rank]){
			if(i == this.projectStageArray.length-1){
				this.projectStageArray.pop(this.projectStageArray.length-1);//去除最后一个对象
				break;
			}else{
				for(var j=i;j<this.projectStageArray.length-1;j++){
					this.projectStageArray[j] = this.projectStageArray[j+1];
				}
				this.projectStageArray.pop(this.projectStageArray.length-1);//去除最后一个对象
				break;
			}
		}
	}
	
	for(var i=rank;i<this.showStageArray.length-1;i++){
		this.showStageArray[i] = this.showStageArray[i+1];
	}
	
	this.showStageArray.pop(this.showStageArray.length-1);
};
projectStageFrameObj.prototype.showArrayNewLayout = function(){//显示对象重新布局操作(刷新操作)\
	var rank = 0;
	for(var i=0;i<this.projectStageArray.length;i++){
		if(this.projectStageArray[i] == this.showStageArray[0]){
			rank = i;
			break;
		}
	}
	
	for(var i=0;i<this.showStageArray.length;i++){
		this.showStageArray[i].mWindow.displayWindow();
		this.showStageArray[i].old_rank = i+rank;
		this.showStageArray[i].old_location_Y = i*200;
		this.showStageArray[i].alterTitleText("课题阶段"+(i+rank+1));
		this.showStageArray[i].setLocationY(i*200);
	}
};
projectStageFrameObj.prototype.newLayout = function(){//重新布局操作(刷新操作)
	for(var i=0;i<this.projectStageArray.length;i++){
		this.projectStageArray[i].old_rank = i;
		this.projectStageArray[i].old_location_Y = i*200;
		this.projectStageArray[i].alterTitleText("课题阶段"+(i+1));
		this.projectStageArray[i].setLocationY(i*200);
	}
};
projectStageFrameObj.prototype.addStageError = function(errorView){//添加阶段错误信息
	this.error_views.appendChild(errorView);
};
projectStageFrameObj.prototype.removeStageError = function(errorView){//删除阶段错误信息
	errorView != null || undefined ? this.error_views.removeChild(errorView) : "";
};
projectStageFrameObj.prototype.existError = function(){//判断是否存在错误
	for(var i=0;i<this.projectStageArray.length;i++){
		this.projectStageArray[i].checkStageErrors();
	}
	
	for(var i=0;i<this.projectStageArray.length;i++){
		if(this.projectStageArray[i].haveErrors){
			return false;
		}
	}
	return true;
};


//创建一个阶段创建对象窗口类
/*
 * stageFrame->>容器对象
 * old_rank->>用于标记对象当前所在的数组对象的位置
 */
function StageCreateWindow(stageFrame , old_rank, old_location_Y){
	this.mWindow = null;
	this.stageFrame = stageFrame;
	this.old_rank = old_rank;
	
	this.stageError = new Array(3);//这个是用于保存阶段的错误信息内容的0:阶段名称问题,1:阶段要求,2:阶段资料
	this.haveErrors = false;//这个是用于检测阶段对象元素是否存在错误信息
	this.moveUpload = null;//用于绑定上传组件对象
	this.stageForm = null;//这个对象是用于方便的索引对象的内容信息
	this.old_location_Y = old_location_Y == null || undefined ? 0 : old_location_Y;
}
StageCreateWindow.prototype.createWindow = function(){
	var projectStage = document.createElement("div");
	projectStage.style.position = "relative";
   	
   	this.stageForm = document.createElement("form");
   	this.stageForm.innerHTML = "<table width='100%' border='0'>"
  							+"<tr><td width='25%' align='right'>阶段名称：</td>"
    						+"<td width='36%'><div class='input_frame'><input type='text' name='stage_name' maxlength='20'/></div></td>"
   							+"<td width='13%' align='right'>时间限定：</td>"
    						+"<td width='26%'><select name='stage_timeLimit'></select><span style='margin-left:10px;'>天</span></td></tr>"
  							+"<tr><td align='right'>阶段要求：</td><td colspan='3' rowspan='4'>"
    						+"<div class='textarea_frame'><textarea name='stage_demand'></textarea></div></td></tr>"
  							+"<tr><td align='right'>&nbsp;</td></tr>"
  							+"<tr><td align='right'>&nbsp;</td></tr>"
  							+"<tr><td align='right'>&nbsp;</td></tr>"
  							+"<tr><td align='right'>阶段资料：</td><td><input type='button' class='stage_file_up' name='stage_file_up' title='阶段文件上传'/>"
  							+"<input type='button' class='stage_filed' name='stage_filed'/></td>"
    						+"<td align='right'>&nbsp;</td><td>&nbsp;</td></tr></table>";
   	
   	projectStage.appendChild(this.stageForm);
   	
   	var titleClose = new Window_close();
   	//复写click方法
	titleClose.close_Click = this.close_Click;
	var title = new Window_titleview(null , null, new Window_title("课题阶段"+(this.old_rank+1)), true, null, false, null, null, titleClose);//设置标题信息
	
	var frame = new Window_frame(596 , 198, 0, 0, "2px solid #c4c4c4", null, null, null, null, false);
	
	this.mWindow = new moveWindow(frame , title, false, null, null, null, true, 1, window, this.stageFrame);
	this.mWindow.create_View();
	this.mWindow.Win_view.add_Child(projectStage);
	
	this.mWindow.setWindowY(this.old_location_Y);
	addEvent(title.titles , "mouseup", this.suitLoaction(this));//添加自动location调节操作
	
	//添加文件上传操作事件
	this.moveUpload = new moveUploadObj(this.stageForm.elements["stage_file_up"] , "FileManageServlet?type=projectStageUploadFile&project_id="+$("projectID").value, "阶段文件上传", "file", this.stageForm, projectStage);
	this.moveUpload.createView();
	this.moveUpload.alterView(this.stageForm.elements["stage_filed"]);
	
	var stage_name = this.stageForm.elements["stage_name"];
	addEvent(stage_name , "blur", this.stageNameBlurEvent(stage_name , this));
	addEvent(stage_name , "focus", this.stageNameFocusEvent(stage_name));
	
	var stage_demand = new textareaElementObj(this.stageForm.elements["stage_demand"] , 200);
	addEvent(this.stageForm.elements["stage_demand"] , "blur", this.stageDemandBlurEvent(this.stageForm.elements["stage_demand"] , 200, this));
	stage_demand.createView();
	
	this.setStageTimeLimit(this.stageForm.elements["stage_timeLimit"]);
	
	stageFrameObj.projectStageArray.push(this);
	stageFrameObj.showStageArray.push(this);//用于显示对象的
};
StageCreateWindow.prototype.stageNameFocusEvent = function(inputObj){
	return function(){
		inputObj.parentNode.className = "input_frame_focus";
	}
};
StageCreateWindow.prototype.stageNameBlurEvent = function(inputObj , stageObj){
	return function(){
		inputObj.parentNode.className = "input_frame";
		stageObj.stageNameChecked(inputObj);
	}
};
StageCreateWindow.prototype.stageNameChecked = function(inputObj){
	if(inputObj.value == ""){
		this.addStageErrorInfor(0 , "error"+(this.old_rank+1)+"：请输入课题阶段名称...", inputObj);
	}else{
		this.removeStageErrorInfor(0);
	}
};
StageCreateWindow.prototype.stageDemandBlurEvent = function(textareaObj , maxLength, stageObj){
	return function(){
		textareaObj.parentNode.className = "textarea_frame";
		if(check_Length(textareaObj.value) > maxLength){
			textareaObj.value = textareaObj.value.substring(0 , maxLength);
		}
		stageObj.stageDemandChecked(textareaObj);
	}
};
StageCreateWindow.prototype.stageDemandChecked = function(textareaObj){
	if(textareaObj.value == ""){
		this.addStageErrorInfor(1 , "error"+(this.old_rank+1)+"：请输入课题阶段内容...", textareaObj);
	}else{
		this.removeStageErrorInfor(1);
	}
};
StageCreateWindow.prototype.textOnblurEvent = function(){
	this.parentNode.style.background = "url(images/input_noenter.png)";
};
StageCreateWindow.prototype.setLocationY = function(location_Y){
	this.mWindow.setWindowY(location_Y);
};
StageCreateWindow.prototype.setStageTimeLimit = function(stageTimeObj){//设置课题阶段的时间限定
	if(stageParamsObj != null){
		for(var i=0;i<stageParamsObj.stageUpTime;i++){
			var option = new Option(i+1 , i+1);
			stageTimeObj.options[i] = option;
		}
	}
};
StageCreateWindow.prototype.suitLoaction = function(stageObj){//自动调节位置属性(当鼠标放开是窗口对象自动调节位置参数)
	return function(){
		var stageID = null;
		for(var i=0;i<stageFrameObj.showStageArray.length;i++){
			if(stageFrameObj.showStageArray[i] == stageObj){
				stageID = i;
				break;
			}
		}
		
		//event.clinetY:表示的当前事件相对于整个显示框对象（显示容器不包括滚动条中的内容）
		var result = relativePageY() / 100;//事件发生地的相对整个子页面（relativePageY()->相对整个子页面的位置）的位置编号
	
		var rank = Math.round(result/2);//获取当前对象所在要去的位置编号
		
		stageObj.mWindow.setWindowY(rank*200);
		stageFrameObj.adjustFrame(stageID , (rank > stageFrameObj.showStageArray.length ? stageFrameObj.showStageArray.length : rank), stageObj);
	};
};
StageCreateWindow.prototype.alterTitleText = function(titleText){//更改标题内容
	this.mWindow.Win_titleview.alterTitleText(titleText);
};
StageCreateWindow.prototype.addStageErrorInfor = function(type , errorInfor, errorObj){//添加阶段错误到错误信息队列中
	if(this.stageError[type] == null || undefined){
		var error = document.createElement("div");
		error.className = "stage_error_type";
		error.innerHTML = errorInfor;
		
		//注册点击事件
		error.ondblclick = function(){//注册一个错误定位操作
			errorObj != null || undefined ? errorObj.focus() : "";
		}
		
		error.onselectstart = function(){
			return false;
		}
		
		this.stageError[type] = error;
		stageFrameObj.addStageError(error);
	}else{
		this.stageError[type].innerHTML = errorInfor;
	}
};
StageCreateWindow.prototype.removeStageErrorInfor = function(type){//添加阶段错误到错误信息队列中
	stageFrameObj.removeStageError(this.stageError[type]);//移除对象
	this.stageError[type] = null;
};
StageCreateWindow.prototype.cleanErrors = function(){//清除该阶段的错误信息
	for(var i=0;i<this.stageError.length;i++){
		stageFrameObj.removeStageError(this.stageError[i]);
	}
};
StageCreateWindow.prototype.checkStageErrors = function(){//总体性的检查阶段问题
	this.stageNameChecked(this.stageForm.elements["stage_name"]);
	this.stageDemandChecked(this.stageForm.elements["stage_demand"]);
	
	if(this.moveUpload != null && this.moveUpload.submitEvent){//这个表示正在上传文件
		this.addStageErrorInfor(2 , "阶段资料正在上传请等待...");
	}else{
		this.removeStageErrorInfor(2);
	}
	
	for(var i=0;i<3;i++){
		if(this.stageError[i] != null){
			this.haveErrors = true;
			return;
		}
	}
	
	this.haveErrors = false;
};
StageCreateWindow.prototype.close_Click = function(parentObj){
	return function(){
		for(var i=0;i<stageFrameObj.showStageArray.length;i++){
			if(stageFrameObj.showStageArray[i].mWindow == parentObj.getParentObj()){
				parentObj.getParentObj().closeWindow();//从页面上删除对象
				stageFrameObj.showStageArray[i].cleanErrors();//清除阶段对象的错误信息
				stageFrameObj.deleteStage(i);//删除对象
				stageFrameObj.showArrayNewLayout();//重新布局操作
			}
		}
	};
};

//设置一个用于处理用户JSON在特殊字符上处理的问题（使用replace替换）
function JSONInitlize(infor){
	//先处理特殊字符,再使用encodeURI进行16位字符转换处理乱码问题
	return encodeURI(encodeURI(infor.replace(new RegExp('(["\"])', 'g'), "\\\"")));
}

//课题阶段信息提交操作处理设定
function projectStageSaveObj(stageSubmitObj){
	this.stageSubmitObj = stageSubmitObj;//绑定提交对象元素
	
	this.promptWin = null;//创建一个提示框对象
	this.submitEvent = false;//用于控制点击事件无法发送多次操作
}
projectStageSaveObj.prototype.createView = function(){
	addEvent(this.stageSubmitObj , "click", this.clickEvent(this));
};
projectStageSaveObj.prototype.clickEvent = function(saveObj){//这个是用于处理对于需要提交的课题阶段的内容的格式等的检验操作
	return function(){
		if(stageFrameObj.existError() && stageParamsObj.checkStageParams() && !saveObj.submitEvent){
			var stageForms = stageFrameObj.projectStageArray;
		
			//对于这个数据的传输使用JSON格式在servlet端可以使用org.JSON包来解析JSON数据(或者自己去写一个解析JSON格式的操作)
			var urlJSON = "[";
			
			for(var i=0;i<stageForms.length;i++){
				urlJSON += "{";
				
				urlJSON += "stage_name:\""+JSONInitlize(stageForms[i].stageForm.elements["stage_name"].value == "" ? "null" : stageForms[i].stageForm.elements["stage_name"].value)+"\",";
				urlJSON += "stage_timeLimit:\""+stageForms[i].stageForm.elements["stage_timeLimit"].value+"\",";
				urlJSON += "stage_demand:\""+JSONInitlize(stageForms[i].stageForm.elements["stage_demand"].value == "" ? "null" : stageForms[i].stageForm.elements["stage_demand"].value)+"\",";
				urlJSON += "stage_filed:\""+JSONInitlize(stageForms[i].stageForm.elements["stage_filed"].value == "" ? "null" : stageForms[i].stageForm.elements["stage_filed"].value)+"\"";
				
				urlJSON += (i == stageForms.length-1 ? "}" : "},");
				
			}
			urlJSON += "]";
			
			//创建一个等待提示框
			saveObj.promptWin = new promptWindow();
			saveObj.promptWin.createWaitView("正在提交课题信息请等待...");
			saveObj.submitEvent = true;
			
			var stageRequest = newXMLHttpRequest();
			stageRequest.open("post" , "ProjectManagerServlet?type=create_ProjectStage&project_id="+$("projectID").value+"&stageJSON="+urlJSON, true);
			stageRequest.onreadystatechange = saveObj.saveProjectStage(stageRequest , saveObj);
			
			stageRequest.send(null);
		}
	}
};
projectStageSaveObj.prototype.saveProjectStage = function(stageRequest , saveObj){
	return function(){
		if(stageRequest.readyState == 1 || stageRequest.readyState == 2 || stageRequest.readyState == 3){
			
		}else if(stageRequest.readyState == 4){
			if(stageRequest.status == 200){
				var result = stageRequest.responseText;
				
				if(result == "true"){//成功提交
					saveObj.promptWin.confirmButtonEvent = saveObj.submitSuccess(saveObj);
					saveObj.promptWin.createConfirmView("<span style='color:green;'>你提交的课题阶段信息已成功保存！</span>" , "确定");
				}else{
					saveObj.promptWin.confirmButtonEvent = saveObj.submitError(saveObj);
					saveObj.promptWin.createConfirmView("<span style='color:red;'>Sorry 您提交课题失败！</span>" , "确定");
				}
			}
		}
	}
};
projectStageSaveObj.prototype.submitError = function(saveObj){
	return function(){
		saveObj.promptWin.closeWindow();
		saveObj.submitEvent = false;
	}
};
projectStageSaveObj.prototype.submitSuccess = function(saveObj){
	return function(){
		saveObj.promptWin.closeWindow();
		saveObj.submitEvent = false;
		var url = ifIE ? "../ProjectManagerServlet?type=query_detail_project&project_id="+$("projectID").value : "ProjectManagerServlet?type=query_detail_project&project_id="+$("projectID").value;
		window.open(url , "main_body");
		window.parent.upsendObj.closeWindows();//关闭上一层课题创建页面的处理框
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
#project_stage_frame{
	margin:0px auto;
	width:600px;
	height:auto;
	border: 1px solid #c3c4c5;
}
#project_stage_Views{
	width:600px;
	height:200px;
	font-size:12px;
	position:relative;
}
#project_stage_Operate{
	width:600px;
	height:40px;
}
#add_projectStage{
	width:25px;
	height:25px;
	float:right;
	margin-top:10px;
	margin-right:5px;
	cursor:pointer;
	background:url(images/add_project_stage.png) no-repeat;
}
#hidden_projectStage{
	width:25px;
	height:25px;
	float:right;
	margin-top:10px;
	margin-right:5px;
	cursor:pointer;
	background:url(images/hidden_project_stage.png) no-repeat;
}
#show_projectStages{
	width:25px;
	height:25px;
	float:right;
	margin-top:10px;
	margin-right:5px;
	cursor:pointer;
	background:url(images/show_project_stage.png) no-repeat;
}
#project_stage_params{
	width:25px;
	height:25px;
	float:right;
	margin-top:10px;
	margin-right:5px;
	cursor:pointer;
	background:url(images/project_stage_params.png) no-repeat;
}
.stage_params_infor{
	width:200px;
	height:auto;
	position:relative;
	top:-70px;
	left:-88px;
	z-index:999999;
	display:none;
	background:#fff;
	border:2px solid #c3c4c5;
}
.stage_params_infor div{
	margin-left:20px;
}
#project_stage_submit{
	width:102px;
	height:29px;
	
	font-size:13px;
	font-weight:bold;
	line-height:29px;
	color:white;
	cursor:pointer;
	margin:0px;
	float:right;
	margin-top:5px;
	margin-right:150px;
	background:url(images/frame_button0.png) no-repeat;
	border:0px none;
}
#project_stage_submit:hover{
	background:url(images/frame_button1.png) no-repeat;
}
.stage_file_up{
	margin:0px;
	padding:0px;
	width:30px;
	height:30px;
	cursor:pointer;
	border:0px none;
	background:url(images/page_up.png);
}
.stage_filed{
	margin:0px;
	padding:0px;
	width:auto;
	height:30px;
	line-height:30px;
	cursor:pointer;
	border:0px none;
}

/* 上传文件组件对象的css样式start */
.upload_form{
	position:relative;
}
.upload_file_input{
	position:absolute;
	width:60px;
	height:25px;
	right:-35px;
	line-height:auto;
	font-size:13px;
	
	filter:alpha(opacity:0);
	opacity: 0;
	z-index:1000;
}
.upload_submit{
	width:102px;
	height:29px;
	
	margin-top:auto;
	margin-left:7px;
	font-size:13px;
	font-weight:bold;
	line-height:29px;
	color:white;
	cursor:pointer;
	background:url(images/frame_button0.png) no-repeat;
	border:0px none;
}
.select_upload{
	width:25px;
	height:25px;
	position:absolute;
	right:2px;
	top:2px;
	background:url(images/select_upload_file.png) no-repeat;
}
.upload_file_frame{
	width:320px;
	height:auto;
	
	overflow:hidden;
	background: white;
}
.frame_form_view{
	width:100%;
	margin-top:5px;
	margin-left:10px;
}
.frame_error_view{
	width:100%;
	height:30px;
	float:left;
	line-height:30px;
}
.upload_error_infor{
	color:red;
	float:left;
	margin-left:15px;
	font-size:12px;
	font-weight:bold;
}
.project_result_view{
	color:green;
	font-size:12px;
	font-weight:bold;
	display:none;
}
#stages_errors_view{
	position:absolute;
	width:200px;
	height:auto;
	bottom:0px;
	right:0px;
	z-index:999999;
}
/* 上传文件组件对象的css样式end */


.input_frame{
	width:195px;
	height:30px;
	float:left;
	position:relative;
	overflow:hidden;
	background:url(images/input_noenter.png) #fff;
}
.input_frame_focus{
	width:195px;
	height:30px;
	float:left;
	position:relative;
	overflow:hidden;
	background:url(images/input_enter.png) #fff;
}
input{
	width:180px;
	height:20px;
	margin-top:5px;
	margin-left:7px;
	line-height:20px;
	font-size:13px;
	font-family:Verdana,Tahoma,Arial;
	background:#fff;
	border:0 none;
}
.textarea_frame{
	position:relative;
	width:320px;
	height:90px;
	background:url(images/textarea_noenter.png);
}
.textarea_frame_foucs{
	position:relative;
	width:320px;
	height:90px;
	background:url(images/textarea_enter.png);
}
.textarea_maxCount{
	position:absolute;
	bottom:2px;
	right:8px;
	font-size:12px;
	text-align:center;
	background:white;
}
textarea{
	margin-top:10px;
	margin-left:10px;
	min-width:300px;
	min-height:70px;
	max-width:300px;
	max-height:70px;
	font-size:13px;
	border:0px none;
	overflow:hidden;
}
.stage_error_type{
	color:red;
	font-size:12px;
	font-weight:normal;
	height:25px;
	padding-left:10px;
	line-height:25px;
	cursor:pointer;
}
.stage_error_type:hover{
	font-weight:bold;
	text-decoration:underline;
}
</style>
</head>

<body onload="init()">
<input type="hidden" id="projectID" value="${param.projectID }"/>
<div id="project_stage_frame">
	<div id="project_stage_Views">
		<div id="stages_errors_view"></div>
	</div>

	<div id="project_stage_Operate">
		<div id="add_projectStage" title="添加阶段"></div>
		<div id="hidden_projectStage" title="隐藏阶段"></div>
		<div id="show_projectStages" title="显示全部阶段"></div>
		<div id="project_stage_params" title="阶段参数信息"></div>
		<input type="button" id="project_stage_submit" value="保存"></input>
	</div>
</div>
</body>
</html>

