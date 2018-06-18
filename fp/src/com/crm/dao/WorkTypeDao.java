package com.crm.dao;

import java.util.List;
import com.crm.entity.WorkType;

public interface WorkTypeDao {

	public List<WorkType> getAllWorkType();
	
	public WorkType getWorkType(int id);
}
