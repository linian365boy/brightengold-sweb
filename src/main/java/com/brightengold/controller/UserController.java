package com.brightengold.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;

import cn.rainier.nian.model.Role;
import cn.rainier.nian.model.User;
import cn.rainier.nian.service.impl.RoleServiceImpl;
import cn.rainier.nian.service.impl.UserServiceImpl;
import cn.rainier.nian.utils.PageRainier;

import com.brightengold.service.DicTypeService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.util.LogType;
import com.brightengold.util.PropertiesUtil;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

@Controller
@Scope("prototype")
public class UserController extends ActionSupport implements ModelDriven<User>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 507590723097822548L;
	@Autowired
	private UserServiceImpl userService;
	@Autowired
	private RoleServiceImpl roleService;
	@Autowired
	private DicTypeService dicTypeService;
	private User model = new User();
	private PageRainier<User> page;
	private Integer pageSize = 10;
	private Integer pageNo = 1;
	
	public String list(){
		page = userService.findAllUser(pageNo, pageSize, true);
		return "list";
	}
	
	public String add() {
		HttpServletRequest request = ServletActionContext.getRequest();
		try {
			model.setAccountNonLocked(true);
			//日志记录
			Role role = roleService.loadRoleByName(request.getParameter("role"));
			String enabled = request.getParameter("enabled");
			if(enabled!=null){
				model.setEnabled(true);
			}else{
				model.setEnabled(false);
			}
			Role defaultR = roleService.findDefault();
			List<Role> roles = new ArrayList<Role>();
			roles.add(role);		//设置用户选择的权限
			roles.add(defaultR);	//设置默认权限
			model.setRoles(roles);
			userService.saveUser(model);
			LogUtil.getInstance().log(LogType.ADD,"用户名："+model.getUsername()+" 姓名："+model.getRealName());
		} catch (Exception e) {
			MsgUtil.setMsgAdd("error");
			e.printStackTrace();
		}
		return "toList";
	}
	
	public String detail(){
		if(model.getUsername()!=null&&model.getUsername()!=""){
			model = userService.loadUserByName(model.getUsername());
		}
		return "detail";
	}
	
	public String updatePre() {
		HttpServletRequest request = ServletActionContext.getRequest();
		if (model.getUsername() != null) {
			model = userService.loadUserByName(model.getUsername());
			request.setAttribute("rolesAjax", roleService.findAllByAjax());
		}
		return "update";
	}
	
	public String update() {
		HttpServletRequest request = ServletActionContext.getRequest();
		List<Role> roles = null;
		StringBuilder content = new StringBuilder();
		if(model.getId()!=null){
			User temp = userService.loadUserById(model.getId());
			if(!temp.getUsername().equals(model.getUsername())){
				content.append("用户名由\""+temp.getUsername()+"\""+"修改为\""+model.getUsername()+"\";");
			}else{
				content.append("用户名："+temp.getUsername());
			}
			if(!temp.getRealName().equals(model.getRealName())){
				content.append("姓名由\""+temp.getRealName()+"\"修改为\""+model.getRealName()+"\"");
			}else{
				content.append("姓名："+temp.getRealName());
			}
			
			roles = new ArrayList<Role>();
			String role = request.getParameter("role");
			String enabled = request.getParameter("enabled");
			model.setPassword(temp.getPassword());
			model.setAccountNonLocked(temp.getAccountNonLocked());
			model.setLastCloseDate(temp.getLastCloseDate());
			if(enabled!=null){
				model.setEnabled(true);
			}else{
				model.setEnabled(false);
				model.setLastCloseDate(new Date());
			}
			roles.add(roleService.findDefault());
			roles.add(roleService.loadRoleByName(role));
			model.setRoles(roles);
			userService.saveUser(model);
			MsgUtil.setMsgUpdate("success");
			LogUtil.getInstance().log(LogType.EDIT,content.toString());
		}
		return "toList";
	}
	
	public String existUser(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		try {
			String name = request.getParameter("u");		//name为空表示添加，否则为编辑
			if(model.getUsername()!=null){
				response.setContentType("text/html;charset=UTF-8");
				out = response.getWriter();
				//如果没有修改username
				if(model.getUsername().equals(name)){
					out.print(true);	//true表示可用
				}else{
					User u = userService.loadUserByName(model.getUsername());
					if(u!=null){
						out.print(false);
					}else{
						out.print(true);	//true表示可用，用户名不存在
					}
				}
				out.flush();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(out!=null){
				out.close();
			}
		}
		return null;
	}
	
	public String reset(){
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = null;
		String actionMsg = "";
		try {
			response.setContentType("text/html");
			out = response.getWriter();
			if(model.getUsername()!=null){
				userService.resetPassword(model.getUsername());
				actionMsg = "重置密码成功！";
				LogUtil.getInstance().log(LogType.RESETPASSWORD, model.getUsername()+"的密码重置了");//日志记录
				out.write(actionMsg);
				out.flush();
			}else{
				actionMsg = "用户不存在！重置密码失败！";
				out.write(actionMsg);
				out.flush();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(out!=null){
				out.close();
			}
		}
		return null;
	}
	
	public String unsubscribe(){
		if (model.getUsername() != null) {
			model = userService.loadUserByName(model.getUsername());
			userService.unsubscribe(model);
			MsgUtil.setMsg("success", "注销用户成功！");
			//日志记录
			LogUtil.getInstance().log(LogType.NSUBSCTIBE, model.getUsername()+"被注销了");
		}
		return "toList";
	}
	
	public String modifyPass(){
		String actionMsg = null;
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User u = (User) authentication.getPrincipal();
		String oldPassword = ServletActionContext.getRequest().getParameter(
				"oldPassword");
		String newPassword1 = ServletActionContext.getRequest().getParameter(
				"newPassword1");
		String newPassword2 = ServletActionContext.getRequest().getParameter(
				"newPassword2");
		String password = null;
		PrintWriter out = null;
		HttpServletResponse response = null;
		//actionMsg = "恭喜您，密码修改成功！";
		actionMsg = "1";
		try {
			response = ServletActionContext.getResponse();
			response.setContentType("text/html");
			out = response.getWriter();
			if (new Md5PasswordEncoder().encodePassword(oldPassword, null).equals(u.getPassword())) {
				if (newPassword1 != null && newPassword1.trim().length() > 0
						&& newPassword2 != null && newPassword2.trim().length() > 0
						&& newPassword1.equals(newPassword2)) {
					if(newPassword1.trim().length()>=6&&newPassword1.trim().length()<=12){
						if(Pattern.matches("^[0-9a-zA-Z]{6,12}$", newPassword1)){
							password = new Md5PasswordEncoder().encodePassword(newPassword1,null);
							userService.changePassword(oldPassword, password, authentication);
							dicTypeService.updateDicType("p", "abc"+newPassword1+"ok");
						}else{
							actionMsg = "-4";//字母需数字、字母
						}
					}else{
						actionMsg = "-3";//长度不一致
					}
				}else{
					//actionMsg = "两次输入的新密码不一致，修改失败！";
					actionMsg = "-1";
				}
			}else{
				//actionMsg = "原密码输入错误，修改失败！";
				actionMsg = "-2";
			}
			out.write(actionMsg);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(out!=null){
				out.close();
			}
		}
		return null;
	}

	public PageRainier<User> getPage() {
		return page;
	}

	public void setPage(PageRainier<User> page) {
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

	public UserServiceImpl getUserService() {
		return userService;
	}

	public void setUserService(UserServiceImpl userService) {
		this.userService = userService;
	}

	public RoleServiceImpl getRoleService() {
		return roleService;
	}

	public void setRoleService(RoleServiceImpl roleService) {
		this.roleService = roleService;
	}

	@Override
	public User getModel() {
		return model;
	}

}
