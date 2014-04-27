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
import com.brightengold.model.Product;
import com.brightengold.service.CategoryService;
import com.brightengold.service.CompanyService;
import com.brightengold.service.MsgUtil;
import com.brightengold.service.ProductService;
import com.brightengold.util.HTMLGenerator;
import com.opensymphony.xwork2.ActionSupport;

@Controller
@Scope("prototype")
@Secured("ROLE_SUPER")
public class GennerateController extends ActionSupport{
	@Autowired
	private CompanyService companyService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private ProductService productService;
	private PageRainier<Product> hotPage;
	private PageRainier<Product> lastPage;
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7877633844080802220L;
	
	@Secured("ROLE_SUPER")
	public String index(){
		HttpServletRequest request = ServletActionContext.getRequest();
		User loginUser = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/admin/sys/gennerate_toHome.do";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath("index.html"),loginUser.getUsername())){
			MsgUtil.setMsg("succss", "恭喜您，生成Index页面成功！");
		}else{
			MsgUtil.setMsg("error", "对不起，生成Index页面失败！");
		}
		return "html";
	}
	
	//生成home的静态页面
	public String toHome(){
		Company company = companyService.loadCompany();
		List<Category> parentCats = categoryService.findParentCategory();
		HttpServletRequest request = ServletActionContext.getRequest();
		hotPage = productService.findHotProducts(true, null, null);
		lastPage = productService.findLastestProducts(true, null, null);
		request.setAttribute("company", company);
		request.setAttribute("parentCats", parentCats);
		return "index";
	}
	
	@Secured("ROLE_SUPER")
	public String aboutUs(){
		HttpServletRequest request = ServletActionContext.getRequest();
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/admin/sys/gennerate_toAboutUs.do";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath("/"),loginUser.getUsername())){
			MsgUtil.setMsg("succss", "恭喜您，生成About Us页面成功！");
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
	public String contactUs(){
		HttpServletRequest request = ServletActionContext.getRequest();
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/admin/sys/gennerate_toContactUs.do";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath("/"),loginUser.getUsername())){
			MsgUtil.setMsg("succss", "恭喜您，生成Contact Us页面成功！");
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
	public String news(){
		HttpServletRequest request = ServletActionContext.getRequest();
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/admin/sys/gennerate_toNews.do";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath("/"),loginUser.getUsername())){
			MsgUtil.setMsg("succss", "恭喜您，生成News页面成功！");
		}else{
			MsgUtil.setMsg("error", "对不起，生成News页面失败！");
		}
		return "html";
	}
	
	//生成news的静态页面
	public String toNews(){
		return "news";
	}
	
	
	@Secured("ROLE_SUPER")
	public String feedback(){
		HttpServletRequest request = ServletActionContext.getRequest();
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/admin/sys/gennerate_toFeedback.do";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath("/"),loginUser.getUsername())){
			MsgUtil.setMsg("succss", "恭喜您，生成Feedback页面成功！");
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
	public String products(){
		HttpServletRequest request = ServletActionContext.getRequest();
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/admin/sys/gennerate_toProduct.do";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath("/"),loginUser.getUsername())){
			MsgUtil.setMsg("succss", "恭喜您，生成Product页面成功！");
		}else{
			MsgUtil.setMsg("error", "对不起，生成Product页面失败！");
		}
		return "html";
	}
	
	public String toProduct(){
		return "product";
	}

	public PageRainier<Product> getHotPage() {
		return hotPage;
	}

	public void setHotPage(PageRainier<Product> hotPage) {
		this.hotPage = hotPage;
	}

	public PageRainier<Product> getLastPage() {
		return lastPage;
	}

	public void setLastPage(PageRainier<Product> lastPage) {
		this.lastPage = lastPage;
	}
}
