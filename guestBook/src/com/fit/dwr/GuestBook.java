package com.fit.dwr;

import java.util.List;

import com.fit.dao.impl.GuestBookDaoImpl;
import com.fit.dao.intf.GuestBookDaoIntf;
import com.fit.entity.GuestBookEntity;

/**
 * ---行知汇元教学示例---
 * DWR通过对该类中方法的调用进行数据的操作
 * （该类方法在页面中的调用是本示例重点代码）
 * 
 * @author 米强
 */
public class GuestBook {
	private GuestBookDaoIntf guestBookDao = null;

	public GuestBook() {
	}

	/**
	 * 插入一条新的留言信息
	 * @param title 标题
	 * @param userName 用户
	 * @param content 留言内容
	 * @return 留言实体类
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
	 * 返回所有留言内容
	 * @return 留言内容集合类
	 */
	public List<GuestBookEntity> findGuestBookByAll(){
		guestBookDao = new GuestBookDaoImpl();
		return guestBookDao.findGuestBookByAll();
	}

}
