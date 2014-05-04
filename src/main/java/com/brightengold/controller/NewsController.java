package com.brightengold.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;

import cn.rainier.nian.model.User;
import cn.rainier.nian.utils.PageRainier;

import com.brightengold.model.Category;
import com.brightengold.model.Company;
import com.brightengold.model.JsonEntity;
import com.brightengold.model.News;
import com.brightengold.service.CategoryService;
import com.brightengold.service.CompanyService;
import com.brightengold.service.DicTypeService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.service.NewsService;
import com.brightengold.util.HTMLGenerator;
import com.brightengold.util.LogType;
import com.brightengold.util.Tools;
import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

@Controller
@Scope("prototype")
public class NewsController extends ActionSupport implements ModelDriven<News>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Autowired
	private NewsService newsService;
	private PageRainier<News> page;
	private Integer pageSize = 10;
	private Integer pageNo = 1;
	private News model = new News();
	@Autowired
	private DicTypeService dicTypeService;
	@Autowired
	private CompanyService companyService;
	@Autowired
	private CategoryService categoryService;
	
	public String list(){
		page = newsService.findAll(pageNo, pageSize);
		return "list";
	}
	
	public String add(){
		if(model.getPriority()==null){
			model.setPriority(0);
		}
		model.setClicks(0);
		model.setCreateDate(new Date());
		model.setUrl("views/html/news/"+Tools.getRndFilename()+".html");
		newsService.saveNews(model);
		MsgUtil.setMsgAdd("success");
		LogUtil.getInstance().log(LogType.ADD,"标题："+model.getTitle());
		return "toList";
	}
	
	public String updatePre(){
		if(model.getId()!=null){
			model = newsService.loadNews(model.getId());
		}
		return "update";
	}
	
	public String update(){
		if(model.getId()!=null){
			StringBuilder content = new StringBuilder();
			News temp = newsService.loadNews(model.getId());
			model.setCreateDate(temp.getCreateDate());
			model.setClicks(temp.getClicks());
			model.setUrl(temp.getUrl());
			newsService.saveNews(model);
			if(!temp.getTitle().equals(model.getTitle())){
				content.append("标题由\""+temp.getTitle()+"\"修改为\""+model.getTitle()+"\"");
			}
			if(!temp.getPriority().equals(model.getPriority())){
				content.append("优先值由\""+temp.getPriority()+"\"修改为\""+model.getPriority()+"\"");
			}
			if("".equals(content.toString().trim())){
				content.append("修改了标题为"+model.getTitle()+"新闻");
			}
			MsgUtil.setMsgUpdate("success");
			LogUtil.getInstance().log(LogType.EDIT, content.toString());
		}
		return "toList";
	}
	
	public String detail(){
		if(model.getId()!=null){
			HttpServletRequest request = ServletActionContext.getRequest();
			model = newsService.loadNews(model.getId());
			newsService.updateClicks(model);	//点击率
			Company company = companyService.loadCompany();
			List<Category> parentCats = categoryService.findParentCategory();
			request.setAttribute("company", company);
			request.setAttribute("parentCats", parentCats);
			return "details";
		}
		MsgUtil.setMsg(ERROR, "对不起，新闻不存在！");
		return "toList";
	}
	
	public String del(){
		HttpServletRequest request = ServletActionContext.getRequest();
		if(model.getId()!=null){
			model = newsService.loadNews(model.getId());
			String htmlUrl = model.getUrl();
			if(newsService.delNews(model)){
				if(htmlUrl!=null){
					String path = request.getSession().getServletContext().getRealPath("/"+htmlUrl);
					Tools.delFile(path);
				}
				MsgUtil.setMsgDelete("success");
			}
			LogUtil.getInstance().log(LogType.DEL, "标题："+model.getTitle());
		}
		return "toList";
	}
	
	public void checkPub(){
		PrintWriter writer = null;
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setContentType("text/html; charset=UTF-8");
			writer = response.getWriter();
			if(model.getId()!=null){
				model = newsService.loadNews(model.getId());
				if(model!=null){
					if(model.getPublishDate()!=null){
						writer.write("1");
					}else{
						writer.write("-1");
					}
				}else{
					writer.write("0");
				}
			}else{
				writer.write("0");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(writer!=null){
				writer.close();
			}
		}
	}
	
	public void publishNews(){
		 PrintWriter writer = null;
			try {
				HttpServletRequest request = ServletActionContext.getRequest();
				model = newsService.loadNews(model.getId());
				User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
				String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();				
				String url=basePath+"/admin/news/news_detail.do?id="+model.getId();
				HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
				String value = dicTypeService.getDicType("p").getValue();
				JsonEntity entity = new JsonEntity();
				if(htmlGenerator.createHtmlPage(url,
						request.getSession().getServletContext().getRealPath(model.getUrl()),
						loginUser.getUsername(),
						value.substring(value.indexOf("abc")+3, value.lastIndexOf("ok")))){
					model.setPublishDate(new Date());
					if(newsService.saveNews(model)!=null){
						entity.setKey("1");
						entity.setValue(Tools.formatDate(model.getPublishDate(), false));
						LogUtil.getInstance().log(LogType.PUBLISH, "标题："+model.getTitle());
					}else{
						entity.setKey("-1");
					}
				}else{
					model.setPublishDate(null);
					entity.setKey("-1");
				}
				newsService.saveNews(model);
				Gson gson = new Gson();
				writer = ServletActionContext.getResponse().getWriter();
				writer.write(gson.toJson(entity));
			} catch (IOException e) {
				e.printStackTrace();
			}
	}
	
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	@Override
	public News getModel() {
		return model;
	}
	
	public PageRainier<News> getPage() {
		return page;
	}

	public void setPage(PageRainier<News> page) {
		this.page = page;
	}

	public Integer getPageNo() {
		return pageNo;
	}

	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}
	
}
