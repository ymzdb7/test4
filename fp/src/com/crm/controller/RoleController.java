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

import com.crm.entity.Dept;
import com.crm.entity.HealthyType;
import com.crm.entity.MenuPresent;
import com.crm.entity.RelationType;
import com.crm.entity.Role;
import com.crm.entity.UserInfo;
import com.crm.entity.WorkType;
import com.crm.service.CustomerService;
import com.crm.service.DeptService;
import com.crm.service.HealthyTypeService;
import com.crm.service.RelationTypeService;
import com.crm.service.RoleService;
import com.crm.service.WorkTypeService;
import com.sun.istack.internal.logging.Logger;

/* 帮扶对象管理相关对应的controller
 * author:韦文峰
 * date:2017.11.10
 */
@Controller
@RequestMapping("/role")
// 个人管理
public class RoleController {

	/* 日志 */
	Logger log = Logger.getLogger(RoleController.class);

	@Resource
	private RoleService service;
	
	/**
	 * 返回角色列表
	 * @param page 当前页的最小序号
	 * @param rows 每页的行数
	 * @return
	 */
	@RequestMapping("/roleList.do")
	@ResponseBody
	public Map<String, Object>  getRoleList(
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows
			) {
		
		if (page==null || page.trim().equals("")){
			page = "1";
		}
		
		if (rows==null || rows.trim().equals("")){
			rows = "10";
		}

		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("startIndex", ((Integer.valueOf(page)-1)*Integer.valueOf(rows)));
		map.put("rows", Integer.valueOf(rows));

		List<Role> list = this.service.getRoleList(map);
		int total = this.service.getTotalRole();

		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("rows", list);
		map2.put("total", total);

		return map2;
	}
	
	/**
	 * 保存角色
	 * @param role
	 * @return
	 */
	@RequestMapping("/saveRole.do")
	@ResponseBody
	public Map<String,String> saveRole(Role role) {
		return this.service.saveRole(role);
	}
	
	/**
	 * 删除角色
	 * @param role
	 * @return
	 */
	@RequestMapping("/deleteRole.do")
	@ResponseBody
	public Map<String,String> deleteRole(String rids) {
		return this.service.deleteRole(rids); 
	}

	/**
	 * 获取最大的RoleID
	 * @param role
	 * @return
	 */
	@RequestMapping("/getTopRoleID.do")
	@ResponseBody
	public Map<String,String> getTopRoleID() {
		return this.service.getTopRoleID();
	}
	
	@RequestMapping("/checkRoleIsUsed.do")
	@ResponseBody
	public Map<String,String> checkRoleIsUsed(Integer rid) {
		return this.service.checkRoleIsUsed(rid);
	}
		
	/**
	 * 根据角色ID得到全部菜单信息，并且标注相应菜单想是否被checked，json格式
	 * @param rid
	 * @return
	 */
	@RequestMapping("/getMenuByRid.do")
	@ResponseBody
	public List<MenuPresent> getMenuByRid(Integer rid) {
		return this.service.getMenuByRid(rid);
	}
	
	/**
	 * 保存角色与菜单的对应关系
	 * @param rids，客户端发送的mid的数组
	 * @return
	 */
	@RequestMapping("/saveMenuRoleMap.do")
	@ResponseBody
	public Map<String,Object> saveMenuRoleMap(String mids,Integer rid) {
		String[] strMids = mids.split(",");
		Integer[] imids = null;
		if (strMids.length !=0){
			if (mids != null || !mids.trim().equals("")){
				imids = new Integer[strMids.length];
				for (int i=0; i<strMids.length; i++){
					imids[i] = Integer.valueOf(strMids[i].equals("")?"0":strMids[i]);
				}
			}
		}
		return this.service.saveMenuRoleMap(imids,rid);
	}
	
}
