package com.brightengold.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Query;

import cn.rainier.nian.dao.base.AbstractDao;

import com.brightengold.model.Category;
import com.brightengold.model.Product;

public interface ProductDao extends AbstractDao<Product, Integer>{
	@Query("select p from Product p where p.category.id = ?")
	List<Product> findProductByCategory(Integer categoryId);
}
