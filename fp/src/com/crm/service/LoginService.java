package com.crm.service;

import java.util.List;
import java.util.Map;

import com.crm.entity.AppInfo;
import com.crm.entity.Dept;
import com.crm.entity.Menu;
import com.crm.entity.UserInfo;
import com.crm.entity.UserInfoPresent;

public interface LoginService {
	
	public List<Menu> getAllMenu();
	public UserInfoPresent loginUserInfo(String phone, String upwd);
	public List<UserInfo> getUserInfo();
	public List<UserInfo> getUserInfo1(int did);
	public List<Menu> getPowerMenu(int uid);
	public Map<String, String> getUserExtendInfo(UserInfo user);
	public List<Dept> getAllDept();
	public Map<String, Object> setAppVersion(AppInfo ai);
	public Map<String, Object> getAppVersion();
	
}
