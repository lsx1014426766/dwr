package com.fit.entity;

import java.sql.Timestamp;

/**
 * ---行知汇元教学示例---
 * 留言内容的实体类
 * （该类非本示例重点代码）
 * 
 * @author 米强
 */
public class GuestBookEntity {
	private int id = 0;
	private String title = null;
	private String userName = null;
	private String content = null;
	private Timestamp putTime = null;

	public GuestBookEntity() {
	}

	public GuestBookEntity(int id, String title, String userName,
			String content, Timestamp putTime) {
		this.id = id;
		this.title = title;
		this.userName = userName;
		this.content = content;
		this.putTime = putTime;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getPutTime() {
		return putTime;
	}

	public void setPutTime(Timestamp putTime) {
		this.putTime = putTime;
	}

}
