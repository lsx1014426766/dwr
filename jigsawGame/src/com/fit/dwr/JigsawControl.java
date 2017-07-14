package com.fit.dwr;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * ---��֪��Ԫ��ѧʾ��---
 * ƴͼ��Ϸ����������Ҫ�������ѡ��ͼƬ�����󣬽�����ͼƬ��ַ�����Ƶ���Ϣͨ�����϶��󷵻ؿͻ���
 * 
 * @author ��ǿ
 * 
 */
public class JigsawControl {
	/*
	 * ���ͼƬ��Ŀ¼����
	 */
	private final static String PHOTO_DIRECTORY = "photo/";
	/*
	 * ����ͼƬ��ǰ׺��
	 */
	private final static String PHOTO_NAME = "jigsaw_";

	/**
	 * ����ѡ��ͼƬ�����󣬽�����ͼƬ��URLͨ�����϶��󷵻ؿͻ���
	 * @param photoNumber ͼƬ���
	 * @return ͼƬURL�ļ��϶���
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
	 * ����һ������������������1����������ָ��ֵn����������֮��
	 * @param n ָ��ֵ
	 * @return �����
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
	 * ��ʽ����ţ�����ͼƬ�����е��������λ���������Ϊһλ��ʱ��ǰ����0������λ
	 * @param index ���
	 * @return �ַ������͵���λ���
	 */
	public String formatNumber(int index){
		String n = index < 10 ? "0" + index : "" + index;
		return n;
	}

}
