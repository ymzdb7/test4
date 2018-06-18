package com.crm.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.crm.controller.CustomerController;
import com.crm.dao.CustomerDao;
import com.crm.dao.DeptDao;
import com.crm.dao.HealthyTypeDao;
import com.crm.dao.RelationTypeDao;
import com.crm.dao.RoleDao;
import com.crm.dao.UserDao;
import com.crm.dao.WorkTypeDao;
import com.crm.entity.CustomerSearchInfo;
import com.crm.entity.Dept;
import com.crm.entity.HolderInfo;
import com.crm.entity.HolderInfoPresent;
import com.crm.entity.Menu;
import com.crm.entity.MenuPresent;
import com.crm.entity.MenuRoleMap;
import com.crm.entity.Org;
import com.crm.entity.Role;
import com.crm.entity.RoleListPresent;
import com.crm.entity.UserInfo;
import com.crm.entity.UserInfoPresent;
import com.crm.entity.HealthyType;
import com.crm.entity.RelationType;
import com.crm.entity.SqlOptInfoBean;
import com.crm.entity.WorkType;
import com.crm.util.DeptUtil;
import com.crm.util.ResultMapUtil;
import com.sun.istack.internal.logging.Logger;

@Service
public class CustomerServiceImpl implements CustomerService {

	/* 日志 */
	Logger log = Logger.getLogger(CustomerController.class);

	@Resource
	CustomerDao cDao;
	@Resource
	WorkTypeDao wDao;
	@Resource
	HealthyTypeDao hDao;
	@Resource
	RelationTypeDao rDao;
	@Resource
	DeptDao dDao;
	@Resource
	RoleDao roledao;

	/**
	 * 获取当前用户的帮扶对象信息 didList 部门ID的列表
	 * WEB专用
	 */
	@Override
	public Map<String, Object> getAllCustomerInfo(List<Dept> allDept, int page,
			int rows, Integer[] didList) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startIndex", ((page - 1) * rows));
		map.put("rows", rows);
		map.put("did", didList);
		List<UserInfo> uList = this.cDao.getAllCustomerInfo(map);
		List<UserInfoPresent> retObj = new ArrayList<UserInfoPresent>();

		List<RelationType> relation = this.rDao.getAllRelationType();
		List<WorkType> work = this.wDao.getAllWorkType();
		List<HealthyType> healthy = this.hDao.getAllHealthyType();
		List<UserInfo> names = this.cDao.geAllUserPidPName();

		for (Iterator<UserInfo> l = uList.iterator(); l.hasNext();) {
			UserInfo c = l.next();
			// 建立表现层对象
			UserInfoPresent cp = new UserInfoPresent();
			cp.setPid(c.getPid());
			cp.setFid(c.getIsHolder());// 户号
			cp.setDid(c.getDid());
			cp.setDname(getDeptNameById(allDept, c.getDid()));
			cp.setPname(c.getPname());
			cp.setSex(c.getSex());
			cp.setSexName(c.getSex().equals("F") ? "女" : "男");
			cp.setRelationType(c.getRelationType());
			cp.setRelationTypeName(this.getRelationTypeNameById(relation,
					c.getRelationType()));
			cp.setCid(c.getCid());
			int workType = c.getWorkType();
			cp.setWorkType(workType);
			cp.setWorkTypeName(this.getWorkTypeNameById(work, workType));
			cp.setMarriedType(c.getMarriedType());
			cp.setMarriedTypeName(this.getMerriedById(c.getMarriedType()));// 婚姻状况。0-未婚
																			// 1-已婚
																			// 2-未知
			cp.setPhone(c.getPhone());
			cp.setHealthyType(c.getHealthyType());
			cp.setHealthyTypeName(this.getHealthyTypeNameById(healthy,
					c.getHealthyType()));
			cp.setIsHolder(c.getIsHolder()); // 是否户主标识如果等于户主PID，则表示是户主
			cp.setHolderName(this.geUserNameByPid(names, c.getIsHolder())); // 根据个人编码获得户主姓名；
			cp.setFaddr(c.getFaddr());
			String duty = "";
			if (c.getPid() == c.getIsHolder()) {
				duty = "户主";
			} else if (c.getPid() == 0 || workType == 13) {
				duty = "工作人员"; // 1-工作人员，13-扶贫对象
			} else {
				duty = "非户主";
			}
			cp.setDuty(duty);
			cp.setDescb(c.getDescb());
			retObj.add(cp);
		}

		Map<String, Object> map2 = new HashMap<String, Object>();
		int countSize = this.getTotalUser(map);
		map2.put("rows", retObj);
		map2.put("total", countSize);
		map2.put("success", "true");
		map2.put("message", "成功");
		return map2;
	}

	/**
	 * 搜索信息
	 * @param allDept
	 * @param page
	 * @param rows
	 * @param didList
	 * @param f
	 * @return
	 */
	@Override
	public Map<String, Object> getSearchCustomerInfo(CustomerSearchInfo si, int page,
			int rows,  int f, Integer[] didList, boolean b) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startIndex", ((page - 1) * rows));
		map.put("rows", rows);
		map.put("si", si);
		map.put("did", didList);
		if (b){
			//只搜索户主信息
			map.put("isHolder", "true");
		}else{
			//搜索全部信息
			map.put("isHolder", "false");
		}
		List<UserInfoPresent> lcsi = this.cDao.getSearchCustomerInfo(map);
		List<HolderInfoPresent>  mAmount = this.getFamilyMemberAmount(lcsi);
		List<HolderInfoPresent>  lhip = new ArrayList<HolderInfoPresent>();
		
		for (UserInfoPresent o : lcsi){
			HolderInfoPresent hip = new HolderInfoPresent();
			hip.setCid(o.getCid());
			for (HolderInfoPresent o2 : mAmount){
				if (o2.getIsHolder() == o.getIsHolder()){
					hip.setAmount(o2.getAmount());
					break;
				}
			}
			hip.setDescb(o.getDescb());
			hip.setDid(o.getDid());
			hip.setDname(o.getDname());
			hip.setDuty(o.getDuty());
			hip.setFaddr(o.getFaddr());
			hip.setFid(o.getFid());
			hip.setHealthyType(o.getHealthyType());
			hip.setHealthyTypeName(o.getHealthyTypeName());
			hip.setHolderName(o.getHolderName());
			hip.setIsHolder(o.getIsHolder());
			hip.setMarriedType(o.getMarriedType());
			o.setMarriedTypeName(getMerriedById(o.getMarriedType()));
			hip.setMarriedTypeName(o.getMarriedTypeName());
			hip.setOid(o.getOid());
			hip.setOname(o.getOname());
			hip.setoTime(o.getoTime());
			hip.setPhone(o.getPhone());
			hip.setPid(o.getPid());
			hip.setPname(o.getPname());
			hip.setRelationType(o.getRelationType());
			hip.setRelationTypeName(o.getRelationTypeName());
			hip.setRid(o.getRid());
			hip.setRname(o.getRname());
			hip.setSex(o.getSex());
			o.setSexName(o.getSex().equals("F") ? "女" : "男");
			hip.setSexName(o.getSexName());
			hip.setWorkType(o.getWorkType());
			hip.setWorkTypeName(o.getWorkTypeName());
			lhip.add(hip);
		}

		Map<String, Object> map2 = new HashMap<String, Object>();
		int countSize = this.cDao.getTotalSearchCustomerInfo(map);
		if (f == 1){
			map2.put("rows", lhip);
		}else{
			map2.put("data", lhip);
		}
		map2.put("total", countSize);
		map2.put("success", "true");
		map2.put("message", "成功");

		return map2;
	}
	
	public List<HolderInfoPresent>  getFamilyMemberAmount(List<UserInfoPresent> uList){
		Map<String, Object> uPids = new HashMap<String, Object>();
		Integer[] pids = null;
		if (uList.size()!=0){
			pids = new Integer[uList.size()];
			//获取户成员数
			for (int i=0; i<uList.size(); i++){
				pids[i] = uList.get(i).getPid();
			}
		}
		uPids.put("pid", pids);
		
		List<HolderInfoPresent> listAmount = this.cDao.getFamilyAmount(uPids);

		return listAmount;
	}
	
	/**
	 * 功能同：getAllCustomerInfo函数
	 * 手机端专用
	 */
	@Override
	public Map<String, Object> getAllCustomerInfoForApp(List<Dept> allDept, int page,
			int rows, Integer[] didList) {

		// PageBean pb = new PageBean(page, rows, null);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startIndex", ((page - 1) * rows));
		map.put("rows", rows);
		map.put("did", didList);
		List<UserInfo> uList = this.cDao.getAllCustomerInfo(map);
		List<UserInfoPresent> retObj = new ArrayList<UserInfoPresent>();

		List<RelationType> relation = this.rDao.getAllRelationType();
		List<WorkType> work = this.wDao.getAllWorkType();
		List<HealthyType> healthy = this.hDao.getAllHealthyType();
		List<UserInfo> names = this.cDao.geAllUserPidPName();

		for (Iterator<UserInfo> l = uList.iterator(); l.hasNext();) {
			UserInfo c = l.next();
			// 建立表现层对象
			UserInfoPresent cp = new UserInfoPresent();
			cp.setPid(c.getPid());
			cp.setFid(c.getIsHolder());// 户号
			cp.setDid(c.getDid());
			cp.setDname(getDeptNameById(allDept, c.getDid()));
			cp.setPname(c.getPname());
			cp.setSex(c.getSex());
			cp.setSexName(c.getSex().equals("F") ? "女" : "男");
			cp.setRelationType(c.getRelationType());
			cp.setRelationTypeName(this.getRelationTypeNameById(relation,
					c.getRelationType()));
			cp.setCid(c.getCid());
			int workType = c.getWorkType();
			cp.setWorkType(workType);
			cp.setWorkTypeName(this.getWorkTypeNameById(work, workType));
			cp.setMarriedType(c.getMarriedType());
			cp.setMarriedTypeName(this.getMerriedById(c.getMarriedType()));// 婚姻状况。0-未婚
																			// 1-已婚
																			// 2-未知
			cp.setPhone(c.getPhone());
			cp.setHealthyType(c.getHealthyType());
			cp.setHealthyTypeName(this.getHealthyTypeNameById(healthy,
					c.getHealthyType()));
			cp.setIsHolder(c.getIsHolder()); // 是否户主标识如果等于户主PID，则表示是户主
			cp.setHolderName(this.geUserNameByPid(names, c.getIsHolder())); // 根据个人编码获得户主姓名；
			cp.setFaddr(c.getFaddr());
			String duty = "";
			if (c.getPid() == c.getIsHolder()) {
				duty = "户主";
			} else if (c.getPid() == 0 || workType == 13) {
				duty = "工作人员"; // 1-工作人员，13-扶贫对象
			} else {
				duty = "非户主";
			}
			cp.setDuty(duty);
			cp.setDescb(c.getDescb());
			retObj.add(cp);
		}

		Map<String, Object> map2 = new HashMap<String, Object>();
		int countSize = this.getTotalUser(map);
		map2.put("data", retObj);
		map2.put("total", countSize);
		map2.put("success", "true");
		map2.put("message", "成功");
		return map2;
	}

	/**
	 * 得到户主详细信息，增加amount，户成员数字段
	 * @param dept
	 * @param page
	 * @param rows
	 * @param dids
	 * @return
	 */
	@Override
	public Map<String, Object> getAllHolderInfo(List<Dept> allDept, int page,
			int rows, Integer[] dids, int f) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startIndex", ((page - 1) * rows));
		map.put("rows", rows);
		map.put("did", dids);
		
		//获取户主信息
		List<UserInfo> uList = this.cDao.getAllHolderInfo(map);
		
		Map<String, Object> uPids = new HashMap<String, Object>();
		Integer[] pids = null;
		if (uList.size()!=0){
			pids = new Integer[uList.size()];
			//获取户成员数
			for (int i=0; i<uList.size(); i++){
				pids[i] = uList.get(i).getPid();
			}
		}
		uPids.put("pid", pids);
		
		List<HolderInfoPresent> listAmount = this.cDao.getFamilyAmount(uPids);
		
		List<HolderInfoPresent> retObj = new ArrayList<HolderInfoPresent>();

		List<RelationType> relation = this.rDao.getAllRelationType();
		List<WorkType> work = this.wDao.getAllWorkType();
		List<HealthyType> healthy = this.hDao.getAllHealthyType();
		List<UserInfo> names = this.cDao.geAllUserPidPName();

		//for (Iterator<UserInfo> l = uList.iterator(); l.hasNext();) {
		for (int k = 0; k<uList.size(); k++) {
			UserInfo c = uList.get(k);
			// 建立表现层对象
			HolderInfoPresent cp = null;
			for (int s=0; s<listAmount.size(); s++){
				if (listAmount.get(k).getIsHolder() == c.getPid()){
					cp = listAmount.get(k);
					break;
				}
			}
			
			if (cp == null){
				cp = new HolderInfoPresent();
			}
			
			cp.setPid(c.getPid());
			cp.setFid(c.getIsHolder());// 户号
			cp.setDid(c.getDid());
			cp.setDname(getDeptNameById(allDept, c.getDid()));
			cp.setPname(c.getPname());
			cp.setSex(c.getSex());
			cp.setSexName(c.getSex().equals("F") ? "女" : "男");
			cp.setRelationType(c.getRelationType());
			cp.setRelationTypeName(this.getRelationTypeNameById(relation,
					c.getRelationType()));
			cp.setCid(c.getCid());
			int workType = c.getWorkType();
			cp.setWorkType(workType);
			cp.setWorkTypeName(this.getWorkTypeNameById(work, workType));
			cp.setMarriedType(c.getMarriedType());
			cp.setMarriedTypeName(this.getMerriedById(c.getMarriedType()));// 婚姻状况。0-未婚
																			// 1-已婚
																			// 2-未知
			cp.setPhone(c.getPhone());
			cp.setHealthyType(c.getHealthyType());
			cp.setHealthyTypeName(this.getHealthyTypeNameById(healthy,
					c.getHealthyType()));
			cp.setIsHolder(c.getIsHolder()); // 是否户主标识如果等于户主PID，则表示是户主
			cp.setHolderName(this.geUserNameByPid(names, c.getIsHolder())); // 根据个人编码获得户主姓名；
			cp.setFaddr(c.getFaddr());
			String duty = "";
			if (c.getPid() == c.getIsHolder()) {
				duty = "户主";
			} else if (c.getPid() == 0 || workType == 13) {
				duty = "工作人员"; // 1-工作人员，13-扶贫对象
			} else {
				duty = "非户主";
			}
			cp.setDuty(duty);
			cp.setDescb(c.getDescb());
			retObj.add(cp);
		}

		Map<String, Object> map2 = new HashMap<String, Object>();
		int countSize = this.getTotalHolder(map);
		if (f == 0){
			//手机端
			map2.put("data", retObj);
		}else{
			//web端
			map2.put("rows", retObj);
		}
		map2.put("total", countSize);
		map2.put("success", "true");
		map2.put("message", "成功");
		return map2;
	}
	
	/**
	 * 获取当前部门下的用户数量
	 * 
	 * @param sdid
	 * @return
	 */
	public int getTotalUser(Map<String, Object> sdid) {
		return this.cDao.getTotalUser(sdid);
	}
	
	public int getTotalHolder(Map<String, Object> sdid) {
		return this.cDao.getTotalHolder(sdid);
	}
	
	public int getTotalMngUser(Map<String, Object> sdid) {
		return this.cDao.getTotalMngUser(sdid);
	}

	public String getWorkTypeNameById(List<WorkType> list, int id) {

		for (WorkType wt : list) {
			if (wt.getId() == id) {
				return wt.getType_name();
			}
		}
		return "";
	}

	public String getHealthyTypeNameById(List<HealthyType> list, int id) {

		for (HealthyType wt : list) {
			if (wt.getId() == id) {
				return wt.getType_name();
			}
		}
		return null;
	}

	public String getRelationTypeNameById(List<RelationType> list, int id) {

		for (RelationType wt : list) {
			if (wt.getId() == id) {
				return wt.getType_name();
			}
		}
		return "";
	}

	public String getMerriedById(int id) {
		// 婚姻状况。0-未婚 1-已婚 2-未知
		if (id == 0) {
			return "未婚";
		} else if (id == 1) {
			return "已婚";
		} else {
			return "未知";
		}
	}

	/**
	 * 新增帮扶对象信息
	 */
	@Override
	public Map<String, Object> addCustomer(UserInfo cust, String flaged) {
		int result = 0;
		// did,pname，sex，relationType,cid,workTyp,marriedType,phone,healthyTyp,faddr,descb原值插入
		// isHolder
		// 根据relationType判断，如relationType=1，表示户主，则本字段的ID同PID,该步骤操作将在CustumerDao中实现
		if (flaged == null || flaged.trim().equals("") || flaged.equals("a")) {
			// 返回操作之后的成功记录数
			// rid角色处理，默认为0，不具有任何角色与权限
			cust.setRid(0);
			result = this.cDao.addCustomer(cust);
		} else if (flaged.equals("m")) {
			result = this.cDao.updateCustomer(cust);
		}

		Map<String, Object> map = new HashMap<String, Object>();
		if (result == 1) {
			map.put("success", "true");
			map.put("message", "成功");
			map.put("errCode", 0);
		} else {
			map.put("success", "false");
			if (result == 10001){
				map.put("message", "身份证重复，失败");
			}else{
				map.put("message", "电话号码重复，失败");
			}
			map.put("errCode", result);
		}
		return map;
	}

	/**
	 * 根据PID获取该人姓名
	 * 
	 * @param list
	 * @param pid
	 * @return
	 */
	public String geUserNameByPid(List<UserInfo> names, int pid) {
		for (UserInfo ui : names) {
			if (ui.getPid() == pid) {
				return ui.getPname();
			}
		}
		return "";
	}

	/**
	 * 根据部门ID取得部门名称 this.dDao.getDeptNameById(, did);
	 * 
	 * @return
	 */
	public String getDeptNameById(List<Dept> dept, int did) {
		for (Dept d : dept) {
			if (d.getDid() == did) {
				return d.getDname();
			}
		}
		return "";
	}

	/**
	 * 密码修改
	 * @param upwd
	 * @param phone
	 * @param pid
	 * @return
	 */
	@Override
	public Map<String, Object> updatePwd(String opwd, String phone, String upwd, int pid) {
		
		boolean b = this.checkPwd(phone, opwd);
		if (!b) {
			//密码不正确
			//map.put("success", "false");
			//map.put("errCode", "10010");
			return ResultMapUtil.resultMapObject("false", "更新密码失败，原密码错误","10010");
		}
		
		Map<String,String> m = new HashMap<String,String>();
		m.put("upwd", upwd);
		m.put("pid",String.valueOf(pid));
		int result = this.cDao.updatePwd(m);
		if (result == 1) {
			return ResultMapUtil.resultMapObject("true", "更新密码成功");
		} else {
			//map.put("success", "false");
			return ResultMapUtil.resultMapObject("false", "更新密码失败");
		}
//		return map;
	}

	/**
	 * 密码重置
	 * @param pid
	 * @return
	 */
	@Override
	public Map<String, Object> pwdReset(int pid) {
		Map<String,String> m = new HashMap<String,String>();
		m.put("upwd", "123456");
		m.put("pid",String.valueOf(pid));
		int result = this.cDao.updatePwd(m);
		if (result == 1) {
			return ResultMapUtil.resultMapObject(true, "成功");
		} else {
			return ResultMapUtil.resultMapObject(true, "失败");
		}

	}

	@Override
	public Map<String, Object> getHoldersByDids(Integer[] dids) {
		if (dids == null)
			return new HashMap<String, Object>();
		Map<String, Integer[]> map = new HashMap<String, Integer[]>();
		map.put("did", dids);

		List<HolderInfo> lhi= this.cDao.getHoldersByDids(map);
		if (lhi.size()>0){
			return ResultMapUtil.resultMapObject(true, "获取成功", lhi);
		}else{
			return ResultMapUtil.resultMapObject(false, "获取失败");
		}
	}

	@Override
	public Object checkCidDup(UserInfo userInfo) {
		int result = this.cDao.checkCidDup(userInfo);
		Map<String, Object> map = new HashMap<String, Object>();
		if (result >= 1) {
			map.put("success", "true");
		} else {
			map.put("success", "false");
		}
		return map;
	}

	@Override
	public Object checkPhoneDup(UserInfo userInfo) {
		int result = this.cDao.checkPhoneDup(userInfo);
		Map<String, Object> map = new HashMap<String, Object>();
		if (result >= 1) {
			map.put("success", "true");
		} else {
			map.put("success", "false");
		}
		return map;
	}

	@Override
	public Object getPageDid(List<Dept> allDept, Integer[] arrInt) {
		List<Dept> list = new ArrayList<Dept>();

		for (int i = 0; i < arrInt.length; i++) {
			for (int j = 0; j < allDept.size(); j++) {
				Dept d = allDept.get(j);
				if (d.getDid() == arrInt[i]) {
					//Dept dept = new Dept();
					//dept.setDid(d.getDid());
					//dept.setDname(d.getDname());
					list.add(d);
					break;
				}
			}
		}
		
		return DeptUtil.buildFormatDept(list);
	}

	@Override
	public Object deleteCustomer(UserInfo userInfo) {
		int result = this.cDao.deleteCustomer(userInfo);
		Map<String, Object> map = new HashMap<String, Object>();
		if (result >= 1) {
			map.put("success", "true");
			map.put("message", "成功");
		} else {
			map.put("success", "false");
			map.put("message", "失败");
		}
		return map;
	}

	@Override
	public Map<String, Object> getAllMngUserInfo(List<Dept> allDept, int page,
			int rows, Integer[] didList, int allUser) {

		// PageBean pb = new PageBean(page, rows, null);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startIndex", ((page - 1) * rows));
		map.put("rows", rows);
		map.put("allUser", allUser);
		map.put("did", didList);
		List<UserInfo> uList = this.cDao.getAllMngUserInfo(map);
		List<UserInfoPresent> retObj = new ArrayList<UserInfoPresent>();
		List<Org> listOrg = getOrg();

		for (Iterator<UserInfo> l = uList.iterator(); l.hasNext();) {
			UserInfo c = l.next();
			// 建立表现层对象
			UserInfoPresent cp = new UserInfoPresent();
			cp.setPid(c.getPid());
			cp.setDid(c.getDid());
			cp.setOid(c.getOid());
			for (int k=0; k<listOrg.size(); k++){
				Org org = listOrg.get(k);
				if (cp.getOid() == org.getOid()){
					cp.setOname(org.getOname());
				}
			}
			cp.setDname(getDeptNameById(allDept, c.getDid()));
			cp.setPname(c.getPname());
			cp.setPhone(c.getPhone());
			cp.setIsHolder(c.getIsHolder()); // 是否户主标识如果等于户主PID，则表示是户主
			String duty = "";
			if (c.getPid() == c.getIsHolder()) {
				duty = "户主";
			} else if (c.getIsHolder() == 0 || c.getPid() == 0) {
				duty = "工作人员"; // 1-工作人员，13-扶贫对象
			} else {
				duty = "非户主";
			}
			cp.setDuty(duty);
			retObj.add(cp);
		}

		Map<String, Object> map2 = new HashMap<String, Object>();
		int countSize = this.getTotalMngUser(map);
		map2.put("rows", retObj);
		map2.put("total", countSize);
		map2.put("success", "true");
		map2.put("message", "成功");
		return map2;
	}

	/**
	 * 验证密码是否正确
	 * @param phone
	 * @param pwd
	 * @param pid
	 * @return
	 */
	@Override
	public Boolean checkPwd(String phone,String pwd) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("phone",phone);
		map.put("upwd", pwd);

		UserInfo user =  this.cDao.checkPwd(map);
		
		if (user == null) {
			return false;  //没有用户使用该号码
		} else {
			return true;   //有用户使用
		}
	}

	@Override
	public List<RoleListPresent> getRoleUserMapByPid(Integer pid) {

		//取得指定PID的用户信息
		UserInfo userInfo = this.cDao.getUserInfoByPid(pid);

		Map<String,Integer> map1 = new HashMap<String,Integer>();
		map1.put("startIndex", 0);
		map1.put("rows", 8000);
		//获取全部角色信息
		List<Role> listRole = this.roledao.getRoleList(map1);
		
		//封装前端需要的格式数据，并且标记那个角色已经被选取了。
		List<RoleListPresent> rList = buildPowerRoleList(listRole,userInfo);
						
		return rList;
	}
	
	private List<RoleListPresent> buildPowerRoleList( List<Role> listRole, UserInfo userInfo){
		List<RoleListPresent> lr = new ArrayList<RoleListPresent>();
		RoleListPresent mp1 = null;
		for (Role r : listRole ){
			mp1 = new RoleListPresent();
			mp1.setId(r.getRid());
			mp1.setText("("+r.getRid()+")"+r.getRname());
			if (userInfo.getRid()==r.getRid()){
				mp1.setChecked(true);
			}else{
				mp1.setChecked(false);
			}
			mp1.setState("");
			mp1.setChildren("");
			lr.add(mp1);
		}
		return lr;
	}
	
	public Map<String, Object> saveRoleUserMap(Integer pid, Integer rid){
		Map<String, Object> result = new HashMap<String, Object>();
		if (rid==null || pid==null || pid==0){
			result.put("success", "false");
			result.put("message", "用户ID为空");
			return result;
		}
		
		//rid等于0表示取消这个人的所有角色权限，设置rid=0;
		
		Map<String, Integer> map = new HashMap<String,Integer>();
		map.put("pid", pid);
		map.put("rid", rid);
		int re = this.cDao.saveRoleUserMap(map);
		if (re == 1) {
			result.put("success", "true");
			result.put("message", "成功");
		}else{
			result.put("success", "false");
			result.put("message", "失败");
		}
		return result;
	}

	/**
	 * 获取指定户主下的所有户成员信息
	 */
	@Override
	public Map<String, Object> getAllCustomerInfoByHolder(List<Dept> allDept,
			int page, int rows, Integer[] didList, int isHolder, int f) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startIndex", ((page - 1) * rows));
		map.put("rows", rows);
		map.put("did", didList);
		map.put("isHolder", isHolder);
		List<UserInfo> uList = this.cDao.getAllCustomerInfoByHolder(map);

		List<UserInfoPresent> retObj = new ArrayList<UserInfoPresent>();

		List<RelationType> relation = this.rDao.getAllRelationType();
		List<WorkType> work = this.wDao.getAllWorkType();
		List<HealthyType> healthy = this.hDao.getAllHealthyType();
		List<UserInfo> names = this.cDao.geAllUserPidPName();

		for (Iterator<UserInfo> l = uList.iterator(); l.hasNext();) {
			UserInfo c = l.next();
			// 建立表现层对象
			UserInfoPresent cp = new UserInfoPresent();
			cp.setPid(c.getPid());
			cp.setFid(c.getIsHolder());// 户号
			cp.setDid(c.getDid());
			cp.setDname(getDeptNameById(allDept, c.getDid()));
			cp.setPname(c.getPname());
			cp.setSex(c.getSex());
			cp.setSexName(c.getSex().equals("F") ? "女" : "男");
			cp.setRelationType(c.getRelationType());
			cp.setRelationTypeName(this.getRelationTypeNameById(relation,
					c.getRelationType()));
			cp.setCid(c.getCid());
			int workType = c.getWorkType();
			cp.setWorkType(workType);
			cp.setWorkTypeName(this.getWorkTypeNameById(work, workType));
			cp.setMarriedType(c.getMarriedType());
			cp.setMarriedTypeName(this.getMerriedById(c.getMarriedType()));// 婚姻状况。0-未婚
																			// 1-已婚
																			// 2-未知
			cp.setPhone(c.getPhone());
			cp.setHealthyType(c.getHealthyType());
			cp.setHealthyTypeName(this.getHealthyTypeNameById(healthy,
					c.getHealthyType()));
			cp.setIsHolder(c.getIsHolder()); // 是否户主标识如果等于户主PID，则表示是户主
			cp.setHolderName(this.geUserNameByPid(names, c.getIsHolder())); // 根据个人编码获得户主姓名；
			cp.setFaddr(c.getFaddr());
			String duty = "";
			if (c.getPid() == c.getIsHolder()) {
				duty = "户主";
			} else if (c.getPid() == 0 || workType == 13) {
				duty = "工作人员"; // 1-工作人员，13-扶贫对象
			} else {
				duty = "非户主";
			}
			cp.setDuty(duty);
			cp.setDescb(c.getDescb());
			retObj.add(cp);
		}

		Map<String, Object> map2 = new HashMap<String, Object>();
		int countSize = this.getTotalUserByHolder(map);
		if (f == 0) {
			//手机端调用
			map2.put("data", retObj);
		}else{
			//web端调用
			map2.put("rows", retObj);
		}
		map2.put("total", countSize);
		map2.put("success", "true");
		map2.put("message", "成功");
		return map2;
	}
	
	
	@Override
	public Map<String, Object> getCustomerInfoByPid(int pid) {
		UserInfoPresent cp = getUserInfoByPid(pid);
		if (cp == null) {
			return ResultMapUtil.resultMapObject("true", "不存在");
		}else{
			return ResultMapUtil.resultMapObject("true", "成功", cp);
		}
	}
	/**
	 * 获取指定Pid下的成员信息
	 */
	@Override
	public UserInfoPresent getUserInfoByPid(int pid) {

		UserInfoPresent cp = this.cDao.getUserInfoByPid(pid);
		if (cp == null) return null;

		cp.setDname(this.dDao.getDeptNameById(cp.getDid()).getDname());
		if (cp.getIsHolder()!=0){
			cp.setSexName(cp.getSex().equals("F") ? "女" : "男");
			int t = cp.getRelationType();
			String tn = this.rDao.getRelationTypeNameById(t);
			cp.setRelationTypeName(tn);
			cp.setWorkTypeName(this.wDao.getWorkType(cp.getWorkType()).getType_name());
			cp.setMarriedTypeName(this.getMerriedById(cp.getMarriedType()));// 婚姻状况。0-未婚
																			// 1-已婚
																			// 2-未知
			cp.setHealthyTypeName(this.hDao.getHealthyType(cp.getHealthyType()).getType_name());
			cp.setHolderName(this.cDao.getUserInfoByPid(cp.getIsHolder()).getPname()); // 根据个人编码获得户主姓名；
		}else{
			cp.setSexName("");
			cp.setRelationTypeName("");
			cp.setWorkTypeName("");
			cp.setMarriedTypeName("");
			cp.setHealthyTypeName("");
			cp.setHolderName("");
			cp.setSex("");
			cp.setOname("");
			cp.setRname("");
			cp.setCid("");
			cp.setFaddr("");
			cp.setDescb("");
		}
		if (cp.getPid() == cp.getIsHolder()) {
			cp.setDuty("户主");
		} else if (cp.getIsHolder() == 0 || cp.getPid() == 0 || cp.getWorkType() == 13) {
			cp.setDuty("工作人员"); // 1-工作人员，13-扶贫对象
		} else {
			cp.setDuty("非户主");
		}
		return cp;

	}
	
	public int getTotalUserByHolder(Map<String, Object> sdid) {
		return this.cDao.getTotalUserByHolder(sdid);
	}

	@Override
	public List<Org> getOrg() {
		return this.cDao.getOrg();
	}


	
	@Override
	public Map<String, Object> updatePhone(String oldPhone, String newPhone,
			String pwd, int pid) {
		//1，检查密码
		Boolean b = this.checkPwd(oldPhone, pwd);
		if (!b) {
			//不存在该手机号码和密码的对应关系。验证不正确
			return ResultMapUtil.resultMapObject("false", "原密码错误,或原手机号码不存在","10010");
		}
		//2, 检查新电话号码是否重复
		UserInfo ui = new UserInfo();
		ui.setPid(pid);
		ui.setPhone(newPhone);
		int result = this.cDao.checkPhoneDup(ui);
		if (result >= 1) {
			//map.put("success", "true");
			return ResultMapUtil.resultMapObject("false", "新电话号码重复");
		} 
		//3, 修改电话
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("oldPhone", oldPhone);
		m.put("newPhone", newPhone);
		int result2 = this.cDao.updatePhone(m);
		if (result2 == 1) {
			//map.put("success", "true");
			return ResultMapUtil.resultMapObject("true", "更新电话号码成功");
		}else{ 
			return ResultMapUtil.resultMapObject("false", "更新电话失败");
		}
	}

	@Override
	public int getDidByPid(int pid) {
		return this.cDao.getDidByPid(pid);
	}

	@Override
	public int getOidByPid(int pid) {
		return this.cDao.getOidByPid(pid);
	}

	@Override
	public Map<String, Object> getSearchCustomerInfoForApp(String searchPara,
			int page, int rows, int f, Integer[] didList, boolean b) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startIndex", ((page - 1) * rows));
		map.put("rows", rows);
		map.put("searchPara", searchPara);
		map.put("did", didList);
		if (b){
			//只搜索户主信息
			map.put("isHolder", "true");
		}else{
			//搜索全部信息
			map.put("isHolder", "false");
		}
		List<UserInfoPresent> lcsi = this.cDao.getSearchCustomerInfoForApp(map);
		
		for (UserInfoPresent o : lcsi){
			o.setMarriedTypeName(getMerriedById(o.getMarriedType()));
			o.setSexName(o.getSex().equals("F") ? "女" : "男");
		}

		Map<String, Object> map2 = new HashMap<String, Object>();
		int countSize = this.cDao.getTotalSearchCustomerInfoForApp(map);
		if (f == 1){
			map2.put("rows", lcsi);
		}else{
			map2.put("data", lcsi);
		}
		map2.put("total", countSize);
		map2.put("success", "true");
		map2.put("message", "成功");

		return map2;	
	}

	@Override
	public List<Org> getOrg1(int conTypeId) {
		// TODO Auto-generated method stub
		return this.cDao.getOrg1(conTypeId);
	}

	@Override
	public Org getOrg2(int conTypeId) {
		// TODO Auto-generated method stub
		return this.cDao.getOrg2(conTypeId);
	}

}
