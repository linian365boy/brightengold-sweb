package com.brightengold.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table
public class Company implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	/**
	 * 公司名称
	 */
	private String name;
	/**
	 * 公司联系方式
	 */
	private String telPhone;
	/**
	 * 公司手机联系方式
	 */
	private String mobile;
	/**
	 * 传真
	 */
	private String fax;
	/**
	 * 公司联系人
	 */
	private String person;
	/**
	 * 公司地址
	 */
	private String address;
	/**
	 * 工厂地址
	 */
	private String facAddress;
	/**
	 * 公司邮箱
	 */
	private String email;
	/**
	 * 公司简介
	 */
	private String introduce;
	/**
	 * 公司logo标志
	 */
	private String logo;
	/**
	 * 热线图片标志
	 */
	private String phonePic;
	/**
	 * 公司口号
	 */
	private String slogan;
	/**
	 * 公司网站
	 */
	private String website;
	/**
	 * 公司创建日期
	 */
	private Date createDate;
	/**
	 * 备用字段
	 */
	private String temp1;
	private String temp2;
	@Id
	@GeneratedValue
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@Column(length=100)
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Column(length=20)
	public String getTelPhone() {
		return telPhone;
	}
	public void setTelPhone(String telPhone) {
		this.telPhone = telPhone;
	}
	@Column(length=300)
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	@Column(length=50)
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	@Column(length=255)
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	@Column(length=255)
	public String getSlogan() {
		return slogan;
	}
	public void setSlogan(String slogan) {
		this.slogan = slogan;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public String getTemp1() {
		return temp1;
	}
	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}
	public String getTemp2() {
		return temp2;
	}
	public void setTemp2(String temp2) {
		this.temp2 = temp2;
	}
	@Temporal(TemporalType.DATE)
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getPhonePic() {
		return phonePic;
	}
	public void setPhonePic(String phonePic) {
		this.phonePic = phonePic;
	}
	public String getPerson() {
		return person;
	}
	public void setPerson(String person) {
		this.person = person;
	}
	@Column(length=20)
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	@Column(length=300)
	public String getFacAddress() {
		return facAddress;
	}
	public void setFacAddress(String facAddress) {
		this.facAddress = facAddress;
	}
	
}
