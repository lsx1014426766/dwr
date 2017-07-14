package com.fit.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * ---行知汇元教学示例---
 * 负责链接、释放数据库的DAO基础类
 * （该类非本示例重点代码）
 * 
 * @author 米强
 */
public class BaseDao {
	// 链接数据库所需的静态常量
	private final String user = "sa";
	private final String password = "sa";
	private final String datebaseName = "guestBookDB";
	private final String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private final String url = "jdbc:sqlserver://localhost:1433;DatabaseName=" + datebaseName;

	// 给子类使用的数据库操作变量
	protected Connection connection = null;
	protected PreparedStatement ps = null;
	protected ResultSet rs = null;

	public BaseDao() {
	}

	/**
	 * 创建一个新的数据库链接
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public void createConnection() throws ClassNotFoundException, SQLException{
		if(connection != null){
			try {
				connection.close();
			} catch (SQLException e) {
			} finally {
				connection = null;
			}
		}
		Class.forName(driver);
		connection = DriverManager.getConnection(url, user, password);
	}

	/**
	 * 释放所有连接
	 */
	public void closeAll(){
		if(rs != null){
			try {
				rs.close();
			} catch (SQLException e) {
			} finally {
				rs = null;
			}
		}
		if(ps != null){
			try {
				ps.close();
			} catch (SQLException e) {
			} finally {
				ps = null;
			}
		}
		if(connection != null){
			try {
				connection.close();
			} catch (SQLException e) {
			} finally {
				connection = null;
			}
		}
	}

}
