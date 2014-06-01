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
<title>用户数据信息</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script type="text/javascript" src="js/School_User_CL.js"></script>
<script>
function init(){
	suit_Page();

    var nameObj = new inputElementObj($("query_userName"));
    nameObj.onblurEvent = queryEvent;
    nameObj.createView();
}

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
    var url = "SchoolManageServlet?type=query_user_infor&query_userId="+userId;

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
    var frame = new Window_frame(600 , 480, 5, margin_Left, null, null, null, null, null, true);

    userInfo.mWindow = new moveWindow(frame , title, null, null, null, null, true, 1, null, null);
    userInfo.mWindow.create_View();

    userInfo.createView(userInfo , userId);
};

function queryClick(pageNo){
    var url = "SchoolManageServlet?type=query_school_users&pageNo="+pageNo+"&userName="+$("query_userName").value;
    window.open(url , "main_body");
};

function queryEvent(inputObj){
    return function(){
        inputObj.parentNode.className = "input_frame";
        var url = "SchoolManageServlet?type=query_school_users&userName="+$("query_userName").value;
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
                <td align="center">${item.userType eq "S" ? "学生" : "教师"}</td>
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
</div>
</body>
</html>
