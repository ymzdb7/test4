package com.crm.mapper;	

import java.util.List;
import java.util.Map;

import com.crm.entity.ConsultInfo;
import com.crm.entity.ConsultInfoPresent;
import com.crm.entity.ConsultType;
import com.crm.entity.PublishInfo;
import com.crm.entity.PublishInfoPresent;

public interface PublishMapper extends BaseMapper {
	
	public int savePublishInfo(PublishInfo pi);

	public List<PublishInfoPresent> getPublishInfo(Map<String, Object> map);

	public int getTotalPublishInfo(Map<String, Object> map);

	public int stopPublish(Map<String, Object> stopMap);
	
	public int deletePublish(int id);

	public int updatePublishInfo(PublishInfoPresent pip);

	public List<PublishInfoPresent> getPublishInfoById(Integer id);

	public List<PublishInfoPresent> getSearchInfo(Map<String, Object> map);

	public Integer getTotalSearchInfo(Map<String, Object> map);
	
}
