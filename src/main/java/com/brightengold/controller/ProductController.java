package com.brightengold.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import cn.rainier.nian.model.User;
import cn.rainier.nian.utils.PageRainier;
import com.brightengold.model.Product;
import com.brightengold.service.CategoryService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.service.ProductService;
import com.brightengold.util.LogType;
import com.brightengold.util.Tools;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

@Controller
@Scope("prototype")
public class ProductController extends ActionSupport implements ModelDriven<Product>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Autowired
	private ProductService productService;
	@Autowired
	private CategoryService categoryService;
	private PageRainier<Product> page;
	private Integer pageSize = 10;
	private Integer pageNo = 1;
	private Product model = new Product();
	private File photo;
	private String photoContentType;
	private String photoFileName;
	
	public String list(){
		page = productService.findAll(pageNo, pageSize);
		return "list";
	}
	
	public String updatePre() {
		if (model.getId() != null) {
			model = productService.loadProductById(model.getId());
			ServletActionContext.getRequest().setAttribute("parents", categoryService.findParentByAjax());
		}
		return "update";
	}
	
	public String update() {
		HttpServletRequest request = ServletActionContext.getRequest();
		StringBuilder content = new StringBuilder();
		try {
			if(model.getId()!=null){
				Product tempProduct = productService.loadProductById(model.getId());
				String categoryId = request.getParameter("parents");
				if(photo!=null){
					String realPath = request.getSession().getServletContext().getRealPath("/resources/upload/products");
					String newFileName = realPath+"/"+Tools.getRndFilename()+Tools.getExtname(getPhotoFileName());
					FileUtils.copyInputStreamToFile(new FileInputStream(getPhoto()), new File(newFileName));
					String url = newFileName.substring(realPath.lastIndexOf("upload"));
					model.setPicUrl(url.replace("\\", "/"));
				}else{
					model.setPicUrl(tempProduct.getPicUrl());
				}
				content.append("产品名称："+model.getEnName());
				model.setCategory(categoryService.loadCategoryById(Integer.parseInt(categoryId)));
				model.setCreateDate(tempProduct.getCreateDate());
				model.setCreateUser(tempProduct.getCreateUser());
				productService.saveProduct(model);
				MsgUtil.setMsgUpdate("success");
				LogUtil.getInstance().log(LogType.EDIT,content.toString());
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "toList";
	}
	
	public String add() {
		HttpServletRequest request = ServletActionContext.getRequest();
		User u = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		StringBuilder sb = new StringBuilder();
		try {
			String categoryId = request.getParameter("parentC");
			model.setCategory(categoryService.loadCategoryById(Integer.parseInt(categoryId)));
			String realPath = request.getSession().getServletContext().getRealPath("/resources/upload/products");
			String newFileName = realPath+"/"+Tools.getRndFilename()+Tools.getExtname(getPhotoFileName());
			FileUtils.copyInputStreamToFile(new FileInputStream(getPhoto()), new File(newFileName));
			String url = newFileName.substring(realPath.lastIndexOf("upload"));
			model.setPicUrl(url.replace("\\", "/"));
			model.setPublish(false);
			model.setCreateDate(new Date());
			model.setCreateUser(u);
			productService.saveProduct(model);
			MsgUtil.setMsgAdd("success");
			sb.append("名称："+model.getEnName());
			LogUtil.getInstance().log(LogType.ADD, sb.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "toList";
	}
	
	public String del(){
		if(model.getId()!=null){
			StringBuilder sb = new StringBuilder();
			model = productService.loadProductById(model.getId());
			productService.delProduct(model);
			sb.append("名称："+model.getEnName());
			MsgUtil.setMsgDelete("success");
			LogUtil.getInstance().log(LogType.DEL, sb.toString());
		}
		return "toList";
	}
	
	public String publish(){
		if(model.getId()!=null){
			Product temp = productService.loadProductById(model.getId());
			if(!checkPub(temp)){
				temp.setPublish(true);
				productService.saveProduct(temp);
				MsgUtil.setMsg("success", "产品发布成功！");
			}else{
				MsgUtil.setMsg("error", "产品已发布！");
			}
		}
		return "toList";
	}

	private boolean checkPub(Product product) {
		if(product.isPublish()){
			return true;
		}else{
			return false;
		}
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	@Override
	public Product getModel() {
		return model;
	}

	public PageRainier<Product> getPage() {
		return page;
	}

	public void setPage(PageRainier<Product> page) {
		this.page = page;
	}

	public Integer getPageNo() {
		return pageNo;
	}

	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}

	public File getPhoto() {
		return photo;
	}

	public void setPhoto(File photo) {
		this.photo = photo;
	}

	public String getPhotoContentType() {
		return photoContentType;
	}

	public void setPhotoContentType(String photoContentType) {
		this.photoContentType = photoContentType;
	}

	public String getPhotoFileName() {
		return photoFileName;
	}

	public void setPhotoFileName(String photoFileName) {
		this.photoFileName = photoFileName;
	}
}
