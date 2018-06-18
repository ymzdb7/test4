package com.crm.entity;

public class LoginUserMap {
	private String phone;
	private String upwd;
	
	public LoginUserMap(String phone2, String upwd2) {
		this.phone = phone2;
		this.upwd = upwd2;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getUpwd() {
		return upwd;
	}
	public void setUpwd(String upwd) {
		this.upwd = upwd;
	}
	
}
