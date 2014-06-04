package com.brightengold.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;

import cn.rainier.nian.model.User;
import cn.rainier.nian.utils.PageRainier;

import com.brightengold.model.Category;
import com.brightengold.model.Company;
import com.brightengold.model.News;
import com.brightengold.model.Product;
import com.brightengold.service.CategoryService;
import com.brightengold.service.CompanyService;
import com.brightengold.service.DicTypeService;
import com.brightengold.service.MsgUtil;
import com.brightengold.service.NewsService;
import com.brightengold.service.ProductService;
import com.brightengold.util.DESPlus;
import com.brightengold.util.HTMLGenerator;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;

@Controller
@Scope("prototype")
@Secured("ROLE_SUPER")
public class GennerateController extends ActionSupport implements Preparable{
	@Autowired
	private CompanyService companyService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private ProductService productService;
	@Autowired
	private NewsService newsService;
	private Company company = null;
	private List<Category> parentCats = null;
	@Autowired
	private DicTypeService dicTypeService;
	/**
	 * 
	 */
	private static final long serialVersionUID = 7877633844080802220L;
	
	@Secured("ROLE_SUPER")
	public String index() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		User loginUser = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/admin/sys/gennerate_toHome.do";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		String value = dicTypeService.getDicType("p"+loginUser.getId()).getTvalue();
		value = new DESPlus().decrypt(value);
		if(htmlGenerator.createHtmlPage(url,
				request.getSession().getServletContext().getRealPath("index.html"),
				loginUser.getUsername()
				,value.substring(value.indexOf("abc")+3, value.lastIndexOf("ok")))){
			MsgUtil.setMsg(SUCCESS, "恭喜您，生成Index页面成功！");
		}else{
			MsgUtil.setMsg("error", "对不起，生成Index页面失败！");
		}
		return "html";
	}
	
	//生成home的静态页面
	public String toHome(){
		HttpServletRequest request = ServletActionContext.getRequest();
		PageRainier<Product> hotPage = productService.findHotProducts(true, null, null);
		PageRainier<Product> lastPage = productService.findLastestProducts(true, null, null);
		request.setAttribute("hotPage", hotPage);
		request.setAttribute("lastPage", lastPage);
		return "index";
	}
	
	@Secured("ROLE_SUPER")
	public String aboutUs() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/admin/sys/gennerate_toAboutUs.do";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		String value = dicTypeService.getDicType("p"+loginUser.getId()).getTvalue();
		value = new DESPlus().decrypt(value);
		if(htmlGenerator.createHtmlPage(url,
				request.getSession().getServletContext().getRealPath("about.html"),
				loginUser.getUsername(),
				value.substring(value.indexOf("abc")+3, value.lastIndexOf("ok")))){
			MsgUtil.setMsg(SUCCESS, "恭喜您，生成About Us页面成功！");
		}else{
			MsgUtil.setMsg("error", "对不起，生成About Us页面失败！");
		}
		return "html";
	}
	
	//生成关于我们的静态页面
	public String toAboutUs(){
		return "aboutUs";
	}
	
	@Secured("ROLE_SUPER")
	public String contactUs() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/admin/sys/gennerate_toContactUs.do";
		String value = dicTypeService.getDicType("p"+loginUser.getId()).getTvalue();
		value = new DESPlus().decrypt(value);
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,
				request.getSession().getServletContext().getRealPath("contact.html"),
				loginUser.getUsername(),
				value.substring(value.indexOf("abc")+3, value.lastIndexOf("ok")))){
			MsgUtil.setMsg(SUCCESS, "恭喜您，生成Contact Us页面成功！");
		}else{
			MsgUtil.setMsg("error", "对不起，生成Contact Us页面失败！");
		}
		return "html";
	}
	
	//生成联系我们的静态页面
	public String toContactUs(){
		return "contactUs";
	}
	
	@Secured("ROLE_SUPER")
	public String news() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/admin/sys/gennerate_toNews.do";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		String value = dicTypeService.getDicType("p"+loginUser.getId()).getTvalue();
		value = new DESPlus().decrypt(value);
		if(htmlGenerator.createHtmlPage(url,
				request.getSession().getServletContext().getRealPath("projects.html"),
				loginUser.getUsername(),
				value.substring(value.indexOf("abc")+3, value.lastIndexOf("ok")))){
			MsgUtil.setMsg(SUCCESS, "恭喜您，生成Projects页面成功！");
		}else{
			MsgUtil.setMsg("error", "对不起，生成Projects页面失败！");
		}
		return "html";
	}
	
	//生成news的静态页面
	public String toNews(){
		HttpServletRequest request = ServletActionContext.getRequest();
		PageRainier<News> newsPage = newsService.findAllPublish(1,15);
		request.setAttribute("page", newsPage);
		return "news";
	}
	
	
	@Secured("ROLE_SUPER")
	public String feedback() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/admin/sys/gennerate_toFeedback.do";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		String value = dicTypeService.getDicType("p"+loginUser.getId()).getTvalue();
		value = new DESPlus().decrypt(value);
		if(htmlGenerator.createHtmlPage(url,
				request.getSession().getServletContext().getRealPath("feedback.html"),
				loginUser.getUsername(),
				value.substring(value.indexOf("abc")+3, value.lastIndexOf("ok")))){
			MsgUtil.setMsg(SUCCESS, "恭喜您，生成Feedback页面成功！");
		}else{
			MsgUtil.setMsg("error", "对不起，生成Feedback页面失败！");
		}
		return "html";
	}
	
	//生成反馈的静态页面
	public String toFeedback(){
		return "feedback";
	}
	
	@Secured("ROLE_SUPER")
	public String products() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/admin/sys/gennerate_toProduct.do";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		String value = dicTypeService.getDicType("p"+loginUser.getId()).getTvalue();
		value = new DESPlus().decrypt(value);
		if(htmlGenerator.createHtmlPage(url,
				request.getSession().getServletContext().getRealPath("product.html"),
				loginUser.getUsername(),
				value.substring(value.indexOf("abc")+3, value.lastIndexOf("ok")))){
			MsgUtil.setMsg(SUCCESS, "恭喜您，生成Product页面成功！");
		}else{
			MsgUtil.setMsg("error", "对不起，生成Product页面失败！");
		}
		return "html";
	}
	
	public String toProduct(){
		PageRainier<Product> pages = productService.findHotProducts(false, 1, 9);
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("page", pages);
		return "product";
	}

	@Override
	public void prepare() throws Exception {
		company = companyService.loadCompany();
		parentCats = categoryService.findParentCategory();
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	public List<Category> getParentCats() {
		return parentCats;
	}

	public void setParentCats(List<Category> parentCats) {
		this.parentCats = parentCats;
	}
	
}
