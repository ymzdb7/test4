package com.crm.entity;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class AppInfo {
	private String version;
	private String version_desc;
	private String version_name;
	private String link; 
	private String forcedup; //0-不强制, 1-强制
	private Date add_time; 
	private Date update_time;
	
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getVersion_desc() {
		return version_desc;
	}
	public void setVersion_desc(String version_desc) {
		this.version_desc = version_desc;
	}
	public String getVersion_name() {
		return version_name;
	}
	public void setVersion_name(String version_name) {
		this.version_name = version_name;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getForcedup() {
		return forcedup;
	}
	public void setForcedup(String forcedup) {
		this.forcedup = forcedup;
	}
	public Date getAdd_time() {
		return add_time;
	}
	public void setAdd_time(Date add_time) {
		this.add_time = add_time;
	}
	public Date getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	public String getAddTime() {
		return new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss").format(this.add_time);
	}
	public void setAddTime(String add_time) throws ParseException {
		this.add_time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(add_time);
	}
	public String getUpdateTime() {
		return new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss").format(this.update_time);
	}
	public void setUpdateTime(String update_time) throws ParseException {
		this.update_time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(update_time);
	}
}
