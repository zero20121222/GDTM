<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>无标题文档</title>
<link href="css/index_body.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="js/Fade_Slide.js"></script>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script>
function init(){
	suit_Page();
	//slideInfor();
	var slideSchoolNews = new slidePS();
	slideSchoolNews.createView();
	
	var userNews = new slideNews();
	userNews.createView();
}

function register_Out(obj, e){//用于判断是否是最外边
	if (e.currentTarget) {
		if (e.relatedTarget != obj) {
			if (obj != e.relatedTarget.parentNode) {
				return true;
			}
		}
	} else {
		if (e.toElement != obj) {
			if (obj != e.toElement.parentNode) {
				return true;
			}
		}
	}

	return false;
}

function timeTools(year , month, day, hour, minute, second){
	this.year = year;
	this.month = month;
	this.day = day;
	this.hour = hour;
	this.minute = minute;
	this.second = second;
}
timeTools.prototype.stringtoObj = function(timeStr){//匹配为yyyy-hh-dd HH:MM:SS
	timeStr = timeStr.replace(/\.|\s/g,"-");
	var timeArray = timeStr.split("-");
	
	//使用parseInt时当输入的数据前面有0时函数默认这个数据为8进制所以当数据为08|09时输出的结果为0所以还是使用parseFloat比较好或者用parseInt("08" , 10);定义为10进制
	this.year = parseFloat(timeArray[0]);
	this.month = parseFloat(timeArray[1]);
	this.day = parseFloat(timeArray[2]);
	this.hour = parseFloat(timeArray[3]);
	this.minute = parseFloat(timeArray[4]);
	this.second = parseFloat(timeArray[5]);
}

///////////////////////////////////////////////////////////////////////
/* 消息显示
 * 后期任务：将从数据库返回的数据使用json传送&将数据显示使用div框架显示
 */
function slideNews(){
	this.tween = new Tween(10 , 0, 100, 100);
	this.args = new SlideArgs("top" , true, 0, 10, 2000, "quart");
	this.slide = null;
	this.timeObj = new timeTools();//时间字符处理对象
	
	this.allInfor = $("all_news");
}
slideNews.prototype.createView = function(){//创建视图
	var newsRequest = newXMLHttpRequest();
	newsRequest.open("post" , "IndexInterlizeServlet?type=ManageSUserNews", true);
	newsRequest.onreadystatechange = this.loadNews(newsRequest , this);
	
	newsRequest.send(null);
}
slideNews.prototype.loadNews = function(newsRequest , slideObj){//加载信息内容
	return function(){
		if(newsRequest.readyState == 1 || newsRequest.readyState == 2 || newsRequest.readyState == 3){
			
		}else if(newsRequest.readyState == 4){
			if(newsRequest.status == 200){
				var news = eval(newsRequest.responseText);
				
				var inforsFrame = document.createElement("div");
				inforsFrame.id = "inforsFrame";
				inforsFrame.style.position = "absolute";
				inforsFrame.style.width = "290px";
				 
				var len = news.length;
				for(var i=0;i<len;i++){
					var newframe = document.createElement("div");
					newframe.className = "news_section";
					
					// 时间框架 
					slideObj.timeObj.stringtoObj(news[i].sendTime);
					var newdate = document.createElement("div");
					newdate.className = "new_date";
					var dateday = document.createElement("div");
					dateday.className = "date_day";
					dateday.innerHTML = slideObj.timeObj.day < 10 ? "0"+slideObj.timeObj.day : slideObj.timeObj.day;
					
					var dateyear = document.createElement("div");
					dateyear.className = "date_year";
					dateyear.innerHTML = slideObj.timeObj.year+"."+slideObj.timeObj.month;
					newdate.appendChild(dateday);
					newdate.appendChild(dateyear);
					newdate.onclick = slideObj.newClickEvent;
					
					// 信息框架 
					var newinfor = document.createElement("div");
					newinfor.className = "news_infor";
					var newfromname = document.createElement("div");
					newfromname.className = "news_fromname";
					newfromname.innerHTML = "From:<a href='#'>"+news[i].senderName+"</a>";
					newfromname.onclick = slideObj.nameClickEvent;
					
					var information = document.createElement("p");
					information.innerHTML = news[i].newContent;
					
					newinfor.appendChild(newfromname);
					newinfor.appendChild(information);
					
					newframe.appendChild(newdate);
					newframe.appendChild(newinfor);
					
					newframe.onmouseover = function(evt){
						if(register_Out(newframe , evt)){
							slideObj.slide.slideStop();
						}
					}
					
					newframe.onmouseout = function(evt){
						if(register_Out(newframe , evt)){
							slideObj.slide.slideRun();
						}
					}
					
					inforsFrame.appendChild(newframe);
				}
				
				slideObj.allInfor.appendChild(inforsFrame);
				if(len>=4){//当大于等于4条信息时创建轮动效果
					slideObj.slide = new SlideObj("all_news" , "inforsFrame", len, slideObj.args, slideObj.tween);
					slideObj.slide.slideRun();
				}
			}
		}
	}
}
slideNews.prototype.newClickEvent = function(){//信息点击显示操作
	alert("后期用于处理关于请求的处理结果");
}
slideNews.prototype.newCloseEvent = function(){//关闭显示操作
	
}
slideNews.prototype.nameClickEvent = function(){//用户名点击操作显示请求用户信息
	alert("后期显示用户详细信息页面来操作");
}
slideNews.prototype.nameCloseEvent = function(){//关闭用户信息
	
}

///////////////////////////////////////////////////////////////////////////////////////
/*对于学校最新信息的动态显示处理*/
//将图片对象封装到框架中(完成项目后将这些javascript整合成为一个javascript库)
function slidePS(){
	/*图片动作对象*/
	this.tween = new Tween(10 , 0, 100, 100);
	this.args = new SlideArgs("left" , false, 0, 10, 2000, "bounce");
	this.slide = null;//缓冲对象
	this.newindex = 0;//表示当前索引对象
	
	this.frameObj = document.createElement("div");//框架对象
	this.inforFrame = new Array();//信息对象容器
	this.loadfileFrames = new Array();//用于存放加载后的文件显示对象容器
}
slidePS.prototype.createView = function(){
	//这一部分时候起对于使用Ajax技术调用后台数据显示的
	var requestNotice = newXMLHttpRequest();
	requestNotice.open("post" , "IndexInterlizeServlet?type=commonSNews", true);
	requestNotice.onreadystatechange = this.loadNotices(requestNotice , this);
	$("views_frame").style.background = "url(images/waiting.gif) no-repeat 50%";
	
	requestNotice.send(null);
}
slidePS.prototype.loadNotices = function(requestNotice , slideobj){//传入一个request请求对象,obj:对象引用
	return function(){
		if(requestNotice.readyState == 1 || requestNotice.readyState == 2 || requestNotice.readyState == 3){
			
		}else if(requestNotice.readyState == 4){
			$("views_frame").style.background = "none";
			if(requestNotice.status == 200){
				var noticeObjs = eval(requestNotice.responseText);
				
				var len = noticeObjs.length;
				
				slideobj.frameObj.style.overflow = "hidden";
				slideobj.frameObj.style.width = len*500+"px";
				slideobj.frameObj.style.height = "204px";
				slideobj.frameObj.id = "all_picture";
				$("views_frame").appendChild(slideobj.frameObj);
				
				slideobj.slide = new SlideObj("views_frame" , "all_picture", len, slideobj.args, slideobj.tween);
				var infor_show = $("frame_infor");
				
				for(var i=0;i<len;i++){
					var obj = document.createElement("div");
					obj.style.width = "410px";
					obj.style.height = "200px";
					obj.style.border = "2px solid white";
					obj.style.marginRight = "86px";
					obj.style.styleFloat = "left";//IE专业
					obj.style.cssFloat = "left";//非IE浏览器中使用这个
					obj.style.background = "url(Schoolinfor/"+$("schoolId").value+"/News/"+noticeObjs[i].id+"/"+noticeObjs[i].picture+") no-repeat 50%";
					
					var infor_frame = document.createElement("div");
					infor_frame.className = "infor_frame";
					infor_frame.style.display = i == 0 ? "block" : "none";
					
					var frame_title = document.createElement("div");
					frame_title.className = "frame_title";
					frame_title.innerHTML = noticeObjs[i].title;
					
					var frame_inforview = document.createElement("div");
					frame_inforview.className = "frame_inforview";
					frame_inforview.innerHTML = "<p>"+noticeObjs[i].content+"</p>";
					
					//这个后期用于获取OutputStream文件输出流对象
					var frame_button = document.createElement("div");
					frame_button.className = "frame_button";
					frame_button.innerHTML = "详细信息";
					//添加文件详细信息显示事件
					addEvent(frame_button , "click", slideobj.fileClickEvent(slideobj , $("schoolId").value, noticeObjs[i].id, noticeObjs[i].contentfile, noticeObjs[i].title));
					
					
					infor_frame.appendChild(frame_title);
					infor_frame.appendChild(frame_inforview);
					infor_frame.appendChild(frame_button);
					
					slideobj.inforFrame.push(infor_frame);
					infor_show.appendChild(infor_frame);
					slideobj.frameObj.appendChild(obj);
				}
				
				//图片轮动启动
				slideobj.slide.slideRun();
				
				//向左点击事件
				addEvent($("views_left") , "click",slideobj.leftClickEvent(slideobj , len));
				
				$("views_right").style.display = "block";
				//向右点击事件
				addEvent($("views_right") , "click", slideobj.rightClickEvent(slideobj , len));
			}
		}
	}
}
slidePS.prototype.fileClickEvent = function(slideObj , schoolId, newId, file, title){
	return function(){
		var filetype = file.split(".")[1].toLowerCase();
		var url;
		if(filetype == "doc" || filetype == "html" || filetype == "xls"){//相对于doc这个文件格式系统自动转换成html格式显示
			//这个是直接调用转换后的html格式的文件显示
			url = "Schoolinfor/"+schoolId+"/News/"+newId+"/"+file.replace(".doc",".html");
		}else{
			//假如不是doc文件则由servlet返回一个数据输出流来到客户端显示
			url = "FileManageServlet?type=schoolNewFile&schoolId="+schoolId+"&newId="+newId+"&fileName="+file;
		}
		
		var frame = slideObj.existLoadFrameObj(url);
		if(frame == null){
			frame = new LoadFileFrameObj(url , title);
			slideObj.loadfileFrames.push(frame);
			frame.createFrame();
		}else{
			frame.mWindow.Win_frame.showView();
			frame.mWindow.Win_cover.showView();
		}
	}
}
slidePS.prototype.leftClickEvent = function(slideobj , len){
	return function(){
		slideobj.slide.slidePrevious();
					
		if(slideobj.slide.nowIndex <= 0){
			$("views_left").style.display = "none";
			slideobj.changeInfor((slideobj.slide.nowIndex+1) , slideobj.slide.nowIndex);
		}else if(slideobj.slide.nowIndex < len-1){
			slideobj.changeInfor((slideobj.slide.nowIndex+1) , slideobj.slide.nowIndex);
			$("views_right").style.display = "block";
		}
	}
}
slidePS.prototype.rightClickEvent = function(slideobj , len){
	return function(){
		slideobj.slide.slideNext();
						
		if(slideobj.slide.nowIndex >= (len-1)){
			$("views_right").style.display = "none";
			slideobj.changeInfor((slideobj.slide.nowIndex-1) , slideobj.slide.nowIndex);
		}else if(slideobj.slide.nowIndex > 0){
			slideobj.changeInfor((slideobj.slide.nowIndex-1) , slideobj.slide.nowIndex);
			$("views_left").style.display = "block";
		}
	}
}
slidePS.prototype.changeInfor = function(nowindex , nextindex){//将前一个对象none；将后一个block
	this.inforFrame[nowindex].style.display = "none";
	this.inforFrame[nextindex].style.display = "block";
}
slidePS.prototype.existLoadFrameObj = function(url){
	for(var i=0; i<this.loadfileFrames.length; i++){
		if(this.loadfileFrames[i].url == url){
			return this.loadfileFrames[i];
		}
	}
	
	return null;
}

//创建一个文件信息显示iframe对象
var old_loadFileObj;//用于保存旧的对象引用
function LoadFileFrameObj(url , titleinfor){
	this.url = url;//文件路径
	this.titleinfor = titleinfor == null || undefined ? "标题" : titleinfor;
	this.mWindow = null;//索引移动窗口对象
}
LoadFileFrameObj.prototype.createFrame = function(){
	var iframe = parent.document.createElement("iframe");
	iframe.style.width = "100%";
	iframe.style.height = "318px";//高度为Window_frame-32
	iframe.style.background = "white";
	iframe.style.border = "0 none";
	iframe.src = this.url;
	
	var titleClose = new Window_close();
	titleClose.close_Click = this.close_Click;//复写click方法
	//关闭了
	var title = new Window_titleview(null , null, new Window_title(this.titleinfor), null, null, false, null, null, titleClose, null);//设置标题信息
	
	var margin_Left = (parent.document.body.clientWidth - 800)/2;
	var frame = new Window_frame(800 , 350, 100, margin_Left, null, null, null, null, null, true);
	
	//this.mWindow = new moveWindow(frame , title, false, null, null, new Window_cover(parent.document.body), null);
	//完美的解决方案（通过输入当前滑动窗口是针对那个页面的来实现操作处理）
	this.mWindow = new moveWindow(frame , title, false, null, null, null, null, null, parent, null);
	this.mWindow.create_View();
	this.mWindow.Win_view.add_Child(iframe);
};
LoadFileFrameObj.prototype.close_Click = function(parentObj){
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
/*
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

#school_news_frame {
	clear: both;
	width: 980px;
	margin: 0 auto;
	
	overflow:hidden;
}

.news_frame {
	float: left;
	width: 900px;
	height: 260px;
	margin-bottom: 10px;
	background: #215b8d;
}

.frame_pictures {
	float: left;
	width: 610px;
	height: 260px;
	overflow: hidden;	
	background: url(images/templatemo_slider_right_divider.jpg) right repeat-y;
}

#frame_infor {
	float: left;
	width: 250px;
	height: 180px;
	padding: 40px 20px;
	overflow: hidden;
	background: #1d4b73;
}
.infor_frame{
	width: 250px;
	height: 180px;
}

.frame_inforview{
	width:250px;
	height:100px;
	margin-bottom:10px;
	
	word-wrap:break-word;
	overflow:hidden;
	text-overflow:ellipsis;
}
.frame_inforview p{
	color:#CCCCCC;
	font-size:13px;
}

#detail_system {
	float:left;
	width:608px;
	height:260px;
	overflow:hidden;
	background: #ffffff;
}

#detail_system p {
	padding-bottom: 20px;
}

.system_view{
	margin:40px 48px 20px 50px;
}



.title_text{
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color: #395a7b;
	margin-bottom:10px;
}
.infor_text{
	font-size: 12px;
	font-weight: bolde;
	background: url("images/ts.gif") no-repeat left top;
}
.server_link{
	text-decoration:none;
	font-weight: bold;
	color:#FF6600;
}
.service_links{
	margin-top:20px;
}
.service_email{
	padding-left:20px;
	background:url("images/icon-mail.gif") no-repeat left;
}
.service_phone{
	padding-left:20px;
	background:url("images/icon-phone.gif") no-repeat left;
}


#main_body {
	width: 900px;
	margin: 30px;
	padding: 9px;
	
	
	overflow:hidden;
	border: 1px solid #c3c4c5;
	background: #d8d7d7;
	border-radius:5px;
	box-shadow:3px 3px 2px #000;
}

#detail_frame {
	width:898px;
	border:1px solid #c6c5c5;
	background:#eeeeee;
}

#infor_news {
	float: left;
	width: 290px;
	height: 260px;
	overflow:hidden;
	background: #eeeeee url(images/content_right_column_bg.jpg) left repeat-y;
}
#infor_news .new_titles{
	width:290px;
	height:30px;
	font-size:14px;
	font-weight:bold;
	line-height:30px;
	text-indent:2em;
	color:#000000;
	
	margin-bottom:20px;
	background: url(images/templatemo_side_header_bg.jpg) repeat-x;
}
#infor_news .new_titles span{
	font-style:oblique;

	margin-left:10px;
	color:red;
}


#all_news{
	height:195px;
	overflow:hidden;
	position:relative;
}
.news_section {
	overflow:hidden;
	height:55px;
	margin: 0 20px 10px 20px;
}
.news_section .new_date{
	width:50px;
	height:50px;
	float:left;
	cursor:pointer;
	overflow:hidden;
	border-radius:5px;
	box-shadow:3px 3px 2px #000;
}
.news_section .new_date .date_day{
	width:50px;
	height:35px;
	line-height:35px;
	font-size:20px;
	font-weight:bold;
	text-align: center;
	color: #ffffff;
	background:#307CBF;
}
.news_section .new_date .date_year{
	width:50px;
	height:15px;
	line-height:15px;
	font-size:13px;
	text-align: center;
	color: #ffffff;
	background:#1B466C;
}

.news_section .news_infor{
	float:left;
	
	margin-left:10px;
	margin-top:2px;
	width:180px;
}
.news_infor .news_fromname{
	color:black;
	font-size:12px;
	font-weight:bold;
	font-style:oblique;
}
.news_infor .news_fromname a{
	color:black;
	margin-left:10px;
	text-decoration:none;
	font-style:normal;
	font-weight:normal;
}

.frame_title{
	clear: both;
	font-size: 17px;
	line-height:18px;
	color: #dad021;
	font-weight: bold;	
	padding: 0 0 10px 0;
	margin: 0 0 10px 0;
	background: url(images/templatemo_banner_divider.jpg) bottom repeat-x;
}
.frame_button{
	width:102px;
	height:29px;
	padding-left:25px;
	
	font-size:13px;
	font-weight:bold;
	line-height:29px;
	color:white;
	cursor:pointer;
	background:url(images/frame_button0.png) no-repeat;
}
.frame_button:hover{
	background:url(images/frame_button1.png) no-repeat;
}

.views_left_css{
	width:48px;
	height:60px;
	margin-top:100px;
	margin-left:30px;
	margin-right:20px;
	float:left;
}
#views_left{
	width:48px;
	height:60px;
	cursor:pointer;
	display:none;
	background:url(images/picture_left.png) no-repeat;
}
#views_frame{
	width:414px;
	height:204px;
	position:relative;
	margin-top:28px;
	margin-bottom:28px;
	background: #215b8d;
	float:left;
}
.views_right_css{
	width:48px;
	height:60px;
	margin-top:100px;
	margin-left:20px;
	margin-right:30px;
	float:left;
}
#views_right{
	width:48px;
	height:60px;
	cursor:pointer;
	display:none;
	background:url(images/picture_right.png) no-repeat;
}
#view_picture{
	width:410px;
	height:200px;
	border:2px solid white;
	background:url('images/templatemo_image_02.jpg');
}*/
</style>
</head>

<body onload="init()">
<input type="hidden" value="${school_id }" id="schoolId"/>
<div id="school_news_frame">
    <div id="main_body">
	
    	<div class="news_frame">
        	<div class="frame_pictures">
        		<div class="views_left_css"><div id="views_left"></div></div>
            	<div id="views_frame"></div>
            	<div class="views_right_css"><div id="views_right"></div></div>
          	</div>
            <div id="frame_infor">
            	
            </div>
        </div>
        
        <div id="detail_frame">
            <div id="detail_system">
				<div class="system_view">
					<div class="">
						<div class="title_text">感谢您使用“GDT-大学生毕业设计与管理平台”</div>
						<div class="infor_text">
							<span style="margin-left:20px;font-weight:bold;font-size:13px;">提示：</span><br/>
							您现在使用的是GDT-大学生毕业设计与管理信息系统！如果您有任何疑问请点击<a href="#" class="server_link">在线客服</a>进行咨询！<br/>
							功能逐步完善，一站通使用方式。该系统功能强大，操作简单，各类功能易如反掌！<br/>
							此系统为您提供强大的毕业课题选择以及管理功能！<br/>
							加强毕业课题的创新性，实践性，规范性，合理性！<br/>
						</div>
					</div>
					
					<div class="service_links">
						<span class="service_email"> 客户服务邮箱：MichaelZhaoZero@gmail.com</span><br/>
						<span class="service_phone"> 客服电话：18657327206</span>
					</div>
				</div>
			</div>
            <!-- end of column w610 -->
            
            <div id="infor_news">
            	<div class="new_titles">用户最新信息<span>New</span></div>
				<div id="all_news">
					<!-- 这个后期是作为一个信息轮动框架的 -->
				</div>   
            </div>
        </div> 
    </div>
</div>
</body>
</html>
