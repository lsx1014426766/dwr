package com.fit.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.fit.dao.BaseDao;
import com.fit.dao.intf.GuestBookDaoIntf;
import com.fit.entity.GuestBookEntity;

/**
 * ---行知汇元教学示例---
 * 操作GuestBook数据表的Dao实现类
 * （该类非本示例重点代码）
 * 
 * @author 米强
 */
public class GuestBookDaoImpl extends BaseDao implements GuestBookDaoIntf {

	/**
	 * 向数据表中插入一条留言数据
	 * 
	 * @param guestBook
	 *            留言数据的实体类
	 * @return 插入数据的ID，如果成功则ID值大于0，插入失败则ID值等于0
	 */
	public int addGuestBook(GuestBookEntity guestBook) {
		// 声明需返回的ID变量
		int id = 0;
		try {
			// 创建与数据库的链接，该方法来自父类
			createConnection();
		} catch (ClassNotFoundException e) {
			// 出现异常后返回0，表示该次数据插入失败
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
			// 执行SQL操作语句
			int i = ps.executeUpdate();
			// 如果插入操作失败，返回0
			if (i == 0) {
				return 0;
			}
			// 查询上一条SQL插入语句所产生的ID值
			sql = "select @@identity as id";
			ps = connection.prepareStatement(sql);
			rs = ps.executeQuery();
			rs.next();
			id = rs.getInt("id");
		} catch (SQLException e) {
			// e.printStackTrace();
			return 0;
		} finally {
			// 释放所有链接
			closeAll();
		}
		return id;
	}

	/**
	 * 按数据ID检索某一条数据
	 * 
	 * @param id
	 *            数据ID
	 * @return 留言实体类
	 */
	public GuestBookEntity findGuestBookById(int id) {
		// 声明需要返回的留言实体类，此处不要初始化，因为如果没有我们需要的数据，将返回null值
		GuestBookEntity guestBook = null;
		try {
			// 创建与数据库的链接，该方法来自父类
			createConnection();
		} catch (ClassNotFoundException e) {
			// 出现异常后返回未实例化的guestBook变量，该变量此时为null值
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
			// 执行检索语句
			rs = ps.executeQuery();
			// 如果检索到需要的数据
			if (rs.next()) {
				// 实例化留言实体类，并赋值
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
			// 释放所有链接，该方法来自父类
			closeAll();
		}
		return guestBook;
	}

	/**
	 * 检索所有的数据
	 * 
	 * @return 实体类集合
	 */
	public List<GuestBookEntity> findGuestBookByAll() {
		// 声明需要返回的留言集合类
		List<GuestBookEntity> guestBooks = new ArrayList<GuestBookEntity>();
		try {
			// 创建与数据库的链接，该方法来自父类
			createConnection();
		} catch (ClassNotFoundException e) {
			// 出现异常后返回未插入任何数据的集合变量
			// e.printStackTrace();
			return guestBooks;
		} catch (SQLException e) {
			// e.printStackTrace();
			return guestBooks;
		}
		// 按ID的倒序排列，检索留言信息
		String sql = "select * from guestBook order by id desc";
		try {
			ps = connection.prepareStatement(sql);
			// 执行检索语句
			rs = ps.executeQuery();
			while (rs.next()) {
				// 实例化一个留言实体类，并赋值
				GuestBookEntity guestBook = new GuestBookEntity();
				guestBook.setId(rs.getInt("id"));
				guestBook.setTitle(rs.getString("title"));
				guestBook.setUserName(rs.getString("userName"));
				guestBook.setContent(rs.getString("content"));
				guestBook.setPutTime(rs.getTimestamp("putTime"));
				// 将实体类插入集合
				guestBooks.add(guestBook);
			}
		} catch (SQLException e) {
			// e.printStackTrace();
		} finally {
			// 释放所有链接，该方法来自父类
			closeAll();
		}
		return guestBooks;
	}

}
