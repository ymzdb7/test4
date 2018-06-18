package com.crm.service;

import java.util.List;
import java.util.Map;

import com.crm.entity.Dept;
import com.crm.entity.EduAssist;
import com.crm.entity.EduAssistPresent;
import com.crm.entity.EduPhaseType;
import com.crm.entity.EduSearchInfo;

public interface EduService {

	public Map<String, Object> getAllEduAssistInfo(List<Dept> allDept, int page,
			int rows, Integer[] dids, int f);

	public List<EduPhaseType> getAllEduPhaseType();

	public Object addEduAssistInfo(EduAssistPresent eduAssist, String flaged);

	public Object deleteEduAssistInfo(int id);

	public Map<String,Object>  getEduAssistInfoByPid(int pid);

	public Map<String, Object> getSearchEduInfo(EduSearchInfo esi, int p,
			int r, Integer[] arrDids, int f);
}
