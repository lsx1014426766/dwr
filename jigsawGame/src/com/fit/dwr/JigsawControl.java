package com.fit.dwr;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * ---行知汇元教学示例---
 * 拼图游戏控制器，主要负责接收选择图片的请求，将该类图片地址、名称等信息通过集合对象返回客户端
 * 
 * @author 米强
 * 
 */
public class JigsawControl {
	/*
	 * 存放图片的目录常量
	 */
	private final static String PHOTO_DIRECTORY = "photo/";
	/*
	 * 所有图片的前缀名
	 */
	private final static String PHOTO_NAME = "jigsaw_";

	/**
	 * 接收选择图片的请求，将该类图片的URL通过集合对象返回客户端
	 * @param photoNumber 图片编号
	 * @return 图片URL的集合对象
	 */
	public List<String> requestPhoto(String photoNumber) {
		List<String> list = new ArrayList<String>();
		String url = PHOTO_DIRECTORY + PHOTO_NAME + photoNumber;
		for(int i = 1; i <= 20; i++){
			String tempURL = url + "_" + formatNumber(i) + ".jpg";
			list.add(randemNumber(list.size()), tempURL);
		}
		return list;
	}

	/**
	 * 返回一个随机数，该随机数在1（包括）和指定值n（不包括）之间
	 * @param n 指定值
	 * @return 随机数
	 */
	public int randemNumber(int n) {
		if(n == 0){
			return 0;
		}
		Random r = new Random();
		int in = r.nextInt(n);
		in++;
		return in;
	}

	/**
	 * 格式化编号，由于图片名称中的序号是两位数，当序号为一位数时，前面用0补齐两位
	 * @param index 序号
	 * @return 字符串类型的两位序号
	 */
	public String formatNumber(int index){
		String n = index < 10 ? "0" + index : "" + index;
		return n;
	}

}
