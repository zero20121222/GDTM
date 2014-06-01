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
<title>学校院系管理</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script type="text/javascript" src="js/School_User_CL.js"></script>
<script>
function init(){
	suit_Page();
}

/*
 * 公告详细信息
 */
function collegeInfo(){
    this.mWindow = null;
    this.errorView = null;
    this.commitStage = false;	//控制提交状态
}
collegeInfo.prototype.closeClick = function(parentObj){
    return function(){
        //判断该对象是否打开了遮罩层
        if(!parentObj.getParentObj().Win_closeC){
            parentObj.getParentObj().Win_cover.hiddenView();//隐藏遮罩对象
        }
        parentObj.getParentObj().closeWindow();//影藏对象
    };
};
collegeInfo.prototype.createView = function(fileObj , collegeName){
    var viewFrame = document.createElement("div");
    var url = "SchoolManageServlet?type=query_detail_college&collegeName="+encodeURI(encodeURI(collegeName));

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

function cClickEvent(collegeName){
    var userInfo = new collegeInfo();
    var titleClose = new Window_close();
    titleClose.close_Click = userInfo.closeClick;
    var title = new Window_titleview(null , null, new Window_title("学校院系详细信息"), null, null, true, null, null, titleClose, null);//设置标题信息

    var margin_Left = (document.body.clientWidth - 650)/2;
    var frame = new Window_frame(650 , 430, 20, margin_Left, null, null, null, null, null, true);

    userInfo.mWindow = new moveWindow(frame , title, null, null, null, null, true, 1, null, null);
    userInfo.mWindow.create_View();

    userInfo.createView(userInfo , collegeName);
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
    min-height: 410px;
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
    min-height: 410px;
	position:relative;
	background:white;
}
.user_file_log{
    width:50px;
    height:50px;
    position:absolute;
    bottom:5px;
    left:5px;
    background:url(images/stage_file_min.png);
}
a{
    color:blue;
    cursor:pointer;
    text-decoration: none;
}
tr > td{
    font-size:12px;
    height:25px;
}
.user_file_info{
    background:#eeeeee;
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
</style>
</head>

<body onload="init()">
<div class="user_infor_frame">
<div class="user_infor_body">
	<div class="user_update_frame">
        <div class="user_file_log"></div>
        <table width="100%" border="0">
        <tr><td colspan="6" align="right">&nbsp;</td></tr>

        <tr style="background:#d8d7d7;font-weight:bold;">
            <td align="center" width="18%">院系名称</td>
            <td align="center" width="18%">院系专业1</td>
            <td align="center" width="18%">院系专业2</td>
            <td align="center" width="18%">院系专业3</td>
            <td align="center" width="18%">院系专业4</td>
            <td align="center" width="10%">操作</td>
        </tr>

        <c:forEach var="item" items="${collegeList}" varStatus="status">
            <tr class="<c:if test='${status.count%2==0}'>user_file_info</c:if>">
                <td align="center">${item.collegeName}</td>
                <td align="center">${item.major1}</td>
                <td align="center">${item.major2}</td>
                <td align="center">${item.major3}</td>
                <td align="center">${item.major4}</td>
                <td align="center"><a onclick="cClickEvent('${item.collegeName}')">查看全部</a></td>
            </tr>
        </c:forEach>

        <tr>
            <td colspan="6" align="right">&nbsp;</td>
        </tr>
        </table>
	</div>
</div>
</div>
</body>
</html>
