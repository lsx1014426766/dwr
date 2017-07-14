package com.fit.dwr;

/**
 * ---行知汇元教学示例---
 * 验证用户输入的登录名是否存在
 * 
 * @author 米强
 */
public class TestUserName {
	// 此学习示例简化数据库查询部分，数组中的人名充当数据库中的用户名数据
	private String[] userNames = { "李白", "杜甫", "白居易", "吴梅村", "李清照", "苏轼", "辛弃疾", "陆游" };

	/**
	 * 验证登录名是否存在
	 * @param userName 参数为String类型，用户输入的登录名
	 * @return 返回值为boolean类型，true为用户名存在，false为不存在
	 */
	public boolean test(String userName) {
		// 通过循环用户名数组，模拟查询数据库
		for(int i = 0; i < userNames.length; i++){
			// 如果用户输入的登录名存在
			if(userName.equals(userNames[i])){
				return true;
			}
		}
		return false;
	}

}
