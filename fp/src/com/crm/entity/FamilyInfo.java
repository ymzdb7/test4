package com.crm.entity;

import java.util.Date;

/*
 * 户基本信息：(FAMILY_INFO)对应的实体类 
 */
public class FamilyInfo {
	
	private int fid;						//户信息ID
	private int pid;						//户主ID
	private String faddress;				//家庭住址
	private String fphone;					//家庭联系电话
	private Date input_time;				//操作时间
	
	public int getFid() {
		return fid;
	}
	public void setFid(int fid) {
		this.fid = fid;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getFaddress() {
		return faddress;
	}
	public void setFaddress(String faddress) {
		this.faddress = faddress;
	}
	public String getFphone() {
		return fphone;
	}
	public void setFphone(String fphone) {
		this.fphone = fphone;
	}
	public Date getInput_time() {
		return input_time;
	}
	public void setInput_time(Date input_time) {
		this.input_time = input_time;
	}

}
