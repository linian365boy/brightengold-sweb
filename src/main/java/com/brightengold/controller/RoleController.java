package com.brightengold.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import cn.rainier.nian.model.Menu;
import cn.rainier.nian.model.Resource;
import cn.rainier.nian.model.ResourceDetailsMonitor;
import cn.rainier.nian.model.Role;
import cn.rainier.nian.model.User;
import cn.rainier.nian.service.impl.MenuServiceImpl;
import cn.rainier.nian.service.impl.ResourceServiceImpl;
import cn.rainier.nian.service.impl.RoleServiceImpl;
import cn.rainier.nian.utils.PageRainier;
import cn.rainier.nian.utils.UUIDGenerator;

import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.util.LogType;
import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

@Controller
@Scope("prototype")
public class RoleController extends ActionSupport implements ModelDriven<Role>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5168107597551332062L;
	@Autowired
	private RoleServiceImpl roleService;
	private PageRainier<Role> page;
	private Integer pageSize = 10;
	@Autowired
	private ResourceServiceImpl resourceService;
	@Autowired
	private ResourceDetailsMonitor resourceDetailsMonitor;
	@Autowired
	private MenuServiceImpl menuService;
	private Role model = new Role();
	private Integer pageNo = 1;
	private String name;
	
	/**
	 * @FunName: getRolesByAjax
	 * @Description:  通过ajax请求获得角色标识与描述
	 * @return
	 * @Author: 李年
	 */
	public void getRolesByAjax(){
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			List<Object[]> rolesByAjax = roleService.findAllByAjax();
			Gson gson = new Gson();
			writer.write(gson.toJson(rolesByAjax));
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(writer!=null){
				writer.close();
			}
		}
	}
	
	public String list(){
		page = roleService.findAll(pageNo, pageSize, true);
		return "list";
	}
	
	public String add() {
		try {
			String marking = UUIDGenerator.getUUID().toUpperCase();
			model.setName("ROLE_"+marking);
			model.setCreateDate(new Date());
			roleService.saveRole(model);
			MsgUtil.setMsgAdd("success");
			LogUtil.getInstance().log(LogType.ADD,"角色："+model.getDesc());
		} catch (Exception e) {
			MsgUtil.setMsgAdd("error");
			e.printStackTrace();
		}
		return "toList";
	}
	
	public String updatePre() {
		if (model.getName() != null) {
			model=roleService.loadRoleByName(model.getName());
		}
		return "update";
	}
	
	public String update() {
		if(model.getName()!=null){
			Role temp = roleService.loadRoleByName(model.getName());
			String ryName = temp.getDesc();
			temp.setDesc(model.getDesc());
			roleService.saveRole(temp);
			MsgUtil.setMsgUpdate("success");
			LogUtil.getInstance().log(LogType.EDIT,"角色由\""+ryName+"\"修改为：\""+temp.getDesc()+"\"");
		}
		return "toList";
	}
	
	public String del(){
		if(model.getName()!=null){
			Role role = roleService.loadRoleByName(model.getName());
			for(User u : role.getUsers()){
				u.getRoles().remove(role);
			}
			roleService.delRole(role);
			MsgUtil.setMsgDelete("success");
			LogUtil.getInstance().log(LogType.DEL,"角色名为："+role.getDesc());
		}
		return "toList";
	}
	
	public String distribute(){
		HttpServletRequest request = ServletActionContext.getRequest();
		try {
			if(model.getName()!=null){
				//此处strIds既包括menuId也包括resourceId
				String strIds = request.getParameter("str");
				String[] strIdArr = null;
				model = roleService.loadRoleByName(model.getName());
				if(strIds!=null&&strIds.trim()!=""){
					strIdArr = strIds.split(",");
					List<Resource> ress = new ArrayList<Resource>();
					List<Menu> menus = new ArrayList<Menu>();
					List<Resource> resources = null;
					Resource res = null;
					Menu menu = null;
					for(String str : strIdArr){
						if(str.startsWith("r_")){
							res = resourceService.loadResourceByResource(Long.parseLong(str.substring(2)));
							ress.add(res);
						}else{
							menu = menuService.loadMenuById(Long.parseLong(str));
							resources = resourceService.findResourceByParentId(menu.getId());
							if(menu.getParentMenu()!=null&&resources!=null&&resources.size()==0){
								ress.addAll(resourceService.findAllResourceByParentId(menu.getId()));
							}
							menus.add(menu);
						}
					}
					model.setResources(ress);
					model.setMenus(menus);
				}else{
					if(strIds!=null){
						model.setResources(null);
						model.setMenus(null);
					}
				}
				roleService.saveRole(model);
				MsgUtil.setMsg("success", "成功分配【"+model.getDesc()+"】权限！");
				LogUtil.getInstance().log(LogType.DISTRIBUTE, "重新分配了"+model.getDesc()+"的权限");
				try {
					resourceDetailsMonitor.afterPropertiesSet();
					request.getSession().removeAttribute("menuXml");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}else{
				MsgUtil.setMsg("error", "分配权限失败！");
			}
		} catch (NumberFormatException e) {
			MsgUtil.setMsg("error", "分配权限失败！");
		}
		return "toList";
	}
	
	public void exportToCSV(){
		HttpServletResponse response = ServletActionContext.getResponse();
		try {
			List<Role> roles = roleService.findAll(null, null,false).getResult();
			roles.remove(roleService.findDefault());
			String fileName = "角色信息"+new Date().getTime()+".csv";
			fileName = new String(fileName.getBytes("gbk"),"iso8859-1");
			response.setContentType("application/csv;charset=gbk");
			response.setHeader("Content-Disposition","attachment; filename="+fileName);
			//注意：先权限jar包里的（按属性顺序下来的），再扩展的属性
			String[] headers = {"角色","权限"};
			roleService.exportToCSVExNoDisplay(roles,fileName,headers,response);
			LogUtil.getInstance().log(LogType.EXPORT,"导出角色表："+fileName);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public RoleServiceImpl getRoleService() {
		return roleService;
	}

	public void setRoleService(RoleServiceImpl roleService) {
		this.roleService = roleService;
	}

	public PageRainier<Role> getPage() {
		return page;
	}

	public void setPage(PageRainier<Role> page) {
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
	public Role getModel() {
		return model;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
