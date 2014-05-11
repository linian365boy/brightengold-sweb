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
import com.brightengold.service.CategoryService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.util.LogType;
import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

@Controller
@Scope("prototype")
public class CategoryController extends ActionSupport implements ModelDriven<Category>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4167797046226746254L;
	@Autowired
	private CategoryService categoryService;
	private PageRainier<Category> page;
	private Integer pageSize = 10;
	private Integer pageNo = 1;
	private Category model = new Category();
	
	public String list(){
		page = categoryService.findAll(pageNo, pageSize);
		return "list";
	}
	
	public String add() {
		HttpServletRequest request = ServletActionContext.getRequest();
		User u = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		try {
			if(Integer.parseInt(request.getParameter("parentC"))==0){
				model.setParent(null);
			}else{
				model.setParent(categoryService.loadCategoryById(Integer.parseInt(request.getParameter("parentC"))));
			}
			model.setCreateDate(new Date());
			model.setCreateUser(u);
			categoryService.saveCategory(model);
			MsgUtil.setMsgAdd("success");
			LogUtil.getInstance().log(LogType.ADD,"名称："+model.getEnName());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "toList";
	}
	
	public void getParentByAjax(){
		HttpServletResponse res = ServletActionContext.getResponse();
		PrintWriter writer = null;
		try {
			String flag = ServletActionContext.getRequest().getParameter("flag");
			List<Object[]> parentsByAjax = this.getParent(flag);
			Gson gson = new Gson();
			writer = res.getWriter();
			writer.write(gson.toJson(parentsByAjax));
		} catch (IOException e) {
			e.printStackTrace();
		} finally{
			if(writer!=null){
				writer.close();
			}
		}
	}
	
	public List<Object[]> getParent(String flag){
		List<Object[]> parentsByAjax = categoryService.findParentByAjax();
		if(!"0".equals(flag)){
			parentsByAjax.add(0, new Object[]{0,"根节点"});
		}
		return parentsByAjax;
	}
	
	public String updatePre() {
		HttpServletRequest request = ServletActionContext.getRequest();
		if (model.getId() != null) {
			model = categoryService.loadCategoryById(model.getId());
			request.setAttribute("parents", this.getParent("1"));
		}
		return "update";
	}
	
	public String update() {
		StringBuilder content = new StringBuilder();
		HttpServletRequest request = ServletActionContext.getRequest();
		if(model.getId()!=null){
			Category temp = categoryService.loadCategoryById(model.getId());
			String parentIds = request.getParameter("parents");
			if(parentIds!=null){
				model.setParent(categoryService.loadCategoryById(Integer.parseInt(parentIds)));
			}
			if(!temp.getEnName().equals(model.getEnName())){
				content.append("名称由\""+temp.getEnName()+"\"修改为\""+model.getEnName()+"\" ");
			}else{
				content.append("名称："+temp.getEnName());
			}
			if(temp.getParent()!=null&&!(temp.getParent().equals(model.getParent()))){
				if(model.getParent()!=null){
					content.append("一级分类由\""+temp.getParent().getEnName()+"\"修改为\""+model.getParent().getEnName()+"\"");
				}else{
					content.append("一级分类由\""+temp.getParent().getEnName()+"\"修改为\"根节点\"");
				}
			}else if(temp.getParent()==null&&parentIds!=null&&!("0".equals(parentIds))){
				if(temp.getChildren()!=null&&temp.getChildren().size()<=0){
					content.append("一级分类由\"根节点\"修改为\""+model.getParent().getEnName()+"\"");
				}else{
					MsgUtil.setMsg("error", "该分类下已有子分类，不能变更商品分类级别！");
					return "toList";
				}
			}else{
				if(temp.getParent()!=null){
					content.append("一级分类："+temp.getParent().getEnName());
				}
			}
			model.setCreateDate(temp.getCreateDate());
			model.setCreateUser(temp.getCreateUser());
			categoryService.saveCategory(model);
			MsgUtil.setMsgUpdate("success");
			LogUtil.getInstance().log(LogType.EDIT,content.toString());
		}
		return "toList";
	}
	
	public void existCategory(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = null;
		PrintWriter out = null;
		try {
			response = ServletActionContext.getResponse();
			String enName = request.getParameter("enName");
			String name = request.getParameter("en");		//name为空表示添加，否则为编辑
			if(enName!=null){
				response.setContentType("text/html;charset=UTF-8");
				out = response.getWriter();
				//如果没有修改username
				if(enName.equals(name)){
					out.print(true);	//true表示可用
				}else{
					Category ca = categoryService.loadCategoryByName(enName);
					if(ca!=null){
						out.print(false);
					}else{
						out.print(true);	//true表示可用，用户名不存在
					}
				}
				out.flush();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(out!=null){
				out.close();
			}
		}
	}
	
	public String del(){
		if(model.getId()!=null){
			model = categoryService.loadCategoryById(model.getId());
			if(categoryService.checkHasChildren(model)){
				MsgUtil.setMsg("error", "请先删除该分类下的子分类");
			}else{
				if(categoryService.checkHasProduct(model)){
					MsgUtil.setMsg("error", "请先删除该分类下的商品");
				}else{
					categoryService.delCategory(model.getId());
					MsgUtil.setMsg("success", "删除分类成功！");
					//日志记录
					LogUtil.getInstance().log(LogType.DEL, model.getEnName()+"删除了");
				}
			}
		}
		return "toList";
	}
	
	public void getCCate(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String pid = request.getParameter("pid");
		HttpServletResponse res = ServletActionContext.getResponse();
		PrintWriter writer = null;
		try {
			if(pid!=null){
				List<Object[]> childCates = categoryService.getChildrenCategory(Integer.parseInt(pid));
				Gson gson = new Gson();
				writer = res.getWriter();
				writer.write(gson.toJson(childCates));
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(writer!=null){
				writer.close();
			}
		}
	}

	public PageRainier<Category> getPage() {
		return page;
	}

	public void setPage(PageRainier<Category> page) {
		this.page = page;
	}

	public Integer getPageNo() {
		return pageNo;
	}

	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	@Override
	public Category getModel() {
		return model;
	}
}
