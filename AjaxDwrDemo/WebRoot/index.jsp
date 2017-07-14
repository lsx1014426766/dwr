<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type='text/javascript' src='dwr/interface/UserService.js'></script>
    <script type='text/javascript' src='dwr/engine.js'></script>
    <script type='text/javascript' src='dwr/util.js'></script>
    <script type="text/javascript">
    
		function  test1(){
		    //UserService.test();
		    //UserService.test2("zhangsan");
		   //UserService.test3("zhangsan",back);//  输入 可以有多个， 输出参数 回调函数 只有一个 也只有最后一个
		
		  /*  UserService.test4( function(data){
		    	alert(data[0]);
		    });*/
		    UserService.test5( function(data){
		    	
		    	alert(data[0].username);
		    });
		}
		function  back(data){
			alert(data);
		}
    </script>
	
	
  </head>
  
  <body>
     <input type="button" value="test" onclick="test1()">
  </body>
</html>
