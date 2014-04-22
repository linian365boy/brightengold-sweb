package com.brightengold.controller;

import java.io.File;
import java.io.FileInputStream;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import com.brightengold.model.Company;
import com.brightengold.service.CompanyService;
import com.brightengold.service.LogUtil;
import com.brightengold.service.MsgUtil;
import com.brightengold.util.LogType;
import com.brightengold.util.Tools;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

@Controller
@Scope("prototype")
public class CompanyController extends ActionSupport implements ModelDriven<Company>{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7594208869181287086L;
	@Autowired
	private CompanyService companyService;
	private Company model = new Company();
	private File phone;
	private String phoneFileName;
	private String phoneContentType;
	
	private File logo;
	private String logoFileName;
	private String logoContentType;
	
	public String detail() {
		model = companyService.loadCompany();
		return "detail";
	}
	
	public String update(){
		Company temp = companyService.loadCompany();
		HttpServletRequest request = ServletActionContext.getRequest();
		try{
			if(logo!=null){
				String realPath = request.getSession().getServletContext().getRealPath("/resources/upload/company");
				String newFileName = realPath+"/"+Tools.getRndFilename()+Tools.getExtname(getLogoFileName());
				FileUtils.copyInputStreamToFile(new FileInputStream(getLogo()), new File(newFileName));
				String url = newFileName.substring(realPath.lastIndexOf("upload"));
				model.setLogo(url.replace("\\", "/"));
			}else{
				model.setLogo(temp.getLogo());
			}
			if(phone!=null){
				String realPath = request.getSession().getServletContext().getRealPath("/resources/upload/company");
				String newFileName = realPath+"/"+Tools.getRndFilename()+Tools.getExtname(getPhoneFileName());
				FileUtils.copyInputStreamToFile(new FileInputStream(getPhone()), new File(newFileName));
				String url = newFileName.substring(realPath.lastIndexOf("upload"));
				model.setPhonePic(url.replace("\\", "/"));
			}else{
				model.setPhonePic(temp.getPhonePic());
			}
			model.setCreateDate(temp.getCreateDate());
			model = companyService.save(model);
			StringBuilder content = new StringBuilder();
			if(!temp.getName().equals(model.getName())){
				content.append("公司名称由\""+temp.getName()+"\"修改为\""+model.getName()+"\"");
			}
			if(!temp.getLogo().equals(model.getLogo())){
				content.append("公司logo由\""+temp.getLogo()+"\"修改为\""+model.getLogo()+"\"");
			}
			if(!temp.getEmail().equals(model.getEmail())){
				content.append("公司邮箱由\""+temp.getEmail()+"\"修改为\""+model.getEmail()+"\"");
			}
			if(!temp.getTelPhone().equals(model.getTelPhone())){
				content.append("公司联系方式由\""+temp.getTelPhone()+"\"修改为\""+model.getTelPhone()+"\"");
			}
			MsgUtil.setMsgUpdate("success");
			LogUtil.getInstance().log(LogType.EDIT, content.toString());
		}catch(Exception e){
			e.printStackTrace();
		}
		return "toDetail";
	}

	@Override
	public Company getModel() {
		return model;
	}

	public File getPhone() {
		return phone;
	}

	public void setPhone(File phone) {
		this.phone = phone;
	}

	public String getPhoneFileName() {
		return phoneFileName;
	}

	public void setPhoneFileName(String phoneFileName) {
		this.phoneFileName = phoneFileName;
	}

	public String getPhoneContentType() {
		return phoneContentType;
	}

	public void setPhoneContentType(String phoneContentType) {
		this.phoneContentType = phoneContentType;
	}

	public File getLogo() {
		return logo;
	}

	public void setLogo(File logo) {
		this.logo = logo;
	}

	public String getLogoFileName() {
		return logoFileName;
	}

	public void setLogoFileName(String logoFileName) {
		this.logoFileName = logoFileName;
	}

	public String getLogoContentType() {
		return logoContentType;
	}

	public void setLogoContentType(String logoContentType) {
		this.logoContentType = logoContentType;
	}
	
}
