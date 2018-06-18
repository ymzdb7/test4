package com.crm.mapper;

import java.util.List;
import java.util.Map;

import com.crm.entity.Menu;
import com.crm.entity.MenuRoleMap;
import com.crm.entity.Role;

public interface RoleMapper extends BaseMapper {

	public List<Role> getRoleList(Map map);
	
	public int insertRole(Role role);
	
	public int updateRole(Role role);
	
	public int deleteRole(Map map);
	
	public int getTotalRole();
	
	public int getTopRoleID();
	
	public Integer checkRoleIsUsed(Integer rid);

	public List<MenuRoleMap> getPowerRoleListByRid(Integer rid);

	public List<Menu> getAllMenuList();

	public int deleteMenuRoleMap(Map<String, Object> obj);

	public int insertMenuRoleMap(List<MenuRoleMap> list);

}
