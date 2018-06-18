package com.crm.dao;

import java.util.List;
import java.util.Map;

import com.crm.entity.Dept;
import com.crm.entity.Level;
import com.crm.entity.Org;

public interface DeptDao {

	public List<Dept> getAllDept();
	public List<Dept> getDeptList();
	public List<Dept> getDeptVillaList(int superDid);
	public List<Dept> getDeptInfo(Map<String,Integer> map);
	
	public String getDeptNameById(List<Dept> ds, int id);
	
	public List<Level> getAllLevel();

	public String getLevelNameById(List<Level> ds, int id);
	
	public int getTotalDept();

	public int getMaxDid();

	public List<Dept> getSuperDept(Integer did);

	public int saveDept(Dept dept);

	public Integer checkDeptIsUsed(Integer did);

	public int deleteDept(Integer did);

	public Dept getDeptNameById(int id);

	public int getMaxOid();

	public int saveOrg(Org org);

	public int deleteOrg(Integer oid);
}
