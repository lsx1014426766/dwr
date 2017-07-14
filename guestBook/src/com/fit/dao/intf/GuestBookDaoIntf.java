package com.fit.dao.intf;

import java.util.List;

import com.fit.entity.GuestBookEntity;

/**
 * ---行知汇元教学示例---
 * 操作GuestBook数据表的Dao接口
 * （该接口非本示例重点代码）
 * 
 * @author 米强
 */
public interface GuestBookDaoIntf {

	/**
	 * 按数据ID检索某一条数据
	 * @param id 数据ID
	 * @return 留言实体类
	 */
	public GuestBookEntity findGuestBookById(int id);

	/**
	 * 检索所有的数据
	 * @return 实体类集合
	 */
	public List<GuestBookEntity> findGuestBookByAll();

	/**
	 * 向数据表中插入一条留言数据
	 * @param guestBook 留言数据的实体类
	 * @return 插入数据的ID，如果成功则ID值大于0，插入失败则ID值等于0
	 */
	public int addGuestBook(GuestBookEntity guestBook);
	
}
