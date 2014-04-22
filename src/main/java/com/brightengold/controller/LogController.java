package com.brightengold.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import cn.rainier.nian.utils.PageRainier;
import com.brightengold.model.Log;
import com.brightengold.service.LogService;
import com.opensymphony.xwork2.ActionSupport;

@Controller
@Scope("prototype")
public class LogController extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2848028987456999904L;
	@Autowired
	private LogService logService;
	private PageRainier<Log> page;
	private Integer pageSize = 10;
	private Integer pageNo = 1;
	
	public String list(){
		page = logService.findAll(pageNo, pageSize);
		return "list";
	}

	public PageRainier<Log> getPage() {
		return page;
	}

	public void setPage(PageRainier<Log> page) {
		this.page = page;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getPageNo() {
		return pageNo;
	}

	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}
	
}
