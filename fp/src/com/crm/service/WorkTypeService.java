package com.crm.service;

import java.util.List;
import com.crm.entity.WorkType;

public interface WorkTypeService {

	public List<WorkType> getAllWorkType();
	
	public WorkType getWorkType(int id);

}
