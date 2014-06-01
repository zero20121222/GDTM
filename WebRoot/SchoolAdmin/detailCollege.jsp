<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"></base>
<title>详细院系信息</title>
<script type="text/javascript" src="js/BasicJavascript.js"></script>
<script>
var majors;
function init(){
    majors = new Array();
    var num = 0;
    for(var i=0; i<10; i++){
        var major = $("major"+(i+1));
        if(major != null){
            new inputElementObj(major).createView();
            majors[num++] = major;
        }
    }
}

function updateCollege(collegeName){
    var url = "SchoolManageServlet?type=updateColleges&collegeName="+encodeURI(encodeURI(collegeName));

    for(var i=0; i<majors.length; i++){
        if(majors[i].value != ""){
            url += "&"+majors[i].id+"="+encodeURI(encodeURI(majors[i].value));
        }
    }

    window.open(url , "main_body");
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
tr > td{
	font-size:14px;
}
tr{
    height:30px;
}
.project_creater_log{
	width:128px;
	height:128px;
	position:absolute;
	top:20px;
	right:20px;
	background:url(images/upload_file.png);
}
</style>
</head>

<body onload="init()">
<div class="project_creater_log"></div>
    <table width="100%" border="0">
        <tr>
          <td width="40%" align="right">院系名称：</td>
          <td width="60%" align="left">
            ${schoolCollege.collegeName }
          </td>
        </tr>

        <tr>
          <td align="right">院系专业1：</td>
          <td align="left">
              ${schoolCollege.major1 == null ? "<div class='input_frame'><input type='text' name='major1' id='major1'/></div>" : schoolCollege.major1}
          </td>
        </tr>

        <tr>
            <td align="right">院系专业2：</td>
            <td align="left">
                ${schoolCollege.major2 == null ? "<div class='input_frame'><input type='text' name='major2' id='major2'/></div>" : schoolCollege.major2}
            </td>
        </tr>

        <tr>
            <td align="right">院系专业3：</td>
            <td align="left">
                ${schoolCollege.major3 == null ? "<div class='input_frame'><input type='text' name='major3' id='major3'/></div>" : schoolCollege.major3}
            </td>
        </tr>

        <tr>
            <td align="right">院系专业4：</td>
            <td align="left">
                ${schoolCollege.major4 == null ? "<div class='input_frame'><input type='text' name='major4' id='major4'/></div>" : schoolCollege.major4}
            </td>
        </tr>

        <tr>
            <td align="right">院系专业5：</td>
            <td align="left">
                ${schoolCollege.major5 == null ? "<div class='input_frame'><input type='text' name='major5' id='major5'/></div>" : schoolCollege.major5}
            </td>
        </tr>

        <tr>
            <td align="right">院系专业6：</td>
            <td align="left">
                ${schoolCollege.major6 == null ? "<div class='input_frame'><input type='text' name='major6' id='major6'/></div>" : schoolCollege.major6}
            </td>
        </tr>

        <tr>
            <td align="right">院系专业7：</td>
            <td align="left">
                ${schoolCollege.major7 == null ? "<div class='input_frame'><input type='text' name='major7' id='major7'/></div>" : schoolCollege.major7}
            </td>
        </tr>

        <tr>
            <td align="right">院系专业8：</td>
            <td align="left">
                ${schoolCollege.major8 == null ? "<div class='input_frame'><input type='text' name='major8' id='major8'/></div>" : schoolCollege.major8}
            </td>
        </tr>

        <tr>
            <td align="right">院系专业9：</td>
            <td align="left">
                ${schoolCollege.major9 == null ? "<div class='input_frame'><input type='text' name='major9' id='major9'/></div>" : schoolCollege.major9}
            </td>
        </tr>

        <tr>
            <td align="right">院系专业10：</td>
            <td align="left">
                ${schoolCollege.major10 == null ? "<div class='input_frame'><input type='text' name='major10' id='major10'/></div>" : schoolCollege.major10}
            </td>
        </tr>

        <tr style="height:40px;">
            <td align="right">&nbsp;</td>
            <td align="left"><input type="button" id="college_submit" onclick="updateCollege('${schoolCollege.collegeName }')" class="upload_submit" value="提交"/></td>
        </tr>
    </table>
</body>
</html>
