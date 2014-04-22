package com.brightengold.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import cn.rainier.nian.utils.PageRainier;
import com.brightengold.model.Feedback;
import com.brightengold.service.FeedbackService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.util.LogType;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

@Controller
@Scope("prototype")
public class FeedbackController extends ActionSupport implements ModelDriven<Feedback>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6656090366762932727L;
	@Autowired
	private FeedbackService feedbackService;
	private PageRainier<Feedback> page;
	private Integer pageSize = 10;
	private Integer pageNo = 1;
	private Feedback model = new Feedback();
	
	public String list(){
		page = feedbackService.findAll(pageNo, pageSize);
		return "list";
	}
	
	public String detail(){
		if(model.getId()!=null){
			model = feedbackService.loadOne(model.getId());
		}
		return "detail";
	}
	
	public String delete(){
		if (model.getId() != null) {
			feedbackService.delete(model.getId());
			MsgUtil.setMsgDelete("success");
			LogUtil.getInstance().log(LogType.DEL, "联系方式为"+model.getTelePhone());
		}
		return "toList";
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	@Override
	public Feedback getModel() {
		return model;
	}

	public PageRainier<Feedback> getPage() {
		return page;
	}

	public void setPage(PageRainier<Feedback> page) {
		this.page = page;
	}

	public Integer getPageNo() {
		return pageNo;
	}

	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}
	
}
