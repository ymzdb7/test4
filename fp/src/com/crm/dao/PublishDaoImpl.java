package com.crm.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.crm.entity.ConsultInfo;
import com.crm.entity.ConsultInfoPresent;
import com.crm.entity.ConsultType;
import com.crm.entity.PublishInfo;
import com.crm.entity.PublishInfoPresent;
import com.crm.mapper.ConsultMapper;
import com.crm.mapper.PublishMapper;

@Repository
public class PublishDaoImpl implements PublishDao {
	
	@Resource
	private PublishMapper mapper; 

	@Override
	public List<PublishInfoPresent> getPublishInfo(Map<String, Object> map) {
		return this.mapper.getPublishInfo(map);
	}

	@Override
	public int getTotalPublishInfo(Map<String, Object> map) {
		return this.mapper.getTotalPublishInfo(map);
	}

	@Override
	public int savePublishInfo(PublishInfo pi) {
		return this.mapper.savePublishInfo(pi);
	}

	@Override
	public int stopPublish(Map<String, Object> stopMap) {
		return this.mapper.stopPublish(stopMap);
	}

	@Override
	public int deletePublish(int id) {
		return this.mapper.deletePublish(id);
	}

	@Override
	public int updatePublishInfo(PublishInfoPresent pip) {
		return this.mapper.updatePublishInfo(pip);
	}

	@Override
	public List<PublishInfoPresent> getPublishInfoById(Integer id) {
		return this.mapper.getPublishInfoById(id);
	}

	@Override
	public List<PublishInfoPresent> getSearchInfo(Map<String, Object> map) {
		return this.mapper.getSearchInfo(map);
	}

	@Override
	public Integer getTotalSearchInfo(Map<String, Object> map) {
		return this.mapper.getTotalSearchInfo(map);
	}

}
