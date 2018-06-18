package com.crm.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.crm.entity.ConsultType;
import com.crm.entity.Org;
import com.crm.entity.PubSearchInfo;
import com.crm.entity.PublishInfoPresent;
import com.crm.entity.UserInfo;
import com.crm.util.ResultMapUtil;
import com.crm.dao.ConsultDao;
import com.crm.dao.CustomerDao;
import com.crm.dao.PublishDao;
import com.sun.istack.internal.logging.Logger;

@Service
public class PublishServiceImpl implements PublishService {

	/* 日志 */
	Logger log = Logger.getLogger(PublishService.class);

	@Resource
	private PublishDao dao;
	@Resource
	private ConsultDao cdao;
	@Resource
	private CustomerDao cudao;

	@Override
	public Map<String, Object> getPublishInfo(int page, int rows, int typeId,int oid,int f) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startIndex", ((page - 1) * rows));
		map.put("rows", rows);
		map.put("oid", oid);
		map.put("typeId", typeId);
		List<PublishInfoPresent> retObj = loadPresent(this.dao.getPublishInfo(map));
		int countSize = 0;
		Integer ti = this.dao.getTotalPublishInfo(map);
		if (ti != null) {
			countSize = ti;
		}
		
		Map<String, Object> map2 = new HashMap<String, Object>();
		if (f == 0){
			//手机端
			map2.put("data", retObj);
		}else{
			//web端
			map2.put("rows", retObj);
		}
		map2.put("total", countSize);
		map2.put("message", "成功");
		map2.put("success", "true");
		return map2;
	}

	/**
	 * 封装展现层信息
	 * @param listpip
	 * @return
	 */
	private List<PublishInfoPresent> loadPresent(List<PublishInfoPresent> listpip){
		List<PublishInfoPresent> list = new ArrayList<PublishInfoPresent>();
		//获取全部的机构ID名称列表
		//List<Org> lo = this.getOrg();
		
		for (int i=0; i<listpip.size(); i++){
			PublishInfoPresent cip = listpip.get(i);
			cip.setTypeName(this.getTypeName(cip.getTypeId()));
			/*
			for (Org o : lo){
				if (cip.getOid()==o.getOid()){
					cip.setOname(o.getOname());
					break;
				}
			}
			*/
			if (cip.getStopFlag()==0 ){
				cip.setStopFlagDesc("停发");
			}else{
				cip.setStopFlagDesc("启用");
			}
			list.add(cip);
		}
		return list;
	}
	
	private String getTypeName(int typeId) {
		if (typeId == 1){
			return "农耕养殖技术";
		}else if (typeId == 2){
			return "就业创业信息";
		}else if (typeId == 3){
			return "惠农政策宣传";
		}else if (typeId == 4){
			return "新闻时事报道";			
		}else if (typeId == 5){
			return "扶贫政策";
		}else if (typeId == 6){
			return "信息发布";
		}else {
			return "";
		}
	}

	@Override
	public List<Org> getOrg(){
		return  this.cudao.getOrg();
	}
	
	@Override
	public Map<String,Object> savePublishInfo(PublishInfoPresent pip) {
		
		int result = this.dao.savePublishInfo(pip);
		if (result == 1) {
			return ResultMapUtil.resultMapObject(true, "信息保存成功");
		}else{
			return ResultMapUtil.resultMapObject(false, "信息保存失败");
		}
	}

	@Override
	public List<ConsultType> getConsultType(){
		return this.cdao.getConsultType();
	}

	@Override
	public Object stopPublish(int stopFlag, int id) {
		Map<String, Object> stopMap = new HashMap<String,Object>();
		stopMap.put("stopFlag", stopFlag);
		stopMap.put("id", id);
		int result = this.dao.stopPublish(stopMap);
		
		if (result == 1) {
			if (stopFlag==0){
				return ResultMapUtil.resultMapObject(true, "停止发布成功");
			}else{
				return ResultMapUtil.resultMapObject(true, "启用发布成功");
			}
		}else{
			if (stopFlag==0){
				return ResultMapUtil.resultMapObject(true, "停止发布失败");
			}else{
				return ResultMapUtil.resultMapObject(true, "启用发布失败");
			}
		}
	}

	@Override
	public Object deletePublish(int id) {
		int result = this.dao.deletePublish(id);
		Map<String, Object> map = new HashMap<String,Object>();
		if (result == 1) {
			map.put("success", "true");
			map.put("message", "删除信息成功");
		}else{
			map.put("success", "false");
			map.put("message", "删除信息失败");
		}
		return map;		
	}

	@Override
	public Object updatePublishInfo(PublishInfoPresent pip) {
		int result = this.dao.updatePublishInfo(pip);
		Map<String, Object> map = new HashMap<String,Object>();
		if (result == 1) {
			map.put("success", "true");
			map.put("message", "更新信息成功");
		}else{
			map.put("success", "false");
			map.put("message", "更新信息失败");
		}
		return map;		
	}

	@Override
	public List<Org> getOrgByOid(int oid) {
		return this.cudao.getOrgByOid(oid);
	}

	@Override
	public Map<String, Object> getPublishInfoById(Integer id) {
		List<PublishInfoPresent> listPip = this.dao.getPublishInfoById(id);
		if (listPip != null && listPip.size() > 0){
			return ResultMapUtil.resultMapObject(true, "获取数据成功", listPip);
		}else{
			return ResultMapUtil.resultMapObject(false, "获取数据失败");
		}
	}

	@Override
	public Map<String, Object> getSearchInfo(int page, int rows, int typeId,
			int oid, int f, PubSearchInfo psi) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startIndex", ((page - 1) * rows));
		map.put("rows", rows);
		map.put("oid", oid);
		map.put("typeId", typeId);
		map.put("psi", psi);
		List<PublishInfoPresent> retObj = loadPresent(this.dao.getSearchInfo(map));
		int countSize = 0;
		Integer ti = this.dao.getTotalSearchInfo(map);
		if (ti != null) {
			countSize = ti;
		}
		
		Map<String, Object> map2 = new HashMap<String, Object>();
		if (f == 0){
			//手机端
			map2.put("data", retObj);
		}else{
			//web端
			map2.put("rows", retObj);
		}
		map2.put("total", countSize);
		map2.put("message", "成功");
		map2.put("success", "true");
		return map2;	
	}
}
