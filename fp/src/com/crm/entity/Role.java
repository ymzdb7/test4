package com.crm.entity;

/*
 * 用户角色(ROLE_MNG)对应的实体类 
 */
public class Role {

	private int rid;
	private String rname;
	private String flaged;

	public int getRid() {
		return this.rid;
	}

	public void setRid(int rid) {
		this.rid = rid;
	}

	public String getRname() {
		return this.rname;
	}

	public void setRname(String rname) {
		this.rname = rname;
	}

	public String getFlaged() {
		return flaged;
	}

	public void setFlaged(String flaged) {
		this.flaged = flaged;
	}
}
