package com.crm.mapper;

import java.util.List;
import com.crm.entity.HealthyType;

public interface HealthyTypeMapper extends BaseMapper {

	public List<HealthyType> getAllHealthyType();
	
	public HealthyType getHealthyType(int id);
}
