package com.crm.mapper;

import java.util.List;

import com.crm.entity.RelationType;

public interface RelationTypeMapper extends BaseMapper {
	
	public List<RelationType> getAllRelationType();
	
	public RelationType getRelationType(int id);
	
	public String getRelationTypeNameById(int id);
}
