<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>青岛工学院管理员入口</title>
<link rel="icon" href="images/favicon.ico" type="image/x-icon"></link>
<link href="css/school_admin_login.css?Ver=20131229" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script>
var shortObj = null;//保存
var request = null;
var login_error = null;//login_error对象经常使用将其设定为全局提高性能
var waiting_login = false;//这个是用于标志当前按钮是否已经点击过信息审核
var cookieObj = null;//定义一个CookieObj对象

function init(){
	cookieObj = new CookieObj();//创建cookie对象
	$("verifycode").src = "VerifyCode?uid="+new Date().getTime();//初始化验证码对象
	login_error = $("login_error");//转载login_error对象
	
	adaptView();
	window.onresize = adaptView;//实现浏览器大小更改是更改页面的显示位置大小
	
	register_ParmEvent();//对象事件初始化
}

//为了实现在不同的显示器下得到同样的登入界面对象显示在中间操作
function adaptView(){
	var frame = $("body_frame");
	var winHeight = windowHeight() < 600 ? 616 : windowHeight();
	var marginlength = (winHeight - (frame.offsetHeight+178))/2 + "px";
	
	//是登入界面居中显示
	frame.style.marginTop = marginlength;
	frame.style.marginBottom = marginlength;
}

//为对象注册事件
function register_ParmEvent(){
	register_NameEvent();
	register_PasswordEvent();
	register_CodeEvent();
	register_Submit();
}
//用户名对象事件注册
function register_NameEvent(){
	var user_name = $("user_name");
	var close_user_name = $("close_user_name");
	
	user_name.value = cookieObj.getCookie("GDT_School_Admin");
	close_user_name.style.display = user_name.value == "" ? "none" : "block";
	
	user_name.onblur = function(){
		$("name_view").className = "text_view_blur";
	};
	user_name.onfocus = function(){
		$("name_view").className = "text_view_focus";
	};
	user_name.onkeyup = function(){
		if(user_name.value.length > 0){
			close_user_name.style.display = "block";
		}else{
			close_user_name.style.display = "none";
		}
	};
	close_user_name.onmouseover = function(){
		close_user_name.className = "close_name_over";
	};
	
	close_user_name.onmouseout = function(){
		close_user_name.className = "close_name_out";
	};
	
	close_user_name.onclick = function(){
		user_name.value = "";
		close_user_name.style.display = "none";
	};
}

//用户名密码事件注册
function register_PasswordEvent(){
	$("user_password").onblur = function(){
		$("password_view").className = "text_view_blur";
	};
	$("user_password").onfocus = function(){
		$("password_view").className = "text_view_focus";;
	};
}

//验证码事件注册
function register_CodeEvent(){
	$("user_code").onblur = function(){
		$("code_view").className = "code_view_blur";
	};
	$("user_code").onfocus = function(){
		$("code_view").className = "code_view_focus";
	};
	$("verifycode").onclick = function(){//刷新验证码
		$("verifycode").src = "VerifyCode?uid="+new Date().getTime();
	};
}

//自动的刷新验证码当有错误报告时
function flush_CodeEvent(){
	$("verifycode").src = "VerifyCode?uid="+new Date().getTime();
}

//提交按钮事件注册
function register_Submit(){
	var inter_submit = $("inter_submit");
	
	inter_submit.onclick = function(){
		if($("user_name").value == ""){
			login_error.style.display = "block";
			login_error.innerHTML = "您的用户名还未输入!";
		}else if($("user_password").value == ""){
			login_error.style.display = "block";
			login_error.innerHTML = "您的密码还未输入!";
		}else if($("user_code").value == ""){
			login_error.style.display = "block";
			login_error.innerHTML = "您的验证码还未输入!";
		}else{
			if(!waiting_login){
				var url = "SchoolLoginServlet?type=Admin_Login&user_name="+$("user_name").value+"&user_password="+$("user_password").value+"&user_code="+$("user_code").value;
				waiting_login = true;//确认发送信息
				check_UserInfor(url);
			}
		}
	};
}

//这个是用于异步交互的ajax技术
function createXMLHttp(){
	if(ifIE){
		request = new ActiveXObject("Microsoft.XMLHTTP");
	}else if(window.XMLHttpRequest){
		request = new XMLHttpRequest();
	}
}

//得到一个XMLHttpRequest对象
function newXMLHttpRequest(){
	if(ifIE){
		return new ActiveXObject("Microsoft.XMLHTTP");
	}else if(window.XMLHttpRequest){
		return new XMLHttpRequest();
	}
}

//验证用户
function check_UserInfor(url){
	createXMLHttp();//创建XMLHttprequest对象
	/*
	这一步还未连接
	method：请求的类型；GET 或 POST
	url：文件在服务器上的位置
	async：true（异步）或 false（同步）
	 */
	request.open("post" , url, true);
	request.onreadystatechange = check_function;//每当 readyState 改变时，就会触发 onreadystatechange 事件。
	request.send(null);//发送信息
}
/*
readystate取值:
0: 请求未初始化
1: 服务器连接已建立
2: 请求已接收
3: 请求处理中
4: 请求已完成，且响应已就绪
*/

function check_function(){
	//Googal对于request.readyState == 1无反应不进行 服务器连接已建立 判断
	if(request.readyState == 1 || request.readyState == 2 || request.readyState == 3){
		login_error.style.display = "block";
		login_error.style.color = "green";
		login_error.innerHTML = "系统正在验证信息请等待!";
	}else if(request.readyState == 4){
		if(request.status == 200){//成功
			var user_id = parseInt(request.responseText);//取得返回信息
			
			if(user_id > 0){
				//验证通过
				login_error.innerText = "验证通过正在登入...";
				
				cookieObj.setCookie("GDT_School_Admin" , $("user_name").value, 7);
				
				//清除原先填写的一些用户信息
				var inputs = document.getElementsByTagName("input");
				for(var i=0;i<inputs.length;i++){
					inputs[i].value = "";
				}
				var login_url = ifIE ? "../SchoolLoginServlet?type=Login_amdinIndex" : "SchoolLoginServlet?type=Login_amdinIndex";
				window.open(login_url ,"_self");
			}else if(user_id == 0){
				//用户名或密码不正确
				login_error.style.color = "red";
				login_error.innerHTML = "您的用户名或密码不正确...";
				flush_CodeEvent();//刷新验证码
				waiting_login = false;
			}else if(user_id == -1){
				//验证码不正确
				login_error.style.color = "red";
				login_error.innerHTML = "您的验证码不正确...";
				flush_CodeEvent();
				waiting_login = false;
			}
		}else{
			//status:404 服务器异常
			login_error.style.color = "red";
			login_error.innerHTML = "Sorry 当前服务器异常...";
			flush_CodeEvent();
			waiting_login = false;
		}
	}else{
		//status:404 服务器异常
		login_error.style.display = "block";
		login_error.style.color = "red";
		login_error.innerHTML = "Sorry 当前服务器异常...";
		flush_CodeEvent();
		waiting_login = false;
	}
}
</script>
</head>

<body onload="init()">
<div id="header_frame">
	<div id="school_name"></div>
</div>
<div id="header_menu_frame">
</div> 

<div class="login_body">
	<div id="body_frame">
	  <div class="frame_left">
			<div class="left_name">GDT大学生毕业设计管理系统</div>
			<div>为管理方便 1.对于提交课题审核2.学校信息设定</div>
			<div>3.对于本学校系统参数设定</div>
			<div class="left_login_way">您的当前登入点 <span style="margin-left:10px;color:#A7A7A7">青岛工学院</span></div>
		</div>
		<div class="frame_right">
			<div class="frame_name">
				<div style="float:left">用户名：</div>
				<div id="name_view" class="text_view_blur"><input id="user_name" type="text" value=""/></div>
				<div id="close_user_name" class="close_name_out"></div>
			</div>
			<div class="frame_password">
				<div style="float:left">密　码：</div>
				<div id="password_view" class="text_view_blur"><input id="user_password" type="password" value=""/></div>
			</div>
			<div class="frame_code">
				<div class="inter_code">
					<div style="float:left">验证码：</div>
					<div id="code_view" class="code_view_blur"><input id="user_code" maxlength="4" type="text" value=""/></div>
				</div>
				<div class="login_code">
					<img id="verifycode" title="看不清?点击一下" style="cursor:pointer;"/>
				</div>
			</div>
			
			<div id="login_error"></div>
     
			<div class="frame_submit"><div id="inter_submit">登&nbsp;录</div></div>
		</div>
	</div>
</div>

<div id="footer_view">
	<div id="footer_frame">
		<div class="footer_links">
			<a href="index.html">主页</a> <span>|</span> 
			<a href="about.html">在线客服</a> <span>|</span> 
			<a href="#">功能手册</a> <span>|</span>
			<a href="clients.html">关于我们</a>
		</div>
		<div class="footer_email">
			Copyright © 2013 <a href="#">MichaelZhaoZero@gmail.com</a>
		</div>
    </div>
</div>
</body>
</html>
