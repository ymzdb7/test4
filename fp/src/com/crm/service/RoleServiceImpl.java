package com.crm.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.crm.controller.CustomerController;
import com.crm.dao.RoleDao;
import com.crm.entity.Menu;
import com.crm.entity.MenuPresent;
import com.crm.entity.MenuRoleMap;
import com.crm.entity.Role;
import com.sun.istack.internal.logging.Logger;

@Service
public class RoleServiceImpl implements RoleService {

	/* 日志 */
	Logger log = Logger.getLogger(RoleService.class);

	@Resource
	RoleDao dao;
	
	/**
	 * 获取角色信息
	 */
	@Override
	public List<Role> getRoleList(Map map){
		
		return dao.getRoleList( map);
	}
	
	/**
	 * 获取角色总数数量
	 * @param sdid
	 * @return
	 */
	@Override
	public int getTotalRole(){
		return this.dao.getTotalRole();
	}

	/**
	 * 保存角色信息
	 */
	@Override
	public Map<String,String> saveRole(Role role){
		 
		int result = this.dao.saveRole(role);
		Map<String,String> map = new HashMap<String,String>();

		if (result == 1) {
			map.put("success", "true");
		}else{
			map.put("success", "false");
		}
		return map;
	}
	
	/**
	 * 删除角色
	 * @param rids
	 * @return
	 */
	@Override
	public Map<String,String> deleteRole(String rids){
		String[] strArr = rids.split(",");
		Map<String,Integer> map = new HashMap<String,Integer>();
		for (String s : strArr){
			map.put("rid", Integer.valueOf(s));
		}
		
		int result = this.dao.deleteRole(map);
		Map<String,String> map1 = new HashMap<String,String>();
		if (result == 1) {
			map1.put("success", "true");
		}else{
			map1.put("success", "false");
		}
		return map1;
	}
	
	/**
	 * 获取角色ID的最大自增值
	 */
	public Map<String,String> getTopRoleID() {
		 int topRid = this.dao.getTopRoleID();
		 Map<String,String> map = new HashMap<String,String>();

		 map.put("topRid", Integer.toString(topRid+1));
		 map.put("success", "true");
		 return map;
	}
	
	/**
	 * 检查被删除角色的id是否被使用；
	 */
	public Map<String,String> checkRoleIsUsed(Integer rid){
		Integer s = this.dao.checkRoleIsUsed(rid);
		Map<String,String> map = new HashMap<String,String>();
		//log.info("********************************\ts = "+s);
		if (s >= 1) {
			map.put("isUsed", "true");
		}else{
			map.put("isUsed", "false");
		}
		
		return map;
	}

	/**
	 * 根据角色ID得到标注了权限的菜单完整列表，有权限的菜单项，被checked标注为true，否则为false
	 */
	@Override
	public List<MenuPresent> getMenuByRid(Integer rid) {

		//得到全部的菜单信息;
		List<Menu> lm = this.dao.getAllMenuList();

		//获取用户对应权限的菜单信息
		List<MenuRoleMap> powerRoleListByRid = this.dao.getPowerRoleListByRid(rid);
		//封装对象，共封装两次
		List<MenuPresent> rList = getPowerMenuByRID(powerRoleListByRid,lm);
						
		//Map<String,Object> mt = new HashMap<String,Object>();
		
		return rList;
	}
	
	/**
	 * 获得表现层菜单对象
	 * @param mrlist 菜单角儿对应权限的list
	 * @param arList 所有角儿的对应List
	 * @return
	 */
	private List<MenuPresent> getPowerMenuByRID(List<MenuRoleMap> mrlist,List<Menu> arList){
		
		//找出顶级菜单
		List<MenuPresent> lmp1 = getLevelOneMenuPresent(mrlist,arList);
		//找到第二级菜单
		List<MenuPresent> lmp2 = getLevelTwoMenuPresent(mrlist,arList);

		Map<Integer,Integer> map = mapMenu(arList);
		
		//整合两级菜单
		List<MenuPresent> result = getMenuPresent(map,lmp1,lmp2);
		
		return result;

	}
	
	/**
	 * 整合两级菜单
	 * @param m1
	 * @param m2
	 * @return
	 */
	private List<MenuPresent> getMenuPresent(Map<Integer,Integer> map,List<MenuPresent> m1,List<MenuPresent> m2){
		List<MenuPresent> lmp1 = new ArrayList<MenuPresent>();
		List<MenuPresent> lmp2 = null;
		
		for (MenuPresent mp1 : m1){
			lmp2 = new ArrayList<MenuPresent>();
			for (MenuPresent mp2 : m2){
				//父子关系
				if (map.get(mp2.getId()) == mp1.getId()) {
					mp2.setChildren("");
					lmp2.add(mp2);
				}
			}
			mp1.setChildren(lmp2);
			lmp1.add(mp1);
		}
		return lmp1;
	}
	
	/**
	 * 映射菜单关系表
	 * @param mrlist
	 * @return key:第一层id，value第二层mid
	 */
	private Map<Integer,Integer> mapMenu(List<Menu> arlist){
		Map<Integer,Integer> map = new HashMap<Integer,Integer>();
		for (Menu mrp : arlist){
			int pmid = mrp.getParentid();
			int mid = mrp.getMid();
			//排除顶层映射
			if (pmid == mid) continue;
			map.put(mid,pmid);
		}
		return map;
	}
	
	/**
	 * 顶级菜单
	 * @param mr
	 * @param menu
	 * @return
	 */
	private List<MenuPresent> getLevelOneMenuPresent(List<MenuRoleMap> mr, List<Menu> menu){

		List<MenuPresent> rList = new ArrayList<MenuPresent>();
		MenuPresent mp1 = null;//顶级菜单
		for (Menu m : menu ){
			int mid = m.getMid();
			if (mid != m.getParentid()) {
				//非顶级菜单略过
				continue;
			}
			mp1 = new MenuPresent();
			//顶级菜单项
			mp1.setId(mid);
			mp1.setText("("+mid+")"+m.getMname());
			mp1.setChecked(false);//默认先设置false
			mp1.setState("");
			
			for (MenuRoleMap mrs :mr){
				int mrid = mrs.getMid();
				if (mid == mrid) {
					//标记该角色具有该菜单功能
					mp1.setChecked(true);
					break;
				}else{
					mp1.setChecked(false);
				}
			}
		
			rList.add(mp1);
		}
		
		return rList;
	}

	/**
	 * 二级菜单处理
	 * @param mr
	 * @param menu
	 * @return
	 */
	private List<MenuPresent> getLevelTwoMenuPresent(List<MenuRoleMap> mr, List<Menu> menu){

		List<MenuPresent> rList = new ArrayList<MenuPresent>();
		MenuPresent mp2 = null;//二级菜单
		for (Menu m : menu ){
			int mid = m.getMid();
			if (mid == m.getParentid()) {
				//顶级菜单略过
				continue;
			}
			mp2 = new MenuPresent();
			//顶级菜单项
			mp2.setId(mid);
			mp2.setText("("+mid+")"+m.getMname());
			mp2.setChecked(false);//默认先设置false
			mp2.setState("");
			
			for (MenuRoleMap mrs :mr){
				int mrid = mrs.getMid();
				if (mid == mrid) {
					//标记该角色具有该菜单功能
					mp2.setChecked(true);
					break;
				}else{
					mp2.setChecked(false);
				}
			}
		
			rList.add(mp2);
		}
		
		return rList;
	}

	@Override
	public Map<String, Object> saveMenuRoleMap(Integer[] mids,Integer rid) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (rid==null){
			resultMap.put("success", "false");
			return resultMap;
		}
				
		int result = this.dao.saveMenuRoleMap(mids,rid);
		if (result == 1) {
			resultMap.put("success", "true");
		}else{
			resultMap.put("success", "false");
		}
		return resultMap;
	}
}
