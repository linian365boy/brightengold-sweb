package com.brightengold.service;

import org.junit.Test;

public class TestJava {
	public static void main(String[] args) {
		String str = "D:ddfg/dfgdf/resources/upload/products";
		int i = str.lastIndexOf("upload");
		System.out.println(i);
		String re = str.substring(i);
		System.out.println(re);
	}
	
	@Test
	public void testSubString(){
		String str = "abcabc123ok456okok";
		System.out.println(str.substring(str.indexOf("abc")+3, str.lastIndexOf("ok")));
	}
}
