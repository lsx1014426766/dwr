<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>DWR�����Ա�ѧϰʾ��</title>

		
		<style type="text/css">
			table{
				font-size: 12px;
			}
		</style>
		<script type='text/javascript' src='dwr/interface/GuestBook.js'></script>
		<script type='text/javascript' src='dwr/engine.js'></script>
		<script type='text/javascript' src='dwr/util.js'></script>
		
		<script type="text/javascript" language="JavaScript">
			/*
			 * ҳ�������ɺ��Զ����øú����������ݿ����Ѵ��ڵ�������ʾ��ҳ����
			 */
			function init(){
				// ����GuestBook���findGuestBookByAll������ȡ����������Ϣ
				GuestBook.findGuestBookByAll(showAll);
			}
			/*
			 * ͨ��ѭ�����������е���������������ʾ����
			 */
			function showAll(data){
				for(var i = data.length - 1; i >= 0; i--){
					show(data[i]);
				}
			}
			/*
			 * ���һ���µ�����
			 */
			function add(){
				// ��ȡ�������������ֵ
				var title = DWRUtil.getValue("title");
				var userName = DWRUtil.getValue("userName");
				var content = DWRUtil.getValue("content");
				
				// ��֤�����Ƿ���д����
				if(!title || !userName || !content){
					alert("�뽫����������д������");
					return;
				}
				// ��ձ�����е�ֵ
				$("title").value = "";
				$("userName").value = "";
				$("content").value = "";
				// ����GuestBook���addGuestBook��������һ��������Ϣ
				GuestBook.addGuestBook(title, userName, content, show);
			}
			/*
			 * ������������Ϣ��ʾ��DIV��
			 */
			function show(data){
				// ������������ʾ��DIV��
				${"contentDiv"}.insertAdjacentHTML("afterBegin", "<table border='0' cellpadding='5' style='width: 500px;'><tr style='background-color: #DDDDFF;'><td style='width: 400px;'>&nbsp;��&nbsp;" + data.title + "</td><td style='width: 100px; text-align: center;'>[" + data.putTime.getYear() + "��" + (data.putTime.getMonth() + 1) + "��" + data.putTime.getDate() + "��]</td></tr><tr><td colspan='2'>���ߣ�" + data.userName + "<br/>" + data.content + "</td></tr></table>");
			}
		</script>
	</head>

	<body onload="JavaScript: init();" style="text-align: center;">
		<h1 style="color: #FF3333;">�������Ա�</h1>
		<form action="JavaScript:;" method="post">
			<table border="1" cellpadding="6" style="width: 500px;">
				<tr>
					<td style="width: 80px; text-align: right;">���Ա��⣺</td>
					<td><input type="text" id="title" name="title" style="width: 400px;" /></td>
				</tr>
				<tr>
					<td style="width: 80px; text-align: right;">�������ߣ�</td>
					<td><input type="text" id="userName" name="userName" style="width: 120px;" /></td>
				</tr>
				<tr>
					<td style="width: 80px; text-align: right; vertical-align: top;">�������ݣ�</td>
					<td><textarea id="content" name="content" style="width: 400px; height: 80px;"></textarea></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center">
						<input type="button" value="�ύ" onclick="JavaScript: add();">&nbsp;&nbsp;
						<input type="reset" value="����">
					</td>
				</tr>
			</table>
		</form>
		<hr size="1" />
		<div id="contentDiv"></div>
	</body>
</html>
