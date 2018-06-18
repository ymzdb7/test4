package com.crm.entity;

import java.util.Date;

public class Hty {

	private int id;
	private int pid;
	private String illnessName;
	private String hospital;
	private float cost;
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
	public String getIllnessName() {
		return illnessName;
	}
	public void setIllnessName(String illnessName) {
		this.illnessName = illnessName;
	}
	public String getHospital() {
		return hospital;
	}
	public void setHospital(String hospital) {
		this.hospital = hospital;
	}
	public float getCost() {
		return cost;
	}
	public void setCost(float cost) {
		this.cost = cost;
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
