<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>审核规则</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script type="text/javascript" src="js/School_User_CL.js"></script>
<script>
function init(){
    suit_Page();

    if($("user_infor_frame").offsetHeight < 350){
        var frame = parent.document.getElementById("main_body");

        var winHeight = windowHeight() < 600 ? 686 : windowHeight();
        var marginlength = (winHeight - (frame.offsetHeight+205))/2 + "px";

        //是登入界面居中显示
        frame.style.marginTop = marginlength;
        frame.style.marginBottom = marginlength;
    }
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
#user_infor_frame{
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
</style>
</head>

<body onload="init()">
<div id="user_infor_frame">
    <div class="user_infor_body">
        <div class="user_update_frame">
            <div class="user_update_log"></div>
            <form id="update_params_form" method="post">
                <table width="100%" border="0">
                    <tr>
                        <td colspan="3" align="right">&nbsp;</td>
                    </tr>

                    <tr>
                        <td colspan="3" align="left"><span style="margin-left:120px;">学校课题创建规则</span></td>
                    </tr>

                    <tr><td colspan="3" align="right">&nbsp;</td></tr>

                    <tr>
                        <td align="right" width="40%">课题参与人数上限：</td>
                        <td align="left">
                            ${schoolParams.parterUpperLimit }

                            <span style="margin-left:60px">课题阶段总时间上限：</span>
                            ${schoolParams.stageUpperTime }
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" align="right">&nbsp;</td>
                    </tr>

                    <tr>
                        <td align="right">课题阶段上限：</td>
                        <td align="left">
                            ${schoolParams.stageUpperLimit }

                            <span style="margin-left:100px">课题阶段下限：</span>
                            ${schoolParams.stageFloorLimit }
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" align="right">&nbsp;</td>
                    </tr>

                    <tr>
                        <td colspan="3" align="left"><span style="margin-left:150px;">学校审核规则</span></td>
                    </tr>

                    <tr><td colspan="3" align="right">&nbsp;</td></tr>

                    <tr>
                        <td align="right">
                            审核课题人数：
                        </td>
                        <td align="left">
                            ${schoolParams.auditNumber }

                            <span style="margin-left:86px">审核课题通过数：</span>
                            ${schoolParams.adoptNumber }
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" align="right">&nbsp;</td>
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
