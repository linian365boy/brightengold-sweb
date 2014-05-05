package com.brightengold.service;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import cn.rainier.nian.utils.PageRainier;

import com.brightengold.dao.ProductDao;
import com.brightengold.model.Product;

@Component("productService")
public class ProductService {
	@Autowired
	private ProductDao productDao;

	public PageRainier<Product> findAll(Integer pageNo, Integer pageSize) {
		Page<Product> tempPage = productDao.findAll(new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"id")));
		PageRainier<Product> page = new PageRainier<Product>(tempPage.getTotalElements(),pageNo,pageSize);
		page.setResult(tempPage.getContent());
		return page;
	}

	public Product loadProductById(Integer productId) {
		return productDao.findOne(productId);
	}

	public Product saveProduct(Product product) {
		return productDao.save(product);
	}

	public void delProduct(Integer productId) {
		productDao.delete(productId);
	}
	
	public void delProduct(Product product) {
		productDao.delete(product);
	}
	
	public PageRainier<Product> findProductByCategory(Integer categoryId,Integer prNo,Integer prSize){
		Page<Product> page = productDao.findAll(getProductByCaIdSpeci(categoryId), new PageRequest(prNo-1,prSize,new Sort(Direction.DESC,"createDate")));
		PageRainier<Product> pageRainier = new PageRainier<Product>(page.getTotalElements(),prNo,prSize);
		pageRainier.setResult(page.getContent());
		return pageRainier;
	}
	
	private Specification<Product> getProductByCaIdSpeci(final Integer categoryId) {
		return new Specification<Product>(){
			@Override
			public Predicate toPredicate(Root<Product> root, CriteriaQuery<?> query,
					CriteriaBuilder cb) {
				return cb.and(
					cb.or(cb.equal(root.get("category").get("id"), categoryId),
					cb.equal(root.get("category").get("parent").get("id"), categoryId)
					),
					cb.equal(root.get("publish"), true));
			}
		};
	}

	/**
	 * 最新推荐
	 * @param flag flag 为true表示index页面，否则就是分页页面
	 * @return
	 */
	public PageRainier<Product> findLastestProducts(boolean flag,Integer pageNo,Integer pageSize){
		if(flag){
			pageNo = 1;
			pageSize = 30;
		}
		Page<Product> productsPage = productDao.findAll(getLastestProductsSpeci(),new PageRequest(pageNo-1, pageSize, new Sort(Direction.DESC, "createDate")));
		PageRainier<Product> page = new PageRainier<Product>(productsPage.getTotalElements(),pageNo,pageSize);
		page.setResult(productsPage.getContent());
		return page;
	}
	
	private Specification<Product> getLastestProductsSpeci(){
		return new Specification<Product>() {
			@Override
			public Predicate toPredicate(Root<Product> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {
				Path<String> path = root.get("publish");
				return cb.equal(path, true);
			}
		};
	}
	
	/**
	 * 热门商品
	 * @param flag flag 为true表示index页面，否则就是分页页面
	 * @return
	 */
	public PageRainier<Product> findHotProducts(boolean flag,Integer pageNo,Integer pageSize){
		if(flag){
			pageNo = 1;
			pageSize = 6;
		}
		Page<Product> productsPage = productDao.findAll(getHotProductsSpeci(),new PageRequest(pageNo-1, pageSize, new Sort(Direction.DESC,"createDate")));
		PageRainier<Product> page = new PageRainier<Product>(productsPage.getTotalElements(),1,6);
		page.setResult(productsPage.getContent());
		return page;
	}

	private Specification<Product> getHotProductsSpeci() {
		return new Specification<Product>() {
			@Override
			public Predicate toPredicate(Root<Product> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {
				return cb.and(cb.equal(root.get("publish"),true),cb.equal(root.get("hot"),true));
			}
		};
	}
}
