package com.crm.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crm.entity.Dept;
import com.crm.entity.Org;
import com.crm.entity.UserInfo;
import com.crm.service.DeptService;
import com.crm.service.LoginService;
import com.crm.util.ResultMapUtil;

@Controller
@RequestMapping("/dept")
public class DeptController {

	@Resource
	DeptService service;
	@Resource
	LoginService loginService;

	/* 新增部门信息(联合查询dept_info) */
	@RequestMapping(value="/saveDept.do")
	@ResponseBody
	public Map<String,String> saveDept(Dept dept) {
		return this.service.saveDept(dept);
	//@ResponseBody
	//public ResponseEntity<Map<String,String>> saveDept(Dept dept) {
	//	Map<String,String> map = this.service.saveDept(dept);
	//	return new ResponseEntity<Map<String,String>>(map,new HttpHeaders(),HttpStatus.OK);
	}
	
	/* 部门信息：获取部门信息(联合查询dept_info) */
	@RequestMapping("/deptInfo.do")
	@ResponseBody
	public Object getDeptInfo(
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows,
			HttpSession hs) {

		if (page==null || page.trim().equals("")){
			page = "1";
		}
		
		if (rows==null || rows.trim().equals("")){
			rows = "10";
		}
		
		UserInfo us = (UserInfo)hs.getAttribute("userInfo");
		int did = 0;
		int f = 0;
		if (us != null){
			f = 1;
		}else{
			f = 0;
		}		
		
		return this.service.getDeptInfo(Integer.valueOf(page),Integer.valueOf(rows),f);
	}
	
	/**
	 * 获取用户级别
	 * @return
	 */
	@RequestMapping("/getAllLevel.do")
	@ResponseBody
	public Object getAllLevel(){
		return this.service.getAllLevel();
	}
	
	@RequestMapping("/getMaxDId.do")
	@ResponseBody
	public Object getMaxDId(){
		return this.service.getMaxDid();
	}

	/**
	 * 获取可选父亲部门id和名称，根据级别获取上级别的机构名称
	 * @return
	 */
	@RequestMapping("/getSuperDept.do")
	@ResponseBody
	public Object getSuperDept(String cLevel){
		if (cLevel == null ||cLevel.trim().equals("")) return null;
		return this.service.getSuperDept(cLevel);
		//return null;
	}

	/**
	 * 检查部门是否在使用，如果使用返回true，否则返回false
	 * @param rid
	 * @return
	 */
	@RequestMapping("/checkDeptIsUsed.do")
	@ResponseBody
	public Map<String,String> checkDeptIsUsed(Integer did) {
		return this.service.checkDeptIsUsed(did);
	}
	
	/**
	 * 根据部门DID编号删除部门
	 * @param role
	 * @return
	 */
	@RequestMapping("/deleteDept.do")
	@ResponseBody
	public Map<String,String> deleteDept(Integer did) {
		return this.service.deleteDept(did); 
	}

	@RequestMapping("/getMaxOId.do")
	@ResponseBody
	public Object getMaxOId(){
		return this.service.getMaxOid();
	}

	/* 新增部门信息(联合查询dept_info) */
	@RequestMapping("/saveOrg.do")
	@ResponseBody
	public Object saveOrg(Org org) {
		return this.service.saveOrg(org);
	}
	@RequestMapping("/deleteOrg.do")
	@ResponseBody
	public Map<String,String> deleteOrg(Integer oid) {
		return this.service.deleteOrg(oid); 
	}


	/**
	 * 手机端专用获取宿城区镇及镇上人的信息List
	 * @return
	 */
	@RequestMapping("/getDeptList.do")
	@ResponseBody
	public Map<String, Object> getDeptList() {
		List<Dept> list=new ArrayList<Dept>();
		List<Dept> dept =  this.service.getDeptList();
		if (dept == null || dept.size() == 0){
			return ResultMapUtil.resultMapObject(true, "获取列表失败");
		}else{
			for (int i = 0; i < dept.size(); i++) {
				
				int did=dept.get(i).getDid();
				List<UserInfo> userInfoList=this.loginService.getUserInfo1(did);
				if(userInfoList.size()!=0){
					dept.get(i).setUserInfo(userInfoList);
					list.add(dept.get(i));
				}
				
			}
		
			return ResultMapUtil.resultMapObject(true, "获取列表成功", list);
			
		}
	}
	
	
	/**
	 * 手机端专用获取宿城区相应镇下的所有村及村上的人信息List
	 * @return
	 */
	@RequestMapping("/getDeptVillaList.do")
	@ResponseBody
	public Map<String, Object> getDeptVillaList(String did) {
		int superDid=Integer.parseInt(did);
		List<Dept> dvilist=new ArrayList<Dept>();
		List<Dept> deptVillaList =  this.service.getDeptVillaList(superDid);
		if (deptVillaList == null || deptVillaList.size() == 0){
			return ResultMapUtil.resultMapObject(true, "获取列表失败");
		}else{
			for (int i = 0; i < deptVillaList.size(); i++) {
				
				int did1=deptVillaList.get(i).getDid();
				List<UserInfo> userInfoList=this.loginService.getUserInfo1(did1);
				if(userInfoList.size()!=0){
					deptVillaList.get(i).setUserInfo(userInfoList);
					dvilist.add(deptVillaList.get(i));
				}
				
			}
		
			return ResultMapUtil.resultMapObject(true, "获取列表成功", dvilist);
			
		}
	}
	
	
}
