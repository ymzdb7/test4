package com.crm.dao;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.crm.entity.WorkType;
import com.crm.mapper.WorkTypeMapper;

@Repository
public class WorkTypeDaoImpl implements WorkTypeDao {

	@Resource WorkTypeMapper mapper;
	
	@Override
	public List<WorkType> getAllWorkType() {
		return this.mapper.getAllWorkType();
	}

	@Override
	public WorkType getWorkType(int id) {
		return this.mapper.getWorkType(id);
	}

}
