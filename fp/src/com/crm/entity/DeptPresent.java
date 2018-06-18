package com.crm.entity;

import java.util.List;


/*
 * 部门信息(DEPT_CD)对应的实体类 的表现层类
 */
public class DeptPresent {
	private int did;
	private String dname;
	private String descb;
	private int superDid;
	private String superDidName;
	private int level;
	private String levelName;
	private List<UserInfo> userInfo;
	
	
	
	public List<UserInfo> getUserInfo() {
		return userInfo;
	}
	public void setUserInfo(List<UserInfo> userInfo) {
		this.userInfo = userInfo;
	}
	
	
	public int getSuperDid() {
		return superDid;
	}
	public void setSuperDid(int superDid) {
		this.superDid = superDid;
	}
	public String getSuperDidName() {
		return superDidName;
	}
	public void setSuperDidName(String superDidName) {
		this.superDidName = superDidName;
	}
	public String getLevelName() {
		return levelName;
	}
	public void setLevelName(String levelName) {
		this.levelName = levelName;
	}
	public int getDid() {
		return did;
	}
	public void setDid(int did) {
		this.did = did;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getDescb() {
		return descb;
	}
	public void setDescb(String descb) {
		this.descb = descb;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
}
