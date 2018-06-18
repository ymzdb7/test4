package com.crm.service;

import java.util.List;

import com.crm.entity.RelationType;

public interface RelationTypeService {

	public List<RelationType> getAllRelationType();

	public RelationType getRelationType(int id);

	public String getRelationTypeNameById(int id);

}
