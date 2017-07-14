package com.fit.dwr;

import java.util.ArrayList;
import java.util.List;

/**
 * ---行知汇元教学示例---
 * 文本补全，根据用户输入的部分字符串，在数据集中查找匹配的文本进行补全提示
 * 
 * @author 米强
 */
public class TextSupply {
	// 本示例简化了数据库检索，以字符串数组模拟数据库中的数据进行编程
	private final static String[] data = { "Java入门", "Java类库大全", "网页制作参考手册",
			"网页特效示例", "Java工程解析", "Java365天", "JavaScript100例",
			"JavaScript脚本详解", "C语言入门", "C#面向对象语言", "C#高级编程", "C++经典代码解读",
			"Java面向对象程序设计", "AJAX的魅力", "AJAX进阶参考", "DWR框架技术", "DWR配置文件详解",
			"DWR异步请求技术", "AJAX代码大全", "网页动态效果" };

	public TextSupply() {
	}

	/**
	 * 查询是否有匹配的数据
	 * @return 所有匹配条件的字符串集合
	 */
	public List<String> findText(String text){
		// 为了忽略大小写匹配，将所有字幕转换成小写字母
		text = text.toLowerCase();
		// 保存匹配数据的集合
		List<String> list = new ArrayList<String>();
		for(int i = 0; i < data.length; i++){
			// 用户输入的字符串匹配
			if(data[i].toLowerCase().indexOf(text) == 0){
				// 将匹配数据添加到集合
				list.add(data[i]);
			}
		}
		// 返回集合
		return list;
	}
	
}
