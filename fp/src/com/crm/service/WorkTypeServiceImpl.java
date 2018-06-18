package com.crm.service;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.crm.dao.WorkTypeDao;
import com.crm.entity.WorkType;

@Service
public class WorkTypeServiceImpl implements WorkTypeService {

	@Resource WorkTypeDao dao;
	
	@Override
	public List<WorkType> getAllWorkType() {
		return this.dao.getAllWorkType();
	}

	@Override
	public WorkType getWorkType(int id) {
		return this.dao.getWorkType(id);
	}

}
