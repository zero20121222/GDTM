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
<title>指导的团队信息页面</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
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
.team_stage_view{
	position:absolute;
	top:0px;
	right:0px;
	width:80px;
	height:80px;
	z-index:100;
	background:url(images/req_team_wait.png) no-repeat 50%;
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
.pro_select{
	width:30px;
	height:30px;
	float:left;
	cursor:pointer;
	background:url(images/pro_select.png);
}

.pro_createrName{
	cursor:pointer;
	font-weight:bold;
	font-size:13px;
	color: #666;
	text-decoration:none;
}
.pro_createrName:hover{
	color:#A5A5A5;
}
.title_view_style {
	font-size: 18px;
	font-family: 华文行楷;
}
</style>
<script>
var manageTeam = null;
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
		<div class="body_frame" id="teamer_inforView">
			<table width="100%" style="font-size:13px;" border="0">
			  <tr><td colspan="4" height="15px"></td></tr>
              <tr>
                <td width="32%" height="30px" align="right">题目名称：</td>
                <td width="18%" align="left"><span>《${projectInfor.projectName }》</span></td>
                <td width="15%" align="right">出题人：</td>
                <td width="35%" align="left">
                	<a class="pro_createrName" href="ProjectManagerServlet?type=query_creater_infor&creater_id=${projectInfor.createrId }">${projectInfor.createrName }</a>
                </td>
              </tr>
              
              <tr>
                <td height="30px" align="right">参与人数限定：</td>
                <td align="left"><span>${projectInfor.partNum }&nbsp;人</span></td>
                <td align="right">工作量大小：</td>
                <td align="left"><span>${projectInfor.workload eq "1" ? "工作量较轻" : (projectInfor.workload eq "2" ? "工作量较重" : "工作量很重")}</span></td>
              </tr>
              
              <tr>
                <td height="30px" align="right">院系限定：</td>
                <td colspan="2" align="left"><span>${projectInfor.college eq "null" ? "无院系限定" : projectInfor.college}</span></td>
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
			  </tr>
			  
			  <tr>
                <td height="30px" align="center" class="title_view_style">团队信息</td>
                <td colspan="2" align="left">&nbsp;</td>
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
			  </tr>
            </table>
			
			<hr style="border:1px dashed #c3c4c5;clear:both;"/>
			<c:forEach items="${studentList}" var="stuInfor" varStatus="status">
			<div class="pro_frameout" name="stu_teamer">
				<input type="hidden" value="${stuInfor.replyResult}"/>
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
			<div class="pro_frameout" name="tea_teamer">
				<div class="pro_frame">
				<div class="frame_title">指导老师</div>
					<div class="frame_body">
						<div class="pro_picture" style="background:url(headPictures/${teacherInfor.commonUser.userHead })"></div>
						<div class="pro_infor">
						<table width='100%' height='115' border='0'>
							<tr>
								<td width='45%' align='right'>姓名：</td>
								<td width='55%' align='left'>${teacherInfor.realName }</td>
							</tr>
							<tr>
								<td align='right'>院系类别：</td>
								<td align='left'>${teacherInfor.college }</td>
							</tr>
							<tr>
								<td align='right'>职位：</td>
								<td align='left'>${teacherInfor.position }</td>
							</tr>
							<tr>
								<td align='right'>性别：</td>
								<td align='left'>${teacherInfor.sex eq 'M' ? '男' : '女' }</td>
							</tr>
						</table>
						</div>
					</div>
				</div>
				<div class="pro_select" title="详细信息" onclick="showTeacherInfor(${teacherInfor.id })"></div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
