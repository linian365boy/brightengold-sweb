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
	private String key;
	/**
	 * value值
	 */
	private String value;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	@Id
	@GeneratedValue
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
}
