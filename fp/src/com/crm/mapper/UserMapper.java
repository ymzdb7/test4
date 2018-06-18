package com.crm.mapper;

import java.util.List;
import java.util.Map;

import com.crm.entity.AppInfo;
import com.crm.entity.CustomerSearchInfo;
import com.crm.entity.Dept;
import com.crm.entity.HolderInfo;
import com.crm.entity.HolderInfoPresent;
import com.crm.entity.Menu;
import com.crm.entity.Org;
import com.crm.entity.UserInfo;
import com.crm.entity.UserInfoPresent;

public interface UserMapper extends BaseMapper {

	public UserInfoPresent checkLoginUser(Map<String,Object> map);
	
	public List<Menu> getAllMenu();
	
	public List<UserInfo> getUserInfo();
	public List<UserInfo> getUserInfo1(int did);
	
	public List<Dept> getDeptInfo();

	public List<Menu> getPowerMenu(int uid);
	
	public List<UserInfo> getAllCustomerInfo(Map pb);
	
	public List<UserInfo> getAllHolderInfo(Map pb);
	
	public int addCustomer(UserInfo c);
	
	public int getHolderIdByPid(int pid);
	
	public String getNameByPid(int pid);

	public int getTotalUser(Map<String, Object> sdid);

	public int updatePwd(Map<String, String> map);

	public List<HolderInfo> getHoldersByDids(Map<String, Integer[]> dids);

	public int updateCustomerIsHolder(UserInfo cust);

	public int checkCidDup(UserInfo userInfo);

	public int checkPhoneDup(UserInfo userInfo);

	public int updateCustomer(UserInfo userInfo);

	public List<UserInfo> geAllUserPidPName();

	public int deleteCustomer(UserInfo userInfo);

	public List<UserInfo> getAllMngUserInfo(Map<String, Object> map);

	public int getTotalMngUser(Map<String, Object> sdid);

	public UserInfoPresent getUserInfoByPid(Integer pid);

	public int saveRoleUserMap(Map<String,Integer> map);

	public List<HolderInfoPresent> getFamilyAmount(Map<String, Object> map);

	public int getTotalHolder(Map<String, Object> sdid);

	public List<UserInfo> getAllCustomerInfoByHolder(Map<String, Object> map);

	public int getTotalUserByHolder(Map<String, Object> sdid);

	public List<Org> getOrg();
	public List<Org> getOrg1(int conTypeId);
	public Org getOrg2(int conTypeId);

	public int updatePhone(Map<String, Object> map);

	public UserInfo checkPwd(Map<String, String> map);

	public List<Org> getOrgByOid(int oid);

	public UserInfoPresent loginUserInfo(Map<String, Object> map);

	public int getDidByPid(int pid);

	public int getOidByPid(int pid);

	public int setAppVersion(AppInfo ai);

	public List<AppInfo> getAppVersion();

	public List<UserInfoPresent> getSearchCustomerInfo(Map<String, Object> map);

	public int getTotalSearchCustomerInfo(Map<String, Object> map);

	public List<UserInfoPresent> getSearchCustomerInfoForApp(Map<String, Object> map);

	public int getTotalSearchCustomerInfoForApp(Map<String, Object> map);
}
