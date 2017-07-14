package com.fit.dwr;

import java.util.ArrayList;
import java.util.List;

/**
 * ---��֪��Ԫ��ѧʾ��---
 * �ı���ȫ�������û�����Ĳ����ַ����������ݼ��в���ƥ����ı����в�ȫ��ʾ
 * 
 * @author ��ǿ
 */
public class TextSupply {
	// ��ʾ���������ݿ���������ַ�������ģ�����ݿ��е����ݽ��б��
	private final static String[] data = { "Java����", "Java����ȫ", "��ҳ�����ο��ֲ�",
			"��ҳ��Чʾ��", "Java���̽���", "Java365��", "JavaScript100��",
			"JavaScript�ű����", "C��������", "C#�����������", "C#�߼����", "C++���������",
			"Java�������������", "AJAX������", "AJAX���ײο�", "DWR��ܼ���", "DWR�����ļ����",
			"DWR�첽������", "AJAX�����ȫ", "��ҳ��̬Ч��" };

	public TextSupply() {
	}

	/**
	 * ��ѯ�Ƿ���ƥ�������
	 * @return ����ƥ���������ַ�������
	 */
	public List<String> findText(String text){
		// Ϊ�˺��Դ�Сдƥ�䣬��������Ļת����Сд��ĸ
		text = text.toLowerCase();
		// ����ƥ�����ݵļ���
		List<String> list = new ArrayList<String>();
		for(int i = 0; i < data.length; i++){
			// �û�������ַ���ƥ��
			if(data[i].toLowerCase().indexOf(text) == 0){
				// ��ƥ��������ӵ�����
				list.add(data[i]);
			}
		}
		// ���ؼ���
		return list;
	}
	
}
