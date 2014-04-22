package com.brightengold.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import cn.rainier.nian.model.User;
import com.brightengold.service.MsgUtil;
import com.brightengold.util.HTMLGenerator;
import com.opensymphony.xwork2.ActionSupport;

@Controller
@Scope("prototype")
@Secured("ROLE_SUPER")
public class GennerateController extends ActionSupport{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7877633844080802220L;
	
	@Secured("ROLE_SUPER")
	public String gennerateIndex(){
		HttpServletRequest request = ServletActionContext.getRequest();
		User loginUser = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/sys/gennerate_toHome.do";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath("/"),loginUser)){
			MsgUtil.setMsg("succss", "恭喜您，生成Index页面成功！");
		}else{
			MsgUtil.setMsg("error", "对不起，生成Index页面失败！");
		}
		return "html";
	}
	
	//生成home的静态页面
	public String toHome(){
		return "index";
	}
	
	@Secured("ROLE_SUPER")
	public String gennerateAboutUs(){
		HttpServletRequest request = ServletActionContext.getRequest();
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/sys/gennerate_toAboutUs.do";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath("/"),loginUser)){
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
	public String gennerateContactUs(){
		HttpServletRequest request = ServletActionContext.getRequest();
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/sys/gennerate_toContactUs.do";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath("/"),loginUser)){
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
	public String gennerateNews(){
		HttpServletRequest request = ServletActionContext.getRequest();
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/sys/gennerate_toNews.do";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath("/"),loginUser)){
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
	public String gennerateFeedback(){
		HttpServletRequest request = ServletActionContext.getRequest();
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/sys/gennerate_toFeedback.do";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath("/"),loginUser)){
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
	public String gennerateProducts(){
		HttpServletRequest request = ServletActionContext.getRequest();
		User loginUser = ((User)SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String url=basePath+"/sys/gennerate_toProduct.do";
		HTMLGenerator htmlGenerator = new HTMLGenerator(basePath);
		if(htmlGenerator.createHtmlPage(url,request.getSession().getServletContext().getRealPath("/"),loginUser)){
			MsgUtil.setMsg("succss", "恭喜您，生成Product页面成功！");
		}else{
			MsgUtil.setMsg("error", "对不起，生成Product页面失败！");
		}
		return "html";
	}
	
	public String toProduct(){
		return "product";
	}
	
}
