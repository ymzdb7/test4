package com.crm.service;

import java.util.List;
import java.util.Map;

import com.crm.entity.ConsultInfoPresent;
import com.crm.entity.ConsultType;
import com.crm.entity.Org;
import com.crm.entity.PubSearchInfo;
import com.crm.entity.PublishInfoPresent;

public interface PublishService {

	public Map<String, Object> getPublishInfo(int page, int rows, int typeId, int oid, int f);

	public  Map<String,Object>  savePublishInfo(PublishInfoPresent pip);

	public List<ConsultType> getConsultType();

	public List<Org> getOrg();

	public Object stopPublish(int stopFlag,int id);

	public Object deletePublish(int id);

	public Object updatePublishInfo(PublishInfoPresent pip);

	public List<Org> getOrgByOid(int oid);

	public Map<String, Object> getPublishInfoById(Integer id);

	public Map<String, Object> getSearchInfo(int page, int rows, int typeId, int oid,
			int f, PubSearchInfo psi);

}
