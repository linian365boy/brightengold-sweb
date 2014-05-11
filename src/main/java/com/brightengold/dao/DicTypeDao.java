package com.brightengold.dao;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import cn.rainier.nian.dao.base.AbstractDao;

import com.brightengold.model.DicType;

public interface DicTypeDao extends AbstractDao<DicType, String>{
	@Modifying
	@Query("update DicType set tvalue = :value where tkey = :key")
	void updateDicTypeValue(@Param("key") String key,@Param("value") String value);
}
