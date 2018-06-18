package com.crm.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.crm.entity.AppInfo;
import com.crm.entity.Dept;
import com.crm.entity.LoginUserMap;
import com.crm.entity.Menu;
import com.crm.entity.UserInfo;
import com.crm.entity.UserInfoPresent;
import com.crm.mapper.UserMapper;

@Repository
public class UserDaoImpl implements UserDao{

	@Resource 
	private UserMapper mapper;

	@Override
	public UserInfoPresent checkLoginUser(Map<String,Object> map) {
		return this.mapper.checkLoginUser(map);
	}

	@Override
	public List<Menu> getAllMenu() {
		return this.mapper.getAllMenu();
	}

	@Override
	public List<UserInfo> getUserInfo() {
		return this.mapper.getUserInfo();
	}

	@Override
	public List<Menu> getPowerMenu(int uid) {
		return this.mapper.getPowerMenu(uid);
	}

	@Override
	public UserInfoPresent loginUserInfo(Map<String, Object> map) {
		return this.mapper.loginUserInfo(map);
	}

	@Override
	public int setAppVersion(AppInfo ai) {
		return this.mapper.setAppVersion(ai);
	}

	@Override
	public List<AppInfo> getAppVersion() {
		return this.mapper.getAppVersion();
	}

	@Override
	public List<UserInfo> getUserInfo1(int did) {
		// TODO Auto-generated method stub
		return this.mapper.getUserInfo1(did);
	}
}
