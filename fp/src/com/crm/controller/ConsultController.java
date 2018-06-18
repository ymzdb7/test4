package com.crm.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crm.entity.ConsultInfoPresent;
import com.crm.entity.ConsultSearchInfo;
import com.crm.entity.ConsultType;
import com.crm.entity.UserInfo;
import com.crm.service.ConsultService;
import com.crm.service.CustomerService;
import com.crm.service.DeptService;
import com.crm.util.ResultMapUtil;
import com.sun.istack.internal.logging.Logger;

/* 
 *教育信息
 */
@Controller
@RequestMapping("/consult")
public class ConsultController {

	/* 日志 */
	Logger log = Logger.getLogger(ConsultController.class);
	@Resource
	private ConsultService service;
	@Resource
	private DeptService dservice;
	@Resource
	private CustomerService cservice;
		
	/**
	 * 根据pid的行政区划获得全部咨询信息
	 * @param page
	 * @param rows
	 * @param hs
	 * @param isPubed 0-获取未发布标识，1-获取已发布标识，2，获取全部数据
	 * @return
	 */
	@RequestMapping("/getConsultInfo.do")
	@ResponseBody
	public Map<String,Object> getConsultInfo(
		@RequestParam(value = "page", required = false) String page,
		@RequestParam(value = "rows", required = false) String rows,
		@RequestParam(value = "pid", required = false) Integer pid,
		@RequestParam(value = "isAns", required = false) Integer isAns,
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
		int oid = 0;
		int f = 0;
		if (us != null){
			f = 1;
			//oid = this.cservice.getDidByPid(us.getPid());
			oid = this.cservice.getOidByPid(us.getPid());
		}else{
			f = 0;
			//oid = this.cservice.getDidByPid((pid==null)?0:pid);
			oid = this.cservice.getOidByPid((pid==null)?0:pid);
		}
		
		return this.service.getConsultInfo(p, r, oid, f, (isAns==null)?2:isAns);
	}
	
	@RequestMapping("/searchInfo.do")
	@ResponseBody
	public Map<String,Object> getSearchInfo(
		@RequestParam(value = "page", required = false) String page,
		@RequestParam(value = "rows", required = false) String rows,
		@RequestParam(value = "pid", required = false) Integer pid,
		ConsultSearchInfo csi,
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
		int oid = 0;
		int f = 0;
		if (us != null){
			f = 1;
			//oid = this.cservice.getDidByPid(us.getPid());
			oid = this.cservice.getOidByPid(us.getPid());
		}else{
			f = 0;
			//oid = this.cservice.getDidByPid((pid==null)?0:pid);
			oid = this.cservice.getOidByPid((pid==null)?0:pid);
		}
		
		return this.service.getSearchInfo(p, r, oid, f, csi);
	}

	/**
	 * 根据指定的pid获得本pid发布的咨询信息
	 * @param pid
	 * @return
	 */
	@RequestMapping("/getConsultInfoByPid.do")
	@ResponseBody
	public Map<String,Object> getConsultInfoByPid(
			@RequestParam(value = "pid", required = true) Integer pid,
			HttpSession hs) {
		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		int ipid = 0;
		if (us != null){
			ipid = us.getPid();
		}else{
			ipid = ((pid==null)?0:pid);
		}
		
		return this.service.getConsultInfoByPid(ipid);
	}

	/**
	 * 根据指定的问题id获得发布的咨询信息
	 * @param id
	 * @return
	 */
	@RequestMapping("/getConsultInfoById.do")
	@ResponseBody
	public Map<String,Object> getConsultInfoById(
			@RequestParam(value = "id", required = true) Integer id,
			HttpSession hs) {
		return this.service.getConsultInfoById(id);
	}

	@RequestMapping("/saveConsultInfo.do")
	@ResponseBody
	public Object saveConsultInfo(ConsultInfoPresent cip,
			HttpSession hs) {
		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		int ipid = 0;
		if (us != null){
			ipid = us.getPid();
		}else{
			ipid = (cip.getPid());
		}
		cip.setAid(ipid);
        return this.service.saveConsultInfo(cip);
	}
	
	@RequestMapping("/addConsultInfo.do")
	@ResponseBody
	public Object addConsultInfo(ConsultInfoPresent cip,  
			HttpSession hs) {
		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		int ipid = 0;
		if (us != null){
			ipid = us.getPid();
		}else{
			ipid = (cip.getPid());
		}
		cip.setAid(ipid);
		//cip.setOid(this.cservice.getOidByPid(cip.getPid()));
        return this.service.addConsultInfo(cip);
	}
	
	/**
	 * web端专用
	 * @return
	 */
	@RequestMapping("/getConsultType.do")
	@ResponseBody
	public List<ConsultType> getConsultType(){
		return this.service.getConsultType();
	}

	/**
	 * 手机端专用
	 * @return
	 */
	@RequestMapping("/getConsultTypeForApp.do")
	@ResponseBody
	public Map<String, Object> getConsultTypeForApp(){
		List<ConsultType> o = this.service.getConsultType();
		if (o == null || o.size() == 0){
			return ResultMapUtil.resultMapObject(true, "获取列表失败");
		}else{
			return ResultMapUtil.resultMapObject(true, "获取列表成功", o);
		}
	}

	
	
	
	/**
	 * 评估设置保存接口：1-满意、2-比较满意、3-不满意
	 * @param id 咨询信息id号
	 * @param eval 评估等级，1-满意、2-比较满意、3-不满意
	 * @return
	 */
	@RequestMapping("/Evaluation.do")
	@ResponseBody
	public Object evaluation(int id,int eval){
		return this.service.evaluation(id,eval);
	}

}
