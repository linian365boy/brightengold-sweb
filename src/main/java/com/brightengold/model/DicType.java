package com.brightengold.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table
public class DicType implements Serializable{
	/**   
	* @Fields serialVersionUID : 序列化    
	*/   
	private static final long serialVersionUID = -630505926441005729L;
	/**
	 * id编号
	 */
	private Integer id;
	/**
	 * key值
	 */
	private String tkey;
	/**
	 * value值
	 */
	private String tvalue;
	
	public DicType(){
	}
	
	public DicType(String key, String value) {
		this.tkey = key;
		this.tvalue = value;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@Id
	public String getTkey() {
		return tkey;
	}
	public void setTkey(String tkey) {
		this.tkey = tkey;
	}
	public String getTvalue() {
		return tvalue;
	}
	public void setTvalue(String tvalue) {
		this.tvalue = tvalue;
	}
}
