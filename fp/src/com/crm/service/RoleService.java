package com.crm.service;

import java.util.List;
import java.util.Map;

import com.crm.entity.MenuPresent;
import com.crm.entity.Role;

public interface RoleService {
	
	public List<Role> getRoleList(Map map);
		
	public Map<String,String> saveRole(Role role);
	
	public Map<String,String> deleteRole(String rids);
	
	public Map<String,String> getTopRoleID() ;

	int getTotalRole();
	
	public Map<String,String> checkRoleIsUsed(Integer rid);

	public List<MenuPresent> getMenuByRid(Integer rid);

	public Map<String, Object> saveMenuRoleMap(Integer[] mids, Integer rid);
}
