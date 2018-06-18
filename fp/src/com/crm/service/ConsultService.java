package com.crm.service;

import java.util.List;
import java.util.Map;

import com.crm.entity.ConsultInfoPresent;
import com.crm.entity.ConsultSearchInfo;
import com.crm.entity.ConsultType;

public interface ConsultService {

	public Map<String, Object> getConsultInfo(int page, int rows, int oid, int f, int isAns);

	public  Map<String,Object>  saveConsultInfo(ConsultInfoPresent cip);

	public List<ConsultType> getConsultType();

	public Object addConsultInfo(ConsultInfoPresent cip);

	public Object evaluation(int id, int eval);

	public Map<String, Object> getConsultInfoByPid(int pid);

	public Map<String, Object> getConsultInfoById(Integer id);

	public Map<String, Object> getSearchInfo(int page, int rows, int oid, int f,
			ConsultSearchInfo csi);

}
