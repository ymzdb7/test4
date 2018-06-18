package com.crm.entity;

import java.util.Date;

public class EduAssist {
  
	  private int id ;
	  private int pid;
	  private int eid;
	  private String eschool;
	  private String eclassName;
	  private float ecost;
	  private Date payment_time;
	  private String descb;
	  
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getEid() {
		return eid;
	}
	public void setEid(int eid) {
		this.eid = eid;
	}
	public String getEschool() {
		return eschool;
	}
	public void setEschool(String eschool) {
		this.eschool = eschool;
	}
	public String getEclassName() {
		return eclassName;
	}
	public void setEclassName(String eclassName) {
		this.eclassName = eclassName;
	}
	public float getEcost() {
		return ecost;
	}
	public void setEcost(float ecost) {
		this.ecost = ecost;
	}
	public Date getPayment_time() {
		return payment_time;
	}
	public void setPayment_time(Date payment_time) {
		this.payment_time = payment_time;
	}
	public String getDescb() {
		return descb;
	}
	public void setDescb(String descb) {
		this.descb = descb;
	}
	  
	  
}
