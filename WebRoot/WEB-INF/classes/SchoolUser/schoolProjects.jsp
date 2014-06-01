<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>学校的课题信息</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script type="text/javascript" src="js/Fade_Slide.js"></script>
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/PagingProject.js"></script>
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
	.project_body{
		width:960px;
		height:760px;
		
		margin:auto;
		margin-top:30px;
		margin-bottom:30px;
		
		position:relative;
	}
	#projects_out{/*这个作为一个隐藏框架对象*/
		width:924px;
		height:685px;
		
		position:relative;
		margin-left:30px;
		overflow:hidden;
	}
	.body_frame{
		width:900px;
		height:660px;
		
		float:left;
		margin-right:40px;
		overflow:hidden;
		border:9px solid #d8d7d7;
		background:white;
		border-radius:5px;
		box-shadow:3px 3px 2px #000;
	}
	#find_project{
		width:50px;
		height:50px;
		position:absolute;
		top:10px;
		right:-40px;
		cursor:pointer;
		background:url(images/find_project.png) no-repeat;
	}
	#find_project:hover{
		width:80px;
		height:80px;
		right:-70px;
		background:url(images/find_project1.png) no-repeat;
	}
	#project_createyear{
		width:70px;
		height:200px;
		position:absolute;
		top:5px;
		left:-40px;
	}
	.project_yeartitle{
		width:70px;
		font-size:14px;
		font-family:华文行楷;
	}
	.project_yearframe{
		width:60px;
		height:25px;
		line-height:25px;
		margin:5px;
		font-size:14px;
		letter-spacing:2px;
		text-indent:20px;
		color:black;
		font-family:华文行楷;
		cursor:pointer;
		
		border:2px solid #A2E60C;
		background:white url(images/link_logo.png) no-repeat;
		border-radius:3px;
		box-shadow:0px 2px 2px #000;
	}
	.project_yearframe:hover{
		color:white;
		border:2px solid #d8d7d7;
		background:#d8d7d7 url(images/link_logo.png) no-repeat;
	}
	
	/* width-> 280*/
	.pro_frameout{
		float:left;
		width:390px;
		height:190px;
		
		cursor:default;
		margin-top:10px;
		margin-left:20px;
		margin-right:40px;
		margin-bottom:20px;
		overflow:hidden;
	}
	.pro_frame{
		position:relative;
		float:left;
		width:350px;
		height:180px;
		
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
		height:150px;
	}
	.pro_stage_view{
		position:absolute;
		top:0px;
		right:0px;
		width:80px;
		height:80px;
		z-index:100;
		background:url(images/pro_stage_nosubmit.png) no-repeat 50%;
	}
	.pro_picture{
		width:94px;
		height:134px;
		float:left;
		margin:5px;
		background:white;
		
		border:3px solid white;
		border-radius:5px;
		box-shadow:2px 2px 2px #000;
		background:url(images/ps.png) no-repeat;
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
	.add_to_select{
		width:30px;
		height:30px;
		float:left;
		cursor:pointer;
		background:url(images/add_to_select.png);
	}
	.pro_select{
		width:30px;
		height:30px;
		float:left;
		cursor:pointer;
		background:url(images/pro_select.png);
	}
	.files_down{
		width:30px;
		height:30px;
		float:left;
		cursor:pointer;
		background:url(images/files_down.png);
	}
	#up_to_page{
		width:128px;
		height:128px;
		position:absolute;
		top:240px;/*后期会计算*/
		left:-100px;
		
		display:none;
		opacity:0.2;
		background:url(images/up_to_page.png);
	}
	#down_to_page{
		width:128px;
		height:128px;
		position:absolute;
		top:240px;
		right:-120px;
		
		opacity:0.2;
		background:url(images/down_to_page.png);
	}
	#all_page_num{
		width:288px;
		height:30px;
		padding-top:10px;
		margin:auto;
		
	}
	#all_page_num div{
		width:25px;
		height:25px;
		cursor:pointer;
		line-height:25px;
		
		margin-right:5px;
		border:1px solid #E0E0E0;
		float:left;
		color:#ACACAC;
		font-size:14px;
		font-weight:bold;
	}
	
	
	/* 课题的选择方式 */
	.pagingChangeFrame{
		height:30px;
		line-height:30px;
		margin-top:15px;
	}
	.selectFrame{
		position:relative;
		float:left;
		margin-left:15px;
		cursor:pointer;
		z-index:1000;
	}
	.selectText{
		position:relative;
		float:left;
		margin-left:20px;
	}
	.selectPagings{
		position:absolute;
		top:25px;
		left:0px;
		width:190px;
		height:70px;
		background:white;
		border:1px solid #E0E0E0;
		border-radius:5px;
		box-shadow:2px 2px 2px #000;
	}
	.queryButton{
		width:50px;
		height:25px;
		margin-left:5px;
		margin-right:5px;
		margin-top:3px;
		margin-bottom:3px;
		text-align:center;
		line-height:25px;
		float:left;
		cursor:pointer;
	}
	.queryButton:hover{
		color:black;
	}
	.queryAlterButton{
		width:102px;
		height:29px;
		text-align:center;
		
		position:absolute;
		top:105px;
		left:150px;
		font-size:13px;
		font-weight:bold;
		line-height:29px;
		color:white;
		cursor:pointer;
		background:url(images/frame_button0.png) no-repeat;
	}
	.queryAlterButton:hover{
		background:url(images/frame_button1.png) no-repeat;
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
	#selectProStage{
		position:absolute;
		top:2px;
		right:10px;
		width:50px;
		height:25px;
		line-height:25px;
		cursor:pointer;
	}
	.stageSelects{
		width:50px;
		height:50px;
	}
	.stageSelect{
		width:100%;
		height:20px;
		line-height:20px;
	}
	.stageSelect:hover{
		color:black;
	}
	.queryResult{
		width:100%;
		height:25px;
		line-height:25px;
		text-align:center;
		margin-top:5px;
		color:red;
		font-size:12px;
		font-weight:bold;
	}
</style>
<script>
	var up_button = null;		//为了提高效率加快按钮的索引速度使用全局变量来控制
	var down_button = null;
	var pro = null;				//分页数据参数设置
	var pagingFrameObj = null;	//用于全局索引分页操作处理框
	var proYearObj = null;		//时间判断对象
	function init(){
		suit_Page();
		createButtonEvent();
		
		pagingFrameObj = new PagingFrame($("find_project") , $("proYear").value);
		pagingFrameObj.createView();
		
		proYearObj = new projectYearObj($("project_createyear") , $("proYear").value);
		proYearObj.initYearObj();
	}
	
	//设定按钮事件对象
	function createButtonEvent(){
		up_button = $("up_to_page");
		down_button = $("down_to_page");
		
		up_button.onmouseover = function(){
			up_button.style.opacity = "1"; 
		};
		up_button.onmouseout = function(){
			up_button.style.opacity = "0.2"; 
		};
	
		down_button.onmouseover = function(){
			down_button.style.opacity = "1"; 
		};
		down_button.onmouseout = function(){
			down_button.style.opacity = "0.2"; 
		};
	}
	
	
	/* 数据信息对象
	 * pro_title:课题名称
	 * pro_id:课题编号
	 * pro_schoolId:学校编号
	 * pro_picture:题目图片
	 * pro_username:出题人
	 * pro_userid:出题人id
	 * pro_num:参与人数限定
	 * pro_collage:院系限定
	 * pro_work:工作量
	 * pro_level:难易程度
	 * pro_download:课题文件资料下载
	 * pro_stage:课题的状态信息
	 */
	function ProjectInfor(pro_title , pro_id, pro_schoolId, pro_picture,pro_username, pro_userid, pro_num, pro_collage, pro_work, pro_level, pro_download, pro_stage){
		this.pro_title = pro_title;
		this.pro_id = pro_id;
		this.pro_schoolId = pro_schoolId;
		this.pro_picture = pro_picture;
		this.pro_username = pro_username;
		this.pro_userid = pro_userid;
		this.pro_num = pro_num;
		this.pro_collage = pro_collage;
		this.pro_work = pro_work;
		this.pro_level = pro_level;
		this.pro_download = pro_download;
		this.pro_stage = pro_stage;
	}
	ProjectInfor.prototype.packagePro = function(){//将对象封装成为div对象
		var pro_frameout = document.createElement("div");
		pro_frameout.className = "pro_frameout";
		
		var pro_frame = document.createElement("div");
		pro_frame.className = "pro_frame";
		
		var frame_title = document.createElement("div");
		frame_title.className = "frame_title";
		frame_title.innerHTML = this.pro_title;
		
		var frame_body = document.createElement("div");
		frame_body.className = "frame_body";
		
		var pro_stage_view = document.createElement("div");
		pro_stage_view.className = "pro_stage_view";
		if(this.pro_stage == "S"){
			pro_stage_view.style.background = "url(images/pro_stage_nosubmit.png) no-repeat 50%";
		}else if(this.pro_stage == "W"){
			pro_stage_view.style.background = "url(images/pro_audit_wait.png) no-repeat 50%";
		}else if(this.pro_stage == "T"){
			pro_stage_view.style.background = "url(images/pro_audit_success.png) no-repeat 50%";
		}else if(this.pro_stage == "F"){
			pro_stage_view.style.background = "url(images/pro_audit_failed.png) no-repeat 50%";
		}
		
		var pro_picture = document.createElement("div");
		pro_picture.className = "pro_picture";
		var url = this.pro_picture == "null" ? "images/upload_file.png" : "ProjectInfor/"+this.pro_schoolId+"/"+this.pro_userid+"/"+this.pro_picture;
		pro_picture.style.background = "url("+url+") 50% 50% no-repeat";
		
		var pro_infor = document.createElement("div");
		pro_infor.className = "pro_infor";
		
		pro_infor.innerHTML = "<table width='100%' height='140' border='0'><tr>"+
							  "<td width='45%' align='right'>出题人：</td>"+
							  "<td width='55%' align='left'>"+this.pro_username+"</td></tr>"+
	                     	  "<tr><td align='right'>参与人数限定：</td>"+
	                          "<td align='left'>"+this.pro_num+"&nbsp;人</td></tr>"+
							  "<tr><td align='right'>院系限定：</td>"+
							  "<td align='left'>"+(this.pro_collage == "null" ? "无院系限定" : this.pro_collage)+"</td></tr>"+
							  "<tr><td align='right'>工作量大小：</td>"+
							 "<td align='left'>"+(this.pro_work == "1" ? "工作量较轻" : this.pro_work == "2" ? "工作量较重" : "工作量很重")+"</td></tr>"+
							  "<tr><td align='right'>难易程度：</td>"+
							  "<td align='left'>"+this.pro_level+"</td></tr></table>";
							  
		var add_to_select = document.createElement("div");
		add_to_select.className = "add_to_select";
		add_to_select.title = "添加对比";
		
		var pro_select = document.createElement("div");
		pro_select.className = "pro_select";
		pro_select.title = "详细信息";
		addEvent(pro_select , "click", this.showDetailProject(this.pro_id));
		
		var files_down = document.createElement("div");
		files_down.className = "files_down";
		files_down.title = "资料下载";
		addEvent(files_down , "click", this.downProjectFile(this.pro_id , this.pro_download));
		
		frame_body.appendChild(pro_picture);
		frame_body.appendChild(pro_infor);
		pro_frame.appendChild(frame_title);
		pro_frame.appendChild(frame_body);
		pro_frame.appendChild(pro_stage_view);
		pro_frameout.appendChild(pro_frame);
		pro_frameout.appendChild(add_to_select);
		pro_frameout.appendChild(pro_select);
		pro_frameout.appendChild(files_down);
		
		return pro_frameout;//返回一个对象框架
	};
	ProjectInfor.prototype.showDetailProject = function(pro_id){//显示课题的详细信息内容(根据课题编号查询课题详细信息内容)
		return function(){
			var url = ifIE ? "../ProjectManagerServlet?type=query_project_inforshow&project_id="+pro_id : "ProjectManagerServlet?type=query_project_inforshow&project_id="+pro_id;
			window.open(url , "_self");
		};
	};
	ProjectInfor.prototype.downProjectFile = function(pro_id , pro_download){//课题文件下载操作
		return function(){
			var url = ifIE ? "../FileManageServlet?type=downProjectFile&project_id="+pro_id+"&filename="+pro_download : "FileManageServlet?type=downProjectFile&project_id="+pro_id+"&filename="+pro_download;
			document.location.href = url;//使用document.location设置下载地址操作
		};
	};
	
	/*
	 * 分页操作处理组件
	 * findButton 打开分页参数设置框架的对象
	 */
	function PagingFrame(findButton , queryProYear){
		this.findButton = findButton;
		this.queryProYear = queryProYear == null || undefined ? 0 : queryProYear;//需要查询毕业时间
		
		this.queryPagingWindow = null;//用于索引一个分页设置窗口
		this.selectPagings = null;//选择对象
		this.stageSelects = null;//课题状态选择对象
		
		this.queryFunType = 1;//这个是用于表示当前的分页操作的索引方式
		this.queryProStage = null;//需要查询的课题的状态类型
	}
	PagingFrame.prototype.createView = function(){
		//先获取分页参数信息然后再显示(这个是一个默认的分页对象-》》》这个后期将会对于搜索方式更改为学校审核通过的课题信息.
		PagingProject.getPageNumberBySchoolId(this.queryFunType , this.queryProStage, this.queryProYear, function(pageParams){
			/* 在这里还需要添加一个对于假如无法找到对应的页面数据信息时将显示的信息 */
            pro = new PageSlideObj(0 , pageParams.pagingNumbers);
			pro.initializeObj();
			pro.setPagingParams(pagingFrameObj.queryFunType , pagingFrameObj.queryProStage, pagingFrameObj.queryProYear);//设置分页参数信息
			pro.findProPage(1);
		});
		
		addEvent(this.findButton , "mouseover", this.onmouseover);
		addEvent(this.findButton , "mouseout", this.onmouseout);
		addEvent(this.findButton , "click", this.onclick(this.findButton , this));
	};
	PagingFrame.prototype.changePaging = function(queryFun , queryIndex){//实现根据不同的搜索方式实现分页queryIndex:查询索引
		switch(queryFun){
			case 1:{
				//这个是获取当前页面的分页数目
				PagingProject.getPageNumberBySchoolId($("school_id").value , this.queryProStage, this.queryProYear, function(pageParams){
		            if(pageParams.pagingNumbers == 0){//查询当前索引是否存在页面数据
		            	$("queryResult").style.color = "red";
		            	$("queryResult").innerHTML = "sorry 不存在你要找的课题信息...";
		            }else{
		            	$("queryResult").innerHTML = "<span style='color:#9C9C9C;font-weight:normal'>检索到<span style='color:green'>&nbsp;"+pageParams.pagingObjNumbers+"&nbsp;</span>个相应课题数目</span>";
			            pro.cleanPropageFrame();
			            pro = new PageSlideObj(0 , pageParams.pagingNumbers);
						pro.initializeObj();
						pro.setPagingParams(pagingFrameObj.queryFunType , pagingFrameObj.queryProStage, pagingFrameObj.queryProYear);//设置分页参数信息
						pro.findProPage(1);
					}
				});
				break;
			}
			case 2:{
				PagingProject.getPageNumberByCreateName($("school_id").value , queryIndex, this.queryProStage, this.queryProYear, function(pageParams){
					if(pageParams.pagingNumbers == 0){
						$("queryResult").style.color = "red";
		            	$("queryResult").innerHTML = "sorry 不存在你要找的课题信息...";
					}else{
						$("queryResult").innerHTML = "<span style='color:#9C9C9C;font-weight:normal'>检索到<span style='color:green'>&nbsp;"+pageParams.pagingObjNumbers+"&nbsp;</span>个相应课题数目</span>";
			            pro.cleanPropageFrame();//清除上一个分页操作显示对象
			            pro = new PageSlideObj(0 , pageParams.pagingNumbers);
						pro.initializeObj();
						pro.setPagingParams(pagingFrameObj.queryFunType , pagingFrameObj.queryProStage, pagingFrameObj.queryProYear);
						pro.findProPage(1);
					}
				});
				break;
			}
			case 3:{
				PagingProject.getPageNumberByCollege($("school_id").value , queryIndex, this.queryProStage, this.queryProYear, function(pageParams){
					if(pageParams.pagingNumbers == 0){
						$("queryResult").style.color = "red";
		            	$("queryResult").innerHTML = "sorry 不存在你要找的课题信息...";
					}else{
						$("queryResult").innerHTML = "<span style='color:#9C9C9C;font-weight:normal'>检索到<span style='color:green'>&nbsp;"+pageParams.pagingObjNumbers+"&nbsp;</span>个相应课题数目</span>";
			            pro.cleanPropageFrame();//清除上一个分页操作显示对象
			            pro = new PageSlideObj(0 , pageParams.pagingNumbers);
						pro.initializeObj();
						pro.setPagingParams(pagingFrameObj.queryFunType , pagingFrameObj.queryProStage, pagingFrameObj.queryProYear);
						pro.findProPage(1);
					}
				});
				break;
			}
			case 4:{
				PagingProject.getPageNumberByProjectName($("school_id").value , queryIndex, this.queryProStage, this.queryProYear, function(pageParams){
					if(pageParams.pagingNumbers == 0){
						$("queryResult").style.color = "red";
		            	$("queryResult").innerHTML = "sorry 不存在你要找的课题信息...";
					}else{
						$("queryResult").innerHTML = "<span style='color:#9C9C9C;font-weight:normal'>检索到<span style='color:green'>&nbsp;"+pageParams.pagingObjNumbers+"&nbsp;</span>个相应课题数目</span>";
			            pro.cleanPropageFrame();//清除上一个分页操作显示对象
			            pro = new PageSlideObj(0 , pageParams.pagingNumbers);
						pro.initializeObj();
						pro.setPagingParams(pagingFrameObj.queryFunType , pagingFrameObj.queryProStage, pagingFrameObj.queryProYear);
						pro.findProPage(1);
					}
				});
				break;
			}
			case 5:{
				PagingProject.getPageNumberByPartNum($("school_id").value , queryIndex, this.queryProStage, this.queryProYear, function(pageParams){
					if(pageParams.pagingNumbers == 0){
						$("queryResult").style.color = "red";
		            	$("queryResult").innerHTML = "sorry 不存在你要找的课题信息...";
					}else{
						$("queryResult").innerHTML = "<span style='color:#9C9C9C;font-weight:normal'>检索到<span style='color:green'>&nbsp;"+pageParams.pagingObjNumbers+"&nbsp;</span>个相应课题数目</span>";
			            pro.cleanPropageFrame();//清除上一个分页操作显示对象
			            pro = new PageSlideObj(0 , pageParams.pagingNumbers);
						pro.initializeObj();
						pro.setPagingParams(pagingFrameObj.queryFunType , pagingFrameObj.queryProStage, pagingFrameObj.queryProYear);
						pro.findProPage(1);
					}
				});
				break;
			}
			case 6:{
				PagingProject.getPageNumberByHardNum($("school_id").value , queryIndex, this.queryProStage, this.queryProYear, function(pageParams){
					if(pageParams.pagingNumbers == 0){
						$("queryResult").style.color = "red";
		            	$("queryResult").innerHTML = "sorry 不存在你要找的课题信息...";
					}else{
						$("queryResult").innerHTML = "<span style='color:#9C9C9C;font-weight:normal'>检索到<span style='color:green'>&nbsp;"+pageParams.pagingObjNumbers+"&nbsp;</span>个相应课题数目</span>";
			            pro.cleanPropageFrame();//清除上一个分页操作显示对象
			            pro = new PageSlideObj(0 , pageParams.pagingNumbers);
						pro.initializeObj();
						pro.setPagingParams(pagingFrameObj.queryFunType , pagingFrameObj.queryProStage, pagingFrameObj.queryProYear);
						pro.findProPage(1);
					}
				});
				break;
			}
		}
	};
	PagingFrame.prototype.onmouseover = function(){
		/*使用css伪类
		var event = window.event ? window.event : arguments[0];
		var find_button = event.target ? event.target : event.srcElement;
		
		find_button.style.width = "80px";
		find_button.style.height = "80px";
		find_button.style.right = "-70px";
		find_button.style.background = "url(images/find_project1.png) no-repeat";
		*/
	};
	PagingFrame.prototype.onmouseout = function(){
		/*
		var event = window.event ? window.event : arguments[0];
		var find_button = event.target ? event.target : event.srcElement;
		
		find_button.style.width = "50px";
		find_button.style.height = "50px";
		find_button.style.right = "-40px";
		find_button.style.background = "url(images/find_project.png) no-repeat";
		*/
	};
	PagingFrame.prototype.createQueryWinodw = function(){
		//创建一个可移动的窗口对象用于分页数据的输入操作
		var queryFrame = document.createElement("div");
		
		var pagingChangeFrame = document.createElement("div");
		pagingChangeFrame.className = "pagingChangeFrame";
		
		var selectFrame = document.createElement("div");
		selectFrame.className = "selectFrame";
		selectFrame.innerHTML = "查询方式：<span style='color:green;font-size:13px' id='querySelect'>全部课题<span>";
		addEvent(selectFrame , "mouseover", this.createPagingSelect(selectFrame , this));
		addEvent(selectFrame , "mouseout", this.hiddenPagingSelect(this));
		pagingChangeFrame.appendChild(selectFrame);
		
		var selectText = document.createElement("div");
		selectText.innerHTML = "<span style='float:left'>关键字：</span><div class='input_frame'><input type='text' id='query_Key'/><div id='selectProStage'><span id='queryProStage'>课题状态</span></div></div>";
		selectText.className = "selectText";
		pagingChangeFrame.appendChild(selectText);
		
		var queryResult = document.createElement("div");//提供一个对于分页操作后的结果提示信息
		queryResult.className = "queryResult";
		queryResult.id = "queryResult";
		
		var queryAlterButton = document.createElement("div");
		queryAlterButton.innerHTML = "查询信息";
		queryAlterButton.className = "queryAlterButton";
		addEvent(queryAlterButton , "click", this.pagingProjects(this));
		queryFrame.appendChild(pagingChangeFrame);
		queryFrame.appendChild(queryResult);
		queryFrame.appendChild(queryAlterButton);
		
		return queryFrame;
	};
	PagingFrame.prototype.onclick = function(find_button , pagingFrame){
		return function(){
			if(pagingFrame.queryPagingWindow == null){
				var queryFrame = pagingFrame.createQueryWinodw();
				
				var titleClose = new Window_close();
				titleClose.close_Click = pagingFrame.closeWinodw;
				
				//关闭了
				var title = new Window_titleview(null , null, new Window_title("查询课题信息"), null, null, false, null, null, titleClose, null);//设置标题信息
				
				var margin_Left = (parent.document.body.clientWidth - 400)/2;
				var frame = new Window_frame(400 , 150, 100, margin_Left, null, null, null, null, null, true);
				
				pagingFrame.queryPagingWindow = new moveWindow(frame , title, false, null, null, null, true, null, null, null);
				pagingFrame.queryPagingWindow.create_View();
				pagingFrame.queryPagingWindow.Win_view.add_Child(queryFrame);
				
				pagingFrame.setSelectPagingView();
			}
		};
	};
	PagingFrame.prototype.setSelectPagingView = function(){//设置分页操作框的信息
		var query_Key = new inputElementObj($("query_Key"));
		query_Key.createView();
		
		addEvent($("selectProStage") , "mouseover", this.createStageSelect(this));
		addEvent($("selectProStage") , "mouseout", this.hiddenStageSelect(this));
	};
	PagingFrame.prototype.closeWinodw = function(parentObj){//重写关闭事件
		return function(){  
			if(!parentObj.getParentObj().Win_closeC){
				parentObj.getParentObj().Win_cover.close_Cover();
			}
			
			parentObj.getParentObj().closeWindow();
			
			//清除索引标志
			pagingFrameObj.queryPagingWindow = null;
			pagingFrameObj.selectPagings = null;
			pagingFrameObj.stageSelects = null;
			
			pagingFrameObj.queryFunType = 1;
			pagingFrameObj.queryProStage = null;
		};
	};
	PagingFrame.prototype.createPagingSelect = function(selectFrame , pagingFrame){//课题查询方式的选择
		return function(){
			if(pagingFrame.selectPagings == null){
				pagingFrame.selectPagings = document.createElement("div");
				pagingFrame.selectPagings.className = "selectPagings";
				selectFrame.appendChild(pagingFrame.selectPagings);
				
				//一共有6种查询方式操作
				var select1 = document.createElement("div");
				select1.className = "queryButton";
				select1.innerHTML = "全部课题";
				select1.value = 1;
				addEvent(select1 , "click", pagingFrame.selectClick(select1 , pagingFrame));
				
				var select2 = document.createElement("div");
				select2.className = "queryButton";
				select2.innerHTML = "出题人";
				select2.value = 2;
				addEvent(select2 , "click", pagingFrame.selectClick(select2 , pagingFrame));
				
				var select3 = document.createElement("div");
				select3.className = "queryButton";
				select3.innerHTML = "限定学院";
				select3.value = 3;
				addEvent(select3 , "click", pagingFrame.selectClick(select3 , pagingFrame));
				
				var select4 = document.createElement("div");
				select4.className = "queryButton";
				select4.innerHTML = "课题名称";
				select4.value = 4;
				addEvent(select4 , "click", pagingFrame.selectClick(select4 , pagingFrame));
				
				var select5 = document.createElement("div");
				select5.className = "queryButton";
				select5.innerHTML = "人数限定";
				select5.value = 5;
				addEvent(select5 , "click", pagingFrame.selectClick(select5 , pagingFrame));
				
				var select6 = document.createElement("div");
				select6.className = "queryButton";
				select6.innerHTML = "难易程度";
				select6.value = 6;
				addEvent(select6 , "click", pagingFrame.selectClick(select6 , pagingFrame));
				
				pagingFrame.selectPagings.appendChild(select1);
				pagingFrame.selectPagings.appendChild(select2);
				pagingFrame.selectPagings.appendChild(select3);
				pagingFrame.selectPagings.appendChild(select4);
				pagingFrame.selectPagings.appendChild(select5);
				pagingFrame.selectPagings.appendChild(select6);
			}else{
				pagingFrame.selectPagings.style.display = "block";
			}
		};
	};
	PagingFrame.prototype.createStageSelect = function(pagingFrame){//设置课题状态选择下拉表
		return function(){
			if(pagingFrame.stageSelects == null){
				pagingFrame.stageSelects = document.createElement("div");
				pagingFrame.stageSelects.className = "stageSelects";
				
				//一共有5种课题状态(Teacher->拥有全部状态索引权限，学校管理员->有W,T,F，学生->T)
				//删除状态只能在教师的回收站中查看
				/*保存状态
				var stage_S = document.createElement("div");
				stage_S.className = "stageSelect";
				stage_S.value = "S";
				stage_S.innerHTML = "已保存";
				addEvent(stage_S , "click", pagingFrame.setSelectStage(stage_S , pagingFrame));
				*/
				
				//等待学校审核状态
				var stage_W = document.createElement("div");
				stage_W.className = "stageSelect";
				stage_W.value = "W";
				stage_W.innerHTML = "待审核";
				addEvent(stage_W , "click", pagingFrame.setSelectStage(stage_W , pagingFrame));
				
				//审核通过状态
				var stage_T = document.createElement("div");
				stage_T.className = "stageSelect";
				stage_T.value = "T";
				stage_T.innerHTML = "审核通过";
				addEvent(stage_T , "click", pagingFrame.setSelectStage(stage_T , pagingFrame));
				
				//审核失败状态
				var stage_F = document.createElement("div");
				stage_F.className = "stageSelect";
				stage_F.value = "F";
				stage_F.innerHTML = "审核失败";
				addEvent(stage_F , "click", pagingFrame.setSelectStage(stage_F , pagingFrame));
				
				//pagingFrame.stageSelects.appendChild(stage_S);
				pagingFrame.stageSelects.appendChild(stage_W);
				pagingFrame.stageSelects.appendChild(stage_T);
				pagingFrame.stageSelects.appendChild(stage_F);
				
				$("selectProStage").appendChild(pagingFrame.stageSelects);
			}else{
				pagingFrame.stageSelects.style.display = "block";
			}
		};
	};
	PagingFrame.prototype.hiddenStageSelect = function(pagingFrame){
		return function(){
			//影藏状态选择
			pagingFrame.stageSelects.style.display = "none";
		};
	};
	PagingFrame.prototype.setSelectStage = function(selectObj , pagingFrame){//设置需要查询的课题状态信息
		return function(){
			$("queryProStage").innerHTML = "<span style='color:green'>"+selectObj.innerHTML+"</span>";
			pagingFrame.queryProStage = selectObj.value;
		}
	};
	PagingFrame.prototype.selectClick = function(selectObj , pagingFrame){
		return function(){
			$("querySelect").innerHTML = selectObj.innerHTML;
			pagingFrame.queryFunType = selectObj.value;
		};
	};
	PagingFrame.prototype.hiddenPagingSelect = function(pagingFrame){//影藏选择操作对象
		return function(){
			pagingFrame.selectPagings.style.display = "none";
		};
	};
	PagingFrame.prototype.pagingProjects = function(pagingFrame){
		return function(){
			pagingFrame.changePaging(pagingFrame.queryFunType , $("query_Key").value);
		};
	};
	 
	
	/* 页面对象
	 * pro_id:页面编号
	 * pro_page:装载信息对象的容器(就是页面对象容器)
	 * pro_infor:内部信息数组
	 */
	function PageProject(pro_id , pro_page, pro_infor){
		this.pro_id = pro_id == null || undefined ? 0 : pro_id;
		this.pro_page = pro_page == null || undefined ? alert("请输入容器对象") : pro_page;
		this.pro_infor = pro_infor == null || undefined ? new Array() : pro_infor;
	}
	PageProject.prototype.pushObj = function(obj){//添加对象
		this.pro_infor.push(obj);
	};
	PageProject.prototype.popObj = function(obj){//删除对象的最后一个数据
		this.pro_infor.pop(obj);
	};
	PageProject.prototype.createPage = function(){
		try{
			for(var i=0;i<this.pro_infor.length;i++){
				this.pro_page.appendChild(this.pro_infor[i]);//装载对象到页面中去
			}
		}catch(error){
			alert(error);
		}
	};
	
	
	/* 页面转换对象 
	 * 外围-> projects_out
	 * 这样比较复杂还不如使用DWR框架进行分页处理来得方便(最终决定使用DWR框架来进行处理实现)
	 * 这个现在是以每次多次创建slide对象实现的（以后可以通过扩展包含对象宽度来实现）
	 * pageIndex->>页面对象索引
	 * allPageNum->>全部页面数目
	 * 等有空将这个作为一个通用的处理页面对象类
	 */
	function PageSlideObj(pageIndex , allPageNum){
		this.pageIndex = pageIndex == null || undefined ? 0 : pageIndex;
		this.allPageNum = allPageNum == null || undefined ? 0 : allPageNum;
		
		this.propageFrame = null;//这个是一个用于保存对象(最多也就3个显示对象作为轮动对象)
		this.arrayProjects = new Array();//创建一个对象数组对象(用于存放->PageProject这个页面对象数据)
		
		this.pageNumObj = new pagenumObj($("all_page_num") , this.allPageNum);//创建页面索引对象
		
		this.tween = new Tween(10 , 0, 100, 100);//轮动参数对象
		this.args = new SlideArgs("left" , false, 958, 10, 2000, "circ");
		this.slide = null;//轮动对象
		
		//分页参数信息
		this.pagingFunType = 1;//这个是用于设置当前分页操作的执行类型
		this.pagingProStage = null;//当前需要查询的页面的课题状态类型（默认为S）
		this.queryProYear = 0;//需要查询毕业时间
	}
	PageSlideObj.prototype.initializeObj = function(){//初始化页面对象方式(创建页码点击按钮)
		this.pageNumObj.createFrame(1);//从第几页开始
	};
	PageSlideObj.prototype.createSlideFrame = function(pageNum){//根据页面状况设计外围包含框架的范围大小
		this.propageFrame = document.createElement("div");
		this.propageFrame.id = "propageFrame";
		this.propageFrame.style.height = "660px";
		this.propageFrame.style.position = "absolute";
		
		if(pageNum == 1){//这种情况只存在2个页面(不能向上一页移动)
			this.propageFrame.style.width = 958*2+"px";
			up_button.style.display = "none";/* 这个关于按钮的显示与隐藏还可以优化在这就不处理了 */
			down_button.style.display = this.allPageNum <= 1 ? "none" : "block";//对于全部页面只存在一个页面时影藏下一页跳转
		}else if(pageNum == this.allPageNum){//这种情况只存在2个页面(不能向下一页移动)
			this.propageFrame.style.width = 958*2+"px";
			this.propageFrame.style.left = "-958px";
			up_button.style.display = "block";
			down_button.style.display = "none";
		}else{
			this.propageFrame.style.width = 958*3+"px";
			this.propageFrame.style.left = "-958px";
			up_button.style.display = "block";
			down_button.style.display = "block";
		}
	};
	PageSlideObj.prototype.cleanPropageFrame = function(){//清除前一个分页查询的显示结果
		this.propageFrame != null ? $("projects_out").removeChild(this.propageFrame) : "";
		//还需要对于button事件也要清除事件索引
		removeEventHandler(up_button , "click", upPageEvent);
		removeEventHandler(down_button , "click", downPageEvent);
	};
	PageSlideObj.prototype.jumpProPage = function(pageNum){//这个是直接页面跳转方法（按照页面编号跳转）
		//页面直接跳转时初始化操作
		this.propageFrame == null ? "" : $("projects_out").removeChild(this.propageFrame);//如果容器对象不为空则清除再创建一个新的对象
		removeEventHandler(up_button , "click", upPageEvent);//去除对象的onclick事件(防止对象在页面轮动的时候在进行调用点击事件)
		removeEventHandler(down_button , "click", downPageEvent);
		this.findProPage(pageNum);
	};
	PageSlideObj.prototype.findProPage = function(pageNum){
		var allpage = (pageNum == 1 || pageNum == this.allPageNum) ? 2 : 3;
		this.createSlideFrame(pageNum);
		
		this.pageIndex = pageNum;
		if(this.judgeProject(pageNum)){
			var propage = document.createElement("div");//容器对象元素
			propage.className = "body_frame";
			
			var page = new PageProject(pageNum , propage);
			
			this.arrayProjects.push(page);
			this.findProjects(pageNum , page);//页面对象元素装载(查询数据库)
		}
		
		/*在这里对于当前页面的 下一页&上一页 是否存在进行判断*/
		if(this.judgeProject(pageNum - 1)){
			var propage = document.createElement("div");//容器对象元素
			propage.className = "body_frame";
			
			var page = new PageProject(pageNum - 1 , propage);
			
			this.arrayProjects.push(page);
			this.findProjects(pageNum-1 , page);//页面对象元素装载
		}
		
		if(this.judgeProject(pageNum + 1)){//下一页
			var propage = document.createElement("div");//容器对象元素
			propage.className = "body_frame";
			
			var page = new PageProject(pageNum + 1 , propage);
			
			this.arrayProjects.push(page);
			this.findProjects(pageNum+1 , page);//页面对象元素装载
		}
		
		this.sortProjects(pageNum);//对对象页面按照页面编号排序
		$("projects_out").appendChild(this.propageFrame);
		
		this.slide = new SlideObj("projects_out" , "propageFrame", allpage, this.args, this.tween);
		this.slide.nowIndex = pageNum == 1 ? 0 : 1;
		this.slide.slideRun();
		
		/* 在此处添加一个关于当页面为加载完成无法在点击按钮的操作实现 */
		addEvent(up_button , "click", upPageEvent);
		
		addEvent(down_button , "click", downPageEvent);
	};
	PageSlideObj.prototype.judgeProject = function(pageNum){/*判断指定的页面是否存在在数组对象中*/
		for(var i=0;i<this.arrayProjects.length;i++){
			if(pageNum == this.arrayProjects[i].pro_id || pageNum < 1 || pageNum > this.allPageNum){
				return false;//假如存在
			}
		}
		return true;
	};
	PageSlideObj.prototype.findArrayPros = function(pageNum){/* 根据页面编号查询数组中的对象 */
		for(var i=0 ; i<this.arrayProjects.length; i++){
			if(this.arrayProjects[i].pro_id == pageNum){
				return this.arrayProjects[i];
			}
		}
		
		return null;
	};
	PageSlideObj.prototype.sortProjects = function(pageNum){/* 对于数据页面对象进行排序问题操作处理 */
		if(pageNum == 1){
			this.propageFrame.appendChild(this.findArrayPros(pageNum).pro_page);
			var arrayPros = this.findArrayPros(pageNum+1);
			arrayPros != null ? this.propageFrame.appendChild(arrayPros.pro_page) : "";
		}else if(pageNum == this.allPageNum){
			this.propageFrame.appendChild(this.findArrayPros(pageNum-1).pro_page);
			this.propageFrame.appendChild(this.findArrayPros(pageNum).pro_page);
		}else{
			this.propageFrame.appendChild(this.findArrayPros(pageNum-1).pro_page);
			this.propageFrame.appendChild(this.findArrayPros(pageNum).pro_page);
			this.propageFrame.appendChild(this.findArrayPros(pageNum+1).pro_page);
		}
	};
	PageSlideObj.prototype.setPagingParams = function(pagingFunType , pagingProStage, queryProYear){//设置查询方式索引
		this.pagingFunType = pagingFunType;
		this.pagingProStage = pagingProStage;
		this.queryProYear = queryProYear;
	};
	PageSlideObj.prototype.findProjects = function(pageNum , page){/* 查找页面对象信息使用DWR技术调用后台数据信息 */
		/* 假如该页面对象还未返回，则先调用一个现实页面等待的图像 */
		switch(this.pagingFunType){
			case 1:{
				PagingProject.pagingBySchoolId(pageNum-1 , $("school_id").value, this.pagingProStage, this.queryProYear, function(pageObj){
					for(var i=0;i<pageObj.length;i++){
						var pro = new ProjectInfor(pageObj[i].projectName, pageObj[i].id, pageObj[i].schoolId, pageObj[i].picture, pageObj[i].createrName, pageObj[i].createrId,
									 pageObj[i].partNum, pageObj[i].college, pageObj[i].workload, pageObj[i].hardNum, pageObj[i].projectFile, pageObj[i].stage);
						
						page.pushObj(pro.packagePro());//将对象装载到数组中
					}
					
					page.createPage();//将对象添加到界面上
				});
				break;
			}
			case 2:{
				PagingProject.pagingByCreateName(pageNum-1 , $("school_id").value, $("query_Key").value, this.pagingProStage, this.queryProYear, function(pageObj){
					for(var i=0;i<pageObj.length;i++){
						var pro = new ProjectInfor(pageObj[i].projectName, pageObj[i].id, pageObj[i].schoolId, pageObj[i].picture, pageObj[i].createrName, pageObj[i].createrId,
									 pageObj[i].partNum, pageObj[i].college, pageObj[i].workload, pageObj[i].hardNum, pageObj[i].projectFile, pageObj[i].stage);
						
						page.pushObj(pro.packagePro());//将对象装载到数组中
					}
					
					page.createPage();//将对象添加到界面上
				});
				break;
			}
			case 3:{
				PagingProject.pagingByCollege(pageNum-1 , $("school_id").value, $("query_Key").value, this.pagingProStage, this.queryProYear, function(pageObj){
					for(var i=0;i<pageObj.length;i++){
						var pro = new ProjectInfor(pageObj[i].projectName, pageObj[i].id, pageObj[i].schoolId, pageObj[i].picture, pageObj[i].createrName, pageObj[i].createrId,
									 pageObj[i].partNum, pageObj[i].college, pageObj[i].workload, pageObj[i].hardNum, pageObj[i].projectFile, pageObj[i].stage);
						
						page.pushObj(pro.packagePro());//将对象装载到数组中
					}
					
					page.createPage();//将对象添加到界面上
				});
				break;
			}
			case 4:{
				PagingProject.pagingByProjectName(pageNum-1 , $("school_id").value, $("query_Key").value, this.pagingProStage, this.queryProYear, function(pageObj){
					for(var i=0;i<pageObj.length;i++){
						var pro = new ProjectInfor(pageObj[i].projectName, pageObj[i].id, pageObj[i].schoolId, pageObj[i].picture, pageObj[i].createrName, pageObj[i].createrId,
									 pageObj[i].partNum, pageObj[i].college, pageObj[i].workload, pageObj[i].hardNum, pageObj[i].projectFile, pageObj[i].stage);
						
						page.pushObj(pro.packagePro());//将对象装载到数组中
					}
					
					page.createPage();//将对象添加到界面上
				});
				break;
			}
			case 5:{
				PagingProject.pagingByPartNum(pageNum-1 , $("school_id").value, $("query_Key").value, this.pagingProStage, this.queryProYear, function(pageObj){
					for(var i=0;i<pageObj.length;i++){
						var pro = new ProjectInfor(pageObj[i].projectName, pageObj[i].id, pageObj[i].schoolId, pageObj[i].picture, pageObj[i].createrName, pageObj[i].createrId,
									 pageObj[i].partNum, pageObj[i].college, pageObj[i].workload, pageObj[i].hardNum, pageObj[i].projectFile, pageObj[i].stage);
						
						page.pushObj(pro.packagePro());//将对象装载到数组中
					}
					
					page.createPage();//将对象添加到界面上
				});
				break;
			}
			case 6:{
				PagingProject.pagingByHardNum(pageNum-1 , $("school_id").value, $("query_Key").value, this.pagingProStage, this.queryProYear, function(pageObj){
					for(var i=0;i<pageObj.length;i++){
						var pro = new ProjectInfor(pageObj[i].projectName, pageObj[i].id, pageObj[i].schoolId, pageObj[i].picture, pageObj[i].createrName, pageObj[i].createrId,
									 pageObj[i].partNum, pageObj[i].college, pageObj[i].workload, pageObj[i].hardNum, pageObj[i].projectFile, pageObj[i].stage);
						
						page.pushObj(pro.packagePro());//将对象装载到数组中
					}
					
					page.createPage();//将对象添加到界面上
				});
				break;
			}
		}
	};
	PageSlideObj.prototype.nextProPage = function(){//下一页
		this.findProPage(this.pageIndex+1);
	};
	PageSlideObj.prototype.upProPage = function(){//上一页
		this.findProPage(this.pageIndex-1);
	};
	
	//上一页点击按钮事件函数
	function upPageEvent(){
		removeEventHandler(up_button , "click", upPageEvent);//去除对象的onclick事件(防止对象在页面轮动的时候在进行调用点击事件)
		removeEventHandler(down_button , "click", downPageEvent);
		
		pro.slide.slidePrevious();
		pro.pageNumObj.backPageNum(pro.pageIndex - 1);//更改页面索引按钮样式
		pro.pageNumObj.clearPageNum(pro.pageIndex);
		var up_timer = setInterval(function(){
			if(pro.slide.nowIndex == pro.slide.oldIndex){
				$("projects_out").removeChild(pro.propageFrame);
				pro.upProPage();//自动加载上一页信息
				clearInterval(up_timer);
			}else{
				
			}
		},50);
	}
	
	//下一页点击按钮事件函数
	function downPageEvent(){
		removeEventHandler(down_button , "click", downPageEvent);//去除对象的onclick事件(防止对象在页面轮动的时候在进行调用点击事件)
		removeEventHandler(up_button , "click", upPageEvent);//去除上一页对象的点击事件
		
		pro.slide.slideNext();
		pro.pageNumObj.nextPageNum(pro.pageIndex + 1);//更改页面索引按钮样式
		pro.pageNumObj.clearPageNum(pro.pageIndex);
		var down_timer = setInterval(function(){
			if(pro.slide.nowIndex == pro.slide.oldIndex){//是否移动到下一页
				$("projects_out").removeChild(pro.propageFrame);
				pro.nextProPage();//自动加载下一页信息
				clearInterval(down_timer);
			}else{
				
			}
		},50);
	}
	
	/* 创建一个页面索引对象类 */
	function pagenumObj(frameout , pagenums){
		this.frameout = frameout;
		this.pagenums = pagenums;//pagenums:总页面数
		this.oldPageNum = null;//这个是用于标记上一个对象标记符(这个在功能上是满足了要求的是代码尚不够优美)
		this.numArray = new Array();//用于保存页面编号对象方便索引
	};
	pagenumObj.prototype.createFrame = function(fromnum){//根据页面总数设定fromnum:开始页面编号 
		//var oldPageNum = null;//这个是用于标记上一个对象标记符
		this.clearFrameout();//清除源数据
		
		if(this.pagenums <= 10){
			this.frameout.style.width = 32*this.pagenums + "px";
			for(var i=1; i<=this.pagenums; i++){
				var pagebutton = document.createElement("div");
				if(i == 1){
					pro.pageNumObj.oldPageNum = pagebutton;
					pagebutton.style.background = "#ACACAC";
					pagebutton.style.color = "white";
				}
				
				pagebutton.onmouseover = function(){
					this.style.background = "#ACACAC";
					this.style.color = "white";
				}
				
				pagebutton.onmouseout = function(){
					this.style.background = pro.pageNumObj.oldPageNum == this ? "#ACACAC" : "white";
					this.style.color = pro.pageNumObj.oldPageNum == this ? "white" : "#ACACAC";
				}
				
				pagebutton.onclick = function(){
					if(pro.pageNumObj.oldPageNum != this){
						this.style.background = "#ACACAC";
						this.style.color = "white";
						pro.pageNumObj.oldPageNum.style.background = "white";
						pro.pageNumObj.oldPageNum.style.color = "#ACACAC";
						
						pro.pageNumObj.oldPageNum = this;
						pro.jumpProPage(parseInt(this.innerHTML));
					}
				}
				pagebutton.innerHTML = i;
				
				this.frameout.appendChild(pagebutton);
				this.numArray.push(pagebutton);
			}
		}else{
			this.frameout.style.width = 32*10 + "px";
			for(var i=fromnum; i<fromnum+10; i++){
				var pagebutton = document.createElement("div");
				if(i == fromnum){
					pro.pageNumObj.oldPageNum = pagebutton;
					pagebutton.style.background = "#ACACAC";
					pagebutton.style.color = "white";
				}
				
				pagebutton.onmouseover = function(){
					this.style.background = "#ACACAC";
					this.style.color = "white";
				}
				
				pagebutton.onmouseout = function(){
					this.style.background = pro.pageNumObj.oldPageNum == this ? "#ACACAC" : "white";
					this.style.color = pro.pageNumObj.oldPageNum == this ? "white" : "#ACACAC";
				}
				
				pagebutton.onclick = function(){
					if(pro.pageNumObj.oldPageNum != this){
						this.style.background = "#ACACAC";
						this.style.color = "white";
						pro.pageNumObj.oldPageNum.style.background = "white";
						pro.pageNumObj.oldPageNum.style.color = "#ACACAC";
						
						pro.pageNumObj.oldPageNum = this;//当前对象为旧对象
						pro.jumpProPage(parseInt(this.innerHTML));
					}
				}
				pagebutton.innerHTML = i;
				
				this.frameout.appendChild(pagebutton);
				this.numArray.push(pagebutton);
			}
		}
	};
	pagenumObj.prototype.clearFrameout = function(){//清除元素对象下的所有子元素
		var childs = this.frameout.childNodes;
		
		for(var i=0; i<childs.length; i++){
			this.frameout.removeChild(childs[i--]);//保持索引值一致
		}
	};
	pagenumObj.prototype.nextPageNum = function(pageNum){//下一页一个页面按钮选中
		if((pageNum%10) == 1 && pageNum != 1){//下一页
			
			if(this.judgeExist(pageNum)){//用数组数据装载
				this.clearFrameout();
				for(var i=pageNum; i<(pageNum+10); i++){
					this.frameout.appendChild(this.numArray[i - 1]);
				}
			}else{//创建新数据
				this.createFrame(pageNum);
			}
		}
		pro.pageNumObj.oldPageNum = this.numArray[pageNum - 1];
		this.numArray[pageNum - 1].style.background = "#ACACAC";
		this.numArray[pageNum - 1].style.color = "white";
	};
	pagenumObj.prototype.backPageNum = function(pageNum){//上一页一个页面按钮选中
		if((pageNum%10) == 0 && pageNum != 0){//回到上一页
			this.clearFrameout();
			for(var i=(pageNum-9); i<=pageNum; i++){
				this.frameout.appendChild(this.numArray[i - 1]);
			}
		}
		pro.pageNumObj.oldPageNum = this.numArray[pageNum - 1];
		this.numArray[pageNum - 1].style.background = "#ACACAC";
		this.numArray[pageNum - 1].style.color = "white";
	};
	pagenumObj.prototype.judgeExist = function(pageNum){//判断所要创建的对象元素是否存在
		return this.numArray.length >= pageNum ? true : false;
	};
	pagenumObj.prototype.clearPageNum = function(pageNum){//清除某一个页面按钮选中
		this.numArray[pageNum - 1].style.background = "white";
		this.numArray[pageNum - 1].style.color = "#ACACAC";
	};
	
	/* 创建一个页面时间段显示对象（用于控制当前的毕业年级） */
	function projectYearObj(yearFrame , queryYear){
		this.yearFrame = yearFrame;
		this.queryYear = queryYear;		//需要查询的年份
		
		this.allYears = null;			//显示全部年份
		this.yearObjs = null;			//用于保存全部时间的对象
		this.maxYear = null;			//用于标记课题的最大年份
		this.mimYear = null;			//用于标记课题的最小年份
		this.years = null;				//标记全部年份
		this.yearsArray = new Array();	//年份元素数组用于保存元素当前年份信息内容
	};
	projectYearObj.prototype.initYearObj = function(){
		this.getMaxYear();
		this.getMinYear();
		this.years = this.maxYear - this.minYear + 1;
		
		var title = document.createElement("div");
		title.className = "project_yeartitle";
		title.innerHTML = "毕业时间";
		this.yearFrame.appendChild(title);
		
		this.allYears = document.createElement("div");
		this.allYears.className = "project_yearframe";
		this.allYears.innerHTML = "全部";
		addEvent(this.allYears , "click", this.clickYearAction(0));
		this.yearFrame.appendChild(this.allYears);
		if(this.queryYear == 0){//显示全部数据信息
			this.allYears.style.color = "white";
			this.allYears.style.borderColor = "#d8d7d7";
			this.allYears.style.background = "#d8d7d7 url(images/link_logo.png) no-repeat";
		}
		
		//用于保存全部的具体时间信息内容
		this.yearObjs = document.createElement("div");
		for(var i=this.maxYear; i>=this.minYear; i--){
			var yearObj = document.createElement("div");
			yearObj.className = "project_yearframe";
			yearObj.innerHTML = i;
			
			if(i == this.queryYear){
				yearObj.style.color = "white";
				yearObj.style.borderColor = "#d8d7d7";
				yearObj.style.background = "#d8d7d7 url(images/link_logo.png) no-repeat";
			}
			
			addEvent(yearObj , "click", this.clickYearAction(i));
			this.yearObjs.appendChild(yearObj);
		}
		this.yearFrame.appendChild(this.yearObjs);
	};
	projectYearObj.prototype.getMaxYear = function(){
		//为了防止客户端时间不是正确时间，所以使用获取服务端时间作为准确时间设计(故意保留。作为后门)
		var newTime = new Date();
		//当前属于8月份的话表示是下一年的毕业设计
		this.maxYear = newTime.getMonth()+1 > 7 ? newTime.getFullYear()+1 : newTime.getFullYear();
	};
	projectYearObj.prototype.getMinYear = function(){
		//将使用异步获取当前课题的创建最小时间
		this.minYear = $("minYear").value;
	};
	projectYearObj.prototype.clickYearAction = function(yearNum){
		return function(){
			var url = ifIE ? "../ProjectManagerServlet?type=enter_schoolPros&proYear="+yearNum : "ProjectManagerServlet?type=enter_schoolPros&proYear="+yearNum;
			window.open(url , "_self");
		}
	};
</script>
</head>

<body onload="init()">
<div class="project_body">
	<div id="projects_out">
		<input type="hidden" value="${school_id }" id="school_id"/>
		<input type="hidden" value="${proYear }" id="proYear"/>
		<input type="hidden" value="${minYear }" id="minYear"/>
	</div>
	
	<div id="find_project" title="快速课题查询"></div>
	<div id="project_createyear"></div>
	<div id="up_to_page"></div>
	<div id="down_to_page"></div>
	<div id="all_page_num">
		
	</div>
</div>
</body>
</html>
