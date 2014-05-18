<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	//这样处理的原因是为了保证设计页面与挂到服务器上时样式是相同的
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>GDT毕业设计与管理系统</title>
<link rel="icon" href="images/favicon.ico" type="image/x-icon"></link>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script type="text/javascript" src="js/School_User_CL.js"></script>
<script>
var shortObj = null;//保存
var iframeWindow = null;//iframe对象索引
var old_Iframe_Url = null;
var iframeLinkObj = null;

function init(){
	iframeWindow = window.main_body;//用于索引iframe窗口对象
	//实现异步的jframe加载处理(先启动iframe异步加载->这样有助于整个页面的加载提速)
	loadFiles("SchoolUser/body.jsp" , "main_body", initlizeIframe);
	
	//将用户的真实姓名信息写入cookie
	var nameObj = new userNameObj($("trueName").value);
	nameObj.keepTrueName();
	
	createIndexList();//创建导航条事件对象
	createShort();//创建快速导航工具
	var fillinfor = new fillUserInfor();
	fillinfor.createView();
}

//第一次加载完成Iframe中的url对象后调用处理函数
function initlizeIframe(){
	old_Iframe_Url = iframeWindow.location.href;//保存旧的对象索引
		
	iframeLinkObj = new IframeLinksObj("Student");//创建一个页面管理对象
	var obj = new ButtonLinkObj($("main_page"));
	
	iframeLinkObj.addBLObj(obj);
	obj.addLink(iframeWindow.location.href);//保存当前Iframe窗口中的href路径
	
	setInterval(retrievalUrl , 100);//开启一个监听器对象用于监听浏览器点击返回按钮事件
}

//为了解决关于iframe跳转时button样式没有更改问题(iframe:就是一个window对象是一个子window对象)
//这个是用于检索当浏览器返回到上一页时页面所指的button按钮对象
function retrievalUrl(){
	if(iframeWindow.location.href != old_Iframe_Url){
		var now_Button = iframeLinkObj.getButtonObj(iframeWindow.location.href);//需要指向的目标对象
		
		if((now_Button != null) && (now_Button != old_Button)){
			now_Button.className = "head_link_over";
			
			old_Button.className = "head_link_out";
			old_Button = now_Button;
			old_Iframe_Url = iframeWindow.location.href;//绑定当前的url
		}
	}
}

//创建一个用于保存当前导航栏中点击按钮所引用的Iframe页面的location.url数据
function ButtonLinkObj(btn){
	this.btnobj = btn;
	this.links = new Array();//用于保存对应Button的link连接
}
ButtonLinkObj.prototype.addLink = function(url){
	if(!this.existLink(url)){//假如不存在这条url则保存
		this.links.push(url);
		
		iframeLinkObj.createCookie(iframeLinkObj.userType);
	}
};
ButtonLinkObj.prototype.existLink = function(url){//判断Url是否存在
	for(var i=0; i<this.links.length; i++){
		if(this.links[i] == url){
			return true;
		}
	}	
	return false;
};

//创建一个IframeLinksObj对象用于保存多个ButtonLinkObj对象
//userType:用于保存的用户类型的cookie对象名称
//默认为：Student
function IframeLinksObj(userType){
	this.userType = userType == null || undefined ? "Student" : userType;
	this.BLObj = new Array();//存放ButtonLinkObj对象
	//this.initalizeObj();//初始化加载cookie信息(测试阶段不开启记得后期开启)
}
IframeLinksObj.prototype.addBLObj = function(btnlink){
	this.existBLObj(btnlink) ? "" : this.BLObj.push(btnlink);
};
IframeLinksObj.prototype.existBLObj = function(btn){//判断button是否存在
	for(var i=0; i<this.BLObj.length; i++){
		if(this.BLObj[i].btnobj == btn.btnobj){
			return true;
		}
	}	
	return false;
};
IframeLinksObj.prototype.getBLObj = function(btn){//返回一个ButtonLinkObj对象根据btn检索
	for(var i=0; i<this.BLObj.length; i++){
		if(this.BLObj[i].btnobj == btn){
			return this.BLObj[i];
		}
	}	
	return null;
};
IframeLinksObj.prototype.getButtonObj = function(url){//根据url来检索一个ButtonLinkObj对象
	for(var i=0; i<this.BLObj.length; i++){
		for(var j=0; j<this.BLObj[i].links.length; j++){
			if(this.BLObj[i].links[j] == url){
				return this.BLObj[i].btnobj;//检索到对应的button对象
			}
		}
	}
	
	return null;
};
IframeLinksObj.prototype.toString = function(){//返回该对象的JSON字符串类型
	
	var value = "[";
	for(var i=0 ; i<this.BLObj.length; i++){
		value += "{btn:'"+this.BLObj[i].btnobj.id+"',links:[";
		for(var j=0 ; j<this.BLObj[i].links.length; j++){
			value += (j == (this.BLObj[i].links.length-1) ? "'"+this.BLObj[i].links[j]+"'" : "'"+this.BLObj[i].links[j]+"',");
		}
		value += (i == (this.BLObj.length-1) ? "]}" : "]},");
	}
	value += "]";
	
	return value;
};
IframeLinksObj.prototype.createCookie = function(userType){//创建一个用于保存改用户对象浏览改页面的URL路径以及Button的键值对关系表
	//userType:用于索引的用户类型
	var cookie = new CookieObj();
	
	cookie.setCookie(userType , this.toString(), 7);
};
IframeLinksObj.prototype.getCookie = function(userType){//得到客户端的页面的浏览历史信息
	//userType:用于索引的用户类型
	var cookie = new CookieObj();
	
	return cookie.getCookie(userType);
};
IframeLinksObj.prototype.initalizeObj = function(){//初始化对象模型
	var value = this.getCookie(this.userType);
	if(value != ""){//判断是否存在数据
		var obj = eval(this.getCookie(this.userType));
		
		for(var i=0;i<obj.length;i++){//加载button对象
			var btnObj = new ButtonLinkObj($(obj[i].btn));
			this.BLObj.push(btnObj);//创建对象添加
			
			for(var j=0;j<obj[i].links.length;j++){//加载links对象
				btnObj.links.push(obj[i].links[j]);//添加链接
			}
		}
	}
};

//检验iframe的url页面装载是否完成同时将加载完的页面以及button保存
function waitLoadIframe(loadtimer , btn_obj){
	loadtimer = setInterval(function(){
		if(old_Iframe_Url != iframeWindow.location.href){//是否已加载完新iframe信息
			var button = iframeLinkObj.getBLObj(btn_obj);//得到ButtonLinkObj对象根据按钮对象
			
			if(button == null){
				button = new ButtonLinkObj(btn_obj);
				iframeLinkObj.addBLObj(button);
			}
			
			button.addLink(iframeWindow.location.href);
			old_Iframe_Url = iframeWindow.location.href;
			clearInterval(loadtimer);//加载完成清除定时对象
		}
	} , 100);
}

function createShort(){
	$("open_short_link").onclick = function(evt){
		var event = window.event ? window.event : evt;
		var target = event.target ? event.target : event.srcElement;
		
		if(target.checked && shortObj == null){
			//动态调用函数对象
			loadScript_Css("css/short_Link_Style.css","css",function(){//先调用css文件
				loadScript_Css("js/short_Link.js","javascript",function(){//再调用javascript文件
					shortObj = new create_ShortLinks();
				});
			});
		}else if(!target.checked){
			shortObj.hiddenView();
		}else{
			shortObj.displayView();
		}
	};
}

/* 为索引按钮添加下拉链表对象控件 */
var old_Button = null;//用于绑定上一个点击对象按钮
function createIndexList(){
	var main_obj = new ButtonObj($("main_page"));
	main_obj.createButton();
	main_obj.button.className="head_link_over";
	old_Button = main_obj.button;
	
	/* 其实可以通过实现一个通用类创建 */
	var select_obj = new ButtonObj($("select_page"));
	select_obj.butOverEvent = selectButtonOver;//复写ButtonObj的butOverEvent事件
	select_obj.createButton();
	
	var team_obj = new ButtonObj($("team_page"));
	team_obj.butOverEvent = teamButtonOver;
	team_obj.createButton();
	
	var stage_obj = new ButtonObj($("stage_page"));
	stage_obj.butOverEvent = stageButtonOver;
	stage_obj.createButton();
	
	var user_obj = new ButtonObj($("userinfor_page"));
	user_obj.butOverEvent = userButtonOver;
	user_obj.createButton();
}

//////////////////////////////////////////////////////////////////////////////////////////////
/* 创建一个通用的按钮索引对象 
 * 通过重写类的方法来实现不同的button的各自要求
 */
function ButtonObj(obj){
	this.button = obj;
	this.frameout = null;
	this.overframe = true;//判断鼠标是否移动到对象上
	this.timer = null;//设定时间对象
}
ButtonObj.prototype.createButton = function(){
	addEvent(this.button , "mouseover", this.butOverEvent(this));
	addEvent(this.button , "mouseout", this.butOutEvent(this));
	addEvent(this.button , "click", this.butClickEvent(this));
};
ButtonObj.prototype.butOverEvent = function(obj){/*移入事件*/
	return function(){
		obj.overframe = false;
		obj.button.className = "head_link_over";
	};
};
ButtonObj.prototype.butOutEvent = function(obj){/*移出事件*/
	return function(){
		obj.overframe = true;
		
		setTimeout(function(){/* 这个是为了解决对于移出事件发生时间不匹配问题 */
			if(obj.overframe){
				if(old_Button == obj.button){
					obj.button.className = "head_link_over";
				}else{
					obj.button.className = "head_link_out";
				}
			}
		},100);
		setTimeout(obj.hiddenFrame(obj) , 1000);
	};
};
ButtonObj.prototype.butClickEvent = function(obj){/*点击事件*/
	return function(){
		if(old_Button != obj.button){
			obj.button.className = "head_link_over";
			old_Button.className = "head_link_out";
			
			old_Button = obj.button;
			
			//用于延时等待页面加载完成
			var loadtimer = setInterval(function(){
				if(old_Iframe_Url != iframeWindow.location.href){//是否已加载完新iframe信息
					var button = iframeLinkObj.getBLObj(old_Button);//得到ButtonLinkObj对象根据按钮对象
					
					if(button == null){
						button = new ButtonLinkObj(old_Button);
						iframeLinkObj.addBLObj(button);
					}
					
					button.addLink(iframeWindow.location.href);
					old_Iframe_Url = iframeWindow.location.href;
					clearInterval(loadtimer);//加载完成清除定时对象
				}
			} , 100);
		}
	};
};
ButtonObj.prototype.hiddenFrame = function(obj){
	return function(){
		if(obj.overframe && (obj.frameout != null)){
			obj.frameout.style.display = "none";
		}
	};
};
ButtonObj.prototype.frameOverEvent = function(obj){/*移动到frameout对象中的事件*/
	return function(){
		obj.timer != null ? clearTimeout(obj.timer) : "";
		obj.overframe = false;
		obj.button.className = "head_link_over";
	};
};
ButtonObj.prototype.frameOutEvent = function(obj){
	return function(){
		obj.timer = setTimeout(function(){
			obj.overframe = true;//需要使用全局变量引用
			obj.frameout.style.display = "none";
			
			if(old_Button == obj.button){
				obj.button.className = "head_link_over";
			}else{
				obj.button.className = "head_link_out";
			}
		},100);
	};
};
ButtonObj.prototype.createChild = function(name , url, target){//创建父按钮下的子按钮对象(name:子按钮名称,url:子按钮跳转对象)
	var link = document.createElement("a");
	link.innerHTML = name;
	link.href = url;
	link.target = target;
	
	var loadtimer;
	link.onclick = waitLoadIframe(loadtimer , this.button);//创建一个点击对象处理模式
	
	return link;
};


//子按钮对象
function ChildLinkObj(name , url, target, parent){
	this.name = name;
	this.url = url;
	this.target = target;
	this.parent = parent;//父节点按钮对象
}
ChildLinkObj.prototype.createLink = function(){
	var link = document.createElement("a");
	link.innerHTML = this.name;
	link.href = this.url;
	link.title = this.name;
	link.target = this.target;
	
	addEvent(link , "click", this.clickEvent(this));
	
	return link;
};
ChildLinkObj.prototype.clickEvent = function(obj){
	return function(){//因为为了满足实现为每个按钮点击事件都配置一个定时控制器timer
		obj.parent.className = "head_link_over";
		old_Button.className = "head_link_out";
		
		old_Button = obj.parent;
		
		var loadtimer = setInterval(function(){
			if(old_Iframe_Url != iframeWindow.location.href){//是否已加载完新iframe信息
				var button = iframeLinkObj.getBLObj(obj.parent);//得到ButtonLinkObj对象根据按钮对象
				
				if(button == null){
					button = new ButtonLinkObj(obj.parent);
					iframeLinkObj.addBLObj(button);
				}
				
				button.addLink(iframeWindow.location.href);
				old_Iframe_Url = iframeWindow.location.href;
				clearInterval(loadtimer);//加载完成清除定时对象
			}
		} , 100);
	};
};

function selectButtonOver(obj){
	return function(){
		obj.overframe = false;
		obj.button.className = "head_link_over";
		
		if(obj.frameout == null){
			obj.frameout = document.createElement("div");
			obj.frameout.className = "menu_links_frameout";
			obj.frameout.style.position = "absolute";
			obj.frameout.style.top = getOffsetTop(obj.button) + 41 + "px";
			obj.frameout.style.left = getOffsetLeft(obj.button) + 3 + "px";
			addEvent(obj.frameout , "mouseover", obj.frameOverEvent(obj));
			addEvent(obj.frameout , "mouseout", obj.frameOutEvent(obj));
			
			var frame = document.createElement("div");
			frame.className = "menu_links_frame";
			
			//ChildLinkObj必须是网站内部的url对象不然不好检索
			var link0 = new ChildLinkObj("全部课题" , "ProjectManagerServlet?type=enter_auditedPros", "main_body", obj.button).createLink();
			var link1 = new ChildLinkObj("可选课题" , "SchoolUser/stuSelectProjects.jsp", "main_body", obj.button).createLink();
			
			frame.appendChild(link0);
			frame.appendChild(link1);
			
			obj.frameout.appendChild(frame);
			document.body.appendChild(obj.frameout);
		}else{
			obj.frameout.style.display = "block";
		}
	};
}


function teamButtonOver(obj){
	return function(){
		obj.overframe = false;
		obj.button.className = "head_link_over";
		
		if(obj.frameout == null){
			obj.frameout = document.createElement("div");
			obj.frameout.className = "menu_links_frameout";
			obj.frameout.style.position = "absolute";
			obj.frameout.style.top = getOffsetTop(obj.button) + 41 + "px";
			obj.frameout.style.left = getOffsetLeft(obj.button) + 3 + "px";
			addEvent(obj.frameout , "mouseover", obj.frameOverEvent(obj));
			addEvent(obj.frameout , "mouseout", obj.frameOutEvent(obj));
			
			var frame = document.createElement("div");
			frame.className = "menu_links_frame";
			
			var loading = document.createElement("div");
			loading.className = "loading";
			loading.innerHTML = "loading...";
			frame.appendChild(loading);
			
			obj.frameout.appendChild(frame);
			document.body.appendChild(obj.frameout);
			
			/* 设置一个团队信息获取异步访问 */
			var url = "TeamManageServlet?type=check_enter_team";
			var teamRequest = newXMLHttpRequest();
			teamRequest.open("post" , url, true);
			teamRequest.onreadystatechange = setTeamInfor(teamRequest , frame, obj);//异步Ajax获取阶段名称数据
			teamRequest.send(null);
		}else{
			obj.frameout.style.display = "block";
		}
	};
}
function setTeamInfor(teamRequest , frame, obj){//设置阶段名称信息
	return function(){
		if(teamRequest.readyState == 1 || teamRequest.readyState == 2 || teamRequest.readyState == 3){
		
		}else if(teamRequest.readyState == 4){
			if(teamRequest.status == 200){
				var stageTitles = teamRequest.responseText;
				
				frame.removeChild(frame.childNodes[0]);//删除等待对象子元素
				if(stageTitles == 0){//队长
					var link0 = new ChildLinkObj("团队人员信息" , "TeamManageServlet?type=query_teamers_infor", "main_body", obj.button).createLink();
					var link1 = new ChildLinkObj("团队管理" , "TeamManageServlet?type=manage_teamers_infor", "main_body", obj.button).createLink();
					var link2 = new ChildLinkObj("所选课题" , "TeamManageServlet?type=team_project_infor", "main_body", obj.button).createLink();
					
					frame.appendChild(link0);
					frame.appendChild(link1);
					frame.appendChild(link2);
				}else if(stageTitles == 1){
					var link0 = new ChildLinkObj("团队人员信息" , "TeamManageServlet?type=query_teamers_infor", "main_body", obj.button).createLink();
					var link1 = new ChildLinkObj("所选课题" , "TeamManageServlet?type=team_project_infor", "main_body", obj.button).createLink();
					
					frame.appendChild(link0);
					frame.appendChild(link1);
				}else{
					var loading = document.createElement("div");
					loading.className = "loading";
					loading.innerHTML = "<span style='color:red'>还未选择课题...</span>";
					frame.appendChild(loading);
				}
			}
		}
	};
}

/* 后期这些数据都是通过使用Ajax技术调用后台获取的 */
function stageButtonOver(obj){
	return function(){
		obj.overframe = false;
		obj.button.className = "head_link_over";
		
		if(obj.frameout == null){
			obj.frameout = document.createElement("div");
			obj.frameout.className = "menu_links_frameout";
			obj.frameout.style.position = "absolute";
			obj.frameout.style.top = getOffsetTop(obj.button) + 41 + "px";
			obj.frameout.style.left = getOffsetLeft(obj.button) + 3 + "px";
			obj.frameout.style.width = "360px";
			obj.frameout.style.zIndex = 100;
			addEvent(obj.frameout , "mouseover", obj.frameOverEvent(obj));
			addEvent(obj.frameout , "mouseout", obj.frameOutEvent(obj));
			
			var url = "StageManageServlet?type=query_team_stages";
			
			var frame = document.createElement("div");//容器对象
			frame.className = "menu_links_frame";
			frame.style.width = "350px";
			frame.style.minHeight = "10px";
			/* 延时等待画面 */
			var loading = document.createElement("div");
			loading.className = "loading";
			loading.innerHTML = "loading...";
			frame.appendChild(loading);
			
			var stageRequest = newXMLHttpRequest();
			stageRequest.open("post" , url, true);
			stageRequest.onreadystatechange = setStageName(stageRequest , frame, obj);//异步Ajax获取阶段名称数据
			stageRequest.send(null);
			
			obj.frameout.appendChild(frame);
			document.body.appendChild(obj.frameout);
		}else{
			obj.frameout.style.display = "block";
		}
	};
}
function setStageName(stageRequest , frame, obj){//设置阶段名称信息
	return function(){
		if(stageRequest.readyState == 1 || stageRequest.readyState == 2 || stageRequest.readyState == 3){
		
		}else if(stageRequest.readyState == 4){
			if(stageRequest.status == 200){
				var stageObjs = eval(stageRequest.responseText);
				
				if(stageObjs != null){
					frame.removeChild(frame.childNodes[0]);//删除等待对象子元素
					for(var i=0; i<stageObjs.length; i++){
						//创建一个连接对象（同时绑定的父节点对象，用户浏览器返回上一页是索引）
						var link = new ChildLinkObj(stageObjs[i].stageName , "StageManageServlet?type=query_team_stage&stageId="+stageObjs[i].stageId, "main_body", obj.button).createLink();
						frame.appendChild(link);
					}
				}
			}
		}
	};
}

function userButtonOver(obj){
	return function(){
		obj.overframe = false;
		obj.button.className = "head_link_over";
		
		if(obj.frameout == null){
			obj.frameout = document.createElement("div");
			obj.frameout.className = "menu_links_frameout";
			obj.frameout.style.position = "absolute";
			obj.frameout.style.top = getOffsetTop(obj.button) + 41 + "px";
			obj.frameout.style.left = getOffsetLeft(obj.button) + 3 + "px";
			addEvent(obj.frameout , "mouseover", obj.frameOverEvent(obj));
			addEvent(obj.frameout , "mouseout", obj.frameOutEvent(obj));
			
			var frame = document.createElement("div");
			frame.className = "menu_links_frame";
			
			var link0 = new ChildLinkObj("用户信息查看" , "UserManageServlet?type=student_user_infor", "main_body", obj.button).createLink();
			var link1 = new ChildLinkObj("用户信息更改" , "UserManageServlet?type=come_update_student", "main_body", obj.button).createLink();
			var link2 = new ChildLinkObj("用户密码更改" , "SchoolUser/scuserPWUpdate.jsp", "main_body", obj.button).createLink();
			
			frame.appendChild(link0);
			frame.appendChild(link1);
			frame.appendChild(link2);
			
			obj.frameout.appendChild(frame);
			document.body.appendChild(obj.frameout);
		}else{
			obj.frameout.style.display = "block";
		}
	};
}

/*
 * 实现用户登入时自检用户是否已填写完用户信息（假如没有则跳出填写信息页面，使用拖拽框架）
 * true:这个表示已经填写
 * false:这个未填写详细信息
 */
var logonWindow = null;
function fillUserInfor(){//填写用户详细信息
	this.ifDetail = $("ifDetail").value == "T" ? true : false;
	this.iframeObj = null;
}
fillUserInfor.prototype.createView = function(){
	if(!this.ifDetail){
		this.iframeObj = document.createElement("iframe");
		this.iframeObj.style.width = "100%";
		this.iframeObj.style.height = "700px";
		this.iframeObj.style.border = "0px none";
		this.iframeObj.src = "SchoolUser/studentLogon.jsp";
		
		var margin_Left = (document.documentElement.clientWidth - 600)/2;
		var title = new Window_titleview(null , null, new Window_title("填写学生用户详细信息(<span style='color:red'>*</span>为必填项)"), null, null, false, null, false, null, false);//设置标题信息
		var frame = new Window_frame(600 , 700, 10, margin_Left, null, null, null, null, null, true);
		
		logonWindow = new moveWindow(frame , title, false);
		logonWindow.create_View();
		logonWindow.Win_view.add_Child(this.iframeObj);
	}
}

//提供一个给予子页面调用关闭moveWindow的函数
function closeFillUserWindow(){
	logonWindow.closeWindow();
	logonWindow.Win_cover.close_Cover();
}
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
	background: #fff;
}

.main_frame_top{
	width:100%;
	height:155px;
	overflow:hidden;
}
#header_frame{
	width:100%;
	height:114px;
	margin:0 auto;
	background:#19446a url(images/log2.png) no-repeat 4% 50%;
}
#header_frame #school_name{
	width:1050px;
	height:50px;
	/*这个后期会自动计算长度以及位置的javascript确定*/
	float:right;
	margin-top:25px;
	background:#FFFFFF url(images/school_name.jpg) 10% 0% no-repeat;
}

#header_menu_frame {
	clear: both;
	width: 100%;
	height: 41px;
	margin: 0 auto;
	overflow:hidden;
	background: url(images/templatemo_menu_bg.jpg) repeat-x;
}

#header_menu {
	width: 980px;
	height: 41px;
	margin: 0 auto;
}
#header_menu .short_link{
	float:right;
	margin-top:10px;
}
.short_link span{
	font-size:14px;
	color:white;
}

#header_menu ul {
	float:left;
	margin: 0 0 0 28px;
	padding: 0px;
	list-style: none;
}

#header_menu ul li {
	padding: 0px;
	margin: 0px;
	display: inline;
}
.head_link_over{
	float: left;
	display: block;
	height: 22px;
	width: 128px;
	padding: 13px 0 0 0;
	background:url(images/templatemo_menu_hover.jpg) bottom no-repeat;
	text-align: center;
	font-size: 14px;
	text-decoration: none;
	color: #000;	
	font-weight: bold;
	outline: none;
}
.head_link_out{
	float: left;
	display: block;
	height: 22px;
	width: 128px;
	padding: 13px 0 0 0;
	background: url(images/templatemo_menu.jpg) bottom no-repeat;
	text-align: center;
	font-size: 14px;
	text-decoration: none;
	color: #FFF;	
	font-weight: bold;
	outline: none;
}

.menu_links_frameout{
	width:122px;
	height:auto;
	background:#C9C4C0;
	background:rgba(201,196,192,0.4);
}
.menu_links_frame{
	width:112px;
	height:auto;
	margin:5px;
	overflow:hidden;
	background:#FFFFFF;
	background:rgba(255,255,255,0.8);
}
.menu_links_frame a{
	width:112px;
	height:30px;
	display:block;
	color:#AEA69F;
	cursor:pointer;
	float:left;
	font-size:12px;
	text-decoration:none;
	text-overflow:ellipsis;
	text-align:center;
	line-height:30px;
}
.menu_links_frame a:hover{
	color:#5A534C;
}
.menu_links_frame .loading{
	width:100%;
	height:30px;
	line-height:30px;
	text-align:center;
}

.main_frame_body{
	width:100%;
	height:auto;
}

/* 网页底部样式 */
.main_frame_foot{
	width:100%;
	height:50px;
}
#footer_view {
	width: 100%;
	height: 50px;
	margin: 0 auto;
	background: #111d28;
	overflow:hidden;
}

#footer_frame {
	width: 920px;
	padding: 17px;
	margin: 0 auto;
	color: #828c96;
	overflow:hidden;
	background: url(images/templatemo_footer_bg.jpg) bottom center no-repeat
}

.footer_email{
	float:right;
	text-align:center;
}
.footer_email a{
	color:white;
	text-decoration:none;
}
.footer_links{
	float:left;
}
.footer_links a{
	color:#828C96;
	text-decoration:none;
}
.footer_links a:hover{
	color:white;
}
</style>
</head>

<body onload="init()">
	<input type="hidden" id="ifDetail" value="${ifDetail }"/>
	<input type="hidden" id="trueName" value="${user_trueName }"/>
	<!-- 头部信息 -->
	<div class="main_frame_top">
		<div id="header_frame">
			<div id="school_name"></div>
		</div>
		<div id="header_menu_frame">   
		    <div id="header_menu">
		        <ul>
		            <li><a href="SchoolUser/body.jsp" id="main_page" target="main_body">主页</a></li>
		            <li><a href="ProjectManagerServlet?type=enter_auditedPros" id="select_page" class="head_link_out" target="main_body">毕业课题选择</a></li>
		            <li><a href="TeamManageServlet?type=query_teamers_infor" id="team_page" class="head_link_out" target="main_body">团队信息</a></li>
		            <li><a href="#" id="stage_page" class="head_link_out" target="main_body">阶段性管理</a></li>
		            <li><a href="UserManageServlet?type=student_user_infor" id="userinfor_page" class="head_link_out" target="main_body">用户基本信息</a></li>
		        </ul>  	
				<div class="short_link">
					<span>快捷导航</span>&nbsp;&nbsp;<input id="open_short_link" type="checkbox"/>
				</div>
		    </div>
		</div> 
	</div>
	
	<!-- 主体部分用于页面的部分刷新更改 -->
	<div class="main_frame_body">
		<iframe src="" name="main_body" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" width="100%" height="600px" id="main_body"></iframe>
	</div>
	
	<!-- 尾部信息 -->
	<div class="main_frame_foot">
		<div id="footer_view">
			<div id="footer_frame">
				<div class="footer_links">
					<a href="index.jsp" target="main_body">主页</a> <span>|</span> 
					<a href="about.html">在线客服</a> <span>|</span> 
					<a href="#">功能手册</a> <span>|</span>
					<a href="clients.html">关于我们</a>
				</div>
				<div class="footer_email">
					Copyright © 2013 <a href="#">MichaelZhaoZero@gmail.com</a>
				</div>
		    </div>
		</div>
	</div>
</body>
</html>
