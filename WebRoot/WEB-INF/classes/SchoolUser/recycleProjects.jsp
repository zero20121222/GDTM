<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>课题回收站</title>
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
	.recover_project{
		width:30px;
		height:30px;
		float:left;
		cursor:pointer;
		background:url(images/add_to_select.png);
	}
	.add_to_dustbin{
		width:30px;
		height:30px;
		float:left;
		cursor:pointer;
		background:url(images/delete_project_stage.png) no-repeat 50%;
	}
	.delete_Frame{
		width:400px;
		height:150px;
	}
	.delete_picture{
		width:60px;
		height:60px;
		float:left;
		margin:20px 0px 10px 20px;
	}
	.delete_infor{
		float:left;
		width:300px;
		height:100px;
		
		margin:15px 0px 10px 10px;
	}
	.question_infor{
		width:300px;
		margin-top:10px;
		overflow:hidden;
		line-height:25px;
		overflow:hidden;
		text-overflow:ellipsis;
		white-space:nowrap;
		font-size:14px;
		font-family:"黑体";
	}
	.question_result{
		width:300px;
		height:20px;
		font-size:12px;
		line-height:20px;
		text-align:center;
	}
	.delete_buttons{
		width:300px;
		height:35px;
	}
	.deleteButton{
		width:102px;
		height:29px;
		float:left;
		text-align:center;
		
		font-size:13px;
		font-weight:bold;
		line-height:29px;
		color:white;
		margin:5px 0px 0px 25px;
		cursor:pointer;
		background:url(images/frame_button0.png) no-repeat;
	}
	.deleteButton:hover{
		background:url(images/frame_button1.png) no-repeat;
	}
	.pro_select{
		width:30px;
		height:30px;
		float:left;
		cursor:pointer;
		background:url(images/pro_select.png);
	}
	.pro_update{
		width:30px;
		height:30px;
		float:left;
		cursor:pointer;
		background:url(images/project_update_button.png) no-repeat 50%;
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
</style>
<script>
	var up_button = null;//为了提高效率加快按钮的索引速度使用全局变量来控制
	var down_button = null;
	var pro = null;
	function init(){
		suit_Page();
		createButtonEvent();
		
		new PagingFrame().createView();
	}
	
	//设定按钮事件对象
	function createButtonEvent(){
		up_button = $("up_to_page");
		down_button = $("down_to_page");
		
		up_button.onmouseover = function(){
			up_button.style.opacity = "1"; 
		}
		up_button.onmouseout = function(){
			up_button.style.opacity = "0.2"; 
		}
	
		down_button.onmouseover = function(){
			down_button.style.opacity = "1"; 
		}
		down_button.onmouseout = function(){
			down_button.style.opacity = "0.2"; 
		}
	}
	
	/*
	 * 创建一个提示信息框：用于提示用户是否允许删除当前课题
	 */
	var DeleteWindow = null;
	
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
		}else if(this.pro_stage == "D"){
			pro_stage_view.style.background = "url(images/pro_stage_delete.png) no-repeat 50%";
		}
		
		var pro_picture = document.createElement("div");
		pro_picture.className = "pro_picture";
		var url = this.pro_picture == "null" ? "images/upload_file.png" : "ProjectInfor/"+this.pro_schoolId+"/"+this.pro_userid+"/"+this.pro_picture;
		pro_picture.style.background = "url("+url+") 50% 50% no-repeat";
		
		var pro_infor = document.createElement("div");
		pro_infor.className = "pro_infor";
		
		/* 为数据添加事件处理操作 */
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
						
		var recover_project = document.createElement("div");
		recover_project.className = "recover_project";
		recover_project.title = "还原课题";
		addEvent(recover_project , "click", this.recoverProject(this.pro_id));
			  
		var add_to_dustbin = document.createElement("div");
		add_to_dustbin.className = "add_to_dustbin";
		add_to_dustbin.title = "删除课题";
		addEvent(add_to_dustbin , "click", this.deleteProject(this));
		
		var pro_select = document.createElement("div");
		pro_select.className = "pro_select";
		pro_select.title = "详细信息";
		addEvent(pro_select , "click", this.showDetailProject(this.pro_id));
		
		frame_body.appendChild(pro_picture);
		frame_body.appendChild(pro_infor);
		pro_frame.appendChild(frame_title);
		pro_frame.appendChild(frame_body);
		pro_frame.appendChild(pro_stage_view);
		pro_frameout.appendChild(pro_frame);
		
		pro_frameout.appendChild(recover_project);
		pro_frameout.appendChild(pro_select);
		pro_frameout.appendChild(add_to_dustbin);
		
		return pro_frameout;//返回一个对象框架
	};
	ProjectInfor.prototype.recoverProject = function(pro_id){//恢复当前处于删除状态的课题信息内容
		return function(){
			var url = ifIE ? "../ProjectManagerServlet?type=recover_project&project_id="+pro_id : "ProjectManagerServlet?type=recover_project&project_id="+pro_id;
			window.open(url , "_self");
		}
	};
	ProjectInfor.prototype.showDetailProject = function(pro_id){//显示课题的详细信息内容(根据课题编号查询课题详细信息内容)
		return function(){
			var url = ifIE ? "../ProjectManagerServlet?type=query_project_inforshow&project_id="+pro_id : "ProjectManagerServlet?type=query_project_inforshow&project_id="+pro_id;
			window.open(url , "_self");
		}
	};
	ProjectInfor.prototype.closeDelete = function(parentObj){//重写关闭事件
		return function(){  
			if(!parentObj.getParentObj().Win_closeC){
				parentObj.getParentObj().Win_cover.close_Cover();
			}
			
			parentObj.getParentObj().closeWindow();
			
			//清楚关闭提示框
			DeleteWindow = null;
		};
	};
	ProjectInfor.prototype.createDeleteFrame = function(){
		var deleteFrame = document.createElement("div");
		deleteFrame.className = "delete_Frame";
		
		//左侧课题图片显示
		var delete_picture = document.createElement("div");
		delete_picture.className = "delete_picture";
		delete_picture.style.background = "url(images/system_warning.png) 50% 50% no-repeat";
		
		
		//请求信息显示
		var delete_infor = document.createElement("div");
		delete_infor.className = "delete_infor";
		
		var question_infor = document.createElement("div");
		question_infor.className = "question_infor";
		question_infor.innerHTML = "<span style='color:red;'>警告:</span>课题删除后将无法复原，你确定要删除？";
		
		//请求信息处理
		var question_result = document.createElement("div");
		question_result.className = "question_result";
		
		//处理按钮
		var delete_buttons = document.createElement("div");
		delete_buttons.className = "delete_buttons";
		
		var deleteButton = document.createElement("div");
		deleteButton.innerHTML = "删除";
		deleteButton.className = "deleteButton";
		addEvent(deleteButton , "click", this.deleteAction(this , question_result));
		
		var cancelButton = document.createElement("div");
		cancelButton.innerHTML = "取消";
		cancelButton.className = "deleteButton";
		addEvent(cancelButton , "click", this.cancelAction);
		
		deleteFrame.appendChild(delete_picture);
		delete_infor.appendChild(question_infor);
		delete_infor.appendChild(question_result);
		delete_buttons.appendChild(deleteButton);
		delete_buttons.appendChild(cancelButton);
		delete_infor.appendChild(delete_buttons);
		deleteFrame.appendChild(delete_infor);
		return deleteFrame;
	};
	ProjectInfor.prototype.deleteAction = function(projectModel , question_result){//将课题删除操作
		return function(){
			//使用Ajax技术异步的访问后台数据
			var url = "ProjectManagerServlet?type=delete_totally&project_id="+projectModel.pro_id;
			
			//请求等待
			question_result.style.display = "block";
			question_result.style.color = "green";
			question_result.innerHTML = "系统正在删除课题请等待...";
			
			var deleteRequest = newXMLHttpRequest();
			deleteRequest.open("post" , url, true);
			deleteRequest.onreadystatechange = projectModel.deleteProjectQuestion(deleteRequest , projectModel, question_result);
			
			deleteRequest.send(null);
		}
	};
	ProjectInfor.prototype.deleteProjectQuestion = function(deleteRequest , projectModel, question_result){
		return function(){
			if(deleteRequest.readyState == 1 || deleteRequest.readyState == 2 || deleteRequest.readyState == 3){
				
			}else if(deleteRequest.readyState == 4){
				if(deleteRequest.status == 200){
					var result = Boolean(deleteRequest.responseText);
					
					if(result){
						//删除成功
						question_result.innerHTML = "课题已完全删除！";
						
						//关闭提示框
						projectModel.cancelAction();
						
						//删除成功跳转到垃圾回收站
						window.open("SchoolUser/recycleProjects.jsp" , "_self");
					}else{
						//删除失败
						question_result.style.color = "red";
						question_result.innerHTML = "课题删除失败！";
					}
				}
			}else{
				//系统异常
				question_result.style.color = "red";
				question_result.innerHTML = "系统异常请再次尝试...";
			}
		}
	};
	ProjectInfor.prototype.cancelAction = function(){//关闭显示框架
		if(!DeleteWindow.Win_closeC){
			DeleteWindow.Win_cover.close_Cover();
		}
		
		DeleteWindow.closeWindow();
		
		//清楚关闭提示框
		DeleteWindow = null;
	};
	ProjectInfor.prototype.deleteProject = function(projectModel){//将该毕业课题放到回收站中
		return function(){
			if(DeleteWindow == null){
				var titleClose = new Window_close();
				//绑定关闭事件绑定
				titleClose.close_Click = projectModel.closeDelete;
				
				//设置标题信息
				var title = new Window_titleview(null , null, new Window_title("删除课题《"+projectModel.pro_title+"》信息"), null, null, false, null, null, titleClose, null);
				
				var margin_Left = (parent.document.body.clientWidth - 400)/2;
				var frame = new Window_frame(400 , 150, 100, margin_Left, null, null, null, null, null, true);
				
				DeleteWindow = new moveWindow(frame , title, false, null, null, null, false, null, null, null);
				DeleteWindow.create_View();
				DeleteWindow.Win_view.add_Child(projectModel.createDeleteFrame());
			}
		}
	};
	
	
	
	/*
	 * 分页操作处理组件
	 */
	function PagingFrame(){}
	PagingFrame.prototype.createView = function(){
		//先获取分页参数信息然后再显示(这个是一个默认的分页对象)->显示全部分页数据
		PagingProject.getPageNumberByCreateId($("teacher_id").value , "D", 0, function(pageParams){
            pro = new PageSlideObj(0 , pageParams.pagingNumbers);
			pro.initializeObj();
			pro.findProPage(1);
		});
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
			if(this.pro_infor.length > 0){
				for(var i=0;i<this.pro_infor.length;i++){
					this.pro_page.appendChild(this.pro_infor[i]);//装载对象到页面中去
				}
			}else{
				var promptWin = new promptWindow();
				promptWin.confirmButtonEvent = this.errorEvent(promptWin);
				promptWin.createConfirmView("<span style='color:red;'>您的课题回收站当前是空的！</span>" , "确定");	
			}
		}catch(error){
			alert(error);
		}
	};
	PageProject.prototype.errorEvent = function(promptWin){
		return function(){
			promptWin.closeWindow();
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
	PageSlideObj.prototype.findProjects = function(pageNum , page){/* 查找页面对象信息使用DWR技术调用后台数据信息 */
		/* 假如该页面对象还未返回，则先调用一个现实页面等待的图像 */
		/*  显示全部的分页数据信息 */
		PagingProject.pagingByCreateId(pageNum-1 , $("teacher_id").value, "D", 0, function(pageObj){
			for(var i=0;i<pageObj.length;i++){
				var pro = new ProjectInfor(pageObj[i].projectName, pageObj[i].id, pageObj[i].schoolId, pageObj[i].picture, pageObj[i].createrName, pageObj[i].createrId,
							 pageObj[i].partNum, pageObj[i].college, pageObj[i].workload, pageObj[i].hardNum, pageObj[i].projectFile, pageObj[i].stage);
				
				page.pushObj(pro.packagePro());//将对象装载到数组中
			}
			
			page.createPage();//将对象添加到界面上
		});
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
</script>
</head>

<body onload="init()">
<div class="project_body">
	<div id="projects_out">
		<input type="hidden" value="${user_id }" id="teacher_id"/>
	</div>
	
	<div id="up_to_page"></div>
	<div id="down_to_page"></div>
	<div id="all_page_num"></div>
</div>
</body>
</html>