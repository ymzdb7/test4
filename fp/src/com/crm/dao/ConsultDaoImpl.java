package com.crm.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.crm.entity.ConsultInfo;
import com.crm.entity.ConsultInfoPresent;
import com.crm.entity.ConsultType;
import com.crm.mapper.ConsultMapper;

@Repository
public class ConsultDaoImpl implements ConsultDao {
	
	@Resource
	private ConsultMapper mapper; 

	@Override
	public List<ConsultInfoPresent> getConsultInfo(Map<String, Object> map) {
		return this.mapper.getConsultInfo(map);
	}

	@Override
	public int getTotalConsultInfo(Map<String, Object> map) {
		return this.mapper.getTotalConsultInfo(map);
	}

	@Override
	public int saveConsultInfo(ConsultInfo ci) {
		return this.mapper.saveConsultInfo(ci);
	}

	@Override
	public List<ConsultType> getConsultType() {
		return this.mapper.getConsultType();
	}

	@Override
	public int addConsultInfo(ConsultInfoPresent cip) {
		return this.mapper.addConsultInfo(cip);
	}

	@Override
	public int evaluation(Map<String,Object> map) {
		return this.mapper.evaluation(map);
	}

	@Override
	public List<ConsultInfoPresent> getConsultInfoByPid(int pid) {
		return this.mapper.getConsultInfoByPid(pid);
	}

	@Override
	public List<ConsultInfoPresent> getConsultInfoById(Integer id) {
		return this.mapper.getConsultInfoById(id);
	}

	@Override
	public List<ConsultInfoPresent> getSearchInfo(Map<String, Object> map) {
		return this.mapper.getSearchInfo(map);
	}

	@Override
	public int getTotalSearchInfo(Map<String, Object> map) {
		return this.mapper.getTotalSearchInfo(map);
	}

}
