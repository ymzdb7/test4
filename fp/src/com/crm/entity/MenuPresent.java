package com.crm.entity;

public class MenuPresent {
	
	private Integer id;
	private String text;
	private Boolean checked; // true or false
	private String state; //"" or "closed"
	private Object children; //[]
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public Boolean getChecked() {
		return checked;
	}
	public void setChecked(Boolean checked) {
		this.checked = checked;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public Object getChildren() {
		return children;
	}
	public void setChildren(Object children) {
		this.children = children;
	}
}
