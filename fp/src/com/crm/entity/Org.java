package com.crm.entity;

public class Org {
	private int oid;
	private String oname;
	private String descb;
	private int ulevel;
	private int superDid;
	private String flaged;
	
	public int getOid() {
		return oid;
	}
	public void setOid(int oid) {
		this.oid = oid;
	}
	public String getOname() {
		return oname;
	}
	public void setOname(String oname) {
		this.oname = oname;
	}
	public String getDescb() {
		return descb;
	}
	public void setDescb(String descb) {
		this.descb = descb;
	}
	public int getUlevel() {
		return ulevel;
	}
	public void setUlevel(int ulevel) {
		this.ulevel = ulevel;
	}
	public int getSuperDid() {
		return superDid;
	}
	public void setSuperDid(int superDid) {
		this.superDid = superDid;
	}
	public String getFlaged() {
		return flaged;
	}
	public void setFlaged(String flaged) {
		this.flaged = flaged;
	}
}
