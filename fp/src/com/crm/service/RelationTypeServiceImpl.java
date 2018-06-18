package com.crm.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.crm.dao.HealthyTypeDao;
import com.crm.dao.RelationTypeDao;
import com.crm.entity.RelationType;

@Service
public class RelationTypeServiceImpl implements RelationTypeService {

	@Resource RelationTypeDao dao;
	
	@Override
	public List<RelationType> getAllRelationType() {
		return this.dao.getAllRelationType();
	}

	@Override
	public RelationType getRelationType(int id) {
		return this.dao.getRelationType(id);
	}
	
	@Override
	public String getRelationTypeNameById(int id){
		return this.dao.getRelationTypeNameById(id);
	}

}
