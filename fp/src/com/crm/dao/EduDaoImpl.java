package com.crm.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.crm.entity.EduAssist;
import com.crm.entity.EduAssistPresent;
import com.crm.entity.EduPhaseType;
import com.crm.mapper.EduMapper;

@Repository
public class EduDaoImpl implements EduDao {

	@Resource
	private EduMapper mapper;

	@Override
	public List<EduPhaseType> getAllEduPhaseType() {
		return this.mapper.getAllEduPhaseType();
	}

	@Override
	public Integer getTotalEduAssistInfo(Map<String, Object> map) {
		return this.mapper.getTotalEduAssistInfo(map);
	}

	@Override
	public List<EduAssistPresent> getAllEduAssistInfo(Map<String, Object> map) {
		return this.mapper.getAllEduAssistInfo(map);
	}

	@Override
	public int addEduAssistInfo(EduAssist eduAssist) {
		return this.mapper.addEduAssistInfo(eduAssist);
	}

	@Override
	public int updateEduAssistInfo(EduAssist eduAssist) {
		return this.mapper.updateEduAssistInfo(eduAssist);
	}

	@Override
	public int deleteEduAssistInfo(int id) {
		return this.mapper.deleteEduAssistInfo(id);
	}

	@Override
	public List<EduAssistPresent>  getEduAssistInfoByPid(int pid) {
		return this.mapper.getEduAssistInfoByPid(pid);
	}

	@Override
	public List<EduAssistPresent> getSearchEduInfo(Map<String, Object> map) {
		return this.mapper.getSearchEduInfo(map);
	}

	@Override
	public int getTotalSearchEduInfo(Map<String, Object> map) {
		return this.mapper.getTotalSearchEduInfo(map);
	}
	
}
