package com.crm.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.crm.controller.CustomerController;
import com.crm.entity.Menu;
import com.crm.entity.MenuRoleMap;
import com.crm.entity.PageBean;
import com.crm.entity.Role;
import com.crm.entity.UserInfo;
import com.crm.mapper.RoleMapper;
import com.crm.mapper.UserMapper;
import com.sun.istack.internal.logging.Logger;

@Repository
public class RoleDaoImpl implements RoleDao{

	Logger log = Logger.getLogger(RoleDao.class);

	@Resource RoleMapper mapper;
	
	@Override
	public List<Role> getRoleList(Map map){	
		return this.mapper.getRoleList(map);
	}

	@Override
	public int getTotalRole(){
		return this.mapper.getTotalRole();
	}
	
	@Override
	public int saveRole(Role role){
		//新增
		if (role.getFlaged().equals("a")){
			return this.mapper.insertRole(role);
		//修改
		}else if (role.getFlaged().equals("m")){
			return this.mapper.updateRole(role);
		}
		return 0;
	}
	
	@Override
	public int deleteRole(Map map){
		return this.mapper.deleteRole(map);
	}
	
	@Override
	public int getTopRoleID(){
		
		return this.mapper.getTopRoleID();
	}
	
	@Override
	public Integer checkRoleIsUsed(Integer rid){
		return this.mapper.checkRoleIsUsed(rid);
	}

	@Override
	public List<MenuRoleMap> getPowerRoleListByRid(Integer rid) {
		return this.mapper.getPowerRoleListByRid(rid);
	}

	@Override
	public List<Menu> getAllMenuList() {
		return this.mapper.getAllMenuList();
	} 

	@Override
	@Transactional
	public int saveMenuRoleMap(Integer[] mids,Integer rid) {

		Map<String, Object> deletePowerId = new HashMap<String, Object>();
		Integer[] arrMid = null;
		deletePowerId.put("rid", rid);
		//如果mids为null，则取消该rid下的所有菜单的权限；
		//得到全部的菜单信息;
		List<Menu> lm = this.getAllMenuList();
		arrMid = new Integer[lm.size()] ;
		for (int i=0; i<lm.size(); i++){
			arrMid[i] = lm.get(i).getMid();
		}
		deletePowerId.put("mids", arrMid);
		int dr = this.mapper.deleteMenuRoleMap(deletePowerId);

		//如果是全部取消，即mids没有值，则删除完后，即结束执行；
//		if (mids==null){
//			if (dr != arrMid.length) {
//				return 10041; //删除全部菜单角色数据出错；删除数据与菜单总数不一致；
//			}
//		}
		//否则继续执行，新增mids数组总的菜单操作权限
				
		List<MenuRoleMap> list = new ArrayList<MenuRoleMap>();
		for (int i=0; i<mids.length; i++){
			//log.info("-------------------------------------------- rid="+rid+"\tmids["+i+"]="+mids[i]);
			if (mids[i] == 0){
				return 1; //如果是0，则删除所有的数据后，不需要任何操作；
			}
			MenuRoleMap mrm = new MenuRoleMap();
			mrm.setRid(rid);
			mrm.setMid(mids[i]);
			list.add(mrm);
		}

		//第一步，update MENU_ROLE_MNG的flag字段为0；
		//第二步，再insert这个用户的权限；
		
		//update指定角色的菜单角色对应数据
		//插入指定角色的菜单角色数据
		int ir = this.mapper.insertMenuRoleMap(list);
//		if (ir != mids.length) {
//			return 10042;
//		}

		return 1;
	}

}
