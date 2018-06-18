package com.crm.dao;

import java.util.List;
import java.util.Map;

import com.crm.entity.AppInfo;
import com.crm.entity.Menu;
import com.crm.entity.UserInfo;
import com.crm.entity.UserInfoPresent;

public interface UserDao {
	
	public UserInfoPresent checkLoginUser(Map<String,Object> map);

	public List<Menu> getAllMenu();

	public List<UserInfo> getUserInfo();
	public List<UserInfo> getUserInfo1(int did);

	public List<Menu> getPowerMenu(int uid);

	public UserInfoPresent loginUserInfo(Map<String, Object> map);

	public int setAppVersion(AppInfo ai);

	public List<AppInfo> getAppVersion();
}
