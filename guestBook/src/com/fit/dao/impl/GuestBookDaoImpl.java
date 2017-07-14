package com.fit.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.fit.dao.BaseDao;
import com.fit.dao.intf.GuestBookDaoIntf;
import com.fit.entity.GuestBookEntity;

/**
 * ---��֪��Ԫ��ѧʾ��---
 * ����GuestBook���ݱ��Daoʵ����
 * ������Ǳ�ʾ���ص���룩
 * 
 * @author ��ǿ
 */
public class GuestBookDaoImpl extends BaseDao implements GuestBookDaoIntf {

	/**
	 * �����ݱ��в���һ����������
	 * 
	 * @param guestBook
	 *            �������ݵ�ʵ����
	 * @return �������ݵ�ID������ɹ���IDֵ����0������ʧ����IDֵ����0
	 */
	public int addGuestBook(GuestBookEntity guestBook) {
		// �����践�ص�ID����
		int id = 0;
		try {
			// ���������ݿ�����ӣ��÷������Ը���
			createConnection();
		} catch (ClassNotFoundException e) {
			// �����쳣�󷵻�0����ʾ�ô����ݲ���ʧ��
			// e.printStackTrace();
			return 0;
		} catch (SQLException e) {
			// e.printStackTrace();
			return 0;
		}
		String sql = "insert into guestBook (title, userName, content) values (?, ?, ?)";
		try {
			ps = connection.prepareStatement(sql);
			ps.setString(1, guestBook.getTitle());
			ps.setString(2, guestBook.getUserName());
			ps.setString(3, guestBook.getContent());
			// ִ��SQL�������
			int i = ps.executeUpdate();
			// ����������ʧ�ܣ�����0
			if (i == 0) {
				return 0;
			}
			// ��ѯ��һ��SQL���������������IDֵ
			sql = "select @@identity as id";
			ps = connection.prepareStatement(sql);
			rs = ps.executeQuery();
			rs.next();
			id = rs.getInt("id");
		} catch (SQLException e) {
			// e.printStackTrace();
			return 0;
		} finally {
			// �ͷ���������
			closeAll();
		}
		return id;
	}

	/**
	 * ������ID����ĳһ������
	 * 
	 * @param id
	 *            ����ID
	 * @return ����ʵ����
	 */
	public GuestBookEntity findGuestBookById(int id) {
		// ������Ҫ���ص�����ʵ���࣬�˴���Ҫ��ʼ������Ϊ���û��������Ҫ�����ݣ�������nullֵ
		GuestBookEntity guestBook = null;
		try {
			// ���������ݿ�����ӣ��÷������Ը���
			createConnection();
		} catch (ClassNotFoundException e) {
			// �����쳣�󷵻�δʵ������guestBook�������ñ�����ʱΪnullֵ
			// e.printStackTrace();
			return guestBook;
		} catch (SQLException e) {
			// e.printStackTrace();
			return guestBook;
		}
		String sql = "select * from guestBook where id=?";
		try {
			ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			// ִ�м������
			rs = ps.executeQuery();
			// �����������Ҫ������
			if (rs.next()) {
				// ʵ��������ʵ���࣬����ֵ
				guestBook = new GuestBookEntity();
				guestBook.setId(rs.getInt("id"));
				guestBook.setTitle(rs.getString("title"));
				guestBook.setUserName(rs.getString("userName"));
				guestBook.setContent(rs.getString("content"));
				guestBook.setPutTime(rs.getTimestamp("putTime"));
			}
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			// �ͷ��������ӣ��÷������Ը���
			closeAll();
		}
		return guestBook;
	}

	/**
	 * �������е�����
	 * 
	 * @return ʵ���༯��
	 */
	public List<GuestBookEntity> findGuestBookByAll() {
		// ������Ҫ���ص����Լ�����
		List<GuestBookEntity> guestBooks = new ArrayList<GuestBookEntity>();
		try {
			// ���������ݿ�����ӣ��÷������Ը���
			createConnection();
		} catch (ClassNotFoundException e) {
			// �����쳣�󷵻�δ�����κ����ݵļ��ϱ���
			// e.printStackTrace();
			return guestBooks;
		} catch (SQLException e) {
			// e.printStackTrace();
			return guestBooks;
		}
		// ��ID�ĵ������У�����������Ϣ
		String sql = "select * from guestBook order by id desc";
		try {
			ps = connection.prepareStatement(sql);
			// ִ�м������
			rs = ps.executeQuery();
			while (rs.next()) {
				// ʵ����һ������ʵ���࣬����ֵ
				GuestBookEntity guestBook = new GuestBookEntity();
				guestBook.setId(rs.getInt("id"));
				guestBook.setTitle(rs.getString("title"));
				guestBook.setUserName(rs.getString("userName"));
				guestBook.setContent(rs.getString("content"));
				guestBook.setPutTime(rs.getTimestamp("putTime"));
				// ��ʵ������뼯��
				guestBooks.add(guestBook);
			}
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			// �ͷ��������ӣ��÷������Ը���
			closeAll();
		}
		return guestBooks;
	}

}
