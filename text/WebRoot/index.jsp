<%@ page language="java" pageEncoding="GBK"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>DWR���ı������Զ���ȫѧϰʾ��</title>


		<script type='text/javascript' src='dwr/interface/TextSupply.js'></script>
		<script type='text/javascript' src='dwr/engine.js'></script>
		<script type='text/javascript' src='dwr/util.js'></script>
		<script type="text/javascript" language="JavaScript">
			// ��¼��һ���¼��û������ֵ
			var bookName = "";
			/*
			 * ��ѯ�Ƿ���ƥ�������
			 */
			function findText(){
				// ����û����������ֵ
				var bn = DWRUtil.getValue("bookName");
				// ������ϴε�ֵ��ͬ���򷵻�
				if(bn == bookName){
					return;
				}
				// ������������Ϊ���ַ������ر��ı���ȫ�㣬������
				if(bn == ""){
					bookName = "";
					closeSupply();
					return;
				}
				// �����������ֵ����ȫ�ֱ���
				bookName = bn;
				// ����TextSupply���findText������ѯ����ƥ�������
				TextSupply.findText(bookName, action);
			}
			/*
			 * �������ݼ������Ƿ���ֵ��ѡ��رջ���ı���ȫ��
			 */
			function action(data){
				if(data.length == 0){
					closeSupply();
				}else{
					openSupply(data);
				}
			}
			/*
			 * �رղ�ȫ��ʾ��
			 */
			function closeSupply(){
				// ��select�е�����option���
				DWRUtil.removeAllOptions("supply");
				// �����ı���ȫ��DIV��
				$("supplyDiv").style.display = "none";
			}
			/*
			 * �򿪲�ȫ��ʾ��
			 */
			function openSupply(data){
				// �Ƚ���DIV������궨λ
				divXY();
				// ��select�е�����option���
				DWRUtil.removeAllOptions("supply");
				// �������������ӵ�select��
				DWRUtil.addOptions("supply", data);
				// ��ʾ�ı���ȫ��DIV��
				$("supplyDiv").style.display = "block";
			}
			/*
			 * DIV��λ
			 */
			function divXY(){
				// ��ȡ�ı����������XY����
				var point = getOffsetPosition($("bookName"));
				// ��λ�ı���ȫ��DIV��
				$("supplyDiv").style.top = point.y + 21;
				$("supplyDiv").style.left = point.x;
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
		<h1 style="color: #FF3333;">�������ͼ�����</h1>
		<form action="JavaScript:;" method="get">
			<input type="text" id="bookName" name="bookName" onkeydown="JavaScript:keyDown();" onkeyup="JavaScript:findText();" style="width: 200px;" />
			<input type="submit" value="����" />
		</form>
		<div id="supplyDiv" style="z-index: 2; display: none; border: 1 solid #666666; width: 200px; position: absolute; overflow: hidden;">
			<select id="supply" name="supply" onclick="JavaScript:changeBookName('mouse');" onkeypress="JavaScript:changeBookName('key');" size="5" style="width: 204px; margin: -4px;">
			</select>
		</div>
	</body>
</html>