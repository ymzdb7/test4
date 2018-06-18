package com.crm.entity;

import java.util.Date;

public class PublishInfo {

	private int id;
	private int oid;
	private String title;
	private String content;
	private int typeId;
	private int attachmentId;
	private Date pubTime;
	private int stopFlag;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getOid() {
		return oid;
	}

	public void setOid(int oid) {
		this.oid = oid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getTypeId() {
		return typeId;
	}

	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}

	public int getAttachmentId() {
		return attachmentId;
	}

	public void setAttachmentId(int attachmentId) {
		this.attachmentId = attachmentId;
	}

	public Date getPubTime() {
		return pubTime;
	}

	public void setPubTime(Date pubTime) {
		this.pubTime = pubTime;
	}

	public int getStopFlag() {
		return stopFlag;
	}

	public void setStopFlag(int stopFlag) {
		this.stopFlag = stopFlag;
	}

}
