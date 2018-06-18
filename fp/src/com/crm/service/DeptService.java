package com.crm.service;

import java.util.List;
import java.util.Map;

import com.crm.entity.Dept;
import com.crm.entity.DeptPresent;
import com.crm.entity.Level;
import com.crm.entity.Org;


public interface DeptService {

	public List<Dept> getAllDept();
	
	public Map<String, Object> getDeptInfo(int page, int rows, int f);
	
	public String getDeptNameById(List<Dept> ds,int id);

	public Integer[] getChildDidByDid(List<Dept> ds, int pid);
	public List<Level> getAllLevel();
	public List<Dept> getDeptList();
	public List<Dept> getDeptVillaList(int superDid);

	String getLevelNameById(List<Level> ds, int id);

	public Object getMaxDid();

	public Object getSuperDept(String clevel);

	public Map<String,String> saveDept(Dept dept);

	public Map<String, String> checkDeptIsUsed(Integer rid);

	public Map<String, String> deleteDept(Integer rids);

	public Object getMaxOid();

	public Object saveOrg(Org org);

	public Map<String, String> deleteOrg(Integer oid);
}
