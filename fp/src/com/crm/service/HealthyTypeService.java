package com.crm.service;

import java.util.List;
import com.crm.entity.HealthyType;

public interface HealthyTypeService {
	
	public List<HealthyType> getAllHealthyType();
	
	public HealthyType getHealthyType(int id);
	
}
