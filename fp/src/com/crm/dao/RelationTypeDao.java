package com.crm.dao;

import java.util.List;
import com.crm.entity.RelationType;

public interface RelationTypeDao {

	public List<RelationType> getAllRelationType();

	public RelationType getRelationType(int id);

	public String getRelationTypeNameById(int id);

}
