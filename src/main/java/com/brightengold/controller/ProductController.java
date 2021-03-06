package com.brightengold.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;

import cn.rainier.nian.model.User;
import cn.rainier.nian.utils.PageRainier;

import com.brightengold.model.Category;
import com.brightengold.model.Company;
import com.brightengold.model.Product;
import com.brightengold.service.CategoryService;
import com.brightengold.service.CompanyService;
import com.brightengold.service.DicTypeService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.service.ProductService;
import com.brightengold.util.DESPlus;
import com.brightengold.util.HTMLGenerator;
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
	private Integer pageSize = 8;
	private Integer pageNo = 1;
	private Product model = new Product();
	private File photo;
	private String photoContentType;
	private String photoFileName;
	@Autowired
	private CompanyService companyService;
	@Autowired
	private DicTypeService dicTypeService;
	
	private Integer prSize = 9;
	
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
				String categoryId = request.getParameter("childC");
				String hot = request.getParameter("hot");
				if(hot!=null){
					model.setHot(true);
				}else{
					model.setHot(false);
				}
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
				model.setUrl(tempProduct.getUrl());
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
			String categoryId = request.getParameter("childC");
			String hot = request.getParameter("hot");
			if(hot!=null){
				model.setHot(true);
			}else{
				model.setHot(false);
			}
			model.setCategory(categoryService.loadCategoryById(Integer.parseInt(categoryId)));
			String realPath = request.getSession().getServletContext().getRealPath("/resources/upload/products");
			String newFileName = realPath+"/"+Tools.getRndFilename()+Tools.getExtname(getPhotoFileName());
			FileUtils.copyInputStreamToFile(new FileInputStream(getPhoto()), new File(newFileName));
			String url = newFileName.substring(realPath.lastIndexOf("upload"));
			model.setPicUrl(url.replace("\\", "/"));
			model.setPublish(false);
			model.setUrl("views/html/product/"+Tools.getRndFilename()+".html");
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
		HttpServletRequest request = ServletActionContext.getRequest();
		if(model.getId()!=null){
			StringBuilder sb = new StringBuilder();
			model = productService.loadProductById(model.getId());
			String url = model.getUrl();
			String picUrl = model.getPicUrl();
			String path = null;
			if(url!=null){
				path = request.getSession().getServletContext().getRealPath("/"+url);
				Tools.delFile(path);
			}
			if(picUrl!=null){
				path = request.getSession().getServletContext().getRealPath("/resources/"+picUrl);
				Tools.delFile(path);
			}
			productService.delProduct(model);
			sb.append("名称："+model.getEnName());
			MsgUtil.setMsgDelete("success");
			LogUtil.getInstance().log(LogType.DEL, sb.toString());
		}
		return "toList";
	}
	
	public String detail(){
		if(model.getId()!=null){
			HttpServletRequest request = ServletActionContext.getRequest();
			model = productService.loadProductById(model.getId());
			Company company = companyService.loadCompany();
			List<Category> parentCats = categoryService.findParentCategory();
			request.setAttribute("company", company);
			request.setAttribute("parentCats", parentCats);
			return "detail";
		}
		MsgUtil.setMsg(ERROR, "对不起，商品不存在！");
		return "toList";
	}
	
	public void checkPub(){
		PrintWriter writer = null;
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setContentType("text/html; charset=UTF-8");
			writer = response.getWriter();
			if(model.getId()!=null){
				model = productService.loadProductById(model.getId());
				if(model.isPublish()){
					writer.write("1");	//已发布
				}else{
					writer.write("-1");
				}
			}else{
				writer.write("0");	//不存在商品
			}
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(writer!=null){
				writer.close();
			}
		}
	}
	
	public String publish() throws Exception{
		if(model.getId()!=null){
			Product temp = productService.loadProductById(model.getId());
			HttpServletRequest request = ServletActionContext.getRequest();
			User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
			String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();				
			String url=basePath+"/admin/goods/product_detail.do?id="+model.getId();
			HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
			String value = dicTypeService.getDicType("p"+loginUser.getId()).getTvalue();
			value = new DESPlus().decrypt(value);
			if(htmlGenerator.createHtmlPage(url,
					request.getSession().getServletContext().getRealPath(temp.getUrl()),
					loginUser.getUsername(),
					value.substring(value.indexOf("abc")+3, value.lastIndexOf("ok")))){
				temp.setPublish(true);
			}else{
				temp.setPublish(false);
			}
			productService.saveProduct(temp);
			MsgUtil.setMsg("success", "\""+temp.getEnName()+"\"产品发布成功！");
			LogUtil.getInstance().log(LogType.PUBLISH, temp.getEnName()+"产品发布");
		}else{
			MsgUtil.setMsg("error", "产品已发布！");
		}
		return "toList";
	}
	
	
	public String getProductByCateId(){
		String cateId = ServletActionContext.getRequest().getParameter("cateid");
		Company company = companyService.loadCompany();
		List<Category> parentCats = categoryService.findParentCategory();
		if(cateId!=null&&cateId.trim().length()>0){
			Category category = categoryService.loadCategoryById(Integer.parseInt(cateId));
			page = productService.findProductByCategory(category.getId(),pageNo,prSize);
			ServletActionContext.getRequest().setAttribute("cate", category);
		}else{
			page = productService.findHotProducts(false, pageNo, 9);
		}
		ServletActionContext.getRequest().setAttribute("cateId", cateId);
		ServletActionContext.getRequest().setAttribute("company", company);
		ServletActionContext.getRequest().setAttribute("parentCats", parentCats);
		return SUCCESS;
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

	public Integer getPrSize() {
		return prSize;
	}

	public void setPrSize(Integer prSize) {
		this.prSize = prSize;
	}

}
