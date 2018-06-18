package com.crm.mapper;

import java.util.List;
import java.util.Map;

import com.crm.entity.EduAssist;
import com.crm.entity.EduAssistPresent;
import com.crm.entity.EduPhaseType;

public interface EduMapper extends BaseMapper {
	
	public List<EduPhaseType> getAllEduPhaseType();

	public Integer getTotalEduAssistInfo(Map<String, Object> map);

	public List<EduAssistPresent> getAllEduAssistInfo(Map<String, Object> map);

	public int addEduAssistInfo(EduAssist eduAssist);

	public int updateEduAssistInfo(EduAssist eduAssist);

	public int deleteEduAssistInfo(int id);

	public List<EduAssistPresent>  getEduAssistInfoByPid(int pid);

	public List<EduAssistPresent> getSearchEduInfo(Map<String, Object> map);

	public int getTotalSearchEduInfo(Map<String, Object> map);
	
}
