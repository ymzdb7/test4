package com.crm.entity;

public class HtyPresent extends Hty {

	private int fid;
	private String holderName;
	private String pname;
	private String paymentTime;
    private String relationType;
    private String relationTypeName;

	
	public int getFid() {
		return fid;
	}
	public void setFid(int fid) {
		this.fid = fid;
	}
	public String getHolderName() {
		return holderName;
	}
	public void setHolderName(String holderName) {
		this.holderName = holderName;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPaymentTime() {
		return paymentTime;
	}
	public void getPaymentTime(String paymentTime) {
		this.paymentTime = paymentTime;
	}
	public String getRelationTypeName() {
		return relationTypeName;
	}
	public void setRelationTypeName(String relationTypeName) {
		this.relationTypeName = relationTypeName;
	}
	public String getRelationType() {
		return relationType;
	}
	public void setRelationType(String relationType) {
		this.relationType = relationType;
	}
}
