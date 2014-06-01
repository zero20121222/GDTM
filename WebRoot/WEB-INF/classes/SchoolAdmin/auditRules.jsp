<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>课题审核人员信息</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script>
    function init(){
        suit_Page();

        //注册返回上一页的事件操作
        $("break_old_page").onclick = function(){
            window.history.back();
        };
    }
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
    .project_creater_frame{
        clear: both;
        width: 980px;
        margin: 0 auto;

        overflow:hidden;
    }
    .project_creater_body {
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
    .tea_logon_frame{
        width:100%;
        background:white;
    }
    .project_creater_infor_frame{
        position:relative;
        width:500px;
        margin:0px auto;
        background:white;
    }
    .input_frame{
        width:195px;
        height:30px;
        float:left;
        background:url(images/input_noenter.png);
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
    #break_old_page{
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
    #break_old_page:hover{
        background:url(images/frame_button1.png) no-repeat;
    }
    .sex_radio{
        width:auto;
        height:auto;
        margin-top:5px;
        margin-left:7px;
        margin-right:4px;
    }
    tr > td{
        font-size:14px;
    }
    .textarea_frame{
        width:320px;
        height:90px;
        background:url(images/textarea_noenter.png);
    }
    .user_resume{
        margin-top:10px;
        margin-left:10px;
        min-width:300px;
        min-height:70px;
        max-width:300px;
        max-height:70px;
        color: #666;
        font-size:13px;
        overflow:hidden;
        border:0px none;
    }
    .project_creater_log{
        width:128px;
        height:128px;
        position:absolute;
        top:20px;
        right:20px;
        background:url(images/teacher_logon_log.png);
    }
    .project_words_style {
        width:400px;
        text-indent:20px;
        font-size: 12px;
        font-family: 宋体;
    }
</style>
</head>

<body onload="init()">
<div class="project_creater_frame">
    <div class="project_creater_body">
        <div class="tea_logon_frame">
            <div class="project_creater_infor_frame">
                <div class="project_creater_log"></div>
                <table width="100%" border="0">
                    <tr>
                        <td colspan="3" align="right">&nbsp;</td>
                    </tr>
                    <tr>
                        <td width="21%" align="right">
                            <span style="color:red">*&nbsp;</span>真实姓名：
                        </td>
                        <td width="76%" align="left">
                            ${auditerInfor.realName }
                        </td>
                    </tr>
                    <tr>
                        <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right">
                            <span style="color:red">*&nbsp;</span>院系类别：
                        </td>
                        <td align="left">
                            ${auditerInfor.college }
                        </td>
                    </tr>
                    <tr>
                        <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td>
                    </tr>

                    <tr>
                        <td align="right">
                            <span style="color:red">*&nbsp;</span>学位：
                        </td>
                        <td align="left">
                            ${auditerInfor.degree }
                        </td>
                    </tr>
                    <tr>
                        <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td>
                    </tr>

                    <tr>
                        <td align="right">
                            <span style="color:red">*&nbsp;</span>职位：
                        </td>
                        <td align="left">
                            ${auditerInfor.position }
                        </td>
                    </tr>
                    <tr>
                        <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td>
                    </tr>

                    <tr>
                        <td align="right">
                            <span style="color:red">*&nbsp;</span>办公室：
                        </td>
                        <td align="left">
                            ${auditerInfor.office }
                        </td>
                    </tr>
                    <tr>
                        <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td>
                    </tr>

                    <tr>
                        <td align="right">
                            <span style="color:red">*&nbsp;</span>email：
                        </td>
                        <td align="left">
                            ${auditerInfor.email }
                        </td>
                    </tr>
                    <tr>
                        <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td>
                    </tr>

                    <tr>
                        <td align="right">年龄：</td>
                        <td align="left">
                            ${auditerInfor.age }
                        </td>
                    </tr>
                    <tr>
                        <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right">性别：</td>
                        <td align="left">
                            <input type="radio" disabled="disabled" name="user_sex" ${auditerInfor.sex eq "M" ? "checked='checked'" : ""} class="sex_radio" value="M"/>男
                            <input type="radio" disabled="disabled" name="user_sex" ${auditerInfor.sex eq "F" ? "checked='checked'" : ""} class="sex_radio" value="F"/>女
                        </td>
                    </tr>
                    <tr>
                        <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right">身份证号码：</td>
                        <td align="left">
                            ${auditerInfor.idCard }
                        </td>
                    </tr>
                    <tr>
                        <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right">地址：</td>
                        <td align="left">
                            ${auditerInfor.address }
                        </td>
                    </tr>
                    <tr>
                        <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right">手机：</td>
                        <td align="left">
                            ${auditerInfor.phone }
                        </td>
                    </tr>
                    <tr>
                        <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right">qq：</td>
                        <td align="left">
                            ${auditerInfor.qq }
                        </td>
                    </tr>
                    <tr>
                        <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td>
                    </tr>

                    <tr>
                        <td align="right">个人简介：</td>
                        <td colspan="2" align="left"><div class="project_words_style">${auditerInfor.resume }</div></td>
                    </tr>

                    <tr>
                        <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="right">&nbsp;</td>
                        <td align="left"><input type="button" id="break_old_page" value="上一页"/></td>
                    </tr>
                    <tr>
                        <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
