<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
<title>GDT毕业设计与管理系统 </title>
<link rel="icon" href="images/favicon.ico" type="image/x-icon"></link>
<meta http-equiv="content-type" content="application/xhtml; charset=UTF-8" />
<script type="text/javascript" src="js/Fade_Slide.js"></script>
<style>
	*{
		margin: auto;
		padding: 0;
	}
	body{
		background:#02507d; 
		font-family:arial; 
		font-size:12px; 
		color:#ffffff;
		text-align:center;
	}
	a{
		text-decoration:none;
	}
	a:focus {
		outline:none;
	}
	
	#main_body{
		width:942px;
		margin-top:20px;
		text-align:left;
		padding-bottom:15px;
	}
	/*头部样式*/
	#header_top{
		width:942px;
		height:18px;
		background:url(images/header-top_bg.png) no-repeat;
	}
	#header_bottom{
		width:942px;
		height:19px;
		background:url(images/header-bottom_bg.png) no-repeat;
	}
	#header_body{
		height:265px;
		background:url(images/header_bg.png) repeat-x;
		padding-left:20px;
		padding-right:20px;
	}
	#header{
		height:301px;
		text-transform:uppercase;
		color:#4390c3;
	}
	#header_left{
		width:320px;
		padding-left:5px;
		float:left;
		text-align:left;
	}
	#header_right{
		float:right;
	}
	
	#header_left{
		width:250px;
		height:265px;
		padding-left:5px;
		float:left;
		text-align:center;
	}
	#logo{
		width:227px;
		height:61px;
	}
	.logo_gdt{
		width:207px;
		height:66px;
		background:url(images/log0.png);
	}
	#logo_divider{
		margin-top:5px;
		height:2px;
		background:url("images/logo_divider.png");
	}
	
	/*链接样式设计*/
	#menu{
		list-style-type:none;
		color:#B69E6D;
		padding-top:35px;
		position:relative;
	}
	#menu li{
		list-style-type:none;
		font-size:16px;
		font-weight:bold;
		line-height:30px;
		width:156px;
		height:30px;
		margin-bottom:2px;
		background:url("images/menu_li.png") no-repeat;
	}
	#menu a{
		color:#B69E6D;
	}
	#menu a:hover{
		color:#DBDBDB;
	}
	
	
	#show_view{
		width:575px;
		height:265px;
		position:relative;
	}
	#slide_ps{
		width:570px;
		height:260px;
		margin-left:0px;
		overflow:hidden;
		
		/*background:url("images/pictures.jpg");*/
		border-radius:5px;
		box-shadow:2px 2px 2px #000;
	}
	#fade_ps{
		width:570px;
		height:260px;
		margin-left:0px;
		overflow:hidden;
		display:none;
		
		/*background:url("images/pictures.jpg");*/
		border-radius:5px;
		box-shadow:2px 2px 2px #000;
	}
	/*
	#all_picture{
		overflow:hidden;
		width:2280px;
	}
	#all_picture img{
		width:570px;
		height:260px;
		float:left;
	}*/

	#view_numbers{
		height:20px;
		line-height:20px;
		
		position:absolute;
		left:210px;
		top:240px;
		z-index:10000;
	}
	#view_numbers div{
		width:30px;
		height:10px;
		
		cursor:pointer;
		margin-top:2px;
		margin-right:5px;
		float:left;
		background:black;
		border-radius:3px;
		border:1px solid white;
	}
	
	
	#chang_headps{
		float:right;
		width:20px;
		height:auto;
		margin-bottom:0px;
	}
	#chang_headps div{
		padding-top:5px;
		padding-bottom:5px;
		margin-bottom:1px;
		margin-right:1px;
		text-align:center;
		color:#D0D0D0;
		word-wrap:break-word;
		overflow:hidden;
		cursor:pointer;
		background:#EAEAEA;
		
		border-radius:3px;
		box-shadow:2px 2px 2px #BBBBBB;
	}
	#chang_headps .click_div{
		color:#828282;
		background:#D5D5D5;
	}
	#chang_headps div:hover{
		color:#828282;
		background:#D5D5D5;
	}
	
	#content_body{
		background:url(images/content_bg.png) no-repeat;
		text-align:left;
		padding:30px 20px 0px 20px;
		margin-left:0px;
		overflow:hidden;
	}
	#left_content{
		float:left;
		width:572px;
		font-size:13px;
	}
	#left_content li{
		list-style-image:url(images/li_arrow.png);
		padding-bottom:5px;
	}
	#content_body .headings{
		font-size:16px;
		color:#ffffff;
		padding-bottom:4px;
		border-bottom:1px dashed #053d5e;
		margin-bottom:12px;
		font-weight:bold;
	}
	#content_body .headings .heading_news{
		margin-left:10px;
		color:red;
		font-style:oblique;
		font-weight:bold;
	}
	#left_content .school_province{
		width:560px;
		height:auto;
		overflow:hidden;
		margin:6px;
	}
	#left_content .province{
		width:100px;
		height:30px;
		background:rgba(224,224,224,0.5);
		float:left;
		line-height:30px;
		text-align:center;
		margin:5px;
		cursor:pointer;
		
		border-radius:3px;
		
		font-size:14px;
		font-weight:bold;
		color:white;
	}
	#left_content .province:hover{
		color:#8D8D8D;
		background:white;
		box-shadow:2px 2px 2px #BBBBBB;
	}
	
	/*右边的样式*/
	#right_content{
		float:right;
		width:298px;
		color:#ffffff;
		font-size:13px;
		text-align:left;
	}
	/*295 149*/
	#new_information{
		background:url(images/new_information.png) no-repeat;
		width:300px;
		height:154px;
		overflow:hidden;
		position:relative;
	}
	#news_frame{
		width:285px;
		height:120px;
		margin-top:5px;
		margin-left:5px;
		position:relative;
		overflow:hidden;
	}
	#show_information{
		list-style-type:none;
		width:285px;
		position:absolute;
	}
	#show_information li{
		color:black;
		margin-bottom:4px;
		background:url("images/new_log1.png") no-repeat;
		
		/*必须要设定该设定方式为不换行影藏显示方式*/
		overflow:hidden;
		white-space:nowrap;
		text-overflow:ellipsis;
	}
	#show_information li a{
		margin-left:23px;
		color:black;
		text-decoration:none;
	}
	#show_information li a:hover{
		color:blue;
	}
	
	#share_websits{
		margin-top:0px;
	}
	#share_websits img{
		margin-right:12px;
	}
	
	
	/* 底部界面显示 */
	#footer_top_bg{
		width:942px;
		height:37px;
		background:url(images/footer_top_bg.png) no-repeat;
		overflow:hidden;
	}
	#footer_bottom_bg{
		width:942px;
		height:12px;
		background:url(images/footer_bottom_bg.png) no-repeat;
		overflow:hidden;
	}
	#footer_content{
		padding:5px 20px 5px 20px;
		color:#9bc2e1;
		font-size:11px;
		background:#053d5e;
		width:900px;
		overflow:hidden;
	}
	#footer_content a{
		color:#9bc2e1;
		font-size:11px;
		text-decoration:none;
	}
	#footer_content a:hover{
		color:#ffffff;
		font-size:11px;
		text-decoration:none;
	}
	#footer_content span{
		color:#9bc2e1;
		font-size:11px;
		padding:0px 3px 0px 3px;
	}
	.content_links{
		float:left;
	}
	.content_email{
		float:right;
	}
</style>

<script>
var slideps = null;//图片滑动对象
var fadeps = null;//图片淡入淡出操作
function init(){
	changeViews();
	slideps = new slidePS();
	slideps.createView();
	slideInfor();
}

//将图片对象封装到框架中
//全局变量方便调用

var slide2 = null;

function slidePS(){
	/*图片动作对象*/
	this.tween = new Tween(10 , 0, 100, 100);
	this.args = new SlideArgs("left" , true, 0, 10, 2000, "bounce");
	this.slide = null;//缓冲对象
	this.indexNum = new Array();//创建一个用于保存索引元素

	this.frameObj = document.createElement("div");//框架对象
	this.indexs = document.createElement("div");//索引对象组
}
slidePS.prototype.createView = function(){
	//这一部分时候起对于使用Ajax技术调用后台数据显示的
	var picObj = {
		pictures:[
		{ps:"images/school1.jpg",infor:""},
		{ps:"images/school2.jpg",infor:""},
		{ps:"images/school3.jpg",infor:""},
		{ps:"images/school4.jpg",infor:""}]
	};
	
	var len = picObj.pictures.length;
	this.frameObj.style.overflow = "hidden";
	this.frameObj.style.width = len*570+"px";
	this.frameObj.id = "all_picture";

	//索引对象组样式
	this.indexs.id = "slide_indexs";
	this.indexs.style.overflow = "hidden";
	this.indexs.style.height = "20px";
	this.indexs.style.lineHeight = "20px";
	this.indexs.style.position = "absolute";
	this.indexs.style.left = (570 - len*35)/2+"px";
	this.indexs.style.top = "240px";
	this.indexs.style.zIndex = 1000;
	
	$("slide_ps").appendChild(this.frameObj);

	$("show_view").appendChild(this.indexs);

	this.slide = new SlideObj("slide_ps" , "all_picture", len, this.args, this.tween);
	
	for(var i=0;i<len;i++){
		/* 创建图片对象容器 */
		var obj = document.createElement("div");
		obj.style.width = "570px";
		obj.style.height = "260px";
		obj.style.styleFloat = "left";//IE专业
		obj.style.cssFloat = "left";//非IE浏览器中使用这个
		obj.style.background = "url("+picObj.pictures[i].ps+")";

		this.frameObj.appendChild(obj);

		/* 创建图片索引按钮 */
		var index = document.createElement("div");
		index.style.width = "30px";
		index.style.height = "10px";
		index.style.cursor = "pointer";
		index.style.marginTop = "2px";
		index.style.marginRight = "5px";
		index.style.cssFloat = "left";//W3C标准
		index.style.styleFloat = "left";//IE标准
		index.style.background = "black";
		index.style.border = "1px solid white";
		index.style.borderRadius = "3px";
		
		this.indexNum.push(index);//装载对象
		/* 天际索引按钮事件 */
		addEvent(index , "mouseover", this.btnChange(i));
		addEvent(index , "mouseout", this.btnRunAgain());
		
		this.indexs.appendChild(index);
	}

	//图片轮动点击操作处理
	var ps = $("all_picture").getElementsByTagName("div");
	for(var i=0;i<ps.length;i++){
		addEvent(ps[i] , "mouseover", this.pictureOver());
		addEvent(ps[i] , "mouseout", this.pictureOut());
	}

	//图片轮动启动
	this.slide.startFun = function(){
		for(var i=0;i<slideps.indexNum.length;i++){
			slideps.indexNum[i].style.background = slideps.slide.nowIndex == i ? "#DBDBDB" : "black";
			slideps.indexNum[i].style.border = slideps.slide.nowIndex == i ? "1px solid #6D6D6D" : "1px solid white";
		}
	}

	this.slide.slideRun();
}
slidePS.prototype.btnChange = function(i){
	return function(){
		slideps.slide.slideRun(i);
		slideps.slide.slideStop();
	}
}
slidePS.prototype.btnRunAgain = function(){
	return function(){
		slideps.slide.slideRun();
	}
}
slidePS.prototype.pictureOver = function(){
	return function(){
		slideps.slide.slideStop();
	}
}
slidePS.prototype.pictureOut = function(){
	return function(){
		slideps.slide.slideRun();
	}
}


///////////////////////////////////////////////////////////////////////////
/* 图片淡入淡出实现 */
function fadePS(){
	this.tween = new Tween(0 , 0.1, 100, 200);
	this.args = new FadeArgs(true , 0, 1, 20, 10, 2000, "circ");

	this.frameObj = document.createElement("div");//框架对象
	this.indexs = document.createElement("div");//索引对象组

	this.indexNum = new Array();
}
fadePS.prototype.createView = function(){
	//这一部分时候起对于使用Ajax技术调用后台数据显示的
	var picObj = {
		pictures:[
		{ps:"images/school1.jpg",infor:""},
		{ps:"images/school2.jpg",infor:""},
		{ps:"images/school3.jpg",infor:""},
		{ps:"images/school4.jpg",infor:""}]
	};
	
	var len = picObj.pictures.length;
	this.frameObj.style.overflow = "hidden";
	this.frameObj.style.width = "570px";
	this.frameObj.id = "fade_picture";

	//索引对象组样式
	this.indexs.id = "fade_indexs";
	this.indexs.style.height = "20px";
	this.indexs.style.lineHeight = "20px";
	this.indexs.style.position = "absolute";
	this.indexs.style.left = (570 - len*35)/2+"px";
	this.indexs.style.top = "240px";
	this.indexs.style.zIndex = 1000;
	
	$("fade_ps").appendChild(this.frameObj);

	$("show_view").appendChild(this.indexs);

	
	for(var i=0;i<len;i++){
		/* 创建图片对象容器 */
		var obj = document.createElement("div");
		obj.style.width = "570px";
		obj.style.height = "260px";
		obj.style.background = "url("+picObj.pictures[i].ps+")";

		this.frameObj.appendChild(obj);

		/* 创建图片索引按钮 */
		var index = document.createElement("div");
		index.style.width = "30px";
		index.style.height = "10px";
		index.style.cursor = "pointer";
		index.style.marginTop = "2px";
		index.style.marginRight = "5px";
		index.style.cssFloat = "left";
		index.style.styleFloat = "left";
		index.style.background = "black";
		index.style.border = "1px solid white";
		index.style.borderRadius = "3px";
		
		this.indexNum.push(index);//装载对象
		/* 添加索引按钮事件 */
		addEvent(index , "mouseover", this.btnChange(i));
		addEvent(index , "mouseout", this.btnRunAgain());
		
		this.indexs.appendChild(index);
	}
	
	this.fader = new FadeObj("fade_ps" , "fade_picture", "out", this.args, this.tween);

	//图片淡入淡出点击操作处理
	var ps = $("fade_picture").getElementsByTagName("div");
	for(var i=0;i<ps.length;i++){
		addEvent(ps[i] , "mouseover", this.pictureOver());
		addEvent(ps[i] , "mouseout", this.pictureOut());
	}

	//图片与索引相对应动作
	this.fader.startFun = function(){
		for(var i=0;i<fadeps.indexNum.length;i++){
			fadeps.indexNum[i].style.background = fadeps.fader.nowIndex == i ? "#DBDBDB" : "black";
			fadeps.indexNum[i].style.border = fadeps.fader.nowIndex == i ? "1px solid #6D6D6D" : "1px solid white";
		}
	}

	this.fader.fadeRun();
};

fadePS.prototype.btnChange = function(i){
	return function(){
		fadeps.fader.fadeRun(i);
		fadeps.fader.fadeStop();
	}
}
fadePS.prototype.btnRunAgain = function(){
	return function(){
		fadeps.fader.fadeRun();
	}
}
fadePS.prototype.pictureOver = function(){
	return function(){
		fadeps.fader.fadeStop();
	}
}
fadePS.prototype.pictureOut = function(){
	return function(){
		fadeps.fader.fadeRun();
	}
}

///////////////////////////////////////////////////////////////////////
/* 消息显示
 * 后期任务：将从数据库返回的数据使用json传送&将数据显示使用div框架显示
 */
function slideInfor(){
	//信息轮动效果
	var tween2 = new Tween(10 , 0, 100, 100);
	var args2 = new SlideArgs("top" , true, 0, 10, 2000, "quart");
	
	var allInfor = $("show_information");
	
	//创建一个连接对象(后期为服务器发送的数据)
	var newInfor = {
		infor:[{text:"显示垂直缓动的最新信息",href:"#",title:"2013-3-15"},
            {text:"显示垂直缓动的最新信息",href:"#",title:"2013-3-15"},
            {text:"显示垂直缓动的最新信息",href:"#",title:"2013-3-15"},
            {text:"显示垂直缓动的最新信息",href:"#",title:"2013-3-15"},
            {text:"显示垂直缓动的最新信息",href:"#",title:"2013-3-15"},
            {text:"显示垂直缓动的最新信息",href:"#",title:"2013-3-15"},
            {text:"显示垂直缓动的最新信息",href:"#",title:"2013-3-15"},
            {text:"显示垂直缓动的最新信息",href:"#",title:"2013-3-15"},
            {text:"显示垂直缓动的最新信息",href:"#",title:"2013-3-15"}
		]
	};

	var len = newInfor.infor.length;
	for(var i=0;i<len;i++){
		var li = document.createElement("li");
		li.style.color = "black";
		li.style.marginBottom = "4px";
		li.style.background = "url('images/new_log1.png') no-repeat";
		li.style.overflow = "hidden";
		li.style.whiteSpace = "nowrap";
		li.style.textOverflow = "ellipsis";

		var a = document.createElement("a");
		a.style.marginLeft = "23px";
		a.style.color = "black";
		a.style.textDecoration = "none";
		a.innerHTML = newInfor.infor[i].text;
		a.href = newInfor.infor[i].href;
		a.title = newInfor.infor[i].title;
		
		a.onmouseover = function(evt){
			var event = window.event ? window.event : evt;
			var target = event.target ? event.target : event.srcElement;
			target.style.color = "blue";
			slide2.slideStop();
		}
		a.onmouseout = function(evt){
			var event = window.event ? window.event : evt;
			var target = event.target ? event.target : event.srcElement;
			target.style.color = "black";
			slide2.slideRun();
		}

		li.appendChild(a);
		allInfor.appendChild(li);
	}
	
	slide2 = new SlideObj("news_frame" , "show_information", len, args2, tween2);
	slide2.slideRun();
}

/* 更改图片显示信息的事件操作 */
function changeViews(){
	var changs = $("chang_headps").getElementsByTagName("div");
	changs[0].onclick = function(){
		//开启滑动页面&关闭淡入淡出效果
		$("infor_Sch").className = "click_div";
		$("infor_File").className = "";

		$("fade_ps").style.display = "none";
		fadeps.indexs.style.display = "none";
		fadeps.fader.fadeStop();//将图片淡入淡出动画停止

		$("slide_ps").style.display = "block";
		slideps.indexs.style.display = "block";
		slideps.slide.slideRun();
	};

	changs[1].onclick = function(){
		//开启淡入淡出效果&关闭滑动效果
		$("infor_File").className = "click_div";//更改图标样式
		$("infor_Sch").className = "";

		$("slide_ps").style.display = "none";
		slideps.indexs.style.display = "none";
		slideps.slide.slideStop();

		$("fade_ps").style.display = "block";
		if(fadeps == null){
			fadeps = new fadePS();
			fadeps.createView();
		}
		fadeps.indexs.style.display = "block";
		fadeps.fader.fadeRun();
	};
}
//将信息对象封装到框架中
</script>

</head>

<body onload="init()" onselectstart="return false">
	<div id="main_body">
		<div id="header">
			<div id="header_top"></div>
			<div id="header_body">
				<div id="header_left">
					<div id="logo"><div class="logo_gdt"></div></div>
					<div id="logo_divider"></div>
					<div id="menu">
						<ul>
							<li id="menu_active"><a href="mainLogin.jsp">主页</a></li>
							<li><a href="/SchoolUser/schoolLogin.jsp">快速入口</a></li>
							<li><a href="mainLogin.jsp">在线客服</a></li>
							<li><a href="mainLogin.jsp">功能手册</a></li>
							<li><a href="mainLogin.jsp">关于我们</a></li>
						</ul>
					</div>
				</div>
			
				<div id="header_right">
					<div id="show_view">
						<div id="slide_ps">
						</div>
						<div id="fade_ps">
						</div> 
					</div>
				</div>
				<div id="chang_headps">
					<div class="click_div" id="infor_Sch">名校信息</div>
					<div id="infor_File">优质论文</div>	
				</div>
			</div>
			<div id="header_bottom"></div>
		</div>
		
		<!-- 主体部分的信息显示框架 -->
		<div id="content_body">
			<!-- 左边状态栏消息处理 -->
			<div id="left_content">
				<p class="headings">学校所在省份</p>
				<div class="school_province">
					<div class="province">浙江省</div>
					<div class="province">上海市</div>
                    <div class="province">山东省</div>
				</div>
			</div>
			
			<div id="right_content">
				<p class="headings">网站最新动态<span class="heading_news">New</span></p>
				<div id="new_information">
					<div id="news_frame">
						<ul id="show_information">
						</ul>
					</div>
				</div>
			
				<!-- 网站分享操作(这个也可以设想使用一个动态加载操作处理) -->
				<div id="share_websits">
					<p class="headings">网站分享</p>
					<div id="bdshare" class="bdshare_t bds_tools_32 get-codes-bdshare">
					<a class="bds_tsina"></a>
					<a class="bds_renren"></a>
					<a class="bds_qzone"></a>
					<a class="bds_tqq"></a>
					<a class="bds_tieba"></a>
					<span class="bds_more"></span>
					</div>
					<script type="text/javascript" id="bdshare_js" data="type=tools&amp;mini=1&amp;uid=0" ></script>
					<script type="text/javascript" id="bdshell_js"></script>
					<script type="text/javascript">
					document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000)
					</script>
				</div>
			</div>
		</div>
		
		
		<div id="footer_top_bg"></div>
		<div id="footer_content">
			<div class="content_links">
				<a href="index.html">主页</a> <span>|</span> 
				<a href="about.html">在线客服</a> <span>|</span> 
				<a href="#">功能手册</a> <span>|</span>
				<a href="clients.html">关于我们</a>
			</div>
		
			<div class="content_email">
			&copy; Copyright 2013. <span style="color:#ffffff;">MichaelZhaoZero@gmail.com</span>
			</div>
		</div>	
		<div id="footer_bottom_bg"></div>
	</div>
 </body>
</html>
