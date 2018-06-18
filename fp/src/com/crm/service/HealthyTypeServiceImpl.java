package com.crm.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.crm.dao.HealthyTypeDao;
import com.crm.entity.HealthyType;

@Service
public class HealthyTypeServiceImpl implements HealthyTypeService{

	@Resource HealthyTypeDao dao;
	
	@Override
	public List<HealthyType> getAllHealthyType() {
		return this.dao.getAllHealthyType();
	}

	@Override
	public HealthyType getHealthyType(int id) {
		return this.dao.getHealthyType(id);
	}

}
