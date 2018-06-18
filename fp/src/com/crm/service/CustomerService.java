package com.crm.service;

import java.util.List;
import java.util.Map;

import com.crm.entity.CustomerSearchInfo;
import com.crm.entity.Dept;
import com.crm.entity.HolderInfo;
import com.crm.entity.Org;
import com.crm.entity.RoleListPresent;
import com.crm.entity.UserInfo;
import com.crm.entity.UserInfoPresent;

public interface CustomerService {
	
	public Map<String,Object> getAllCustomerInfo(List<Dept> allDept, int page,int rows,Integer[] didList);

	public Map<String,Object> getAllCustomerInfoForApp(List<Dept> allDept, int page,int rows,Integer[] didList);

	public Map<String,Object> addCustomer(UserInfo cust,String flaged);

	public Map<String,Object>  pwdReset(int pid);

	public Object checkCidDup(UserInfo userInfo);

	public Object checkPhoneDup(UserInfo userInfo);

	public Object getPageDid(List<Dept> allDept, Integer[] arrInt);

	public Object deleteCustomer(UserInfo userInfo);

	public Map getAllMngUserInfo(List<Dept> dept, int p, int r, Integer[] arrInt, int isHolder);

	public Boolean checkPwd(String phone,String pwd);

	public Map<String, Object> updatePwd(String opwd, String phone, String upwd, int pid);

	public List<RoleListPresent> getRoleUserMapByPid(Integer pid);

	public Map<String, Object> saveRoleUserMap(Integer pid, Integer rid);

	public Map<String, Object> getAllHolderInfo(List<Dept> dept, int page, int rows,
			Integer[] dids, int f);

	public Map<String, Object> getAllCustomerInfoByHolder(List<Dept> dept,
			int page, int rows, Integer[] dids, int isHolder, int f);

	public List<Org> getOrg();
	public List<Org> getOrg1(int conTypeId);
	public Org getOrg2(int conTypeId);
	
	public Map<String, Object> updatePhone(String oldPhone,String newPhone,String pwd, int pid);

	public Map<String, Object> getCustomerInfoByPid(int pid);

	public UserInfoPresent getUserInfoByPid(int pid);

	public int getDidByPid(int pid);

	public int getOidByPid(int pid);

	public Map<String, Object> getHoldersByDids(Integer[] dids);

	public Map<String, Object> getSearchCustomerInfo(CustomerSearchInfo si, int page, int rows, int f, Integer[] didList,boolean b);

	public Map<String, Object> getSearchCustomerInfoForApp(String searchPara, int page, int rows, int f, Integer[] didList, boolean b);
}
