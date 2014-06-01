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
<title>学校公告信息</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script type="text/javascript" src="js/School_User_CL.js"></script>
<script>
function init(){
	suit_Page();

    var fileObj = new userFileObj($("add_users"));
    fileObj.initObj();
}

/*
 * 资料文件
 */
var upfileObj = null;
var upPictureObj = null;
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
        var title = new Window_titleview(null , null, new Window_title("学校公告信息"), null, null, false, null, null, titleClose, null);//设置标题信息

        var margin_Left = (document.body.clientWidth - 650)/2;
        var frame = new Window_frame(650 , 325, 55, margin_Left, null, null, null, null, null, true);

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
    var view = "<table width='100%' border='0'>"
            +"<tr style='height:40px;'><td width='30%' height='40px' align='right'>信息标题：</td>"
            +"<td colspan='3' align='left'><div class='input_frame'><input type='text' name='title' id='title'/></div></td></tr>"

            +"<tr><td width='30%' height='40px' align='right'>创建人：</td>"
            +"<td width='20%' align='left'>"+new userNameObj().readTrueName()+"</td>"
            +"<td colspan='2' align='right'></td></tr>"

            +"<tr style='height:40px;'><td width='30%' align='right'>资料文件：</td>"
            +"<td colspan='3' align='left'><form id='stage_file_form' target='upload_iframe' class='upload_form' enctype='multipart/form-data' method='post'>"
            +"<div class='input_frame'><input type='file' id='stage_file_input' class='upload_file_input' hidefocus='hidefocus' name='project_file'/>"
            +"<input type='text' id='invented_stage_file' name='invented_stage_file' readonly/><div class='select_upload'></div></div>"
            +"<input type='button' id='file_send_submit' class='upload_submit' value='发送'/>"
            +"<iframe name='upload_iframe' style='display:none'></iframe></form></td></tr>"

            +"<tr style='height:40px;'><td width='30%' align='right'>图片信息：</td>"
            +"<td colspan='3' align='left'><form id='picture_form' target='upload_iframe' class='upload_form' enctype='multipart/form-data' method='post'>"
            +"<div class='input_frame'><input type='file' id='picture_input' class='upload_file_input' hidefocus='hidefocus' name='project_file'/>"
            +"<input type='text' id='picture_file' name='picture_file' readonly/><div class='select_upload'></div></div>"
            +"<input type='button' id='picture_send_submit' class='upload_submit' value='发送'/>"
            +"<iframe name='upload_iframe' style='display:none'></iframe></form></td></tr>"

            +"<tr style='height:40px;'><td width='30%' height='30px' align='right'>详细内容：</td>"
            +"<td colspan='3' align='left'><div class='textarea_frame'><textarea id='content' name='content' class='content'></textarea></div></td></tr>"

            +"<tr style='height:40px;'><td colspan='4'><input type='button' id='new_submit' class='upload_submit' value='提交'/></td></tr></table>";

    proView.innerHTML = view;

    this.errorView = document.createElement("div");
    this.errorView.className = "stage_req_error";
    this.errorView.style.display = "none";

    viewFrame.appendChild(proView);
    viewFrame.appendChild(this.errorView);
    fileObj.mWindow.Win_view.add_Child(viewFrame);

    var content = new textareaElementObj($("content") , 200);
    content.createView();

    var title = new inputElementObj($("title"));
    title.createView();

    //注册上传文组件
    upfileObj = new uploadFileObj($("stage_file_input") , $("invented_stage_file"), $("stage_file_form"), $("file_send_submit"),
                    "FileManageServlet?type=school_new_file", "file", this);
    upfileObj.createView();

    //注册上传图片组件
    upPictureObj = new uploadFileObj($("picture_input") , $("picture_file"), $("picture_form"), $("picture_send_submit"),
            "FileManageServlet?type=school_picture_file", "picture", this);
    upPictureObj.createView();

    $("new_submit").onclick = newsSubmit(this);
};

//提交通知信息
function newsSubmit(newsObj){
    return function(){
        if($("title").value == ""){
            upfileObj.errorView("信息标题不能为空");
            return false;
        }else if(upfileObj.uploadFileName == null){
            upfileObj.errorView("资料文件不能为空");
            return false;
        }else if(upfileObj.uploadFileName.length > 30){
            upfileObj.errorView("资料文件名长度不能超过30个字");
            return false;
        }else if(upPictureObj.uploadFileName == null){
            upfileObj.errorView("图片信息不能为空");
            return false;
        }else if(upPictureObj.uploadFileName.length > 30){
            upfileObj.errorView("图片名长度不能超过30个字");
            return false;
        }else if($("content").value == ""){
            upfileObj.errorView("详细内容不能为空");
            return false;
        }
        var title = encodeURI(encodeURI($("title").value));
        var content = encodeURI(encodeURI($("content").value));
        var upfile_name = encodeURI(encodeURI(upfileObj.uploadFileName));
        var uppicture_name = encodeURI(encodeURI(upPictureObj.uploadFileName));

        var url = "SchoolManageServlet?type=school_creat_News&title="+title+"&content="+content+"&upfile_name="+upfile_name+"&uppicture_name="+uppicture_name;
        window.open(url , "main_body");
    }
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
            upfileObj.frameObj.action = upfileObj.upurl+"&oldFileName="+encodeURI(encodeURI(upfileObj.uploadFileName));

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

/*
 * 公告详细信息
 */
function newInfoObj(){
    this.mWindow = null;
    this.errorView = null;
    this.commitStage = false;	//控制提交状态
}
newInfoObj.prototype.closeClick = function(parentObj){
    return function(){
        //判断该对象是否打开了遮罩层
        if(!parentObj.getParentObj().Win_closeC){
            parentObj.getParentObj().Win_cover.hiddenView();//隐藏遮罩对象
        }
        parentObj.getParentObj().closeWindow();//影藏对象
    };
};
newInfoObj.prototype.createView = function(fileObj , newId){
    var viewFrame = document.createElement("div");
    var url = "SchoolManageServlet?type=query_new_infor&query_newId="+newId;

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


function cClickEvent(newId){
    var userInfo = new newInfoObj();
    var titleClose = new Window_close();
    titleClose.close_Click = userInfo.closeClick;
    var title = new Window_titleview(null , null, new Window_title("公告详细信息"), null, null, true, null, null, titleClose, null);//设置标题信息

    var margin_Left = (document.body.clientWidth - 650)/2;
    var frame = new Window_frame(650 , 420, 20, margin_Left, null, null, null, null, null, true);

    userInfo.mWindow = new moveWindow(frame , title, null, null, null, null, true, 1, null, null);
    userInfo.mWindow.create_View();

    userInfo.createView(userInfo , newId);
};

function queryClick(pageNo){
    var url = "SchoolManageServlet?type=query_school_news&pageNo="+pageNo;
    window.open(url , "main_body");
};

/*
 * 删除操作
 */
function deleteNews(newsId){
    var promptWin = new promptWindow();
    promptWin.leftBtnClick = commitEvent(promptWin , newsId);
    promptWin.rightBtnClick = errorEvent(promptWin);
    promptWin.createSelectView("<span style='color:red;font-size:12px;'>你确认要删除该通告信息？</span><span style='font-size:10px;font-weight:normal;'>(提交后无法更改!)</span>" , "确定" , "取消");
    promptWin.mWindow.setWindowX(500);
    promptWin.mWindow.setWindowY(300);
};
function errorEvent(promptWin){
    return function(){
        promptWin.closeWindow();
    }
};
function commitEvent(promptWin , newsId){
    return function(){
        promptWin.closeWindow();

        window.open("SchoolManageServlet?type=delete_school_new&newsId="+newsId , "main_body");
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
.content{
    margin-top:10px;
    margin-left:10px;
    min-width:300px;
    min-height:70px;
    max-width:300px;
    max-height:70px;
    font-size:13px;
    overflow:hidden;
    border:0px none;
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
        <tr><td colspan="6" align="right">&nbsp;</td></tr>

        <tr style="background:#d8d7d7;font-weight:bold;">
            <td align="center" width="25%">信息标题</td>
            <td align="center" width="10%">发布人员</td>
            <td align="center" width="18%">上传文件</td>
            <td align="center" width="15%">图片信息</td>
            <td align="center" width="20%">发布时间</td>
            <td align="center" width="12%">操作</td>
        </tr>

        <c:forEach var="item" items="${newList}" varStatus="status">
            <tr class="<c:if test='${status.count%2==0}'>user_file_info</c:if>">
                <td align="center">${item.title}</td>
                <td align="center">${item.senderName}</td>
                <td align="center">${item.contentFile}</td>
                <td align="center">${item.picture}</td>
                <td align="center">${item.time}</td>
                <td align="center"><a onclick="cClickEvent(${item.id})">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;<a onclick="deleteNews(${item.id})">删除</a></td>
            </tr>
        </c:forEach>

        <tr>
            <td colspan="6" align="right">&nbsp;</td>
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
<div id="add_users" title="添加新公告信息"></div>
</div>
</body>
</html>
