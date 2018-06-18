package com.crm.entity;

/*
 *	就业状况编码表(WORK_CD)对应的实体类 
 */
public class WorkType {
	private int id;
	private String type_name;		//描述，0-儿童、1-学生、2-无业、3-个体户、4-灵活就业、5-工作、9-未知
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getType_name() {
		return type_name;
	}
	public void setType_name(String type_name) {
		this.type_name = type_name;
	}

}
