package com.crm.mapper;

import java.util.List;

import com.crm.entity.WorkType;

public interface WorkTypeMapper extends BaseMapper {

	public List<WorkType> getAllWorkType();
	
	public WorkType getWorkType(int id);
	
}
