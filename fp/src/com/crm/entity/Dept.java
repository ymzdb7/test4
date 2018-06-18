package com.crm.entity;

import java.io.Serializable;
import java.util.List;


/*
 * 部门信息(DEPT_CD)对应的实体类 
 */
public class Dept  implements Serializable {
	private int did;
	private String dname;
	private String descb;
	private int superDid;
	private int ulevel;
	private int flag;
	private String flaged;
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
	public int getUlevel() {
		return ulevel;
	}
	public void setUlevel(int ulevel) {
		this.ulevel = ulevel;
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
	public String getFlaged() {
		return flaged;
	}
	public void setFlaged(String flaged) {
		this.flaged = flaged;
	}
	public int getFlag() {
		return flag;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}
}
