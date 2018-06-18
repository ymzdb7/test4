package com.crm.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.crm.entity.Dept;
import com.crm.entity.HtyPresent;
import com.crm.entity.HtySearchInfo;
import com.crm.util.DateUtil;
import com.crm.util.ResultMapUtil;
import com.crm.dao.HtyDao;
import com.sun.istack.internal.logging.Logger;

@Service
public class HtyServiceImpl implements HtyService {

	/* 日志 */
	Logger log = Logger.getLogger(HtyService.class);

	@Resource
	private HtyDao dao;

	@Override
	public Map<String, Object> getAllHtyAssistInfo(List<Dept> allDept,
			int page, int rows, Integer[] dids, int f) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startIndex", ((page - 1) * rows));
		map.put("rows", rows);
		map.put("did", dids);
		List<HtyPresent> retObj = this.dao.getAllHtyAssistInfo(map);
		int countSize = 0;
		Integer ti = this.dao.getTotalHtyAssistInfo(map);
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

	@Override
	public Object addHtyAssistInfo(HtyPresent htyPresent, String flaged) {
		
		Date date = DateUtil.StrToDate(htyPresent.getPaymentTime());
		htyPresent.setPayment_time(date);
		
		int r = 0;
		if (flaged == null || flaged.trim().equals("") ||flaged.equals("a")){
			r = this.dao.addHtyAssistInfo(htyPresent);
		}else if(flaged.equals("m")){
			r = this.dao.updateHtyAssistInfo(htyPresent);
		}
		if (r == 1){
			if (flaged.equals("m")){
				return ResultMapUtil.resultMapObject("true","修改信息成功");
			}else{
				return ResultMapUtil.resultMapObject("true","增加信息成功");
			}
		}else{
			return ResultMapUtil.resultMapObject("false","操作失败");
		}
	}

	@Override
	public Object deleteHtyAssistInfo(int id) {
		int r = this.dao.deleteHtyAssistInfo(id);
		if (r == 1){
			return ResultMapUtil.resultMapObject("true","删除信息成功");
		}else{
			return ResultMapUtil.resultMapObject("false","失败");
		}
	}

	/**
	 * 根据指定的pid大病救助信息
	 */
	@Override
	public Map<String, Object> getHtyAssistInfoByPid(int pid) {
		List<HtyPresent> hp =  this.dao.getHtyAssistInfoByPid(pid);
		if (hp == null){
			return ResultMapUtil.resultMapObject("false", "失败");
		}else{
			return ResultMapUtil.resultMapObject("true", "成功", hp);
		}
		
	}

	/**
	 * 搜索用
	 */
	@Override
	public Map<String, Object> getSearchHtyAssistInfo(HtySearchInfo hsi,
			int page, int rows, Integer[] arrDids, int f) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startIndex", ((page - 1) * rows));
		map.put("rows", rows);
		map.put("did", arrDids);
		map.put("hsi", hsi);
		List<HtyPresent> retObj = this.dao.getSearchHtyAssistInfo(map);

		int ti = this.dao.getTotalSearchHtyAssistInfo(map);
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
