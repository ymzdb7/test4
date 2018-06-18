package com.crm.entity;

public class ConsultInfoPresent extends ConsultInfo {

	private String pname;
	private String questionTypeDesc;
	private String oname;
	private String aname;
	private String evaluationDesc;
	private String isAnonyDesc;
	private String subDate;
	private String ansDate;
	
	public String getQuestionTypeDesc() {
		return questionTypeDesc;
	}
	public void setQuestionTypeDesc(String questionTypeDesc) {
		this.questionTypeDesc = questionTypeDesc;
	}
	public String getIsAnonyDesc() {
		return isAnonyDesc;
	}
	public void setIsAnonyDesc(String isAnonyDesc) {
		this.isAnonyDesc = isAnonyDesc;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getOname() {
		return oname;
	}
	public void setOname(String oname) {
		this.oname = oname;
	}
	public String getAname() {
		return aname;
	}
	public void setAname(String aname) {
		this.aname = aname;
	}
	public String getEvaluationDesc() {
		return evaluationDesc;
	}
	public void setEvaluationDesc(String evaluationDesc) {
		this.evaluationDesc = evaluationDesc;
	}
	public String getSubDate() {
		return subDate;
	}
	public void setSubDate(String subDate) {
		this.subDate = subDate;
	}
	public String getAnsDate() {
		return ansDate;
	}
	public void setAnsDate(String ansDate) {
		this.ansDate = ansDate;
	}
}
