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
import com.crm.entity.HtyPresent;
import com.crm.entity.HtySearchInfo;
import com.crm.entity.UserInfo;
import com.crm.service.CustomerService;
import com.crm.service.DeptService;
import com.crm.service.HtyService;
import com.sun.istack.internal.logging.Logger;

/* 
 *大病救助信息
 */
@Controller
@RequestMapping("/hty")
public class HtyController {

	/* 日志 */
	Logger log = Logger.getLogger(HtyController.class);

	@Resource
	private HtyService service;
	@Resource
	private DeptService dservice;
	@Resource
	private CustomerService cservice;
		
	/**
	 * 获取pid行政区划下的大病救助信息
	 * @param page
	 * @param rows
	 * @param pid
	 * @return
	 */
	@RequestMapping("/htyInfo.do")
	@ResponseBody
	public Map<String,Object> getAllHtyAssistInfo(
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
			f =1;
			did = this.cservice.getDidByPid(us.getPid());
		}else{
			f = 0;
			did = this.cservice.getDidByPid((pid==null)?0:pid);
		}

		List<Dept> allDept = this.dservice.getAllDept();
		List<Dept> dept = new ArrayList<Dept>();
		dept.addAll(allDept);
		Integer[] arrDids = this.dservice.getChildDidByDid(allDept,did);

		return this.service.getAllHtyAssistInfo(dept,p, r, arrDids, f);
	}
		
	@RequestMapping("/searchInfo.do")
	@ResponseBody
	public Map<String,Object> getSearchHtyAssistInfo(
		@RequestParam(value = "page", required = false) String page,
		@RequestParam(value = "rows", required = false) String rows,
		@RequestParam(value = "pid", required = false) Integer pid,
		HtySearchInfo hsi,
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
			f =1;
			did = this.cservice.getDidByPid(us.getPid());
		}else{
			//手机端访问，调整查询值，只是用searchhname作为统一查询输入参数
			f = 0;
			did = this.cservice.getDidByPid((pid==null)?0:pid);
		}

		List<Dept> allDept = this.dservice.getAllDept();
		List<Dept> dept = new ArrayList<Dept>();
		dept.addAll(allDept);
		Integer[] arrDids = this.dservice.getChildDidByDid(allDept,did);

		return this.service.getSearchHtyAssistInfo(hsi,p, r, arrDids, f);
	}
		
	/**
	 * 获取指定pid下面的大病救助信息
	 * @param pid
	 * @return
	 */
	@RequestMapping("/getHtyInfoByPid.do")
	@ResponseBody
	public Map<String,Object> getHtyAssistInfoByPid(
			@RequestParam(value = "pid", required = true) Integer pid,
			HttpSession hs) {
		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		int ipid = 0;
		if (us != null){
			ipid = us.getPid();
		}else{
			ipid = ((pid==null)?0:pid);
		}
		
		return this.service.getHtyAssistInfoByPid(ipid);
	}
		
	@RequestMapping("/addHtyAssistInfo.do")
	@ResponseBody
	public Object addHtyAssistInfo(HtyPresent htyPresent,String flaged) {
		
        return this.service.addHtyAssistInfo(htyPresent,flaged);
	}
	
	@RequestMapping("/deleteHtyAssistInfo.do")
	@ResponseBody
	public Object deleteHtyAssistInfo(int id) {
		
        return this.service.deleteHtyAssistInfo(id);
	}
}
