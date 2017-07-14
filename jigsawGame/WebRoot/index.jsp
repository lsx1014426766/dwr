<%@ page language="java" pageEncoding="GBK"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>DWR��ƴͼ��Ϸѧϰʾ��</title>

		

		<script type='text/javascript' src='dwr/interface/JigsawControl.js'></script>
		<script type='text/javascript' src='dwr/engine.js'></script>
		<script type='text/javascript' src='dwr/util.js'></script>
		<script type="text/javascript" language="JavaScript">
			// �����ڱ�������ʾ��ͼƬԪ�ؼ���
			var x_images = new Array();
			// ���н����϶���ͼƬԪ�ؼ���
			var p_images = new Array();
			// ͼƬ�����ţ�ÿ�θ�ֵʱ��ʹ�ã�++z_index
			var z_index = 1;
			// XY����
			var $x, $y;

			/*
			 * ��ʼ������ͼ���������е�ͼƬԪ�أ������Ӹ����¼�
			 */
			function init(){
				// �����������ͼ
				var ran = Math.floor(Math.random() * 100000) % 6 + 1;
				document.body.style.backgroundImage = "url(images/backImage_0" + ran + ".jpg)";
				// �������е�ͼƬԪ�أ������Ӹ����¼�
				for(var i = 0; i < 20; i++){
					x_images[i] = $("x" + (i + 1));
					p_images[i] = $("p" + (i + 1));
					// ������갴���¼������¼��н��ı�ͼƬ�Ĳ�
					p_images[i].onmousedown = photoMouseDown;
					// ������꿪ʼ��ק�¼�
					p_images[i].ondragstart = photoDragStart;
					// ���������ק�¼�
					p_images[i].ondrag = photoDrag;
					// �������ֹͣ��ק�¼�
					p_images[i].ondragend = photoDragEnd;
				}
			}
			/*
			 * ��ͼƬԪ��������갴���¼�
			 */
			function photoMouseDown(){
				// �ı�ͼƬ��Z�ᣬʹ�������ͼƬ������ʾ������ͼƬ֮��
				event.srcElement.style.zIndex = ++z_index;
			}
			/*
			 * ��꿪ʼ��ק�¼�
			 */
			function photoDragStart(){
				$x = event.x - this.offsetLeft;
				$y = event.y - this.offsetTop;
			}
			/*
			 * �����ק�¼�
			 */
			function photoDrag(){
				// �������ק�ƶ�ͼƬλ��
				this.style.left = event.x - $x;
				this.style.top = event.y - $y;
				// �ж�����϶�ͼƬ�������ĸ�����
				mouseOver(event.x, event.y);
			}
			/*
			 * �ж�����϶�ͼƬ�������ĸ����򣬲��ı�����򱳾�ɫ��ʾ
			 */
			function mouseOver(x, y){
				// ��ʱ��������������
				var temp;
				// ����xx�б�����ÿһ��ͼƬ��X�����꣬4��ͼƬ��5������ֵ
				var xx = new Array();
				// ����yy�б�����ÿһ��ͼƬ��Y�����꣬5��ͼƬ��6������ֵ
				var yy = new Array();
				/*
				 * ��һ��ͼƬ��Ŵ�1��4���ڶ��д�5��6��......
				 * 	1	2	3	4
				 *	5	6	7	8
				 *	9	10	11	12
				 *	13	14	15	16
				 *	17	18	19	20
				 * ֻҪ���1��6��11��16��20��Щλ�õ�ͼƬ���Ͻ����꣬
				 * �Ϳ��Խ�����������������Ҫ��ֵ�����������ͼƬ����
				 * �У���Щλ�õ�ͼƬ��0��5��10��15��19����Ϊ�����±�
				 * �Ǵ�0��ʼ��
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
				// �������϶��������ڱ���֮�⣬�򲻽��к�������
				if(x < xx[0] || x > xx[4] || y < yy[0] || y > yy[5]){
					// ����ϴ�ͼƬ����������Ų�Ϊ0������Ҫ���ϴν�������ı���ɫȥ��
					if(x_image_number != 0){
						x_images[x_image_number - 1].style.backgroundColor = "#FFFFFF";
					}
					// �����ν��������Ÿ�Ϊ0
					x_image_number = 0;
					return;
				}
				// ������ק��ͼƬ��������һ�У�xxx�ֲ�������¼�к�
				var xxx = 0;
				for(var i = 0; i < xx.length - 1; i++){
					if(x >= xx[i] && x < xx[i + 1]){
						xxx = i + 1;
						break;
					}
				}
				// ������ק��ͼƬ��������һ�У�yyy�ֲ�������¼�к�
				var yyy = 0;
				for(var i = 0; i < yy.length - 1; i++){
					if(y >= yy[i] && y < yy[i + 1]){
						yyy = i + 1;
						break;
					}
				}
				// ���㱾����קͼƬ�������ĸ�������
				var now_number = (yyy - 1) * 4 + xxx;
				// ����������ڵ����������ϴν���������Ų�ͬ�����ұ��������Ų�Ϊ0
				if(now_number != x_image_number && now_number != 0){
					// �ϴν���������Ų�Ϊ0�����ϴ�����ı���ɫȥ��
					if(x_image_number != 0){
						x_images[x_image_number - 1].style.backgroundColor = "#FFFFFF";
					}
					// �����ν��������Ÿ���ȫ�ֱ������ϴν��������ţ�
					x_image_number = now_number;
					// �������������ֵ����ɫ
					x_images[x_image_number - 1].style.backgroundColor = "#BBBBBB";
				}
			}
			// �ϴν���������ţ�0����û��
			var x_image_number = 0;
			/*
			 * ���ֹͣ��ק�¼�
			 */
			function photoDragEnd(){
				// �����ֹͣ������ק��Ϊʱ���������ĳ��������
				if(x_image_number != 0){
					// �����קͼƬ��URL��ַ
					var esrc = event.srcElement.src;
					// ��ȡͼƬ��ַ�еı��
					var e = esrc.indexOf(".jpg");
					var s = e - 2;
					var image_number = esrc.slice(s, e);
					// ���ͼƬ��������������ͬ
					if(image_number == x_image_number){
						// �������ڵ�͸��ͼƬURL��Ϊ����קͼƬ��URL��Ч�����Ǳ������������ٱ���ק����
						x_images[x_image_number - 1].src = event.srcElement.src;
						// ������קͼƬ��ֵΪ����
						event.srcElement.style.display = "none";
						// ��ͼƬ�ڷųɹ������ּ�1
						ok++;
						// ����ɹ���20��ͼƬ����ʾ����
						if(ok == 20){
							alert("��ϲ���������ˣ�");
							resetGame();
						}
					}else{
						// ���ͼƬ�����������Ų�ͬ��֤����ͼƬλ���������Բ�����������
						// ����קͼƬ��λ����������
						var p = getOffsetPosition(x_images[x_image_number - 1]);
						event.srcElement.style.top = p.y;
						event.srcElement.style.left = p.x;
					}
				}
			}
			var ok = 0;
			/*
			 * ��ʼ��Ϸ
			 */
			function startGame(n){
				resetGame();
				JigsawControl.requestPhoto(n, showPhoto);
			}
			/*
			 * ��ʾ����ͼƬ
			 */
			function showPhoto(data){
				for(var i = 0; i < data.length; i++){
					// ����ͼƬURL
					p_images[i].src = data[i];
					// ��ʾͼƬ
					p_images[i].style.display = "block";
				}
			}
			/*
			 * ���¿�ʼ��Ϸ����ʼ��������ֵ
			 */
			function resetGame(){
				// ��ʼ��������
				ok = 0;
				x_image_number = 0;
				// ��������������ͼƬ������
				for(var i = 0; i < x_images.length; i++){
					x_images[i].src = "images/1.gif"
					x_images[i].style.backgroundColor = "#FFFFFF";
				}
				// ���ó�ʼ��λ��
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
			 * ����ĳ�����ҳ���е����λ�ã�����һ��Point����
			 */
			function getOffsetPosition(target){
				// �������λ��
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
			 * ������࣬X��Y������������
			 */
			function Point(x, y){
				this.x = x;
				this.y = y;
			}
			// ��ʾƴͼ����ͼ�б��ĸ߶ȣ����¹���ʱ����ֵ�����ж��Ƿ���������
			var listPhotoHeight = 2625;
			// ���Ϲ���ͼƬ���ö�ʱ�����ص�ֵ��ֹͣ��ʱ����Ҫ�˲���
			var up = 0;
			// ���¹���ͼƬ���ö�ʱ�����ص�ֵ��ֹͣ��ʱ����Ҫ�˲���
			var down = 0;
			/*
			 * ���Ϲ�����ʱ�����õĺ���
			 */
			function listUpStart(){
				// ��ô˿�����ͼ�б���TOPֵ
				var top = parseInt($("listPhoto").style.top);
				// ÿ10�������5����
				top += 5;
				// �ж��Ƿ���ʾ�����
				if(top >= 0){
					$("listPhoto").style.top = 0;
					// ֹͣ��ʱ��
					window.clearInterval(up);
					return;
				}
				// ��������ͼ�б���TOPֵ
				$("listPhoto").style.top = top;
			}
			/*
			 * ���¹�����ʱ�����õĺ���
			 */
			function listDownStart(){
				// ��ô˿�����ͼ�б���TOPֵ
				var top = parseInt($("listPhoto").style.top);
				// ÿ10�������5����
				top -= 5;
				// �ж��Ƿ���ʾ����ײ�
				if(top + listPhotoHeight <= 470){
					$("listPhoto").style.top = 470 - listPhotoHeight;
					// ֹͣ��ʱ��
					window.clearInterval(down);
					return;
				}
				// ��������ͼ�б���TOPֵ
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