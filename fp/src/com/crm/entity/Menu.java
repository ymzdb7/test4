package com.crm.entity;

/*
 * 左侧菜单(menu_mng)对应的实体类 
 */
public class Menu {

	private Integer mid;
	private String mname;
	private String murl;
	private Integer parentid;
	
	public Integer getParentid() {
		return parentid;
	}
	public void setParentid(Integer parentid) {
		this.parentid = parentid;
	}
	public Integer getMid() {
		return mid;
	}
	public void setMid(Integer mid) {
		this.mid = mid;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getMurl() {
		return murl;
	}
	public void setMurl(String murl) {
		this.murl = murl;
	}
}
