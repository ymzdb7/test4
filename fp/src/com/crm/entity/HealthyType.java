package com.crm.entity;

/*
 * 健康状况编码表(HEALTHY_CD)对应的实体类 
 */
public class HealthyType {
	private int id;
	private String type_name;	//描述，0-健康、1-残疾、2-慢性病、3-生病、4-死亡、9-未知
	
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
