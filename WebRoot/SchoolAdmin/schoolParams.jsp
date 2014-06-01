<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>学校参数更改</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script type="text/javascript" src="js/School_User_CL.js"></script>
<script>
function init(){
	suit_Page();
	var logon = new logonInputFactory();
	logon.createView();
}

/* 注册input的onblur和onfocus事件处理类 */
function logonInputFactory(){}
logonInputFactory.prototype.createView = function(){
	var submit = new updateSubmitObj($("update_submit"));
	submit.createView();
}

//信息提交按钮事件处理设定
var formsubmit = false;//用于控制是否已经点击submit按钮
function updateSubmitObj(submitObj){
	this.submitObj = submitObj;
}
updateSubmitObj.prototype.createView = function(){
	addEvent(this.submitObj , "click", this.clickEvent);
}
updateSubmitObj.prototype.clickEvent = function(){
	if(checkValue() && !formsubmit){
		$("update_params_form").action = "SchoolManageServlet?type=update_school_params";

		$("update_result").style.display = "block";
		$("update_result").innerHTML = "信息正在检索...";
        formsubmit = true;
		$("update_params_form").submit();
	}
};
function checkValue(){
    if($("parterUpperLimit").value == "" || !checkmath($("parterUpperLimit").value) || $("parterUpperLimit").value <= 0){
        $("update_result").style.display = "block";
        $("update_result").style.color = "red";
        $("update_result").innerHTML = "课题参与人数上限数据格式不正确";
        return false;
    }

    if($("stageUpperTime").value == "" || !checkmath($("stageUpperTime").value) || $("stageUpperTime").value <= 0){
        $("update_result").style.display = "block";
        $("update_result").style.color = "red";
        $("update_result").innerHTML = "课题阶段总时间上限数据格式不正确";
        return false;
    }

    if($("auditNumber").value == "" || !checkmath($("auditNumber").value) || $("auditNumber").value <= 0){
        $("update_result").style.display = "block";
        $("update_result").style.color = "red";
        $("update_result").innerHTML = "审核课题人数数据格式不正确";
        return false;
    }

    if($("auditNumber").value > 3){
        $("update_result").style.display = "block";
        $("update_result").style.color = "red";
        $("update_result").innerHTML = "审核课题人数最多3人";
        return false;
    }

    if($("adoptNumber").value == "" || !checkmath($("adoptNumber").value) || $("adoptNumber").value <= 0){
        $("update_result").style.display = "block";
        $("update_result").style.color = "red";
        $("update_result").innerHTML = "审核通过人数数据格式不正确";
        return false;
    }

    if($("stageUpperLimit").value == "" || !checkmath($("stageUpperLimit").value) || $("stageUpperLimit").value <= 0){
        $("update_result").style.display = "block";
        $("update_result").style.color = "red";
        $("update_result").innerHTML = "课题阶段上限数据格式不正确";
        return false;
    }

    if($("stageFloorLimit").value == "" || !checkmath($("stageFloorLimit").value) || $("stageFloorLimit").value <= 0
            || parseInt($("stageFloorLimit").value) > parseInt($("stageUpperLimit").value)){
        $("update_result").style.display = "block";
        $("update_result").style.color = "red";
        $("update_result").innerHTML = "课题阶段下限数据格式不正确";
        return false;
    }

    if($("proSelectLimit").value == "" || !checkmath($("proSelectLimit").value) || $("proSelectLimit").value <= 0){
        $("update_result").style.display = "block";
        $("update_result").style.color = "red";
        $("update_result").innerHTML = "课题所选次数上限数据格式不正确";
        return false;
    }

    if($("guideTeamLimit").value == "" || !checkmath($("guideTeamLimit").value) || $("guideTeamLimit").value <= 0){
        $("update_result").style.display = "block";
        $("update_result").style.color = "red";
        $("update_result").innerHTML = "指导团队上限数据格式不正确";
        return false;
    }

    return true;
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
	
	overflow:hidden;
}
.user_infor_body {
	width: 800px;
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
	height:auto;
	position:relative;
	background:white;
}
input{
	width:40px;
	height:20px;
	margin-top:5px;
	margin-left:7px;
	line-height:20px;
	font-size:13px;
    border-radius:3px;
	font-family:Verdana,Tahoma,Arial;
}
#update_submit{
	width:102px;
	height:29px;
	
	font-size:13px;
	font-weight:bold;
	line-height:29px;
	color:white;
	cursor:pointer;
	background:url(images/frame_button0.png) no-repeat;
	border:0px none;
}
#update_submit:hover {
    background: url(images/frame_button1.png) no-repeat;
}
.error_infor{
	color:red;
	font-size:12px;
	font-weight:bold;
	display:none;
}
tr > td{
	font-size:14px;
}
.user_update_log{
	width:64px;
	height:64px;
	position:absolute;
	top:20px;
	left:40px;
	background:url(images/school_params.png);
}
.update_result_view{
	color:green;
	font-size:12px;
	font-weight:bold;
	display:none;
}
</style>
</head>

<body onload="init()">
<div class="user_infor_frame">
<div class="user_infor_body">
	<div class="user_update_frame">
		<div class="user_update_log"></div>
		<form id="update_params_form" method="post">
			<table width="100%" border="0">
			<tr>
			  <td colspan="3" align="right">&nbsp;</td>
			</tr>
			
			<tr>
			  <td align="right" width="40%">
			  	课题参与人数上限：
			  </td>
			  <td align="left">
                  <input type="text" name="parterUpperLimit" id="parterUpperLimit" value="${schoolParams.parterUpperLimit }"/>

                  <span style="margin-left:20px">课题阶段总时间上限：</span>
                  <input type="text" name="stageUpperTime" id="stageUpperTime" value="${schoolParams.stageUpperTime }"/>
			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left">&nbsp;</td>
			</tr>
			
			<tr>
			  <td align="right">
			  	审核课题人数：
			  </td>
			  <td align="left">
			  	<input type="text" name="auditNumber" id="auditNumber" value="${schoolParams.auditNumber }"/>

                <span style="margin-left:46px">审核课题通过数：</span>
                <input type="text" name="adoptNumber" id="adoptNumber" value="${schoolParams.adoptNumber }"/>
			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="user_office_error" class="error_infor"></span></td>
			</tr>
			
			<tr>
			  <td align="right">课题阶段上限：</td>
			  <td align="left">
			  	<input type="text" name="stageUpperLimit" id="stageUpperLimit" value="${schoolParams.stageUpperLimit }"/>

                <span style="margin-left:60px">课题阶段下限：</span>
                <input type="text" name="stageFloorLimit" id="stageFloorLimit" value="${schoolParams.stageFloorLimit }"/>
			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="user_age_error" class="error_infor"></span></td>
			</tr>

			<tr>
			  <td align="right">课题所选次数上限：</td>
			  <td align="left">
			  	<input type="text" name="proSelectLimit" value="${schoolParams.proSelectLimit }" id="proSelectLimit"/>

                <span style="margin-left:60px">指导团队上限：</span>
                <input type="text" name="guideTeamLimit" id="guideTeamLimit" value="${schoolParams.guideTeamLimit }"/>
              </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="user_card_error" class="error_infor"></span></td>
			</tr>
			<tr>
			  <td align="right">通告显示条数：</td>
			  <td align="left">
                <input type="text" name="noticeNum" id="noticeNum" value="${schoolParams.noticeNum }"/>
			  </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="user_address_error" class="error_infor"></span></td>
			</tr>
			<tr>
			  <td align="right">是否可更改账户：</td>
			  <td align="left">
                  <select name="updateAccount">
                      <option ${schoolParams.updateAccount eq "T" ? "checked='checked'" : ""} value="T">可更改</option>
                      <option ${schoolParams.updateAccount eq "F" ? "checked='checked'" : ""} value="F">不可更改</option>
                  </select>
                  <span style="margin-left:20px;">覆盖用户数据源：</span>
                  <select name="coverFiles">
                      <option ${schoolParams.coverFiles eq "T" ? "checked='checked'" : ""} value="T">覆盖</option>
                      <option ${schoolParams.coverFiles eq "F" ? "checked='checked'" : ""} value="F">不覆盖</option>
                  </select>
                </td>
              </td>
			</tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><span id="user_phone_error" class="error_infor"></span></td>
			</tr>

            <tr>
                <td align="right">
                    信息是否公开：
                </td>
                <td align="left">
                    <select name="inforOvert">
                        <option ${schoolParams.inforOvert eq "T" ? "checked='checked'" : ""} value="T">公开</option>
                        <option ${schoolParams.inforOvert eq "F" ? "checked='checked'" : ""} value="F">不公开</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="right">&nbsp;</td>
                <td align="left"><span class="update_result_view" id="update_result"></span></td>
            </tr>

			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left"><input type="button" id="update_submit" value="更改参数"/></td>
			  </tr>
			<tr>
			  <td align="right">&nbsp;</td>
			  <td align="left">&nbsp;</td>
			</tr>
			</table>
		</form>
	</div>
</div>
</div>
</body>
</html>
