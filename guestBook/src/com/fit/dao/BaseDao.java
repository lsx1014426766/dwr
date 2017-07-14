package com.fit.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * ---��֪��Ԫ��ѧʾ��---
 * �������ӡ��ͷ����ݿ��DAO������
 * ������Ǳ�ʾ���ص���룩
 * 
 * @author ��ǿ
 */
public class BaseDao {
	// �������ݿ�����ľ�̬����
	private final String user = "sa";
	private final String password = "sa";
	private final String datebaseName = "guestBookDB";
	private final String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private final String url = "jdbc:sqlserver://localhost:1433;DatabaseName=" + datebaseName;

	// ������ʹ�õ����ݿ��������
	protected Connection connection = null;
	protected PreparedStatement ps = null;
	protected ResultSet rs = null;

	public BaseDao() {
	}

	/**
	 * ����һ���µ����ݿ�����
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
	 * �ͷ���������
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
