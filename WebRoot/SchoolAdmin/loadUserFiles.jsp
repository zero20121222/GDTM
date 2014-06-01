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
<title>加载用户数据文件</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script type="text/javascript" src="js/School_User_CL.js"></script>
<script>
function init(){
	suit_Page();

    var fileObj = new userFileObj($("add_users"));
    fileObj.initObj();
}

/*
 * 人员资料文件
 */
var upfileObj = null;
function userFileObj(buttonObj){
    this.buttonObj = buttonObj;

    this.mWindow = null;
    this.errorView = null;
    this.commitStage = false;	//控制提交状态
}
userFileObj.prototype.initObj = function(){
    addEvent(this.buttonObj , "click", this.cClickEvent(this));
}
userFileObj.prototype.cClickEvent = function(fileObj){
    return function(){
        var titleClose = new Window_close();
        titleClose.close_Click = fileObj.closeClick;
        var title = new Window_titleview(null , null, new Window_title("人员数据源（上传限于:xls,xlsx）"), null, null, false, null, null, titleClose, null);//设置标题信息

        var margin_Left = (document.body.clientWidth - 600)/2;
        var frame = new Window_frame(600 , 130, 100, margin_Left, null, null, null, null, null, true);

        fileObj.mWindow = new moveWindow(frame , title, null, null, null, null, true, 1, null, null);
        fileObj.mWindow.create_View();

        fileObj.createView(fileObj);
    };
};
userFileObj.prototype.closeClick = function(parentObj){
    return function(){
        //判断该对象是否打开了遮罩层
        if(!parentObj.getParentObj().Win_closeC){
            parentObj.getParentObj().Win_cover.hiddenView();//隐藏遮罩对象
        }
        parentObj.getParentObj().closeWindow();//影藏对象
    };
};
userFileObj.prototype.createView = function(fileObj){
    var viewFrame = document.createElement("div");

    //请求信息
    var proView = document.createElement("div");
    proView.className = "proView";
    proView.innerHTML = "<table width='100%' border='0'>"
            +"<tr><td width='30%' height='30px' align='right'>上传人：</td>"
            +"<td width='20%' align='left'>"+new userNameObj().readTrueName()+"</td>"
            +"<td width='15%' align='right'>数据类型：</td><td align='left'>"
            +"<select id='fileType'><option value='A'>全部</option><option value='T'>教师</option><option value='S'>学生</option></select></td></tr>"

            +"<tr><td width='30%' height='30px' align='right'>自动导入：</td>"
            +"<td width='20%' align='left'><input style='width:50px' id='autoLoad' type='checkbox' checked='checked'/></td>"
            +"<td colspan='2'></td></tr>"

            +"<tr><td width='30%' align='right'>数据源文件：</td>"
            +"<td colspan='3' align='left'><form id='stage_file_form' target='upload_iframe' class='upload_form' enctype='multipart/form-data' method='post'>"
            +"<div class='input_frame'><input type='file' id='stage_file_input' class='upload_file_input' hidefocus='hidefocus' name='project_file'/>"
            +"<input type='text' id='invented_stage_file' name='invented_stage_file' readonly/><div class='select_upload'></div></div>"
            +"<input type='button' id='file_send_submit' class='upload_submit' value='发送'/>"
            +"<iframe name='upload_iframe' style='display:none'></iframe></form></td></tr></table>";

    this.errorView = document.createElement("div");
    this.errorView.className = "stage_req_error";
    this.errorView.style.display = "none";

    viewFrame.appendChild(proView);
    viewFrame.appendChild(this.errorView);
    fileObj.mWindow.Win_view.add_Child(viewFrame);

    //注册上传文件插件
    upfileObj = new uploadFileObj($("stage_file_input") , $("invented_stage_file"), $("stage_file_form"), $("file_send_submit"),
                    "FileManageServlet?type=userFilesUpLoad", "file", this);
    upfileObj.createView();
};

//文件上传组建
function uploadFileObj(uploadObj, enterObj, frameObj , submitObj, upurl, filetype, stageFileObj){
    this.uploadObj = uploadObj;
    this.enterObj = enterObj;
    this.frameObj = frameObj;
    this.submitObj = submitObj;

    this.upurl = upurl;
    this.filetype = filetype == null || undefined ? "file" : filetype;
    this.stageFileObj = stageFileObj;

    this.uploadFileName = null;//用于记录上传的文件名
    this.submitEvent = false;
    this.uploadSuccess = false;//上传文件结果
}
uploadFileObj.prototype.createView = function(){
    addEvent(this.uploadObj , "change", this.onchangeEvent(this));
    addEvent(this.submitObj , "click", this.uploadFile(this));
};
uploadFileObj.prototype.onchangeEvent = function(upfileObj){//当输入的文档路径更改时调用
    return function(){
        if(upfileObj.stageFileObj.errorView.style.display == "block"){
            upfileObj.stageFileObj.mWindow.setWindowHeight(upfileObj.stageFileObj.mWindow.getWindowHeight()-15);
        }
        upfileObj.enterObj.value = upfileObj.uploadObj.value;
        upfileObj.stageFileObj.errorView.style.display = "none";
    };
};
uploadFileObj.prototype.uploadFile = function(upfileObj){
    return function(){
        if(upfileObj.upurl == null || undefined){

        }else{
            upfileObj.frameObj.action = upfileObj.upurl+"&fileType="+$("fileType").value+"&autoLoad="+$("autoLoad").checked
                    +"&oldFileName="+encodeURI(encodeURI(upfileObj.uploadFileName));

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
    }
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
    if(this.stageFileObj.errorView.style.display != "block"){
        this.stageFileObj.mWindow.setWindowHeight(this.stageFileObj.mWindow.getWindowHeight()+15);
    }
    this.stageFileObj.errorView.style.display = "block";
    this.stageFileObj.errorView.style.color = "green";
    this.stageFileObj.errorView.innerHTML = str;
};
uploadFileObj.prototype.successUpload = function(str){
    if(this.stageFileObj.errorView.style.display != "block"){
        this.stageFileObj.mWindow.setWindowHeight(this.stageFileObj.mWindow.getWindowHeight()+15);
    }
    this.stageFileObj.errorView.style.display = "block";
    this.stageFileObj.errorView.style.color = "green";
    this.stageFileObj.errorView.innerHTML = str;

    //重新加载当前的文档资源信息
    window.open("SchoolManageServlet?type=query_school_files" , "main_body");
};
uploadFileObj.prototype.errorView = function(str){//文件格式问题
    if(this.stageFileObj.errorView.style.display != "block"){
        this.stageFileObj.mWindow.setWindowHeight(this.stageFileObj.mWindow.getWindowHeight()+15);
    }
    this.stageFileObj.errorView.style.display = "block";
    this.stageFileObj.errorView.style.color = "red";
    this.stageFileObj.errorView.innerHTML = str;
    this.reflashButtonEvent();
};
uploadFileObj.prototype.getUploadFileName = function(){//获取上传文件名称
    if(this.enterObj.value != ""){
        var nameObj = this.enterObj.value.split("\\");

        return nameObj[nameObj.length-1];//返回上传文件名
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
            <td align="center">数据源文件名称</td>
            <td align="center">数据源类型</td>
            <td align="center">导入状态</td>
            <td align="center">成功导入数量</td>
            <td align="center">创建时间</td>
            <td align="center">操作</td>
        </tr>

        <c:forEach var="item" items="${usersFileList}" varStatus="status">
            <tr class="<c:if test='${status.count%2==0}'>user_file_info</c:if>">
                <td align="center">${item.name}</td>
                <td align="center">${item.type eq "A" ? "全部" : item.type eq "S" ? "学生" : "教师"}</td>
                <td align="center">${item.ifLoad eq "T" ? "<span style='color:green'>已导入</span>" : "<span style='color:red'>未导入</span>"}</td>
                <td align="center">${item.loadCount}</td>
                <td align="center">${item.createdAt}</td>
                <td align="center"><a href="#">${item.ifLoad eq "T" ? "查询" : "重新导入"}</a></td>
            </tr>
        </c:forEach>

        <tr>
            <td colspan="6" align="right">&nbsp;</td>
        </tr>
        </table>
	</div>
</div>
<div id="add_users" title="添加用户数据源"></div>
</div>
</body>
</html>
