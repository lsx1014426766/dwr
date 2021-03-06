<%@ page language="java" pageEncoding="GBK"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>DWR－文本输入自动补全学习示例</title>


		<script type='text/javascript' src='dwr/interface/TextSupply.js'></script>
		<script type='text/javascript' src='dwr/engine.js'></script>
		<script type='text/javascript' src='dwr/util.js'></script>
		<script type="text/javascript" language="JavaScript">
			// 记录上一次事件用户输入的值
			var bookName = "";
			/*
			 * 查询是否有匹配的数据
			 */
			function findText(){
				// 获得用户本次输入的值
				var bn = DWRUtil.getValue("bookName");
				// 如果与上次的值相同，则返回
				if(bn == bookName){
					return;
				}
				// 如果本次输入的为空字符串，关闭文本补全层，并返回
				if(bn == ""){
					bookName = "";
					closeSupply();
					return;
				}
				// 将本次输入的值赋予全局变量
				bookName = bn;
				// 调用TextSupply类的findText方法查询有无匹配的数据
				TextSupply.findText(bookName, action);
			}
			/*
			 * 根据数据集合中是否有值，选择关闭或打开文本补全层
			 */
			function action(data){
				if(data.length == 0){
					closeSupply();
				}else{
					openSupply(data);
				}
			}
			/*
			 * 关闭补全提示层
			 */
			function closeSupply(){
				// 将select中的所有option清空
				DWRUtil.removeAllOptions("supply");
				// 隐藏文本补全的DIV层
				$("supplyDiv").style.display = "none";
			}
			/*
			 * 打开补全提示层
			 */
			function openSupply(data){
				// 先进行DIV层的坐标定位
				divXY();
				// 将select中的所有option清空
				DWRUtil.removeAllOptions("supply");
				// 将所有数据添加到select中
				DWRUtil.addOptions("supply", data);
				// 显示文本补全的DIV层
				$("supplyDiv").style.display = "block";
			}
			/*
			 * DIV定位
			 */
			function divXY(){
				// 获取文本输入组件的XY坐标
				var point = getOffsetPosition($("bookName"));
				// 定位文本补全的DIV层
				$("supplyDiv").style.top = point.y + 21;
				$("supplyDiv").style.left = point.x;
			}
			/*
			 * 计算某组件在页面中的相对位置，返回一个Point对象
			 */
			function getOffsetPosition(target){
				// 计算相对位置
				var t = 0;
				var l = 0;
				while(target){
					t += target.offsetTop;
					l += target.offsetLeft;
					target = target.offsetParent;
				}
				return new Point(l, t);
			}
			/*
			 * 坐标点类，X、Y两个坐标属性
			 */
			function Point(x, y){
				this.x = x;
				this.y = y;
			}
			function keyDown(){
				if(event.keyCode == 40){
					$("supply").focus();
				}
			}
			function changeBookName(mk){
				if(mk == "key"){
					if(event.keyCode == 13){
						bookName = DWRUtil.getValue("supply");
						DWRUtil.setValue("bookname", bookName);
						closeSupply();
						$("bookName").focus();
					}
				}else{
					bookName = DWRUtil.getValue("supply");
					DWRUtil.setValue("bookname", bookName);
					closeSupply();
					$("bookName").focus();
				}
			}
		</script>
	</head>

	<body style="text-align: center; background-color: ">
		<h1 style="color: #FF3333;">开心书店图书检索</h1>
		<form action="JavaScript:;" method="get">
			<input type="text" id="bookName" name="bookName" onkeydown="JavaScript:keyDown();" onkeyup="JavaScript:findText();" style="width: 200px;" />
			<input type="submit" value="搜索" />
		</form>
		<div id="supplyDiv" style="z-index: 2; display: none; border: 1 solid #666666; width: 200px; position: absolute; overflow: hidden;">
			<select id="supply" name="supply" onclick="JavaScript:changeBookName('mouse');" onkeypress="JavaScript:changeBookName('key');" size="5" style="width: 204px; margin: -4px;">
			</select>
		</div>
	</body>
</html>
