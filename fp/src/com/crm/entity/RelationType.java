package com.crm.entity;

/*
 *与户主关系编码表(RELATION_CD)对应的实体类 
 */
public class RelationType {
	private int id;
	private String type_name;	//描述，0-父子、1-父女、2-母子、3-母女、4-兄弟、5-姐弟、6-兄妹、7-姐妹、8-祖孙、9-曾祖孙、10-其他

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
