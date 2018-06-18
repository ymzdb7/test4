package com.crm.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.crm.entity.ConsultInfoPresent;
import com.crm.entity.ConsultSearchInfo;
import com.crm.entity.ConsultType;
import com.crm.entity.EduPhaseType;
import com.crm.entity.Org;
import com.crm.entity.UserInfo;
import com.crm.util.ResultMapUtil;
import com.crm.dao.ConsultDao;
import com.crm.dao.CustomerDao;
import com.sun.istack.internal.logging.Logger;

@Service
public class ConsultServiceImpl implements ConsultService {

	/* 日志 */
	Logger log = Logger.getLogger(ConsultService.class);

	@Resource
	private ConsultDao dao;
	@Resource
	private CustomerDao cdao;

	@Override
	public Map<String, Object> getConsultInfo(int page, int rows, int oid, int f, int isAns) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startIndex", ((page - 1) * rows));
		map.put("rows", rows);
		map.put("oid", oid);
		map.put("isAns",isAns);
		List<ConsultInfoPresent> retObj = loadPresent(this.dao.getConsultInfo(map));
		int countSize = 0;
		Integer ti = this.dao.getTotalConsultInfo(map);
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
		map2.put("success", "true");
		map2.put("message", "成功");
		return map2;
	}

	/**
	 * 封装展现层信息
	 * @param listCip
	 * @return
	 */
	private List<ConsultInfoPresent> loadPresent(List<ConsultInfoPresent> listCip){
		List<ConsultInfoPresent> list = new ArrayList<ConsultInfoPresent>();
		//全部用户名PID列表
		//List<UserInfo> pn = this.cdao.geAllUserPidPName();
		//获取全部咨询类型
		List<ConsultType> lct = this.dao.getConsultType();
		//获取全部的机构ID名称列表
		List<Org> lo = this.cdao.getOrg();
		
		for (int i=0; i<listCip.size(); i++){
			ConsultInfoPresent cip = listCip.get(i);
			/*
			for (UserInfo ui: pn) {
				if (ui.getPid()==cip.getPid()){
					cip.setPname(ui.getPname());
					break;
				}
			}
			*/
			for (ConsultType ct : lct){
				if (cip.getQuestionTypeId()==ct.getId()){
					cip.setQuestionTypeDesc(ct.getTypeName());
					break;
				}
			}
			for (Org o : lo){
				if (cip.getOid()==o.getOid()){
					cip.setOname(o.getOname());
					break;
				}
			}
			if (cip.getIsAnony()==0){
				cip.setIsAnonyDesc("实名");
			}else if(cip.getIsAnony()==1){
				cip.setIsAnonyDesc("匿名");
			}
			/*
			if (cip.getAid() != 0){
				for (UserInfo ui: pn) {
					if (ui.getPid()==cip.getAid()){
						cip.setAname(ui.getPname());
						break;
					}
				}
			}*/
			if (cip.getAid()==0){
				cip.setAname("");
			}
			if ((cip.getAnswer() == null || cip.getAnswer().trim().equals("")) && cip.getAid()==0){
				cip.setAnsDate("");
			}
			if (cip.getEvaluation()==1){
				cip.setEvaluationDesc("满意");
			}else if (cip.getEvaluation()==2){
				cip.setEvaluationDesc("比较满意");
			}else if (cip.getEvaluation()==3){
				cip.setEvaluationDesc("不满意");
			}else{
				cip.setEvaluationDesc("未评估");
			}
			if (cip.getAname() == null || cip.getAname() == "null" ){
				cip.setAname("");
			}
			if (cip.getAnswer() == null || cip.getAnswer() == "null"){
				cip.setAnswer("");
			}
			if (cip.getEvaluationDesc() == null || cip.getEvaluationDesc() == "null"){
				cip.setEvaluationDesc("");
			}
			list.add(cip);
		}
		return list;
	}
	
	@Override
	public Map<String,Object> saveConsultInfo(ConsultInfoPresent cip) {
		
		int result = this.dao.saveConsultInfo(cip);
		Map<String, Object> map = new HashMap<String,Object>();
		if (result == 1) {
			map.put("success", "true");
			map.put("message", "保存信息成功");
		}else{
			map.put("success", "false");
			map.put("message", "保存信息失败");
		}
		return map;
	}

	@Override
	public List<ConsultType> getConsultType(){
		return this.dao.getConsultType();
	}

	@Override
	public Object addConsultInfo(ConsultInfoPresent cip) {
		int result = this.dao.addConsultInfo(cip);
		if (result == 1){
			return ResultMapUtil.resultMapObject("true", "结果保存成功");
		}else{
			return ResultMapUtil.resultMapObject("false", "结果保存失败");
		}
	}

	@Override
	public Object evaluation(int id, int eval) {
		Map<String,Object> map2 = new HashMap<String,Object>();
		map2.put("id", id);
		map2.put("evaluation", eval);
		int result = this.dao.evaluation(map2);
		if (result == 1){
			return ResultMapUtil.resultMapObject("true", "评估结果成功保存");
		}else{
			return ResultMapUtil.resultMapObject("false", "评估结果保存失败");
		}
	}

	@Override
	public Map<String, Object> getConsultInfoByPid(int pid) {
		List<ConsultInfoPresent> ci = this.dao.getConsultInfoByPid(pid);
		if (ci == null ){
			return ResultMapUtil.resultMapObject("false", "失败");
		}else{
			return ResultMapUtil.resultMapObject("true", "成功", ci);
		}
	}

	@Override
	public Map<String, Object> getConsultInfoById(Integer id) {
		List<ConsultInfoPresent> ci = this.dao.getConsultInfoById(id);
		if (ci == null ){
			return ResultMapUtil.resultMapObject("false", "失败");
		}else{
			return ResultMapUtil.resultMapObject("true", "成功", ci);
		}
	}

	@Override
	public Map<String, Object> getSearchInfo(int page, int rows, int oid,
			int f, ConsultSearchInfo csi) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startIndex", ((page - 1) * rows));
		map.put("rows", rows);
		map.put("oid", oid);
		map.put("csi",csi);
		List<ConsultInfoPresent> retObj = loadPresent(this.dao.getSearchInfo(map));
		int ti = this.dao.getTotalSearchInfo(map);
		
		Map<String, Object> map2 = new HashMap<String, Object>();
		if (f == 0){
			//手机端
			map2.put("data", retObj);
		}else{
			//web端
			map2.put("rows", retObj);
		}
		map2.put("total", ti);
		map2.put("success", "true");
		map2.put("message", "成功");
		return map2;
	}
}
