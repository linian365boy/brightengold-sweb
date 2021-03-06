package com.brightengold.service;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import cn.rainier.nian.model.User;
import cn.rainier.nian.utils.PageRainier;

import com.brightengold.dao.CategoryDao;
import com.brightengold.model.Category;

@Component("categoryService")
public class CategoryService {
	@Autowired
	private CategoryDao categoryDao;

	public PageRainier<Category> findAll(Integer pageNo, Integer pageSize) {
		Page<Category> tempPage = categoryDao.findAll(new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"id")));
		PageRainier<Category> page = new PageRainier<Category>(tempPage.getTotalElements(),pageNo,pageSize);
		page.setResult(tempPage.getContent());
		return page;
	}

	public List<Object[]> findParentByAjax() {
		return this.categoryDao.findParentByAjax();
	}

	public Category loadCategoryById(Integer categoryId) {
		return categoryDao.findOne(categoryId);
	}

	public Category saveCategory(Category temp) {
		return categoryDao.save(temp);
	}

	public Category loadCategoryByName(String enName) {
		return categoryDao.loadCateByName(enName);
	}

	public void delCategory(Integer categoryId) {
		categoryDao.delete(categoryId);
	}

	public boolean checkHasChildren(Category temp) {
		return categoryDao.checkHasChildren(temp)>0?true:false;
	}

	public List<Category> findParentCategory() {
		return categoryDao.findParentCats();
	}

	public List<Object[]> getChildrenCategory(int pid) {
		return this.categoryDao.findChildCategoryByAjax(pid);
	}

	public boolean checkHasProduct(Category model) {
		return categoryDao.checkHasProduct(model)>0?true:false;
	}
	
	
}
