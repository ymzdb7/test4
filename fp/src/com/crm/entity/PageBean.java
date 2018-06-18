package com.crm.entity;

/**
 * 翻页用
 * @author WEIWF
 */
public class PageBean {

	public PageBean(int page, int rows, String did) {
		super();
		this.page = page;
		this.startIndex = (page-1)*rows;
		this.rows = rows;
		this.totalPages = this.rows;
		this.did = did;
	}
	
	String  did ;  //部门id字符串，格式如：“1,2,3,4,5”
	int page = 0; //页码；
	int startIndex = 0; //翻页的开始索引序号-1；
	int rows = 0; //每页大小；
	int totalPages = 0; //总页数；
	
	public String getDid() {
		return did;
	}
	public void setDid(String did) {
		this.did = did;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getStartIndex() {
		return startIndex;
	}
	public void setStartIndex(int startIndex) {
		this.startIndex = startIndex;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public int getTotalPages() {
		return totalPages;
	}
	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}
	
}
