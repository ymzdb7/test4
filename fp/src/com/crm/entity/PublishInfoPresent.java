package com.crm.entity;

import java.util.Date;

public class PublishInfoPresent extends PublishInfo {
	
	private String oname;
	private String typeName;
	private String attachmentName;
	private String attachmentUrl;
	private String pubDate;
	private String stopFlagDesc;
	
	public String getOname() {
		return oname;
	}
	public void setOname(String oname) {
		this.oname = oname;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public String getAttachmentName() {
		return attachmentName;
	}
	public void setAttachmentName(String attachmentName) {
		this.attachmentName = attachmentName;
	}
	public String getAttachmentUrl() {
		return attachmentUrl;
	}
	public void setAttachmentUrl(String attachmentUrl) {
		this.attachmentUrl = attachmentUrl;
	}
	public String getPubDate() {
		return pubDate;
	}
	public void setPubDate(String pubDate) {
		this.pubDate = pubDate;
	}
	public String getStopFlagDesc() {
		return stopFlagDesc;
	}
	public void setStopFlagDesc(String stopFlagDesc) {
		this.stopFlagDesc = stopFlagDesc;
	}
}
