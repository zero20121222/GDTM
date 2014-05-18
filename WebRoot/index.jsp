<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
	<title></title>
	<script>
	function init(){
		alert(document.body.clientHeight);
		parent.document.getElementById("win").style.height = document.body.clientHeight + "px";
	}
	</script>
  </head>
  
  <body onload="init()">
  	<div style="height:auto;overflow:hidden">
	<div style="width:100px;height:500px;background:yellow;margin-top:200px;"></div>
	</div>
  </body>
</html>
