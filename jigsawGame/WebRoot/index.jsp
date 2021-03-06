<%@ page language="java" pageEncoding="GBK"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>DWR－拼图游戏学习示例</title>

		

		<script type='text/javascript' src='dwr/interface/JigsawControl.js'></script>
		<script type='text/javascript' src='dwr/engine.js'></script>
		<script type='text/javascript' src='dwr/util.js'></script>
		<script type="text/javascript" language="JavaScript">
			// 所有在表格中显示的图片元素集合
			var x_images = new Array();
			// 所有将被拖动的图片元素集合
			var p_images = new Array();
			// 图片层的序号，每次赋值时请使用：++z_index
			var z_index = 1;
			// XY坐标
			var $x, $y;

			/*
			 * 初始化背景图，加载所有的图片元素，并添加各种事件
			 */
			function init(){
				// 随机更换背景图
				var ran = Math.floor(Math.random() * 100000) % 6 + 1;
				document.body.style.backgroundImage = "url(images/backImage_0" + ran + ".jpg)";
				// 加载所有的图片元素，并添加各种事件
				for(var i = 0; i < 20; i++){
					x_images[i] = $("x" + (i + 1));
					p_images[i] = $("p" + (i + 1));
					// 添加鼠标按下事件，该事件中将改变图片的层
					p_images[i].onmousedown = photoMouseDown;
					// 添加鼠标开始拖拽事件
					p_images[i].ondragstart = photoDragStart;
					// 添加鼠标拖拽事件
					p_images[i].ondrag = photoDrag;
					// 添加鼠标停止拖拽事件
					p_images[i].ondragend = photoDragEnd;
				}
			}
			/*
			 * 给图片元素添加鼠标按下事件
			 */
			function photoMouseDown(){
				// 改变图片的Z轴，使被点击的图片可以显示在其它图片之上
				event.srcElement.style.zIndex = ++z_index;
			}
			/*
			 * 鼠标开始拖拽事件
			 */
			function photoDragStart(){
				$x = event.x - this.offsetLeft;
				$y = event.y - this.offsetTop;
			}
			/*
			 * 鼠标拖拽事件
			 */
			function photoDrag(){
				// 随鼠标拖拽移动图片位置
				this.style.left = event.x - $x;
				this.style.top = event.y - $y;
				// 判断鼠标拖动图片进入了哪个区域
				mouseOver(event.x, event.y);
			}
			/*
			 * 判断鼠标拖动图片进入了哪个区域，并改变该区域背景色提示
			 */
			function mouseOver(x, y){
				// 临时变量，代表坐标
				var temp;
				// 数组xx中保存着每一列图片的X轴坐标，4列图片有5个坐标值
				var xx = new Array();
				// 数组yy中保存着每一行图片的Y轴坐标，5行图片有6个坐标值
				var yy = new Array();
				/*
				 * 第一行图片编号从1～4，第二行从5～6，......
				 * 	1	2	3	4
				 *	5	6	7	8
				 *	9	10	11	12
				 *	13	14	15	16
				 *	17	18	19	20
				 * 只要获得1、6、11、16、20这些位置的图片左上角坐标，
				 * 就可以将以上两个数组所需要的值计算出来，在图片数组
				 * 中，这些位置的图片是0、5、10、15、19，因为数组下标
				 * 是从0开始的
				 */
				temp = getOffsetPosition(x_images[0]);
				xx[0] = temp.x;
				yy[0] = temp.y;
				temp = getOffsetPosition(x_images[5]);
				xx[1] = temp.x;
				yy[1] = temp.y;
				temp = getOffsetPosition(x_images[10]);
				xx[2] = temp.x;
				yy[2] = temp.y;
				temp = getOffsetPosition(x_images[15]);
				xx[3] = temp.x;
				yy[3] = temp.y
				xx[4] = xx[3] + x_images[15].width + 1;
				temp = getOffsetPosition(x_images[19]);
				yy[4] = temp.y;
				yy[5] = yy[4] + x_images[19].height + 1;
				// 如果鼠标拖动的坐标在表格之外，则不进行后续计算
				if(x < xx[0] || x > xx[4] || y < yy[0] || y > yy[5]){
					// 如果上次图片进入的区域编号不为0，则需要将上次进入区域的背景色去掉
					if(x_image_number != 0){
						x_images[x_image_number - 1].style.backgroundColor = "#FFFFFF";
					}
					// 将本次进入区域编号改为0
					x_image_number = 0;
					return;
				}
				// 计算拖拽的图片进入了哪一行，xxx局部变量记录行号
				var xxx = 0;
				for(var i = 0; i < xx.length - 1; i++){
					if(x >= xx[i] && x < xx[i + 1]){
						xxx = i + 1;
						break;
					}
				}
				// 计算拖拽的图片进入了哪一列，yyy局部变量记录行号
				var yyy = 0;
				for(var i = 0; i < yy.length - 1; i++){
					if(y >= yy[i] && y < yy[i + 1]){
						yyy = i + 1;
						break;
					}
				}
				// 计算本次拖拽图片进入了哪个区域编号
				var now_number = (yyy - 1) * 4 + xxx;
				// 如果本次所在的区域编号与上次进入的区域编号不同，并且本次区域编号不为0
				if(now_number != x_image_number && now_number != 0){
					// 上次进入的区域编号不为0，则将上次区域的背景色去掉
					if(x_image_number != 0){
						x_images[x_image_number - 1].style.backgroundColor = "#FFFFFF";
					}
					// 将本次进入的区域号赋给全局变量（上次进入的区域号）
					x_image_number = now_number;
					// 给进入的区域设值背景色
					x_images[x_image_number - 1].style.backgroundColor = "#BBBBBB";
				}
			}
			// 上次进入的区域编号，0代表没有
			var x_image_number = 0;
			/*
			 * 鼠标停止拖拽事件
			 */
			function photoDragEnd(){
				// 当鼠标停止本次拖拽行为时，如果是在某个区域内
				if(x_image_number != 0){
					// 获得拖拽图片的URL地址
					var esrc = event.srcElement.src;
					// 截取图片地址中的编号
					var e = esrc.indexOf(".jpg");
					var s = e - 2;
					var image_number = esrc.slice(s, e);
					// 如果图片编号与该区域编号相同
					if(image_number == x_image_number){
						// 将区域内的透明图片URL改为被拖拽图片的URL，效果像是被锁定，不能再被拖拽操作
						x_images[x_image_number - 1].src = event.srcElement.src;
						// 将被拖拽图片设值为隐藏
						event.srcElement.style.display = "none";
						// 将图片摆放成功的数字加1
						ok++;
						// 如果成功了20张图片，提示过关
						if(ok == 20){
							alert("恭喜您，过关了！");
							resetGame();
						}
					}else{
						// 如果图片编号与该区域编号不同，证明该图片位置有误，所以不做锁定处理
						// 将拖拽图片定位到该区域内
						var p = getOffsetPosition(x_images[x_image_number - 1]);
						event.srcElement.style.top = p.y;
						event.srcElement.style.left = p.x;
					}
				}
			}
			var ok = 0;
			/*
			 * 开始游戏
			 */
			function startGame(n){
				resetGame();
				JigsawControl.requestPhoto(n, showPhoto);
			}
			/*
			 * 显示所有图片
			 */
			function showPhoto(data){
				for(var i = 0; i < data.length; i++){
					// 加载图片URL
					p_images[i].src = data[i];
					// 显示图片
					p_images[i].style.display = "block";
				}
			}
			/*
			 * 重新开始游戏，初始化所有设值
			 */
			function resetGame(){
				// 初始化计数器
				ok = 0;
				x_image_number = 0;
				// 设置所有区域内图片的属性
				for(var i = 0; i < x_images.length; i++){
					x_images[i].src = "images/1.gif"
					x_images[i].style.backgroundColor = "#FFFFFF";
				}
				// 设置初始化位置
				$("p1").style.top = "60px";
				$("p2").style.top = "175px";
				$("p3").style.top = "160px";
				$("p4").style.top = "170px";
				$("p5").style.top = "260px";
				$("p6").style.top = "50px";
				$("p7").style.top = "310px";
				$("p8").style.top = "130px";
				$("p9").style.top = "230px";
				$("p10").style.top = "370px";
				$("p11").style.top = "350px";
				$("p12").style.top = "410px";
				$("p13").style.top = "390px";
				$("p14").style.top = "460px";
				$("p15").style.top = "160px";
				$("p16").style.top = "330px";
				$("p17").style.top = "90px";
				$("p18").style.top = "60px";
				$("p19").style.top = "450px";
				$("p20").style.top = "260px";
				$("p1").style.left = "680px";
				$("p2").style.left = "930px";
				$("p3").style.left = "780px";
				$("p4").style.left = "690px";
				$("p5").style.left = "910px";
				$("p6").style.left = "820px";
				$("p7").style.left = "685px";
				$("p8").style.left = "1050px";
				$("p9").style.left = "735px";
				$("p10").style.left = "860px";
				$("p11").style.left = "780px";
				$("p12").style.left = "920px";
				$("p13").style.left = "680px";
				$("p14").style.left = "825px";
				$("p15").style.left = "780px";
				$("p16").style.left = "1030px";
				$("p17").style.left = "820px";
				$("p18").style.left = "940px";
				$("p19").style.left = "700px";
				$("p20").style.left = "990px";
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
			// 显示拼图缩略图列表的高度，向下滚动时靠此值才能判断是否滚动到最底
			var listPhotoHeight = 2625;
			// 向上滚动图片设置定时器返回的值，停止定时器需要此参数
			var up = 0;
			// 向下滚动图片设置定时器返回的值，停止定时器需要此参数
			var down = 0;
			/*
			 * 向上滚动定时器调用的函数
			 */
			function listUpStart(){
				// 获得此刻缩略图列表的TOP值
				var top = parseInt($("listPhoto").style.top);
				// 每10毫秒滚动5像素
				top += 5;
				// 判断是否显示到最顶部
				if(top >= 0){
					$("listPhoto").style.top = 0;
					// 停止定时器
					window.clearInterval(up);
					return;
				}
				// 设置缩略图列表的TOP值
				$("listPhoto").style.top = top;
			}
			/*
			 * 向下滚动定时器调用的函数
			 */
			function listDownStart(){
				// 获得此刻缩略图列表的TOP值
				var top = parseInt($("listPhoto").style.top);
				// 每10毫秒滚动5像素
				top -= 5;
				// 判断是否显示到最底部
				if(top + listPhotoHeight <= 470){
					$("listPhoto").style.top = 470 - listPhotoHeight;
					// 停止定时器
					window.clearInterval(down);
					return;
				}
				// 设置缩略图列表的TOP值
				$("listPhoto").style.top = top;
			}
		</script>
	</head>

	<body onload="JavaScript: init();">
		<table width="680" border="0">
			<tr>
				<td valign="top">
					<table border="0" cellpadding="0" cellspacing="0" style="border: 1px solid #555555; background-color: #FFFFFF;">
						<tr>
							<td><img id="x1" src="images/1.gif" width="110" height="110" /></td>
							<td style="border-left: 1px dashed #BBBBBB;"><img id="x2" src="images/1.gif" width="110" height="110" /></td>
							<td style="border-left: 1px dashed #BBBBBB;"><img id="x3" src="images/1.gif" width="110" height="110" /></td>
							<td style="border-left: 1px dashed #BBBBBB;"><img id="x4" src="images/1.gif" width="110" height="110" /></td>
						</tr>
						<tr>
							<td style="border-top: 1px dashed #ABBBBBB;"><img id="x5" src="images/1.gif" width="110" height="110" /></td>
							<td style="border-top: 1px dashed #ABBBBBB; border-left: 1px dashed #BBBBBB;"><img id="x6" src="images/1.gif" width="110" height="110" /></td>
							<td style="border-top: 1px dashed #ABBBBBB; border-left: 1px dashed #BBBBBB;"><img id="x7" src="images/1.gif" width="110" height="110" /></td>
							<td style="border-top: 1px dashed #ABBBBBB; border-left: 1px dashed #BBBBBB;"><img id="x8" src="images/1.gif" width="110" height="110" /></td>
						</tr>
						<tr>
							<td style="border-top: 1px dashed #ABBBBBB;"><img id="x9" src="images/1.gif" width="110" height="110" /></td>
							<td style="border-top: 1px dashed #ABBBBBB; border-left: 1px dashed #BBBBBB;"><img id="x10" src="images/1.gif" width="110" height="110" /></td>
							<td style="border-top: 1px dashed #ABBBBBB; border-left: 1px dashed #BBBBBB;"><img id="x11" src="images/1.gif" width="110" height="110" /></td>
							<td style="border-top: 1px dashed #ABBBBBB; border-left: 1px dashed #BBBBBB;"><img id="x12" src="images/1.gif" width="110" height="110" /></td>
						</tr>
						<tr>
							<td style="border-top: 1px dashed #ABBBBBB;"><img id="x13" src="images/1.gif" width="110" height="110" /></td>
							<td style="border-top: 1px dashed #ABBBBBB; border-left: 1px dashed #BBBBBB;"><img id="x14" src="images/1.gif" width="110" height="110" /></td>
							<td style="border-top: 1px dashed #ABBBBBB; border-left: 1px dashed #BBBBBB;"><img id="x15" src="images/1.gif" width="110" height="110" /></td>
							<td style="border-top: 1px dashed #ABBBBBB; border-left: 1px dashed #BBBBBB;"><img id="x16" src="images/1.gif" width="110" height="110" /></td>
						</tr>
						<tr>
							<td style="border-top: 1px dashed #ABBBBBB;"><img id="x17" src="images/1.gif" width="110" height="110" /></td>
							<td style="border-top: 1px dashed #ABBBBBB; border-left: 1px dashed #BBBBBB;"><img id="x18" src="images/1.gif" width="110" height="110" /></td>
							<td style="border-top: 1px dashed #ABBBBBB; border-left: 1px dashed #BBBBBB;"><img id="x19" src="images/1.gif" width="110" height="110" /></td>
							<td style="border-top: 1px dashed #ABBBBBB; border-left: 1px dashed #BBBBBB;"><img id="x20" src="images/1.gif" width="110" height="110" /></td>
						</tr>
					</table>
				</td>
				<td width="240" valign="top" align="center">
					<table width="200" border="0" cellpadding="0" cellspacing="0" style="background-color: #FFFFFF; border: 1px solid #555555;">
						<tr>
							<td align="center" colspan="2"><img src="images/logo.gif" /></td>
						</tr>
						<tr>
							<td height="12" style="background-image: url('images/back_01.gif'); text-align: center;"><img src="images/buttonUp.gif" style="cursor: hand;" onmouseover="JavaScript:up = window.setInterval('listUpStart()', 10);" onmouseout="JavaScript:window.clearInterval(up);"></td>
						</tr>
						<tr>
							<td>
								<div style="width: 200px; height: 470px; overflow: hidden;">
									<table id="listPhoto" cellpadding="0" cellspacing="0" border="0" style="position: absolute; top: 0;">
										<tr>
											<td align="center"><img src="photo/photo_01.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('01');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_02.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('02');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_03.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('03');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_04.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('04');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_05.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('05');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_06.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('06');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_07.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('07');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_08.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('08');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_09.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('09');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_10.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('10');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_11.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('11');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_12.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('12');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_13.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('13');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_14.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('14');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_15.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('15');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_16.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('16');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_17.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('17');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_18.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('18');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_19.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('19');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_20.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('20');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_21.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('21');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_22.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('22');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_23.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('23');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_24.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('24');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_25.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('25');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_26.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('26');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_27.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('27');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_28.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('28');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_29.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('29');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_30.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('30');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_31.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('31');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_32.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('32');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_33.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('33');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_34.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('34');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_35.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('35');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_36.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('36');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_37.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('37');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_38.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('38');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_39.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('39');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_40.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('40');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
										<tr>
											<td align="center"><img src="photo/photo_41.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('41');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
											<td align="center"><img src="photo/photo_42.jpg" style="filter: alpha(opacity=50); cursor: hand;" onclick="JavaScript:startGame('42');" onmouseover="this.style.MozOpacity=1;this.filters.alpha.opacity=100" onmouseout="this.style.MozOpacity=0.5;this.filters.alpha.opacity=50;" /></td>
										</tr>
									</table>
								</div>
							</td>
						</tr>
						<tr>
							<td height="12" style="background-image: url('images/back_01.gif'); text-align: center;"><img src="images/buttonDown.gif" style="cursor: hand;" onmouseover="JavaScript: down = window.setInterval('listDownStart()', 10);" onmouseout="JavaScript: window.clearInterval(down);"></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<img id="p1" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
		<img id="p2" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
		<img id="p3" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
		<img id="p4" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
		<img id="p5" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
		<img id="p6" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
		<img id="p7" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
		<img id="p8" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
		<img id="p9" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
		<img id="p10" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
		<img id="p11" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
		<img id="p12" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
		<img id="p13" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
		<img id="p14" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
		<img id="p15" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
		<img id="p16" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
		<img id="p17" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
		<img id="p18" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
		<img id="p19" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
		<img id="p20" src="" style="position: absolute; display: none; z-index: 1; border: 1px solid #555555;" />
	</body>
</html>
