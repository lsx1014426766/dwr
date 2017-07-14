<%@ page language="java" pageEncoding="GBK"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>DWR－登录学习示例</title>

		<!-- 行知汇元教学示例 -->
		<!-- 作者：米强 -->

		<script type='text/javascript' src='dwr/interface/TestUserName.js'></script>
		<script type='text/javascript' src='dwr/engine.js'></script>
		<script type='text/javascript' src='dwr/util.js'></script>
		<script type="text/javascript" language="JavaScript">
			/*
			 * 测试用户输入的登录名是否存在
			 */
			function testUserName(){
				// 获取用户名文本组件的值
				var name = DWRUtil.getValue("userName");
				// 如果用户没有输入用户名
				if(name.length == 0){
					// DWRUtil提供的方法，$(id)相当于document.getElementById(id);
					$("userNameResult").innerHTML = "<font color='red'>请填写用户名</font>";
					return;
				}
				// 调用TestUserName类的test方法验证登录名是否存在。第二个参数表示当接收到服务端的返回时DWR将会调用的JavaScript方法
				TestUserName.test(name, setUserNameResult);
			}
			/*
			 * 将测试结果显示到页面中
			 */
			function setUserNameResult(data){
				// 根据返回值将结果显示到页面中
				if(data){
					$("userNameResult").innerHTML = "<img src='images/ok.gif' alt='用户名录入正确' />";
				}else{
					$("userNameResult").innerHTML = "<font color='red'>该用户名未注册</font>";
				}
			}
		</script>
	</head>

	<body>
		<table width="360" cellspacing="0" cellpadding="6" align="center" style="font-size: 12px; border: 1 solid #0000FF;">
			<tr>
				<th colspan="3" style="background-color: #AAAAFF;">用户登录</th>
			</tr>
			<tr>
				<td width="80" style="text-align: right; border-top: 1 solid #0000FF;">用户名：</td>
				<td width="150" style="border-top: 1 solid #0000FF;"><input type="text" id="userName" name="userName" size="18" onblur="JavaScript:testUserName();" /></td>
				<td style="border-top: 1 solid #0000FF;"><div id="userNameResult">&nbsp;</div></td>
			</tr>
			<tr>
				<td width="80" style="text-align: right; border-top: 1 solid #0000FF;">密&nbsp;&nbsp;码：</td>
				<td width="150" style="border-top: 1 solid #0000FF;"><input type="password" id="password" name="password" size="19" /></td>
				<td style="border-top: 1 solid #0000FF;">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="3" style="text-align: center; border-top: 1 solid #0000FF;"><input type="submit" value="登录">&nbsp;&nbsp;<input type="reset" value="重置"></td>
			</tr>
		</table>
	</body>
</html>
