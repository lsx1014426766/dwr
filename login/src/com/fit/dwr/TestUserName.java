package com.fit.dwr;

/**
 * ---��֪��Ԫ��ѧʾ��---
 * ��֤�û�����ĵ�¼���Ƿ����
 * 
 * @author ��ǿ
 */
public class TestUserName {
	// ��ѧϰʾ�������ݿ��ѯ���֣������е������䵱���ݿ��е��û�������
	private String[] userNames = { "���", "�Ÿ�", "�׾���", "��÷��", "������", "����", "������", "½��" };

	/**
	 * ��֤��¼���Ƿ����
	 * @param userName ����ΪString���ͣ��û�����ĵ�¼��
	 * @return ����ֵΪboolean���ͣ�trueΪ�û������ڣ�falseΪ������
	 */
	public boolean test(String userName) {
		// ͨ��ѭ���û������飬ģ���ѯ���ݿ�
		for(int i = 0; i < userNames.length; i++){
			// ����û�����ĵ�¼������
			if(userName.equals(userNames[i])){
				return true;
			}
		}
		return false;
	}

}
