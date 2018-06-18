package com.crm.entity;


/*
 * 帮扶对象信息(USER_INFO)对应的展现层实体类 
 */
public class UserInfoPresent extends UserInfo{
	private int fid;					//户号
	private String dname;				//部门名称
	private String oname;
	private String rname;				//角色名称
	private String sexName;				//性别。 F-女，M-男
	private String relationTypeName;  	//与户主关系名称
	private String workTypeName;			//就业状况编码
	private String marriedTypeName;			//婚姻状况。0-未婚	1-已婚	2-未知
	private String healthyTypeName;			//健康状况
	private String holderName;			//户主姓名
	private String duty;

	public UserInfoPresent(){
		
	}
	
	public String getSexName() {
		return sexName;
	}
	public void setSexName(String sexName) {
		this.sexName = sexName;
	}
	public String getRelationTypeName() {
		return relationTypeName;
	}
	public void setRelationTypeName(String relationTypeName) {
		this.relationTypeName = relationTypeName;
	}
	public String getWorkTypeName() {
		return workTypeName;
	}
	public void setWorkTypeName(String workTypeName) {
		this.workTypeName = workTypeName;
	}
	public String getMarriedTypeName() {
		return marriedTypeName;
	}
	public void setMarriedTypeName(String marriedTypeName) {
		this.marriedTypeName = marriedTypeName;
	}
	public String getHealthyTypeName() {
		return healthyTypeName;
	}
	public void setHealthyTypeName(String healthyTypeName) {
		this.healthyTypeName = healthyTypeName;
	}
	
	public int getFid() {
		return fid;
	}
	public void setFid(int fid) {
		this.fid = fid;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	public String getHolderName() {
		return holderName;
	}
	public void setHolderName(String holderName) {
		this.holderName = holderName;
	}
	public String getOname() {
		return oname;
	}
	public void setOname(String oname) {
		this.oname = oname;
	}

	public String getDuty() {
		return duty;
	}

	public void setDuty(String duty) {
		this.duty = duty;
	}		
}
