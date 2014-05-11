package com.brightengold.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.brightengold.dao.DicTypeDao;
import com.brightengold.model.DicType;
import com.brightengold.util.DESPlus;

@Component("dicTypeService")
public class DicTypeService {
	@Autowired
	private DicTypeDao dicTypeDao;
	
	public DicType getDicType(String key){
		return dicTypeDao.findOne(key);
	}
	
	public void updateDicType(String key, String value){
		try {
			value = new DESPlus().encrypt("abc"+value+"ok");
			dicTypeDao.updateDicTypeValue("p"+key,value);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void saveDicType(Long key,String value){
		try {
			value = new DESPlus().encrypt("abc"+value+"ok");
			DicType entity = new DicType("p"+key,value);
			dicTypeDao.save(entity);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
