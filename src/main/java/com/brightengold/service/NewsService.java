package com.brightengold.service;

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

import cn.rainier.nian.utils.PageRainier;

import com.brightengold.dao.NewsDao;
import com.brightengold.model.Category;
import com.brightengold.model.News;
import com.brightengold.model.Product;

@Component("newsService")
public class NewsService {
	@Autowired
	private NewsDao newsDao;
	
	public PageRainier<News> findAll(Integer pageNo, Integer pageSize) {
		Page<News> tempPage = newsDao.findAll(new PageRequest(pageNo-1,pageSize,new Sort(Direction.DESC,"priority","id")));
		PageRainier<News> page = new PageRainier<News>(tempPage.getTotalElements(),pageNo,pageSize);
		page.setResult(tempPage.getContent());
		return page;
	}

	public News saveNews(News news) {
		try {
			return newsDao.save(news);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public News loadNews(Integer id){
		return newsDao.findOne(id);
	}

	public boolean delNews(News news) {
		try{
			newsDao.delete(news);
			return true;
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}

	public void updateClicks(News news) {
		try{
			newsDao.updateClicks(news.getId(),news.getClicks()+1);
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	public PageRainier<News> findAllPublish(Integer pageNo, Integer pageSize) {
		PageRequest request = new PageRequest(pageNo-1, pageSize,new Sort(Direction.DESC,"priority","publishDate"));
		Page<News> tempPage = newsDao.findAll(getAllPublishSpeci(), request);
		PageRainier<News> page = new PageRainier<News>(tempPage.getTotalElements(), pageNo, pageSize);
		page.setResult(tempPage.getContent());
		return page;
	}
	
	private Specification<News> getAllPublishSpeci(){
		return new Specification<News>() {
			@Override
			public Predicate toPredicate(Root<News> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {
				return cb.isNotNull(root.get("publishDate"));
			}
		};
	}

	public int getClicks(Integer id) {
		return newsDao.getClicks(id);
	}

}
