package com.crm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.crm.dao.CustomerDao;
import com.crm.dao.DeptDao;
import com.crm.dao.UserDao;
import com.crm.entity.AppInfo;
import com.crm.entity.Dept;
import com.crm.entity.LoginUserMap;
import com.crm.entity.Menu;
import com.crm.entity.Org;
import com.crm.entity.UserInfo;
import com.crm.entity.UserInfoPresent;
import com.crm.util.ResultMapUtil;

/*
 * 用户信息的业务逻辑 
 */
@Service
public class LoginServiceImpl implements LoginService{

	@Resource UserDao userDao;
	@Resource CustomerDao cdao;
	@Resource DeptDao ddao;
	
	/* 检查用户名 密码是否合法 */
	@Override
	public UserInfoPresent loginUserInfo(String phone,String upwd) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("phone", phone);
		map.put("upwd", upwd);
		UserInfoPresent uip = this.userDao.loginUserInfo(map);
		if (uip == null) return null;
		if (uip.getSex() != null) {
			//工作人员sex字段为null
			uip.setSexName(uip.getSex().equals("F")?"女":"男");
		}else{
			uip.setSexName("");
		}
		if (uip.getIsHolder() == 0){
			//工作人员，无需设置下列信息
			uip.setMarriedTypeName("");
			uip.setHealthyTypeName("");
			uip.setWorkTypeName("");
			uip.setRelationTypeName("");
		}else{
			if (uip.getMarriedType()==0){
				uip.setMarriedTypeName("未婚");
			}else if (uip.getMarriedType()==1){
				uip.setMarriedTypeName("已婚");
			}else{
				uip.setMarriedTypeName("未知");
			}
		}
		return uip;
	}

	/* 获取所有的菜单项 */
	@Override
	public List getAllMenu() {
		return userDao.getAllMenu();
	}
	
	/* 获取所有的部门信息 */
	public List<UserInfo> getUserInfo() {
		return this.userDao.getUserInfo();
	}

	/*获取制定用户的菜单*/
	@Override
	public List<Menu> getPowerMenu(int uid) {
		return this.userDao.getPowerMenu(uid);
	}

	@Override
	public Map<String, String> getUserExtendInfo(UserInfo user) {
		Map<String, String> map = new HashMap<String, String>();
		List<Org> lorg = this.cdao.getOrg();
		for (Org org : lorg){
			if (org.getOid() == user.getOid()){
				map.put("oname", org.getOname());
				break;
			}
		}
		List<Dept> ldept = this.ddao.getAllDept();
		for (Dept d : ldept){
			if (d.getDid() == user.getDid()){
				map.put("dname", d.getDname());
				break;
			}
		}
		return map;
	}

	@Override
	public List<Dept> getAllDept() {
		return this.ddao.getAllDept();
	}

	@Override
	public Map<String, Object> setAppVersion(AppInfo ai) {
		int res = this.userDao.setAppVersion(ai);
		if (res == 1){
			return ResultMapUtil.resultMapObject(true, "设置APP版本信息成功");
		}else{
			return ResultMapUtil.resultMapObject(false, "设置APP版本信息失败");
		}
	}

	@Override
	public Map<String, Object> getAppVersion() {
		List<AppInfo> lai = this.userDao.getAppVersion();
		if (lai != null && lai.size()>0){
			return ResultMapUtil.resultMapObject(true, "获取版本成功", lai);
		}else{
			return ResultMapUtil.resultMapObject(false, "获取版本失败");
		}
	}

	@Override
	public List<UserInfo> getUserInfo1(int did) {
		// TODO Auto-generated method stub
		return this.userDao.getUserInfo1(did);
	}


	
}
