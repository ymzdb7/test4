package com.crm.dao;

import java.util.List;
import java.util.Map;

import com.crm.entity.MenuRoleMap;
import com.crm.entity.Role;
import com.crm.entity.Menu;

public interface RoleDao {

	public List<Role> getRoleList(Map map);
	
	public int saveRole(Role role);
	
	public int deleteRole(Map map);
	
	public int getTopRoleID();

	int getTotalRole();

	public Integer checkRoleIsUsed(Integer rid);

	public List<MenuRoleMap> getPowerRoleListByRid(Integer rid);

	public List<Menu> getAllMenuList();

	public int saveMenuRoleMap(Integer[] mids,Integer rid);

}
