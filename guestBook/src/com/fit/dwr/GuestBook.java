package com.fit.dwr;

import java.util.List;

import com.fit.dao.impl.GuestBookDaoImpl;
import com.fit.dao.intf.GuestBookDaoIntf;
import com.fit.entity.GuestBookEntity;

/**
 * ---��֪��Ԫ��ѧʾ��---
 * DWRͨ���Ը����з����ĵ��ý������ݵĲ���
 * �����෽����ҳ���еĵ����Ǳ�ʾ���ص���룩
 * 
 * @author ��ǿ
 */
public class GuestBook {
	private GuestBookDaoIntf guestBookDao = null;

	public GuestBook() {
	}

	/**
	 * ����һ���µ�������Ϣ
	 * @param title ����
	 * @param userName �û�
	 * @param content ��������
	 * @return ����ʵ����
	 */
	public GuestBookEntity addGuestBook(String title, String userName, String content){
		GuestBookEntity guestBook = new GuestBookEntity();
		guestBook.setTitle(title);
		guestBook.setUserName(userName);
		guestBook.setContent(content);
		guestBookDao = new GuestBookDaoImpl();
		int id = guestBookDao.addGuestBook(guestBook);
		guestBook = guestBookDao.findGuestBookById(id);
		return guestBook;
	}

	/**
	 * ����������������
	 * @return �������ݼ�����
	 */
	public List<GuestBookEntity> findGuestBookByAll(){
		guestBookDao = new GuestBookDaoImpl();
		return guestBookDao.findGuestBookByAll();
	}

}
