package com.brightengold.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.brightengold.dao.DicTypeDao;
import com.brightengold.model.DicType;

@Component("dicTypeService")
public class DicTypeService {
	@Autowired
	private DicTypeDao dicTypeDao;
	
	public DicType getDicType(String key){
		return dicTypeDao.findOne(key);
	}
	
	public void updateDicType(String key, String value){
		dicTypeDao.updateDicTypeValue(key,value);
	}
	
}
