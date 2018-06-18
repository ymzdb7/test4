package com.crm.dao;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.crm.entity.HealthyType;
import com.crm.mapper.CustomerMapper;
import com.crm.mapper.HealthyTypeMapper;

@Repository
public class HealthyTypeDaoImpl implements HealthyTypeDao {

	@Resource HealthyTypeMapper mapper;
	
	@Override
	public List<HealthyType> getAllHealthyType() {
		return this.mapper.getAllHealthyType();
	}

	@Override
	public HealthyType getHealthyType(int id) {
		return this.mapper.getHealthyType(id);
	}

}
