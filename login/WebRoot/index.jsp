<%@ page language="java" pageEncoding="GBK"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>DWR����¼ѧϰʾ��</title>

		<!-- ��֪��Ԫ��ѧʾ�� -->
		<!-- ���ߣ���ǿ -->

		<script type='text/javascript' src='dwr/interface/TestUserName.js'></script>
		<script type='text/javascript' src='dwr/engine.js'></script>
		<script type='text/javascript' src='dwr/util.js'></script>
		<script type="text/javascript" language="JavaScript">
			/*
			 * �����û�����ĵ�¼���Ƿ����
			 */
			function testUserName(){
				// ��ȡ�û����ı������ֵ
				var name = DWRUtil.getValue("userName");
				// ����û�û�������û���
				if(name.length == 0){
					// DWRUtil�ṩ�ķ�����$(id)�൱��document.getElementById(id);
					$("userNameResult").innerHTML = "<font color='red'>����д�û���</font>";
					return;
				}
				// ����TestUserName���test������֤��¼���Ƿ���ڡ��ڶ���������ʾ�����յ�����˵ķ���ʱDWR������õ�JavaScript����
				TestUserName.test(name, setUserNameResult);
			}
			/*
			 * �����Խ����ʾ��ҳ����
			 */
			function setUserNameResult(data){
				// ���ݷ���ֵ�������ʾ��ҳ����
				if(data){
					$("userNameResult").innerHTML = "<img src='images/ok.gif' alt='�û���¼����ȷ' />";
				}else{
					$("userNameResult").innerHTML = "<font color='red'>���û���δע��</font>";
				}
			}
		</script>
	</head>

	<body>
		<table width="360" cellspacing="0" cellpadding="6" align="center" style="font-size: 12px; border: 1 solid #0000FF;">
			<tr>
				<th colspan="3" style="background-color: #AAAAFF;">�û���¼</th>
			</tr>
			<tr>
				<td width="80" style="text-align: right; border-top: 1 solid #0000FF;">�û�����</td>
				<td width="150" style="border-top: 1 solid #0000FF;"><input type="text" id="userName" name="userName" size="18" onblur="JavaScript:testUserName();" /></td>
				<td style="border-top: 1 solid #0000FF;"><div id="userNameResult">&nbsp;</div></td>
			</tr>
			<tr>
				<td width="80" style="text-align: right; border-top: 1 solid #0000FF;">��&nbsp;&nbsp;�룺</td>
				<td width="150" style="border-top: 1 solid #0000FF;"><input type="password" id="password" name="password" size="19" /></td>
				<td style="border-top: 1 solid #0000FF;">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="3" style="text-align: center; border-top: 1 solid #0000FF;"><input type="submit" value="��¼">&nbsp;&nbsp;<input type="reset" value="����"></td>
			</tr>
		</table>
	</body>
</html>
