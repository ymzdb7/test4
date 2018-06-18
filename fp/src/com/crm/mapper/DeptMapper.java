package com.crm.mapper;

import java.util.List;
import java.util.Map;

import com.crm.entity.Dept;
import com.crm.entity.Level;
import com.crm.entity.Org;

public interface DeptMapper extends BaseMapper {
	
	public List<Dept> getAllDept();
	public List<Dept> getDeptList();
	public List<Dept> getDeptVillaList(int superDid);
	public List<Dept> getDeptInfo(Map<String,Integer> map);
	
	public List<Level> getAllLevel();

	public String getLevelNameById(int id);

	public int getTotalDept();

	public int getMaxDid();

	public List<Dept> getSuperDept(Integer cl);

	public int insertDept(Dept dept);

	public int updateDept(Dept dept);

	public Integer checkDeptIsUsed(Integer did);

	public int deleteDept(Integer did);

	public Dept getDeptNameById(int id);

	public int getMaxOid();

	public int insertOrg(Org org);

	public int updateOrg(Org org);

	public int deleteOrg(Integer oid);
}
