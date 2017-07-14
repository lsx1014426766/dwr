<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>DWR－留言本学习示例</title>

		
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
			 * 页面加载完成后自动调用该函数，将数据库中已存在的留言显示到页面中
			 */
			function init(){
				// 调用GuestBook类的findGuestBookByAll方法获取所有留言信息
				GuestBook.findGuestBookByAll(showAll);
			}
			/*
			 * 通过循环，将集合中的所有留言数据显示出来
			 */
			function showAll(data){
				for(var i = data.length - 1; i >= 0; i--){
					show(data[i]);
				}
			}
			/*
			 * 添加一条新的留言
			 */
			function add(){
				// 获取表单中所有组件的值
				var title = DWRUtil.getValue("title");
				var userName = DWRUtil.getValue("userName");
				var content = DWRUtil.getValue("content");
				
				// 验证数据是否填写完整
				if(!title || !userName || !content){
					alert("请将留言内容填写完整！");
					return;
				}
				// 清空表单组件中的值
				$("title").value = "";
				$("userName").value = "";
				$("content").value = "";
				// 调用GuestBook类的addGuestBook方法插入一条留言信息
				GuestBook.addGuestBook(title, userName, content, show);
			}
			/*
			 * 将单条留言信息显示到DIV中
			 */
			function show(data){
				// 将留言内容显示在DIV中
				${"contentDiv"}.insertAdjacentHTML("afterBegin", "<table border='0' cellpadding='5' style='width: 500px;'><tr style='background-color: #DDDDFF;'><td style='width: 400px;'>&nbsp;●&nbsp;" + data.title + "</td><td style='width: 100px; text-align: center;'>[" + data.putTime.getYear() + "年" + (data.putTime.getMonth() + 1) + "月" + data.putTime.getDate() + "日]</td></tr><tr><td colspan='2'>作者：" + data.userName + "<br/>" + data.content + "</td></tr></table>");
			}
		</script>
	</head>

	<body onload="JavaScript: init();" style="text-align: center;">
		<h1 style="color: #FF3333;">开心留言本</h1>
		<form action="JavaScript:;" method="post">
			<table border="1" cellpadding="6" style="width: 500px;">
				<tr>
					<td style="width: 80px; text-align: right;">留言标题：</td>
					<td><input type="text" id="title" name="title" style="width: 400px;" /></td>
				</tr>
				<tr>
					<td style="width: 80px; text-align: right;">留言作者：</td>
					<td><input type="text" id="userName" name="userName" style="width: 120px;" /></td>
				</tr>
				<tr>
					<td style="width: 80px; text-align: right; vertical-align: top;">留言内容：</td>
					<td><textarea id="content" name="content" style="width: 400px; height: 80px;"></textarea></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center">
						<input type="button" value="提交" onclick="JavaScript: add();">&nbsp;&nbsp;
						<input type="reset" value="重置">
					</td>
				</tr>
			</table>
		</form>
		<hr size="1" />
		<div id="contentDiv"></div>
	</body>
</html>
