package com.crm.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.crm.entity.Dept;
import com.crm.entity.EduAssistPresent;
import com.crm.entity.EduPhaseType;
import com.crm.entity.EduSearchInfo;
import com.crm.util.DateUtil;
import com.crm.util.ResultMapUtil;
import com.crm.controller.CustomerController;
import com.crm.dao.EduDao;
import com.sun.istack.internal.logging.Logger;

@Service
public class EduServiceImpl implements EduService {

	/* 日志 */
	Logger log = Logger.getLogger(EduService.class);

	@Resource
	private EduDao dao;

	@Override
	public Map<String, Object> getAllEduAssistInfo(List<Dept> allDept,
			int page, int rows, Integer[] dids, int f) {

		Map<String, Object> map = new HashMap<String, Object>();
		int i= ((page - 1) * rows);
		map.put("startIndex", ((page - 1) * rows));
		map.put("rows", rows);
		map.put("did", dids);
		List<EduAssistPresent> retObj = this.dao.getAllEduAssistInfo(map);
		int countSize = 0;
		Integer ti = this.dao.getTotalEduAssistInfo(map);
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

	public String getEduPhaseTypeName(List<EduPhaseType> eduPhaseTypeList,
			int id) {
		for (EduPhaseType l : eduPhaseTypeList) {
			if (l.getEid() == id) {
				return l.getPhase();
			}
		}
		return null;
	}

	@Override
	public List<EduPhaseType> getAllEduPhaseType() {
		return this.dao.getAllEduPhaseType();
	}

	@Override
	public Object addEduAssistInfo(EduAssistPresent eduAssist, String flaged) {
		
		Date date = DateUtil.StrToDate(eduAssist.getPaymentTime());
		eduAssist.setPayment_time(date);
		
		int r = 0;
		if (flaged == null || flaged.trim().equals("") ||flaged.equals("a")){
			r = this.dao.addEduAssistInfo(eduAssist);
		}else if(flaged.equals("m")){
			r = this.dao.updateEduAssistInfo(eduAssist);
		}
		if (r == 1){
			if (flaged.equals("m")){
				return ResultMapUtil.resultMapObject("true", "信息修改成功");
			}else{
				return ResultMapUtil.resultMapObject("true", "信息新增成功");
			}
		}else{
			return ResultMapUtil.resultMapObject("false", "处理成功");
		}
	}

	@Override
	public Object deleteEduAssistInfo(int id) {
		int r = this.dao.deleteEduAssistInfo(id);
		if (r == 1){
			return ResultMapUtil.resultMapObject("true", "信息删除成功");
		}else{
			return ResultMapUtil.resultMapObject("false", "信息删除失败");
		}
	}

	/**
	 * 根据指定的pid获取个人教育帮扶信息
	 */
	@Override
	public Map<String,Object> getEduAssistInfoByPid(int pid) {
		List<EduAssistPresent> eap = this.dao.getEduAssistInfoByPid(pid);
		if (eap != null){
			return ResultMapUtil.resultMapObject("success", "获取成功", eap);
		}else{
			return ResultMapUtil.resultMapObject("success", "获取失败");
		}
	}

	@Override
		public Map<String, Object> getSearchEduInfo(EduSearchInfo esi,
				int page, int rows, Integer[] dids, int f) {

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("startIndex", ((page - 1) * rows));
			map.put("rows", rows);
			map.put("did", dids);
			map.put("esi", esi);
			List<EduAssistPresent> retObj = this.dao.getSearchEduInfo(map);
			int ti = this.dao.getTotalSearchEduInfo(map);
			Map<String, Object> map2 = new HashMap<String, Object>();
			if (f == 0){
				//手机端
				map2.put("data", retObj);
			}else{
				//web端
				map2.put("rows", retObj);
			}
			map2.put("total", ti);
			map2.put("message", "成功");
			map2.put("success", "true");
			return map2;
		}


}
