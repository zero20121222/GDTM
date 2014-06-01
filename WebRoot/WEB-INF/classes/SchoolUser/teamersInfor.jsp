<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>团队人员信息内容</title>
<link href="css/pagingCss.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<style>
.teamer_infor_body{
	width:960px;
	height:auto;
	
	margin:auto;
	margin-top:30px;
	padding-bottom:50px;
	
	position:relative;
}
#teamer_infors_out{/*这个作为一个隐藏框架对象*/
	width:924px;
	height:auto;
	
	position:relative;
	margin-left:30px;
	padding-bottom:10px;
	overflow:hidden;
}
.body_frame{
	width:900px;
	height:auto;
	
	float:left;
	margin-right:40px;
	overflow:hidden;
	border:9px solid #d8d7d7;
	background:white;
	border-radius:5px;
	box-shadow:3px 3px 2px #000;
}

.pro_frameout{
	float:left;
	width:390px;
	height:160px;
	
	cursor:default;
	margin-top:10px;
	margin-left:20px;
	margin-right:40px;
	margin-bottom:15px;
	overflow:hidden;
}
.pro_frame{
	position:relative;
	float:left;
	width:350px;
	height:150px;
	
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
	height:120px;
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
	width:48px;
	height:48px;
	float:left;
	margin:5px 5px 0px 30px;
	background:white;
	
	border:1px solid white;
	border-radius:3px;
	box-shadow:2px 2px 2px #000;
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
.add_to_select{
	width:30px;
	height:30px;
	float:left;
	cursor:pointer;
	background:url(images/add_to_select.png);
}
.pro_select{
	width:30px;
	height:30px;
	float:left;
	cursor:pointer;
	background:url(images/pro_select.png);
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
	
	display:none;
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
function init(){
	if($("teamer_infors_out").offsetHeight < 300){
		var iframe_name = "main_body";
		var frame = parent.document.getElementById(iframe_name);
		
		frame.style.marginTop = 0;
		frame.style.marginBottom = 0;
		frame.style.height = document.body.clientHeight+ 150 + "px";
	}else{
		suit_Page();
	}
}

function showTeamerInfor(teamerId){
	var url = "UserManageServlet?type=query_student_infor&user_id="+teamerId;
	window.open(url , "_self");
}

function showTeacherInfor(teamerId){
	var url = "UserManageServlet?type=query_teacher_infor&user_id="+teamerId;
	window.open(url , "_self");
}
</script>
</head>

<body onload="init()">
<div class="teamer_infor_body">
	<div id="teamer_infors_out">
		<input type="hidden" value="${school_id }" id="school_id"/>
		<input type="hidden" value="${user_id }" id="student_id"/>
		<div class="body_frame">
			<c:forEach items="${studentList}" var="stuInfor" varStatus="status">
			<div class="pro_frameout">
				<div class="pro_frame">
					<div class="frame_title">${status.index eq 0 ? '队长' : '队员' }${status.index eq 0 ? '' : status.index }</div>
					<div class="frame_body">
						<div class="pro_picture" style="background:url(headPictures/${stuInfor.commonUser.userHead })"></div>
						<div class="pro_infor">
						<table width='100%' height='115' border='0'>
							<tr>
								<td width='45%' align='right'>姓名：</td>
								<td width='55%' align='left'>${stuInfor.realName }</td>
							</tr>
							<tr>
								<td align='right'>院系类别：</td>
								<td align='left'>${stuInfor.college }</td>
							</tr>
							<tr>
								<td align='right'>专业类别：</td>
								<td align='left'>${stuInfor.major }</td>
							</tr>
							<tr>
								<td align='right'>性别：</td>
								<td align='left'>${stuInfor.sex eq 'M' ? '男' : '女' }</td>
							</tr>
						</table>
						</div>
					</div>
				</div>
				<div class="pro_select" title="详细信息" onclick="showTeamerInfor(${stuInfor.id })"></div>
			</div>
			</c:forEach>
			
			<!-- 教师信息 -->
			<div class="pro_frameout" style="display:${teaInfor == null ? 'none' : '' }">
				<div class="pro_frame">
				<div class="frame_title">指导老师</div>
					<div class="frame_body">
						<div class="pro_picture" style="background:url(headPictures/${teaInfor.commonUser.userHead })"></div>
						<div class="pro_infor">
						<table width='100%' height='115' border='0'>
							<tr>
								<td width='45%' align='right'>姓名：</td>
								<td width='55%' align='left'>${teaInfor.realName }</td>
							</tr>
							<tr>
								<td align='right'>院系类别：</td>
								<td align='left'>${teaInfor.college }</td>
							</tr>
							<tr>
								<td align='right'>职位：</td>
								<td align='left'>${teaInfor.position }</td>
							</tr>
							<tr>
								<td align='right'>性别：</td>
								<td align='left'>${teaInfor.sex eq 'M' ? '男' : '女' }</td>
							</tr>
						</table>
						</div>
					</div>
				</div>
				<div class="pro_select" title="详细信息" onclick="showTeacherInfor(${teaInfor.id })"></div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
