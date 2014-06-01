<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>审核失败更改操作处理页面</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script type="text/javascript" src="js/School_Basic_CL.js"></script>
<script type="text/javascript" src="js/School_User_CL.js"></script>
<script type="text/javascript" src="js/Fade_Slide.js"></script>
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/ProjectAuditDeal.js"></script>
<script>
var upfileObj = null;
var hardStars = null;//用于标记问题难易程度
var uploadFactory = null;//上传组件数组对象
var upsendObj = null;//课题提交处理对象
function init(){
	suit_Page();
	var collegeObj = new userCollegeObj($("project_college"));
	collegeObj.createView();
	collegeObj.selectColllege($("oldProCollege").value);
	
	//问题难易程度
	hardStars = new hardStarsObj($("project_hardNum") , $("oldProHarmNum").value);
	hardStars.createView();
	
	upfileObj = new uploadFileObj($("project_file_input") , $("invented_project_file"), $("project_file_form"), $("file_send_submit"), "FileManageServlet?type=projectUploadFile", "file", $("upload_file_result"));
	upfileObj.createView();
	//为了使需要更改的上传文件名称保存操作
	upfileObj.uploadFileName = $("invented_project_file").value;
	upfileObj.submitEvent = false;
	upfileObj.uploadSuccess = true;
	
	uploadFactory = new moveUploadFactory();
	var moveUpload = new moveUploadObj($("project_picture_frame") , "FileManageServlet?type=projectUploadPicture", "上传课题图片(大小120*150)", "picture", "", document.body).createView();
	//需要重写结果方法等信息
	uploadFactory.resultView = resultView;
	
	new projectInputFactory().createView();
	
	$("project_creater").innerHTML = new userNameObj().readTrueName();
	
	//设定人数限定
	var partObj = new projectPartNumObj($("project_partNum") , $("parterUps").value);
	partObj.createView();
	
	//发送课题详细数据信息
	upsendObj = new upsendProject($("project_submit_button"));
	upsendObj.createView();
	
	var school_id = $("school_id").value;
	var creater_id = $("creater_id").value;
	var picture_name = $("picture_name").value;
	var url = picture_name == "null" ? "images/upload_file.png" : "ProjectInfor/"+school_id+"/"+creater_id+"/"+picture_name;
	$("project_picture_frame").style.background = "url("+url+") 50% 50% no-repeat";
	$("project_picture_frame").title = "更改图片";
	
	//更改课题阶段设置
	new updateProStageObj($("project_stages_update")).createView();
	
	//返回上一页
	$("break_old_page").onclick = function(){
		window.history.back();
	};
	
	new proAuditFrameObj($("project_audit_index")).createView();
}

//初始化页面操作处理(实现将页面数据清空)
function initialize(){
	var inputObjs = document.getElementsByTagName("input");
	for(var i=0;i<inputObjs.length;i++){
		inputObjs[i].value = inputObjs[i].type == "text" ? "" : inputObjs[i].value;
	}
}

//这个是重写文件上传成功后的显示信息操作处理(重写)
function resultView(uploadId , str, pictureUrl){
	this.uploadFrameArray[uploadId].resultView(str);
	this.uploadFrameArray[uploadId].reflashButtonEvent();//刷新submitEvent(刷新上传事件)
	
	$("project_picture_frame").style.background = "url("+pictureUrl+") 50% 50% no-repeat";
	$("picture_name").value = this.uploadFrameArray[uploadId].uploadFileName;
};


//不可移动的上传文档控件设计
function uploadFileObj(uploadObj, enterObj, frameObj , submitObj, upurl, filetype, errorObj){
	this.uploadObj = uploadObj;
	this.enterObj = enterObj;
	this.frameObj = frameObj;
	this.submitObj = submitObj;
	
	this.upurl = upurl;
	this.filetype = filetype == null || undefined ? "file" : filetype;
	this.errorObj = errorObj;
	
	this.uploadFileName = null;//用于记录上传的文件名
	this.submitEvent = false;
	this.uploadSuccess = false;//上传文件结果
}
uploadFileObj.prototype.createView = function(){
	addEvent(this.uploadObj , "change", this.onchangeEvent(this));
	addEvent(this.submitObj , "click", this.uploadFile(this));
	addEvent(this.submitObj , "mouseover", this.submitOver);
	addEvent(this.submitObj , "mouseout", this.submitOut);
};
uploadFileObj.prototype.onchangeEvent = function(upfileObj){//当输入的文档路径更改时调用
	return function(){
		upfileObj.enterObj.value = upfileObj.uploadObj.value;
		upfileObj.errorObj.style.display = "none";
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
	};
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
	this.errorObj.style.display = "block";
	this.errorObj.style.color = "green";
	this.errorObj.innerHTML = str;
};
uploadFileObj.prototype.successUpload = function(str){
	this.errorObj.style.display = "block";
	this.errorObj.style.color = "green";
	this.errorObj.innerHTML = str;
	
	this.reflashButtonEvent();
	this.uploadSuccess = true;
};
uploadFileObj.prototype.errorView = function(str){//文件格式问题
	this.errorObj.style.display = "block";
	this.errorObj.style.color = "red";
	this.errorObj.innerHTML = str;
	this.reflashButtonEvent();
};
uploadFileObj.prototype.submitOver = function(){
	var event = window.event ? window.event : arguments[0];
	var target = event.target ? event.target : event.srcElement;
};
uploadFileObj.prototype.submitOut = function(){
	var event = window.event ? window.event : arguments[0];
	var target = event.target ? event.target : event.srcElement;
};
uploadFileObj.prototype.getUploadFileName = function(){//获取上传文件名称
	if(this.enterObj.value != ""){
		var nameObj = this.enterObj.value.split("\\");
		
		return nameObj[nameObj.length-1];//返回上传文件名
	}
};


/*
 * 对于页面事件对象的设置处理
 */
/* 注册input的onblur和onfocus事件处理类 */
var purposeObj = null;//解决在最终格式验证时的操作需要
var contentObj = null;
function projectInputFactory(){}
projectInputFactory.prototype.createView = function(){
	//添加一个对于数据的操作处理
	old_proName = $("project_name").value;//保存需要更改的课题名称
	project_Name = $("project_name").value;
	var nameObj = new inputElementObj($("project_name"));
	nameObj.onblurEvent = nameBlurEvent;
	nameObj.createView();
	
	purposeObj = new textareaElementObj($("project_purpose") , 200);
	purposeObj.blurEvent = purposeBlurEvent;
	purposeObj.createView();
	purposeObj.setTextInfor($("project_purpose").value);
	
	contentObj = new textareaElementObj($("project_main_content") , 200);
	contentObj.blurEvent = contentBlurEvent;
	contentObj.createView();
	contentObj.setTextInfor($("project_main_content").value);
	
	var limitObj = new closeLimitObj($("project_college") , $("project_no_limit"));
	limitObj.createView();
};

//重写对象元素的onblur事件函数("这个需要注意的是对于更改操作的课题名称需要记录当前的名称")
var old_proName = null;
var project_Name = null;//用于保存通过验证的课题名称
function nameBlurEvent(inputObj){
	return function(){
		checkProjectName(inputObj);
	};
}
function checkProjectName(inputObj){
	inputObj.parentNode.className = "input_frame";
	
	if(inputObj.value == ""){
		$("project_name_error").style.display = "block";
		$("project_name_error").innerHTML = "请输入毕业课题名称...";
		return false;
	}else if(project_Name == null || (project_Name != inputObj.value && inputObj.value != old_proName)){//创建一个Ajax对象操作（检验课题名称是否存在）
		var nameRequest = newXMLHttpRequest();
		nameRequest.open("post" , "ProjectManagerServlet?type=projectName_ifExist&project_name="+encodeURI(encodeURI(inputObj.value)) , true);
		nameRequest.onreadystatechange = existProjectName(nameRequest , inputObj);
		
		nameRequest.send(null);
		
		$("project_name_error").style.display = "block";
		$("project_name_error").style.color = "green";
		$("project_name_error").innerHTML = "系统正在检索课题名称...";
	}else{
		$("project_name_error").style.display = "none";
		return true;
	}
}
function existProjectName(nameRequest , inputObj){//课题名称是否已存在
	return function(){
		if(nameRequest.readyState == 1 || nameRequest.readyState == 2 || nameRequest.readyState == 3){
			
		}else if(nameRequest.readyState == 4){
			if(nameRequest.status == 200){
				var result = nameRequest.responseText;
				
				if(result == "true"){//存在
					$("project_name_error").style.display = "block";
					$("project_name_error").style.color = "red";
					$("project_name_error").innerHTML = "《"+inputObj.value+"》课题名称已存在...";
				}else{
					$("project_name_error").style.display = "none";
					project_Name = inputObj.value;
				}
			}
		}
	};
}

//课题目的的信息检验
function purposeBlurEvent(textObj){
	return function(){
		checkProjectPurpose(textObj);
	};
}
function checkProjectPurpose(textObj){
	textObj.textareaObj.parentNode.className = "textarea_frame";
		
	if(textObj.textareaObj.value.length > textObj.maxLength){
		textObj.textareaObj.value = textObj.textareaObj.value.substring(0 , textObj.maxLength);
		textObj.maxCount.innerHTML = textObj.maxLength+"/"+textObj.maxLength;
	}
	
	if(textObj.textareaObj.value == ""){
		$("project_purpose_error").style.display = "block";
		$("project_purpose_error").innerHTML = "请输入课题目的信息...";
		return false;
	}else{
		$("project_purpose_error").style.display = "none";
		return true;
	}
}

function contentBlurEvent(textObj){
	return function(){
		checkProjectContent(textObj);
	};
}
function checkProjectContent(textObj){
	textObj.textareaObj.parentNode.className = "textarea_frame";
		
	if(textObj.textareaObj.value.length > textObj.maxLength){
		textObj.textareaObj.value = textObj.textareaObj.value.substring(0 , textObj.maxLength);
		textObj.maxCount.innerHTML = textObj.maxLength+"/"+textObj.maxLength;
	}
	
	if(textObj.textareaObj.value == ""){
		$("project_content_error").style.display = "block";
		$("project_content_error").innerHTML = "请输入课题详细内容信息...";
		return false;
	}else{
		$("project_content_error").style.display = "none";
		return true;
	}
}

//设置难度选择控件设计
function hardStarsObj(hardObj , hardNum){
	this.hardObj = hardObj;
	this.hardNum = hardNum == null || undefined ? 3 : hardNum;//用于标记当前的难度系数
	
	this.starsArray = new Array();//用于保存星星对象
	this.hardText = null;
}
hardStarsObj.prototype.createView = function(){
	this.hardObj.style.lineHeight = "35px";
	
	for(var i=0;i<5;i++){
		if(i<this.hardNum){
			var star = this.createStarShow();
			this.starsArray.push(star);
			this.hardObj.appendChild(star);
			addEvent(star , "mouseover", this.mouseoverEvent(this));
			addEvent(star , "mouseout", this.mouseoutEvent(this));
			addEvent(star , "click", this.clickEvent(this));
		}else{
			var star = this.createStarClose();
			this.starsArray.push(star);
			this.hardObj.appendChild(star);
			addEvent(star , "mouseover", this.mouseoverEvent(this));
			addEvent(star , "mouseout", this.mouseoutEvent(this));
			addEvent(star , "click", this.clickEvent(this));
		}
	}
	
	this.createStarText();
};
hardStarsObj.prototype.createStarShow = function(){
	var star = document.createElement("div");
	star.className = "starts_Show";
	
	return star;
};
hardStarsObj.prototype.createStarClose = function(){
	var star = document.createElement("div");
	star.className = "starts_No";
	
	return star;
};
hardStarsObj.prototype.createStarText = function(){
	this.hardText = document.createElement("span");
	this.hardText.style.fontSize = "12px";
	this.hardText.style.styleFloat = "left";
	this.hardText.style.cssFloat = "left";
	this.hardText.innerHTML = "(难度系数"+this.hardNum+".0)";
	
	this.hardObj.appendChild(this.hardText);
};
hardStarsObj.prototype.changeHardText = function(){
	this.hardText.innerHTML = "(难度系数"+this.hardNum+".0)";
};
hardStarsObj.prototype.mouseoverEvent = function(hardObj){ 
	return function(){
		var event = window.event ? window.event : arguments[0];
		var target = event.target ? event.target : event.srcElement;
		
		for(var i=0;i<hardObj.starsArray.length;i++){
			if(target == hardObj.starsArray[i] && (i+1) > hardObj.hardNum){
				for(var j=0;j<(i+1);j++){
					hardObj.starsArray[j].className = "starts_Show";
				}
				break;
			}
		}
	};
};
hardStarsObj.prototype.mouseoutEvent = function(hardObj){
	return function(){
		var event = window.event ? window.event : arguments[0];
		var target = event.target ? event.target : event.srcElement;
	
		for(var i=0;i<hardObj.starsArray.length;i++){
			if(target == hardObj.starsArray[i] && (i+1) > hardObj.hardNum){
				for(var j=i;j<hardObj.starsArray.length;j++){
					hardObj.starsArray[j].className = "starts_No";
				}
				break;
			}
		}
	};
};
hardStarsObj.prototype.clickEvent = function(hardObj){
	return function(){
		var event = window.event ? window.event : arguments[0];
		var target = event.target ? event.target : event.srcElement;
		
		for(var i=0;i<hardObj.starsArray.length;i++){
			if(target == hardObj.starsArray[i] && (i+1)){
				for(var j=(i+1);j<hardObj.starsArray.length;j++){
					hardObj.starsArray[j].className = "starts_No";;
				}
				hardObj.hardNum = i+1;
			}
		}
		
		hardObj.changeHardText();
	};
};

//人数限定信息获取(后期为了快速开发使用DWR框架了)
function projectPartNumObj(selectObj , partNum){
	this.selectObj = selectObj;
	this.partNum = parseInt(partNum);
}
projectPartNumObj.prototype.createView = function(){
	for(var i=0;i<this.partNum;i++){
		var option = new Option("限定为"+(i+1)+"人" , (i+1));
		this.selectObj.options[i] = option;
	
		//在这里添加一个对于当前所选的课题人数限定数据的显示
		(i+1) == $("oldProPartNum").value ? this.selectObj.options[i].selected = true : "";
	}
};

//设置无院系限定操作处理
function closeLimitObj(selectObj , checkObj){
	this.selectObj = selectObj;
	this.checkObj = checkObj;
};
closeLimitObj.prototype.createView = function(){
	addEvent(this.checkObj , "click", this.clickEvent(this));
	
	if($("oldProCollege").value == "null"){
		this.checkObj.checked = true;
		this.selectObj.disabled = true;
	}
};
closeLimitObj.prototype.clickEvent = function(limitObj){
	return function(){
		if(limitObj.checkObj.checked){
			limitObj.selectObj.disabled = true;
		}else{
			limitObj.selectObj.disabled = false;
		}
	};
};

//提交课题的详细信息
function upsendProject(submitObj){
	this.submitObj = submitObj;
	
	this.submitSend = false;//用于索引当前提交事件是否发生
	this.promptWin = null;//这个是用于索引一个提示信息框
}
upsendProject.prototype.createView = function(){
	addEvent(this.submitObj , "click", this.submitClick(this));
};
upsendProject.prototype.submitClick = function(upsendObj){
	return function(){
		if(!upsendObj.submitSend){
			upsendObj.submitSend = true;//锁定无法再点击（直到信息保存成功）
			upsendObj.allChecked();
		}
	};
};
upsendProject.prototype.allChecked = function(){//最终还是决定使用ajax提交数据
	if(checkProjectName($("project_name")) && upfileObj.checkResult() && checkProjectPurpose(purposeObj) && checkProjectContent(contentObj)){
		var picture_name = encodeURI(encodeURI($("picture_name").value));//将数据对象进行16位数据格式转换
		var upfile_name = encodeURI(encodeURI(upfileObj.uploadFileName));
		var project_name = encodeURI(encodeURI($("project_name").value));
		var partNum = $("project_partNum").value;
		var hardNum = hardStars.hardNum;
		var workload = encodeURI(encodeURI($("project_workload").value));
		var limit = $("project_no_limit").checked;
		var college = limit ? null : encodeURI(encodeURI($("project_college").value));
		var purpose = encodeURI(encodeURI($("project_purpose").value));
		var main_content = encodeURI(encodeURI($("project_main_content").value));
		
		var url = "ProjectManagerServlet?type=update_project&project_id="+$("project_id").value+"&picture_name="+picture_name+"&upfile_name="+upfile_name+"&project_name="+project_name
				 +"&partNum="+partNum+"&hardNum="+hardNum+"&workload="+workload+"&college="+college+"&purpose="+purpose+"&main_content="+main_content;
				 
		
		this.promptWin = new promptWindow();
		this.promptWin.createWaitView("正在提交课题信息请等待...");
		
		var createRequest = newXMLHttpRequest();
		createRequest.open("post" , url, true);
		createRequest.onreadystatechange = this.saveProject(createRequest , this);
		
		createRequest.send(null);
		
	}else{
		this.submitSend = false;
	}
};
upsendProject.prototype.saveProject = function(createRequest , upsendObj){
	return function(){
		if(createRequest.readyState == 1 || createRequest.readyState == 2 || createRequest.readyState == 3){
			//在save project时创建一个提示信息框架
		}else if(createRequest.readyState == 4){
			if(createRequest.status == 200){
				var projectId = createRequest.responseText;
				
				if(projectId == -1){//课题更改存在错误
					upsendObj.promptWin.confirmButtonEvent = upsendObj.errorEvent(upsendObj);
					upsendObj.promptWin.createConfirmView("<span style='color:red;'>Sorry 您的更改课题操作存在问题！</span>" , "确定");
				}else if(projectId == 0){//还未创建课题阶段
					var url = "SchoolUser/projectStageCreate.jsp?projectID="+$("project_id").value;
					upsendObj.promptWin.leftBtnClick = upsendObj.openCreateStage(upsendObj , url);
					upsendObj.promptWin.rightBtnClick = upsendObj.gotoIndexPage(upsendObj);
					upsendObj.promptWin.createSelectView("<span style='color:green;'>课题更改操作成功！<span style='font-size:11px;color:#666;font-weight:normal;'>(是否创建课题阶段信息?)</span></span>" , "创建阶段", "下次再说");
					
					upsendObj.submitSend = false;
				}else{//是否更改重新提交审核
					var r_url = "ProjectManagerServlet?type=project_audit_again&project_id="+$("project_id").value;
					var l_url = "ProjectManagerServlet?type=query_project_audit&project_id="+$("project_id").value;
					upsendObj.promptWin.leftBtnClick = upsendObj.sendAuditAgain(upsendObj , r_url);
					upsendObj.promptWin.rightBtnClick = upsendObj.gotoIndexPage(upsendObj , l_url);
					upsendObj.promptWin.createSelectView("<span style='color:green;'>课题更改操作成功！<span style='font-size:11px;color:#666;font-weight:normal;'>(是否重新提交审核?)</span></span>" , "再次审核", "下次再说");
				}
			}
		}
	};
};
upsendProject.prototype.errorEvent = function(upsendObj){//错误信息
	return function(){
		upsendObj.promptWin.closeWindow();
		upsendObj.submitSend = false;
	};
};
upsendProject.prototype.successEvent = function(upsendObj){//成功信息
	return function(){
		upsendObj.promptWin.closeWindow();
		upsendObj.submitSend = false;
	};
};
upsendProject.prototype.openCreateStage = function(upsendObj , url){//打开阶段创建页面
	return function(){
		//将输入的课题信息内容清除
		upsendObj.promptWin.closeWindow();
		upsendObj.createProjectStagesFrame(url);
	};
};
upsendProject.prototype.sendAuditAgain = function(upsendObj , url){//提交再次审核请求
	return function(){
		upsendObj.promptWin.closeWindow();
		window.open(url , "_self");
	};
};
upsendProject.prototype.gotoIndexPage = function(upsendObj , url){//打开主页面
	return function(){
		//将输入的课题信息内容清除
		upsendObj.promptWin.closeWindow();
		window.open(url , "_self");
	};
};
upsendProject.prototype.createProjectStagesFrame = function(url){
	var iframe = parent.document.createElement("iframe");
	iframe.style.width = "100%";
	iframe.style.height = "450px";//高度为Window_frame-32
	iframe.style.background = "white";
	iframe.style.border = "0 none";
	iframe.src = url;
	
	var titleClose = new Window_close();
	titleClose.close_Click = this.close_Click;//复写click方法
	//关闭了
	var title = new Window_titleview(null , null, new Window_title("毕业课题阶段信息创建"), null, null, false, null, null, titleClose, null);//设置标题信息
	
	var margin_Left = (parent.document.body.clientWidth - 800)/2;
	var frame = new Window_frame(800 , 480, 50, margin_Left, null, null, null, null, null, true);
	
	this.mWindow = new moveWindow(frame , title, false, null, null, null, null, null, null, null);
	this.mWindow.create_View();
	this.mWindow.Win_view.add_Child(iframe);
};
upsendProject.prototype.close_Click = function(parentObj){
	return function(){  
		//判断该对象是否打开了遮罩层
		if(!parentObj.getParentObj().Win_closeC){
			parentObj.getParentObj().Win_cover.hiddenView();//隐藏遮罩对象
		}
		parentObj.getParentObj().Win_frame.hiddenView();//影藏对象
	};
};
upsendProject.prototype.closeWindows = function(){
	//判断该对象是否打开了遮罩层
		if(!this.mWindow.Win_closeC){
			this.mWindow.Win_cover.hiddenView();//隐藏遮罩对象
		}
		this.mWindow.Win_frame.hiddenView();//影藏对象
};

//处理课题阶段信息更新操作处理
function updateProStageObj(udpateBtn){
	this.udpateBtn = udpateBtn;
	
	this.mWindow = null;
}
updateProStageObj.prototype.createView = function(){
	addEvent(this.udpateBtn , "click", this.openStageUpdate(this));
};
updateProStageObj.prototype.openStageUpdate = function(upStageObj){
	return function(){
		var iframe = document.createElement("iframe");
		iframe.style.width = "100%";
		iframe.style.height = "450px";//高度为Window_frame-32
		iframe.style.background = "white";
		iframe.style.border = "0 none";
		iframe.src = "ProjectManagerServlet?type=come_update_prostage&project_id="+$("project_id").value;
		
		var titleClose = new Window_close();
		titleClose.close_Click = upStageObj.close_Click;//复写click方法
		var title = new Window_titleview(null , null, new Window_title("毕业课题阶段信息更改"), null, null, false, null, null, titleClose, null);//设置标题信息
		
		var margin_Left = (document.body.clientWidth - 800)/2;
		var frame = new Window_frame(800 , 480, 50, margin_Left, null, null, null, null, null, true);
		
		upStageObj.mWindow = new moveWindow(frame , title, false, null, null, null, null, null, null, null);
		upStageObj.mWindow.create_View();
		upStageObj.mWindow.Win_view.add_Child(iframe);
	};
};
updateProStageObj.prototype.close_Click = function(parentObj){
	return function(){  
		//判断该对象是否打开了遮罩层
		if(!parentObj.getParentObj().Win_closeC){
			parentObj.getParentObj().Win_cover.hiddenView();//隐藏遮罩对象
		}
		parentObj.getParentObj().Win_frame.hiddenView();//影藏对象
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
			var title = new Window_titleview(null , null, new Window_title("依据审核信息更改课题"), null, null, false, null, null, titleClose, null);//设置标题信息
			
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
						+"<tr style='height:110px;display:"+(auditInfor.auditerName1 == null ? 'none' : '')+";'><td align='center'>"+auditInfor.auditerName1+"</td>"
						+"<td align='center'><span style='color:"+(auditInfor.deal1=='T' ? 'green' : 'red')+"'>"+(auditInfor.deal1=='T' ? '通过' : '不通过')+"</span></td>"
						+"<td align='center'>"+proAuditObj.getDateString(new Date(auditInfor.time1))+"</td><td align='left' style='text-indent:20px'>"+auditInfor.remark1+"</td></tr>"
						//审核人2
						+"<tr style='height:110px;background:#EFEFEF;display:"+(auditInfor.auditerName2 == null ? 'none' : '')+";'><td align='center'>"+auditInfor.auditerName2+"</td>"
						+"<td align='center'><span style='color:"+(auditInfor.deal2=='T' ? 'green' : 'red')+"'>"+(auditInfor.deal2=='T' ? '通过' : '不通过')+"</span></td>"
						+"<td align='center'>"+proAuditObj.getDateString(new Date(auditInfor.time2))+"</td><td align='left' style='text-indent:20px'>"+auditInfor.remark2+"</td></tr>"
						//审核人3
						+"<tr style='height:110px;display:"+(auditInfor.auditerName3 == null ? 'none' : '')+";'><td align='center'>"+auditInfor.auditerName3+"</td>"
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
#project_stages_update{
	position:absolute;
	cursor:pointer;
	top:40px;
	left:900px;
	width:48px;
	height:48px;
	background:url(images/pro_stage_show.png) no-repeat;
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
	height:630px;
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
.college_no_limit{
	font-size:12px;
}
#project_no_limit{
	width:auto;
	height:auto;
	margin-top:auto;
	margin-left:auto;
}
#project_creater{
	font-size:13px;
	font-weight:bold;
}
#check_starts{
	width:250px;
	height:30px;
	line-height:40px;
}
.starts_Show{
	cursor:pointer;
	width:35px;
	height:30px;
	float:left;
	background:url(images/start.png);
}
.starts_No{
	cursor:pointer;
	width:35px;
	height:30px;
	float:left;
	background:url(images/startb.png);
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
/* 上传文件组件对象的css样式end */


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
#project_audit_index{
	position:absolute;
	cursor:pointer;
	top:100px;
	left:900px;
	width:48px;
	height:48px;
	background:url(images/pro_audit_infor.png) no-repeat;
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
<input type="hidden" value="${school_id }" id="schoolId"/>
<input type="hidden" value="${school_parterUps }" id="parterUps"/>
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
						<div class="input_frame"><input type="text" name="project_name" id="project_name" value="${projectInfor.projectName }"/></div>
					</td>
	              </tr>
	              <tr>
	                <td align="right">&nbsp;</td>
	                <td align="left"><span id="project_name_error" class="error_infor"></span></td>
	              </tr>
	              <tr>
	                <td align="right">出题人：</td>
	                <td align="left">
	                	<span id="project_creater"></span>
	                </td>
	              </tr>
	              <tr>
	                <td align="right">&nbsp;</td>
	                <td align="left">&nbsp;</td>
	              </tr>
	              <tr>
	                <td align="right">参与人数限定：</td>
	                <td align="left">
	                	<input type="hidden" id="oldProPartNum" value="${projectInfor.partNum }"/>
	                	<select id="project_partNum"></select>
	              	</td>
	              </tr>
	              <tr>
	                <td align="right">&nbsp;</td>
	                <td align="left">&nbsp;</td>
	              </tr>
	              <tr>
	                <td align="right">工作量大小：</td>
	                <td align="left">
	                	<select id="project_workload">
	                		<!-- 等会将这个更改为javascript创建操作处理来实现 -->
		                  	<option selected="${projectInfor.workload eq '1' ? true : false }"  value="1">工作量较轻</option>
		                  	<option selected="${projectInfor.workload eq '2' ? true : false }" value="2">工作量较重</option>
		                  	<option selected="${projectInfor.workload eq '3' ? true : false }" value="3">工作量很重</option>
		            	</select>
		            </td>
	              </tr>
	              <tr>
	                <td align="right">&nbsp;</td>
	                <td align="left">&nbsp;</td>
	              </tr>
	              <tr>
	                <td align="right">院系限定：</td>
	                <td colspan="2" align="left">
	                	<input type="hidden" id="oldProCollege" value="${projectInfor.college }"/>
	                	<select id="project_college"></select>
		                <span class="college_no_limit">(无院系限定任何专业都能选择&nbsp;<input type="checkbox" name="project_no_limit" id="project_no_limit"/>&nbsp;)</span>
		          	</td>
				  </tr>
	              <tr>
	                <td align="right">&nbsp;</td>
	                <td align="left">&nbsp;</td>
	                <td align="left">&nbsp;</td>
	              </tr>
	              <tr>
	                <td align="right" height="30px">难易程度：</td>
	                <td colspan="2" align="left">
	                	<div id="project_hardNum">
	                		<input type="hidden" id="oldProHarmNum" value="${projectInfor.hardNum }"/>
	                	</div>
	                </td>
	              </tr>
	              <tr>
	                <td align="right">&nbsp;</td>
	                <td align="left">&nbsp;</td>
	                <td align="left">&nbsp;</td>
	              </tr>
	              <tr>
	                <td align="right">课题资料文件：</td>
	                <td colspan="2" align="left">
	                	<form id="project_file_form" target="upload_iframe" class="upload_form" enctype="multipart/form-data" method="post">
	                		<div class="input_frame">
	                			<input type="file" id="project_file_input" class="upload_file_input" hidefocus="hidefocus" name="project_file"/>
	                			<input type="text" id="invented_project_file" name="invented_project_file" value="${projectInfor.projectFile }" readonly/>
	                			<div class="select_upload"></div>
	                		</div>
	                		<input type="button" id="file_send_submit" class="upload_submit" value="发送"/>
	                		<iframe name='upload_iframe' style='display:none'></iframe>
	                	</form>
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
	                <td colspan="2" rowspan="2" align="left">
	                	<div class="textarea_frame">
							<textarea id="project_purpose" name="project_purpose">${projectInfor.purpose }</textarea>
						</div>
					</td>
	              </tr>
	              <tr>
	                <td align="right">&nbsp;</td>
	              </tr>
	              
	              <tr>
	                <td align="right">&nbsp;</td>
	                <td align="left"><span id="project_purpose_error" class="error_infor"></span></td>
	                <td align="left">&nbsp;</td>
	              </tr>
	              <tr>
	                <td align="right">主要内容：</td>
	                <td colspan="2" rowspan="2" align="left">
	                	<div class="textarea_frame">
							<textarea id="project_main_content" name="project_main_content">${projectInfor.mainContent }</textarea>
						</div>
					</td>
	              </tr>
	              <tr>
	                <td align="right">&nbsp;</td>
	              </tr>
	              
	
	              <tr>
	                <td align="right">&nbsp;</td>
	                <td align="left"><span id="project_content_error" class="error_infor"></span></td>
	                <td align="left">&nbsp;</td>
	              </tr>
	              <tr>
	                <td align="right">&nbsp;</td>
	                <td align="left" colspan="2">
	                	<input type="button" class="project_button" id="project_submit_button" value="更改信息"/>
	                	<input type="button" class="project_button" id="break_old_page" value="再次审核"/>
	                </td>
	              </tr>
	              <tr>
	                <td colspan="3" align="right">&nbsp;</td>
	              </tr>
	            </table>
			</div>
	    </div>
	</div>
	<div id="project_stages_update" title="课题阶段更改"></div>
	<div id="project_audit_index" title="课题审核详情"></div>
</div>
</body>
</html>
