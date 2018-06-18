package com.crm.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crm.auth.Auth;
import com.crm.entity.CustomerSearchInfo;
import com.crm.entity.Dept;
import com.crm.entity.HealthyType;
import com.crm.entity.MenuPresent;
import com.crm.entity.Org;
import com.crm.entity.RelationType;
import com.crm.entity.Role;
import com.crm.entity.RoleListPresent;
import com.crm.entity.UserInfo;
import com.crm.entity.WorkType;
import com.crm.service.CustomerService;
import com.crm.service.DeptService;
import com.crm.service.HealthyTypeService;
import com.crm.service.RelationTypeService;
import com.crm.service.WorkTypeService;
import com.crm.util.ResultMapUtil;
import com.sun.istack.internal.logging.Logger;

/* 帮扶对象管理相关对应的controller
 * author:韦文峰
 * date:2017.11.10
 */
@Controller
@RequestMapping("/cust")
// 个人管理
public class CustomerController {

	/* 日志 */
	Logger log = Logger.getLogger(CustomerController.class);

	@Resource
	private CustomerService cservice;
	@Resource
	private HealthyTypeService hservice;
	@Resource
	private WorkTypeService wservice;
	@Resource
	private RelationTypeService rservice;
	@Resource
	private DeptService dservice;
		
	/**
	 *  根据pid的行政区划获取该行政区划下的全部农户信息	
	 *  返回JSON格式数据给前端
	 *  WEB前端专用
	 * @param page
	 * @param rows
	 * @param pid searchInfo
	 * @return
	 */
      
	@RequestMapping("/info.do")
	@ResponseBody
	public Map<String,Object> getAllCustomerInfo(
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
		
		List<Dept> ls = this.dservice.getAllDept();

		List<Dept> dept = new ArrayList<Dept>();
		dept.addAll(ls);
		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		int did = 0;
		if (us != null){
			did = this.getDidByPid(us.getPid());
		}else{
			did = this.getDidByPid((pid==null)?0:pid);
		}
		Integer[] arrInt = this.dservice.getChildDidByDid(ls, did);

		return this.cservice.getAllCustomerInfo(dept,p, r, arrInt);
	}
	
	/**
	 * 搜索任何成员信息处理
	 * @param page
	 * @param rows
	 * @param pid
	 * @param si
	 * @param hs
	 * @return
	 */
      
	@RequestMapping("/searchInfo.do")
	@ResponseBody
	public Map<String,Object> getSearchCustomerInfo(
		@RequestParam(value = "page", required = false) String page,
		@RequestParam(value = "rows", required = false) String rows,
		@RequestParam(value = "pid", required = false) Integer pid,
		CustomerSearchInfo si,
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
		
		List<Dept> ls = this.dservice.getAllDept();

		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		int did = 0;
		int f = 0;
		if (us != null){
			f = 1;
			did = this.getDidByPid(us.getPid());
		}else{
			f = 0;
			did = this.getDidByPid((pid==null)?0:pid);
		}
		Integer[] arrInt = this.dservice.getChildDidByDid(ls, did);

		//最后一个参数false，表示搜索所有信息
		return this.cservice.getSearchCustomerInfo(si, p, r, f, arrInt,false);
	}
	
	/**
	 * 搜索任何成员信息处理,APP专用
	 * @param page
	 * @param rows
	 * @param pid
	 * @param searchPara
	 * @return
	 */
      
	@RequestMapping("/searchInfoForApp.do")
	@ResponseBody
	public Map<String,Object> getSearchCustomerInfoForApp(
		@RequestParam(value = "page", required = false) String page,
		@RequestParam(value = "rows", required = false) String rows,
		@RequestParam(value = "pid", required = false) Integer pid,
		String searchPara,
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
		
		List<Dept> ls = this.dservice.getAllDept();

		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		int did = 0;
		int f = 0;
		if (us != null){
			f = 1;
			did = this.getDidByPid(us.getPid());
		}else{
			f = 0;
			did = this.getDidByPid((pid==null)?0:pid);
		}
		Integer[] arrInt = this.dservice.getChildDidByDid(ls, did);

		//最后一个参数false，表示搜索所有信息
		return this.cservice.getSearchCustomerInfoForApp(searchPara, p, r, f,arrInt,false);
	}

	/**
	 * 搜索户主信息处理
	 * @param page
	 * @param rows
	 * @param pid
	 * @param si
	 * @param hs
	 * @return
	 */
      
	@RequestMapping("/searchHolderInfo.do")
	@ResponseBody
	public Map<String,Object> getSearchHolderInfo(
		@RequestParam(value = "page", required = false) String page,
		@RequestParam(value = "rows", required = false) String rows,
		@RequestParam(value = "pid", required = false) Integer pid,
		CustomerSearchInfo si,
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
		
		List<Dept> ls = this.dservice.getAllDept();

		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		int did = 0;
		int f = 0;
		if (us != null){
			f = 1;
			did = this.getDidByPid(us.getPid());
		}else{
			f = 0;
			did = this.getDidByPid((pid==null)?0:pid);
		}
		Integer[] arrInt = this.dservice.getChildDidByDid(ls, did);

		//最后一个参数true，表示只搜索户主信息
		return this.cservice.getSearchCustomerInfo(si, p, r, f, arrInt,true);
	}
	
	/**
	 * 搜索户主信息（APP专用）
	 * @param page
	 * @param rows
	 * @param pid
	 * @param searchPara
	 * @param hs
	 * @return
	 */
      
	@RequestMapping("/searchHolderInfoForApp.do")
	@ResponseBody
	public Map<String,Object> getSearchHolderInfoForApp(
		@RequestParam(value = "page", required = false) String page,
		@RequestParam(value = "rows", required = false) String rows,
		@RequestParam(value = "pid", required = false) Integer pid,
		String searchPara,
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
		
		List<Dept> ls = this.dservice.getAllDept();

		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		int did = 0;
		int f = 0;
		if (us != null){
			f = 1;
			did = this.getDidByPid(us.getPid());
		}else{
			f = 0;
			did = this.getDidByPid((pid==null)?0:pid);
		}
		Integer[] arrInt = this.dservice.getChildDidByDid(ls, did);

		//最后一个参数true，表示只搜索户主信息
		return this.cservice.getSearchCustomerInfoForApp(searchPara, p, r, f,arrInt,true);
	}
	
	/**
	 * 同@RequestMapping("/allCustomerInfo.do") 功能
	 * 手机客户端专用
	 * @param page
	 * @param rows
	 * @param pid
	 * @param hs
	 * @return
	 */
      
	@RequestMapping("/allCustomerInfo.do")
	@ResponseBody
	public Map<String,Object> getAllCustomerInfoForApp(
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
		
		List<Dept> ls = this.dservice.getAllDept();

		List<Dept> dept = new ArrayList<Dept>();
		dept.addAll(ls);
		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		int did = 0;
		if (us != null){
			did = this.getDidByPid(us.getPid());
		}else{
			did = this.getDidByPid((pid==null)?0:pid);
		}
		Integer[] arrInt = this.dservice.getChildDidByDid(ls, did);

		return this.cservice.getAllCustomerInfoForApp(dept,p, r, arrInt);
	}
	
	/**
	 * 根据pid获得个人信息
	 * @param pid
	 * @return
	 */
      
	@RequestMapping("/getCustomerInfoByPid.do")
	@ResponseBody
	public Map<String,Object> getCustomerInfoByPid(
			@RequestParam(value = "pid", required = false) Integer pid,
			HttpSession hs) {
		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		int pi=(us!=null)?us.getPid():pid;
		return this.cservice.getCustomerInfoByPid((us!=null)?us.getPid():pid);
	}
	
	/**
	 * 根据户主（holder）号获取指定用户pid对应行政区划下的的所有家庭成员信息
	 * @param page
	 * @param rows
	 * @param pid
	 * @param holder
	 * @return
	 */
      
	@RequestMapping("/familyMemberInfo.do")
	@ResponseBody
	public Map<String,Object> familyMemberInfo(
		@RequestParam(value = "page", required = false) String page,
		@RequestParam(value = "rows", required = false) String rows,
		@RequestParam(value = "pid", required = false) Integer pid,
		String holder, 
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
		
		int isHolder = 0;
		if (!holder.equals("")){
			isHolder = Integer.valueOf(holder);
		}
		
		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		
		int did = 0;
		int f = 0;
		if (us != null){
			f = 1;
			did = this.getDidByPid(us.getPid());
		}else{
			f = 0;
			did = this.getDidByPid((pid==null)?0:pid);
		}
		//查询所有的地级
		List<Dept> ls = this.dservice.getAllDept();

		List<Dept> dept = new ArrayList<Dept>();
		dept.addAll(ls);
		Integer[] arrInt = this.dservice.getChildDidByDid(ls, did);

		return this.cservice.getAllCustomerInfoByHolder(dept,p, r, arrInt,isHolder, f);
	}
	
	/**
	 * 获得指定pid对应行政区划下的所有户主信息列表
	 * @param page
	 * @param rows
	 * @param pid
	 * @return
	 */
      
	@RequestMapping("/holderInfo.do")
	@ResponseBody
	public Map<String,Object> getAllHolderinfo(
		@RequestParam(value = "page", required = false) String page,
		@RequestParam(value = "rows", required = false) String rows,
		@RequestParam(value = "pid", required = false) Integer pid, HttpSession hs) {
		
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
			did = this.getDidByPid(us.getPid());
		}else{
			f = 0;
			did = this.getDidByPid((pid==null)?0:pid);
		}
		List<Dept> ls = this.dservice.getAllDept();

		List<Dept> dept = new ArrayList<Dept>();
		dept.addAll(ls);
		Integer[] arrInt = this.dservice.getChildDidByDid(ls, did);

		return this.cservice.getAllHolderInfo(dept,p, r, arrInt, f);
	}
	
	/**
	 * 获取所有工作人员账户信息
	 * @param page
	 * @param rows
	 * @param pid
	 * @param allUser =0 
	 * @return
	 */
      
	@RequestMapping("/mngUser.do")
	@ResponseBody
	public Map<String,Object> getAllMngUserInfo(
		@RequestParam(value = "page", required = false) String page,
		@RequestParam(value = "rows", required = false) String rows,
		@RequestParam(value = "pid", required = false) Integer pid,
		int allUser, HttpSession hs) {
		
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
		if (us != null){
			did = this.getDidByPid(us.getPid());
		}else{
			did = this.getDidByPid((pid==null)?0:pid);
		}
		List<Dept> ls = this.dservice.getAllDept();

		List<Dept> dept = new ArrayList<Dept>();
		dept.addAll(ls);
		//获取当前用户机构id的所有子机构id号
		Integer[] arrInt = this.dservice.getChildDidByDid(ls, did);

		return this.cservice.getAllMngUserInfo(dept,p, r, arrInt, allUser);
	}
	
	/**
	 * 获取pid对应行政区划下的全部户主信息
	 * @param pid
	 * @return
	 */
      
	@RequestMapping("/getHolder.do")
	@ResponseBody
	public Object getHoldersByDids(
			@RequestParam(value = "pid", required = false) Integer pid,
			HttpSession hs) {
		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		int did = 0;
		if (us != null){
			did = this.getDidByPid(us.getPid());
		}else{
			did = this.getDidByPid((pid==null)?0:pid);
		}
		List<Dept> ls = this.dservice.getAllDept();
		//获取部门id
		Integer[] dids = this.dservice.getChildDidByDid(ls, did);
		return this.cservice.getHoldersByDids(dids);

	}
	
	/*
	 * 获取大病类型用户对象
	 * Web端专用
	 */
	@RequestMapping("/getAllHealthyType.do")
	@ResponseBody
	public Object getAllHealthyType() {
		List<HealthyType> o = this.hservice.getAllHealthyType();
		return o;
	}

	/*
	 * 获取大病类型用户对象
	 * 手机端专用
	 */
	@RequestMapping("/getAllHealthyTypeForApp.do")
	@ResponseBody
	public Object getAllHealthyTypeForApp() {
		List<HealthyType> o = this.hservice.getAllHealthyType();
		if (o == null || o.size() == 0){
			return ResultMapUtil.resultMapObject(true, "获取列表失败");
		}else{
			return ResultMapUtil.resultMapObject(true, "获取列表成功", o);
		}
	}

	/*
	 * 获取工作类型用户对象
	 * Web端专用
	 */
	@RequestMapping("/getAllWorkType.do")
	@ResponseBody
	public Object getAllWorkType() {
        return this.wservice.getAllWorkType();
	}

	/*
	 * 获取工作类型用户对象
	 * 手机端专用
	 */
	@RequestMapping("/getAllWorkTypeForApp.do")
	@ResponseBody
	public Object getAllWorkTypeForApp() {
		List<WorkType> o = this.wservice.getAllWorkType();
		if (o == null || o.size() == 0){
			return ResultMapUtil.resultMapObject(true, "获取列表失败");
		}else{
			return ResultMapUtil.resultMapObject(true, "获取列表成功", o);
		}
	}

	/*
	 * 获取与户主关系类型用户对象
	 * Web端专用
	 */
	@RequestMapping("/getAllRelationType.do")
	@ResponseBody
	public Object getAllRelationType() {
        return this.rservice.getAllRelationType();
	}

	/*
	 * 获取与户主关系类型用户对象
	 * 手机端专用
	 */
	@RequestMapping("/getAllRelationTypeForApp.do")
	@ResponseBody
	public Object getAllRelationTypeForApp() {
		List<RelationType> o = this.rservice.getAllRelationType();
		if (o == null || o.size() == 0){
			return ResultMapUtil.resultMapObject(true, "获取列表失败");
		}else{
			return ResultMapUtil.resultMapObject(true, "获取列表成功", o);
		}
	}

	/**
	 * 密码重置,设置密码为123456
	 * @param pid
	 * @return
	 */
      
	@RequestMapping("/pwdReset.do")
	@ResponseBody
	public Map<String,Object>  pwdReset(int pid) {
		return this.cservice.pwdReset(pid);
	}

	/**
	 * 密码验证，页面专用
	 * @param pid
	 * @return
	 */
      
	@RequestMapping("/checkPwd.do")
	@ResponseBody
	public Boolean  checkPwd(String phone,String pwd,int pid) {
		return this.cservice.checkPwd(phone,pwd);
	}
	
	/**
	 * 密码验证手机客户端专用
	 * @param phone
	 * @param pwd
	 * @param pid
	 * @return
	 */
      
	@RequestMapping("/pwdCheck.do")
	@ResponseBody
	public Map<String,Object>  pwdCheck(String phone,String pwd,int pid) {
		boolean b = this.cservice.checkPwd(phone,pwd);
		if (b == true) {
			return ResultMapUtil.resultMapObject(true, "密码验证成功");   
		} else {
			//有用户使用
			return ResultMapUtil.resultMapObject(false, "密码验证失败");
		}
	}


	/**
	 * 修改密码
	 * 
	 * @param pid
	 * @return
	 */
      
	@RequestMapping("/pwdModify.do")
	@ResponseBody
	public Map<String, Object> updatePwd(String opwd,String phone, String upwd, int pid) {
		return this.cservice.updatePwd(opwd,phone, upwd, pid);
	}

	/*
	 * 在方法上使用注解@ResponseBody的作用： 1.该方法的返回信息作为response(responseText)中的内容返回给请求
	 * 2.可将该方法的返回值Map或List转成json格式 （在return之前，System.out.println(map)依然是原格式，
	 * 但return到的页面得到的是json格式
	 */
	/* 新增加客户 */
	@RequestMapping("/addCustomer.do")
	@ResponseBody
	public Object addCustomer(UserInfo user,String flaged) {
		return this.cservice.addCustomer(user,flaged);
	}

	/**
	 * 检查身份证号码是否重复
	 * @param cid
	 * @return
	 */
	@RequestMapping("/checkCidDup.do")
	@ResponseBody
	public Object checkCidDup(String cid) {
		UserInfo userInfo = new UserInfo();
		userInfo.setCid(cid);;
		return this.cservice.checkCidDup(userInfo);
	}
	
	@RequestMapping("/checkPhoneDup.do")
	@ResponseBody
	public Object checkPhoneDup(String phone) {
		UserInfo userInfo = new UserInfo();
		userInfo.setPhone(phone);
		return this.cservice.checkPhoneDup(userInfo);
	}
	
      
	@RequestMapping("/getPageDid.do")
	@ResponseBody
	public Object getPageDid(@RequestParam(value = "pid", required = false) Integer pid,
			HttpSession hs) {
		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		int did = 0;
		if (us != null){
			did = this.getDidByPid(us.getPid());
		}else{
			did = this.getDidByPid((pid==null)?0:pid);
		}
		List<Dept> ld = this.dservice.getAllDept();

		List<Dept> listDept = new ArrayList<Dept>();
		listDept.addAll(ld);
		Integer[] arrInt = this.dservice.getChildDidByDid(ld, did);
		
		return this.cservice.getPageDid(listDept,arrInt);
	}
	
	/**
	 * web端专用
	 * @return
	 */
	@RequestMapping("/getOrg.do")
	@ResponseBody
	public List<Org> getOrg() {
		return this.cservice.getOrg();
	}
	/**
	 * 手机端专用
	 * @return
	 */
	@RequestMapping("/getOrgForApp.do")
	@ResponseBody
	public Map<String, Object> getOrgForApp(String conTypeId) {
		List<Org> o =  this.cservice.getOrg();
		if (o == null || o.size() == 0){
			return ResultMapUtil.resultMapObject(true, "获取列表失败");
		}else{
			return ResultMapUtil.resultMapObject(true, "获取列表成功", o);
		}
	}
	
	/**
	 * 手机端专用
	 * @return
	 */
	@RequestMapping("/getOrgForApp1.do")
	@ResponseBody
	public Map<String, Object> getOrgForApp1(String conTypeId) {
		
		Org o =  this.cservice.getOrg2(Integer.parseInt(conTypeId));
		if (o == null){
			return ResultMapUtil.resultMapObject(true, "获取列表失败");
		}else{
			return ResultMapUtil.resultMapObject(true, "获取列表成功", o);
		}
	}
	
	
	
	@RequestMapping("/deleteCustomer.do")
	@ResponseBody
	public Object deleteCustomer(UserInfo userInfo){
		return this.cservice.deleteCustomer(userInfo);
	}
	
      
	@RequestMapping("/getRoleUserMap.do")
	@ResponseBody
	public List<RoleListPresent> getRoleUserMapByPid(Integer pid) {
		return this.cservice.getRoleUserMapByPid(pid);
	}
	
      
	@RequestMapping("/saveRoleUserMap.do")
	@ResponseBody
	public Map<String, Object> saveRoleUserMap(Integer pid,Integer rid) {
		return this.cservice.saveRoleUserMap(pid,rid);
	}
	
      
	@RequestMapping("/updatePhone.do")
	@ResponseBody
	public Object updatePhone(String oldPhone,String newPhone,String pwd, int pid){
		return this.cservice.updatePhone(oldPhone,newPhone,pwd,pid);
	}
	
      
	private int getDidByPid(int pid){
		return this.cservice.getDidByPid(pid);
	}

}
