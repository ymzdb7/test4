package com.crm.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crm.entity.Dept;
import com.crm.entity.EduAssistPresent;
import com.crm.entity.EduPhaseType;
import com.crm.entity.EduSearchInfo;
import com.crm.entity.UserInfo;
import com.crm.service.CustomerService;
import com.crm.service.DeptService;
import com.crm.service.EduService;
import com.crm.util.ResultMapUtil;
import com.sun.istack.internal.logging.Logger;

/* 
 *教育信息
 */
@Controller
@RequestMapping("/edu")
public class EduController {

	/* 日志 */
	Logger log = Logger.getLogger(EduController.class);

	@Resource
	private EduService eservice;
	@Resource
	private CustomerService cservice;
	@Resource
	private DeptService dservice;
		
	/**
	 * 获取pid行政区划下的所有教育救助信息；
	 * @param page
	 * @param rows
	 * @param pid
	 * @return
	 */
	@RequestMapping("/eduInfo.do")
	@ResponseBody
	public Map<String,Object> getAllEduAssistInfo(
		@RequestParam(value = "page", required = false) String page,
		@RequestParam(value = "rows", required = false) String rows,
		@RequestParam(value = "pid", required = false) Integer pid,
		HttpSession hs) {
		
		int p = 1;//默认第一页
		int r = 10;//默认每页十行
		if (page==null || page.trim().equals("")){
			p = 1;
		}else{
			p = Integer.parseInt(page);
		}
		
		if (rows==null || rows.trim().equals("")){
			r = 10;
		}else{
			r = Integer.parseInt(rows);
		}
		
		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		
		int did = 0;
		int f = 0;
		if (us != null){
			f = 1;
			did = this.cservice.getDidByPid(us.getPid());
		}else{
			f = 0;
			did = this.cservice.getDidByPid((pid==null)?0:pid);
		}

		List<Dept> allDept = this.dservice.getAllDept();
		List<Dept> dept = new ArrayList<Dept>();
		dept.addAll(allDept);
		Integer[] arrDids = this.dservice.getChildDidByDid(allDept, did);

		return this.eservice.getAllEduAssistInfo(dept,p, r, arrDids, f);
	}
	
	@RequestMapping("/searchInfo.do")
	@ResponseBody
	public Map<String,Object> getSearchEduInfo(
		@RequestParam(value = "page", required = false) String page,
		@RequestParam(value = "rows", required = false) String rows,
		@RequestParam(value = "pid", required = false) Integer pid,
		EduSearchInfo esi,
		HttpSession hs) {
		
		int p = 1;//默认第一页
		int r = 10;//默认每页十行
		if (page==null || page.trim().equals("")){
			p = 1;
		}else{
			p = Integer.parseInt(page);
		}
		
		if (rows==null || rows.trim().equals("")){
			r = 10;
		}else{
			r = Integer.parseInt(rows);
		}
		
		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		int did = 0;
		int f = 0;
		if (us != null){
			f = 1;
			did = this.cservice.getDidByPid(us.getPid());
		}else{
			//手机端访问，调整查询值，只是用searchhname作为统一查询输入参数
			f = 0;
			did = this.cservice.getDidByPid((pid==null)?0:pid);
		}

		List<Dept> allDept = this.dservice.getAllDept();
		Integer[] arrDids = this.dservice.getChildDidByDid(allDept, did);

		return this.eservice.getSearchEduInfo(esi,p, r, arrDids, f);
	}

	/**
	 * 获取指定pid的教育救助信息
	 * @param page
	 * @param rows
	 * @param pid
	 * @return
	 */
	@RequestMapping("/getEduInfoByPid.do")
	@ResponseBody
	public Map<String,Object> getEduAssistInfoByPid(
			@RequestParam(value = "pid", required = true) Integer pid,
			HttpSession hs) {
		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		int ipid = 0;
		if (us != null){
			ipid = us.getPid();
		}else{
			ipid = ((pid==null)?0:pid);
		}
		
		return this.eservice.getEduAssistInfoByPid(ipid);
	}
	
	/**
	 * web专用
	 * @return
	 */
	@RequestMapping("/getEduPhaseType.do")
	@ResponseBody
	public Object getEduPhaseType() {
        List<EduPhaseType> hel = this.eservice.getAllEduPhaseType();
        
        return hel;
	}
	
	/**
	 * 手机端专用
	 * @return
	 */
	@RequestMapping("/getEduPhaseTypeForApp.do")
	@ResponseBody
	public Object getEduPhaseTypeForApp() {
        List<EduPhaseType> o = this.eservice.getAllEduPhaseType();
		if (o == null || o.size() == 0){
			return ResultMapUtil.resultMapObject(true, "获取列表失败");
		}else{
			return ResultMapUtil.resultMapObject(true, "获取列表成功", o);
		}
	}
	
	@RequestMapping("/addEduAssistInfo.do")
	@ResponseBody
	public Object addEduAssistInfo(EduAssistPresent eduAssist,String flaged) {
		
        return this.eservice.addEduAssistInfo(eduAssist,flaged);
	}
	
	@RequestMapping("/deleteEduAssistInfo.do")
	@ResponseBody
	public Object deleteEduAssistInfo(int id) {
		
        return this.eservice.deleteEduAssistInfo(id);
	}
}
