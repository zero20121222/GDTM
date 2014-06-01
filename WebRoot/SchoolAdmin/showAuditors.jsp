<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>审核人员信息</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script type="text/javascript" src="js/School_User_CL.js"></script>
<script>
var createObj;
function init(){
	suit_Page();

    var nameObj = new inputElementObj($("query_userName"));
    nameObj.onblurEvent = queryEvent;
    nameObj.createView();

    createObj = new createUserObj($("add_users"));
    createObj.initObj();
}

/*
 * 人员资料文件
 */
function createUserObj(buttonObj){
    this.buttonObj = buttonObj;

    this.mWindow = null;
    this.errorView = null;
    this.commitStage = false;	//控制提交状态
}
createUserObj.prototype.initObj = function(){
    addEvent(this.buttonObj , "click", this.cClickEvent(this));
}
createUserObj.prototype.cClickEvent = function(fileObj){
    return function(){
        var titleClose = new Window_close();
        titleClose.close_Click = fileObj.closeClick;
        var title = new Window_titleview(null , null, new Window_title("审核人员用户创建"), null, null, false, null, null, titleClose, null);//设置标题信息

        var margin_Left = (document.body.clientWidth - 500)/2;
        var frame = new Window_frame(500 , 190, 100, margin_Left, null, null, null, null, null, true);

        fileObj.mWindow = new moveWindow(frame , title, null, null, null, null, true, 1, null, null);
        fileObj.mWindow.create_View();

        fileObj.createView(fileObj);
    };
};
createUserObj.prototype.closeClick = function(parentObj){
    return function(){
        //判断该对象是否打开了遮罩层
        if(!parentObj.getParentObj().Win_closeC){
            parentObj.getParentObj().Win_cover.hiddenView();//隐藏遮罩对象
        }
        parentObj.getParentObj().closeWindow();//影藏对象
    };
};
createUserObj.prototype.createView = function(fileObj){
    var viewFrame = document.createElement("div");

    //请求信息
    var proView = document.createElement("div");
    proView.className = "proView";
    proView.innerHTML = "<table width='100%' border='0'>"
            +"<tr><td width='30%' height='30px' align='right'>创建人：</td>"
            +"<td width='20%' align='left'>"+new userNameObj().readTrueName()+"</td>"
            +"<td width='15%' align='right'>账户类型：</td><td align='left'>审核人员</td></tr>"

            +"<tr height='40px'><td width='30%' align='right'>用户名：</td>"
            +"<td colspan='3' align='left'><div class='input_frame'><input type='text' name='userName' id='userName'/></div></tr>"

            +"<tr height='40px'><td width='30%' align='right'>密码：</td>"
            +"<td colspan='3' align='left'><div class='input_frame'><input type='password' name='userPassword' id='userPassword'/></div></tr>"

            +"<tr height='40px'><td width='30%' align='right'>&nbsp;</td>"
            +"<td colspan='4' align='left'><input type='button' id='add_submit' class='upload_submit' value='提交'/></tr></table>";

    this.errorView = document.createElement("div");
    this.errorView.className = "stage_req_error";
    this.errorView.style.display = "none";

    viewFrame.appendChild(proView);
    viewFrame.appendChild(this.errorView);
    fileObj.mWindow.Win_view.add_Child(viewFrame);

    var userName = new inputElementObj($("userName"));
    userName.onblurEvent = nameBlurEvent;
    userName.createView();

    var userPassword = new inputElementObj($("userPassword"));
    userPassword.createView();
    $("add_submit").onclick = submitEvent(this);
};

//重写对象元素的onblur事件函数
var user_Name = null;//用于保存用户名称
function nameBlurEvent(inputObj){
    return function(){
        checkUserName(inputObj);
    }
}
function checkUserName(inputObj){
    inputObj.parentNode.className = "input_frame";

    if(inputObj.value == ""){
        errorView(createObj , "请输入用户名称...");
        return false;
    }else if(user_Name == null || user_Name != inputObj.value){//创建一个Ajax对象操作（检验课题名称是否存在）
        var nameRequest = newXMLHttpRequest();
        nameRequest.open("post" , "SchoolManageServlet?type=userName_ifExist&userName="+encodeURI(encodeURI($("userName").value)) , true);
        nameRequest.onreadystatechange = existUserName(nameRequest , inputObj);

        nameRequest.send(null);
        successView(createObj , "系统正在检索用户名称...");
    }else{
        successView(createObj , "验证通过...");
        return true;
    }
}
function existUserName(nameRequest , inputObj){
    return function(){
        if(nameRequest.readyState == 1 || nameRequest.readyState == 2 || nameRequest.readyState == 3){

        }else if(nameRequest.readyState == 4){
            if(nameRequest.status == 200){
                var result = nameRequest.responseText;

                if(result == "true"){
                    errorView(createObj , "该用户名已存在...");
                }else{
                    successView(createObj , "验证通过...");
                    user_Name = inputObj.value;
                }
            }
        }
    }
}

function submitEvent(userObj){
    return function(){
        if(!checkUserName($("userName"))){
            return false;
        }
        if($("userPassword").value == ""){
            errorView(userObj , "用户名密码不能为空!");
            return false;
        }

        var url = "SchoolManageServlet?type=save_Auditor&auditorName="+encodeURI(encodeURI($("userName").value))+"&userPW="+$("userPassword").value;
        window.open(url , "main_body");
    }
}

function errorView(obj , str){
    if(obj.errorView.style.display != "block"){
        obj.mWindow.setWindowHeight(obj.mWindow.getWindowHeight()+15);
    }
    obj.errorView.style.display = "block";
    obj.errorView.style.color = "red";
    obj.errorView.innerHTML = str;
};
function successView(obj , str){
    if(obj.errorView.style.display != "block"){
        obj.mWindow.setWindowHeight(obj.mWindow.getWindowHeight()+15);
    }
    obj.errorView.style.display = "block";
    obj.errorView.style.color = "green";
    obj.errorView.innerHTML = str;
};

/*
 * 人员资料文件
 */
var upfileObj = null;
function userInfoObj(){
    this.mWindow = null;
    this.errorView = null;
    this.commitStage = false;	//控制提交状态
}
userInfoObj.prototype.closeClick = function(parentObj){
    return function(){
        //判断该对象是否打开了遮罩层
        if(!parentObj.getParentObj().Win_closeC){
            parentObj.getParentObj().Win_cover.hiddenView();//隐藏遮罩对象
        }
        parentObj.getParentObj().closeWindow();//影藏对象
    };
};
userInfoObj.prototype.createView = function(fileObj , userId){
    var viewFrame = document.createElement("div");
    var url = "SchoolManageServlet?type=query_auditor_infor&query_userId="+userId;

    //请求信息
    var proView = document.createElement("div");
    proView.className = "proView";
    proView.innerHTML = "<iframe src="+url+" marginwidth='0' marginheight='0' frameborder='0' scrolling='no' width='100%' height='600px'></iframe>";

    this.errorView = document.createElement("div");
    this.errorView.className = "stage_req_error";
    this.errorView.style.display = "none";

    viewFrame.appendChild(proView);
    viewFrame.appendChild(this.errorView);
    fileObj.mWindow.Win_view.add_Child(viewFrame);
};


function cClickEvent(userId){
    var userInfo = new userInfoObj();
    var titleClose = new Window_close();
    titleClose.close_Click = userInfo.closeClick;
    var title = new Window_titleview(null , null, new Window_title("用户详细信息"), null, null, true, null, null, titleClose, null);//设置标题信息

    var margin_Left = (document.body.clientWidth - 600)/2;
    var frame = new Window_frame(600 , 495, 5, margin_Left, null, null, null, null, null, true);

    userInfo.mWindow = new moveWindow(frame , title, null, null, null, null, true, 1, null, null);
    userInfo.mWindow.create_View();

    userInfo.createView(userInfo , userId);
};

function queryClick(pageNo){
    var url = "SchoolManageServlet?type=query_school_auditors&pageNo="+pageNo+"&userName="+$("query_userName").value;
    window.open(url , "main_body");
};

function queryEvent(inputObj){
    return function(){
        inputObj.parentNode.className = "input_frame";
        var url = "SchoolManageServlet?type=query_school_auditors&userName="+$("query_userName").value;
        window.open(url , "main_body");
    }
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
.user_infor_frame{
	clear: both;
	width: 980px;
	margin: 0 auto;
    position:relative;
	
	overflow:hidden;
}
.user_infor_body {
	width: 800px;
    min-height: 435px;
	margin: 30px;
	margin-left:90px;
	padding: 9px;
	
	overflow:hidden;
	border: 1px solid #c3c4c5;
	background: #d8d7d7;
	border-radius:5px;
	box-shadow:3px 3px 2px #000;
}
.user_update_frame{
	width:100%;
    min-height: 435px;
	position:relative;
	background:white;
}
a{
    cursor:pointer;
    color:blue;
    text-decoration: none;
}
tr > td{
    font-size:12px;
    height:25px;
}
.user_file_info{
    background:#eeeeee;
}
.user_file_log{
    width:50px;
    height:50px;
    position:absolute;
    bottom:5px;
    left:5px;
    background:url(images/prompt_logo.png);
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
#add_users{
    width:50px;
    height:50px;
    position:absolute;
    top:10px;
    right:30px;
    cursor:pointer;
    background:url(images/find_project.png) no-repeat;
}
#add_users:hover{
    width:80px;
    height:80px;
    right:0px;
    background:url(images/find_project1.png) no-repeat;
}
.page_frame {
    position:absolute;
    bottom:5px;
    left:200px;
    width:500px;
    height:30px;
    line-height:30px;
}
.page_frame a{
    width:20px;
    height:20px;
    line-height:20px;
    color:#000000;
    float:left;
    text-align:center;
    cursor:pointer;
    margin-left:5px;
    border-radius:2px;
    box-shadow:1px 1px 1px #000;
}
.page_frame a:hover{
    background:#c3c4c5;
}
</style>
</head>

<body onload="init()">
<div class="user_infor_frame">
<div class="user_infor_body">
	<div class="user_update_frame">
        <div class="user_file_log"></div>
        <table width="100%" border="0">
        <tr style="height:40px;line-height:30px;"><td colspan="5" align="left">
            <span style="margin-left:20px;float:left;">搜索条件－》</span>
            <span style="margin-left:20px;float:left;">用户名：</span>
            <div class="input_frame"><input type="text" value="${userName}" name="query_userName" id="query_userName"/></div>
        </td></tr>

        <tr style="background:#d8d7d7;font-weight:bold;">
            <td width="30%" align="center">用户名</td>
            <td width="25%" align="center">密码</td>
            <td width="20%" align="center">头像</td>
            <td width="10%" align="center">用户类型</td>
            <td width="15%" align="center">操作</td>
        </tr>

        <c:forEach var="item" items="${userList}" varStatus="status">
            <tr class="<c:if test='${status.count%2==0}'>user_file_info</c:if>">
                <td align="center">${item.userName}</td>
                <td align="center">${item.userPassword}</td>
                <td align="center">${item.userHead}</td>
                <td align="center">${item.userType eq "A" ? "管理员" : "审核人员"}</td>
                <td align="center"><a onclick="cClickEvent(${item.id})">查询</a></td>
            </tr>
        </c:forEach>

        <tr>
            <td colspan="5" align="right">&nbsp;</td>
        </tr>
        </table>

        <div class="page_frame">
            <c:forEach var="item" begin="1" end="${countPage}" varStatus="status">
                <a onclick="queryClick(${item})" style="<c:if test='${item == pageNo}'>background:#c3c4c5</c:if>">
                    ${item}
                </a>
            </c:forEach>
        </div>
	</div>
</div>
<div id="add_users" title="添加用户数据源"></div>
</div>
</body>
</html>
