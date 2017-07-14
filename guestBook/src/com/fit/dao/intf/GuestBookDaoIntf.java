package com.fit.dao.intf;

import java.util.List;

import com.fit.entity.GuestBookEntity;

/**
 * ---��֪��Ԫ��ѧʾ��---
 * ����GuestBook���ݱ��Dao�ӿ�
 * ���ýӿڷǱ�ʾ���ص���룩
 * 
 * @author ��ǿ
 */
public interface GuestBookDaoIntf {

	/**
	 * ������ID����ĳһ������
	 * @param id ����ID
	 * @return ����ʵ����
	 */
	public GuestBookEntity findGuestBookById(int id);

	/**
	 * �������е�����
	 * @return ʵ���༯��
	 */
	public List<GuestBookEntity> findGuestBookByAll();

	/**
	 * �����ݱ��в���һ����������
	 * @param guestBook �������ݵ�ʵ����
	 * @return �������ݵ�ID������ɹ���IDֵ����0������ʧ����IDֵ����0
	 */
	public int addGuestBook(GuestBookEntity guestBook);
	
}
