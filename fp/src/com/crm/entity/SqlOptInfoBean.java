package com.crm.entity;

/**
 * sql的insert、update、delete操作的返回信息封装bean，该信息要返回给前端；
 * @author WEIWF
 *
 */
public class SqlOptInfoBean {
	
	//使用mybatis做持久层时，insert、update、delete，
    //sql语句默认是不返回被操作记录主键的，而是返回被操作记录条数
	private int resultNum;   //sql执行的返回成功数；
	private String success;	 //成功失败标记，true-成功，false-失败；
	
	public SqlOptInfoBean(int r, String success) {
		this.resultNum = r;
		this.success = success;
	}
	public int getResultNum() {
		return resultNum;
	}
	public void setResultNum(int resultNum) {
		this.resultNum = resultNum;
	}
	public String getSuccess() {
		return success;
	}
	public void setSuccess(String success) {
		this.success = success;
	}

}
