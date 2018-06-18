package com.crm.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.crm.entity.Hty;
import com.crm.entity.HtyPresent;
import com.crm.mapper.HtyMapper;

@Repository
public class HtyDaoImpl implements HtyDao {

	@Resource
	private HtyMapper mapper;

	@Override
	public Integer getTotalHtyAssistInfo(Map<String, Object> map) {
		return this.mapper.getTotalHtyAssistInfo(map);
	}

	@Override
	public List<HtyPresent> getAllHtyAssistInfo(Map<String, Object> map) {
		return this.mapper.getAllHtyAssistInfo(map);
	}

	@Override
	public int addHtyAssistInfo(Hty hty) {
		return this.mapper.addHtyAssistInfo(hty);
	}

	@Override
	public int updateHtyAssistInfo(Hty hty) {
		return this.mapper.updateHtyAssistInfo(hty);
	}

	@Override
	public int deleteHtyAssistInfo(int id) {
		return this.mapper.deleteHtyAssistInfo(id);
	}

	@Override
	public List<HtyPresent> getHtyAssistInfoByPid(int pid) {
		return this.mapper.getHtyAssistInfoByPid(pid);
	}

	@Override
	public List<HtyPresent> getSearchHtyAssistInfo(Map<String, Object> map) {
		return this.mapper.getSearchHtyAssistInfo(map);
	}

	@Override
	public int getTotalSearchHtyAssistInfo(Map<String, Object> map) {
		return this.mapper.getTotalSearchHtyAssistInfo(map);
	}
	
}
