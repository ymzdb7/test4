package com.crm.dao;

import java.util.List;

import com.crm.entity.HealthyType;

public interface HealthyTypeDao {

	public List<HealthyType> getAllHealthyType();
	
	public HealthyType getHealthyType(int id);
}
