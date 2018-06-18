package com.crm.dao;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.crm.entity.RelationType;
import com.crm.mapper.RelationTypeMapper;

@Repository
public class RelationTypeDaoImpl implements RelationTypeDao {

	@Resource RelationTypeMapper mapper;
	
	@Override
	public List<RelationType> getAllRelationType() {
		return this.mapper.getAllRelationType();
	}

	@Override
	public RelationType getRelationType(int id) {
		return this.mapper.getRelationType(id);
	}

	@Override
	public String getRelationTypeNameById(int id) {
		return this.mapper.getRelationTypeNameById(id);
	}

}
