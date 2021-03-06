package com.brightengold.dao;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import cn.rainier.nian.dao.base.AbstractDao;

import com.brightengold.model.News;

public interface NewsDao extends AbstractDao<News, Integer>{
	@Modifying
	@Query("update News set clicks = ?2 where id = ?1")
	public void updateClicks(Integer newsId,Integer clicks);
	@Query("select clicks from News n where n.id = ?")
	public int getClicks(Integer id);

}
