package com.crm.mapper;

import java.util.List;
import java.util.Map;

import com.crm.entity.Hty;
import com.crm.entity.HtyPresent;

public interface HtyMapper {

	Integer getTotalHtyAssistInfo(Map<String, Object> map);

	List<HtyPresent> getAllHtyAssistInfo(Map<String, Object> map);

	int addHtyAssistInfo(Hty hty);

	int updateHtyAssistInfo(Hty hty);

	int deleteHtyAssistInfo(int id);

	List<HtyPresent> getHtyAssistInfoByPid(int pid);

	List<HtyPresent> getSearchHtyAssistInfo(Map<String, Object> map);

	int getTotalSearchHtyAssistInfo(Map<String, Object> map);
}
