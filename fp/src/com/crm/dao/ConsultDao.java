package com.crm.dao;

import java.util.List;
import java.util.Map;

import com.crm.entity.ConsultInfo;
import com.crm.entity.ConsultInfoPresent;
import com.crm.entity.ConsultType;

public interface ConsultDao {

	public List<ConsultInfoPresent> getConsultInfo(Map<String, Object> map);

	public int getTotalConsultInfo(Map<String, Object> map);

	public int saveConsultInfo(ConsultInfo consultInfo);

	public List<ConsultType> getConsultType();

	public int addConsultInfo(ConsultInfoPresent cip);

	public int evaluation(Map<String,Object> map);

	public List<ConsultInfoPresent> getConsultInfoByPid(int pid);

	public List<ConsultInfoPresent> getConsultInfoById(Integer id);

	public List<ConsultInfoPresent> getSearchInfo(Map<String, Object> map);

	public int getTotalSearchInfo(Map<String, Object> map);
}
