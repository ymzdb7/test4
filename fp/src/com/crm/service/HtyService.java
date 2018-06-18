package com.crm.service;

import java.util.List;
import java.util.Map;

import com.crm.entity.Dept;
import com.crm.entity.HtyPresent;
import com.crm.entity.HtySearchInfo;

public interface HtyService {

	public Map<String, Object> getAllHtyAssistInfo(List<Dept> dept, int page, int rows,
			Integer[] dids, int f);

	public Object addHtyAssistInfo(HtyPresent htyPresent, String flaged);

	public Object deleteHtyAssistInfo(int id);

	public Map<String, Object> getHtyAssistInfoByPid(int pid);

	public Map<String, Object> getSearchHtyAssistInfo(HtySearchInfo hsi, int page,
			int rows, Integer[] arrDids, int f);

}
