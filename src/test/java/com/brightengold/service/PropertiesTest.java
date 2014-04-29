package com.brightengold.service;

public class PropertiesTest {
	public static void main(String[] args) {
		//String path = "common.properties";
		//System.out.println(PropertiesTest.class.getResource(".").getPath());
		//System.out.println(System.getProperty("user.dir"));
		//System.out.println(PropertiesUtil.getPropertyValue(path, "p"));
		//PropertiesUtil.updatePropertyValue(path, "p", "456");
		//System.out.println(PropertiesUtil.getPropertyValue(path, "p"));
		PropertiesTest t = new PropertiesTest();
		t.gg();
	}
	
	public void gg(){
		String path = this.getClass().getClassLoader().getResource("common.properties").getPath();
		System.out.println(path);
	}
}
