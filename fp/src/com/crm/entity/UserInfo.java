package com.crm.entity;

import java.util.Date;

/*
 * 用户信息(USER_INFO)对应的实体类 
 */
public class UserInfo {

	private int pid;					//户成员信息ID
	private int did;					//部门ID
	private int rid;					//角色ID
	private int oid;					//机构ID
	private String pname;				//成员姓名
	private String sex;					//性别。 F-女，M-男
	private int relationType;  			//与户主关系
	private String cid;		  			//身份证号码
	private int workType;				//就业状况编码
	private int marriedType;			//婚姻状况。0-未婚	1-已婚	2-未知
	private String phone;				//联系电话
	private int healthyType;			//健康状况
	private Date oTime;					//操作时间
	private int isHolder;				//是否户主
	private String faddr;				//家庭地址
	private String descb;				//描述
	
	public int getPid() {
		return this.pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getDid() {
		return this.did;
	}
	public void setDid(int did) {
		this.did = did;
	}
	public int getRid() {
		return this.rid;
	}
	public void setRid(int rid) {
		this.rid = rid;
	}
	public String getPname() {
		return this.pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getSex() {
		return this.sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public int getRelationType() {
		return this.relationType;
	}
	public void setRelationType(int relationType) {
		this.relationType = relationType;
	}
	public String getCid() {
		return this.cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public int getWorkType() {
		return this.workType;
	}
	public void setWorkType(int workType) {
		this.workType = workType;
	}
	public int getMarriedType() {
		return this.marriedType;
	}
	public void setMarriedType(int marriedType) {
		this.marriedType = marriedType;
	}
	public String getPhone() {
		return this.phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getHealthyType() {
		return this.healthyType;
	}
	public void setHealthyType(int healthyType) {
		this.healthyType = healthyType;
	}
	public int getIsHolder() {
		return this.isHolder;
	}
	public void setIsHolder(int isHolder) {
		this.isHolder = isHolder;
	}
	public String getFaddr() {
		return this.faddr;
	}
	public void setFaddr(String faddr) {
		this.faddr = faddr;
	}
	public Date getoTime() {
		return this.oTime;
	}
	public void setoTime(Date oTime) {
		this.oTime = oTime;
	}
	public String getDescb() {
		return this.descb;
	}
	public void setDescb(String descb) {
		this.descb = descb;
	}
	public int getOid() {
		return oid;
	}
	public void setOid(int oid) {
		this.oid = oid;
	}
}
