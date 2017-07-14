package com.salmon.service;

import java.util.ArrayList;
import java.util.List;

import com.salmon.bean.UserBean;

public class UserService {

	
	 public  void  test(){
		 
		 System.out.println("你好");
	 }
	 public  void test2(String username){
		 System.out.println(username);
	 }
	 
	 public  String  test3(String username){
		 System.out.println(username);
		 return  username+"jjjj";
	 }
	 public  List  test4(){
		 List  list  = new  ArrayList();
		 list.add("nihao");
		 list.add("hello");
		 list.add("salmon");
		 return  list;
	 }
	 public  List  test5(){
		 List  list  = new  ArrayList();
		 list.add(new UserBean("zhangsan"));
		 list.add(new UserBean("lisi"));
		 return  list;
	 }
	
}

