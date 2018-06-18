package com.crm.entity;

import java.util.Date;

public class ConsultInfo {

	private int id;
	private int pid;
	private Date subTime;
	private String content;
	private int isAnony;
	private int questionTypeId;
	private int oid;
	private String answer;
	private Date ansTime;
	private int aid;
	private int evaluation;
	
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
	public Date getSubTime() {
		return subTime;
	}
	public void setSubTime(Date subTime) {
		this.subTime = subTime;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getIsAnony() {
		return isAnony;
	}
	public void setIsAnony(int isAnony) {
		this.isAnony = isAnony;
	}
	public int getQuestionTypeId() {
		return questionTypeId;
	}
	public void setQuestionTypeId(int questionTypeId) {
		this.questionTypeId = questionTypeId;
	}
	public int getOid() {
		return oid;
	}
	public void setOid(int oid) {
		this.oid = oid;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public Date getAnsTime() {
		return ansTime;
	}
	public void setAnsTime(Date ansTime) {
		this.ansTime = ansTime;
	}
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public int getEvaluation() {
		return evaluation;
	}
	public void setEvaluation(int evaluation) {
		this.evaluation = evaluation;
	}

}
