package com.crm.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.crm.controller.CustomerController;
import com.crm.entity.CustomerSearchInfo;
import com.crm.entity.HolderInfo;
import com.crm.entity.HolderInfoPresent;
import com.crm.entity.Org;
import com.crm.entity.PageBean;
import com.crm.entity.Role;
import com.crm.entity.UserInfo;
import com.crm.entity.UserInfoPresent;
import com.crm.mapper.UserMapper;
import com.sun.istack.internal.logging.Logger;

@Repository
public class CustomerDaoImpl implements CustomerDao{

	/* 日志 */
	Logger log = Logger.getLogger(CustomerDao.class);

	@Resource UserMapper mapper;
	
	@Override
	public List<UserInfo> getAllCustomerInfo(Map pb) {
		return this.mapper.getAllCustomerInfo(pb);
	}
	
	/**
	 * 取得户主信息
	 * @param pb
	 * @return
	 */
	@Override
	public List<UserInfo> getAllHolderInfo(Map pb) {
		return this.mapper.getAllHolderInfo(pb);
	}

	@Override
	@Transactional  
	public int addCustomer(UserInfo userInfo) {
		//处理前先判断身份证号码和电话号码是否已经存在；如果存在直接返回 ；
		//身份证存在返回10001，电话号码存在返回10002
		if (userInfo.getIsHolder()!=0 && userInfo.getCid() != null){//非管理人员执行
			int result01 = this.mapper.checkCidDup(userInfo);
			if (result01 >=1) return 10001;
		}
		int result02 = this.mapper.checkPhoneDup(userInfo);
		if (result02 >=1) return 10002;
		
		//返回新增的主键pid值
		int result1 = this.mapper.addCustomer(userInfo);
		if (userInfo.getRelationType() == 1){ 
			//如果是1户主，则户主设置为自己，及将isHolder字段设置为同pid字段，其他类型则使用原始参数，不变动
			userInfo.setIsHolder(userInfo.getPid());
			this.mapper.updateCustomerIsHolder(userInfo);
		}else if (userInfo.getRelationType() == 13){
			//如果是13工作人员，则户主设置为0，表示工作人员，没有户主的概念
			userInfo.setIsHolder(0);
			this.mapper.updateCustomerIsHolder(userInfo);
		}
		if (result1 == 1){
			return 1;
		}else {
			return 0;
		}
	}
	
	@Override
	@Transactional  
	public int updateCustomer(UserInfo userInfo) {

		//处理前先判断身份证号码和电话号码是否已经存在；如果存在直接返回 ；
		//身份证存在返回10001，电话号码存在返回10002
		if (userInfo.getIsHolder()!=0 && userInfo.getCid() != null){//非管理人员执行
			int result01 = this.mapper.checkCidDup(userInfo);
			//log.warning("@@@@@@@@@@@@@@@@@@@@@@\tresult01="+result01);
			if (result01 >=1) return 10001;
		}
		int result02 = this.mapper.checkPhoneDup(userInfo);
		//log.warning("@@@@@@@@@@@@@@@@@@@@@@\tresult02="+result02);
		if (result02 >=1) return 10002;
		
		if (userInfo.getRelationType() == 1){ 
			//如果是1户主，则户主设置为自己，及将isHolder字段设置为同pid字段，其他类型则使用原始参数，不变动
			userInfo.setIsHolder(userInfo.getPid());
		}else if (userInfo.getRelationType() == 13){
			//如果是13工作人员，则户主设置为0，表示工作人员，没有户主的概念
			userInfo.setIsHolder(0);
		}
		return this.mapper.updateCustomer(userInfo);
	}

	@Override
	public String getNameByPid(int pid){
		return this.mapper.getNameByPid(pid);
	}
	
	@Override
	public int getHolderIdByPid(int pid){
		return this.mapper.getHolderIdByPid(pid);
	}
	
	@Override
	public int getTotalUser(Map<String, Object> sdid) {
		return this.mapper.getTotalUser(sdid);
	}
	@Override
	public int updatePwd(Map<String, String> map) {
		return this.mapper.updatePwd(map);
	}
	
	@Override
	public List<HolderInfo> getHoldersByDids(Map<String,Integer[]> dids){
		return this.mapper.getHoldersByDids(dids);
	}
	@Override
	public int updateCustomerIsHolder(UserInfo cust) {
		return this.mapper.updateCustomerIsHolder(cust);
	}
	@Override
	public int checkCidDup(UserInfo userInfo) {
		return this.mapper.checkCidDup(userInfo);
	}
	@Override
	public int checkPhoneDup(UserInfo userInfo) {
		return this.mapper.checkPhoneDup(userInfo);
	}
	@Override
	public List<UserInfo> geAllUserPidPName() {
		return this.mapper.geAllUserPidPName();
	}
	@Override
	public int deleteCustomer(UserInfo userInfo) {
		return this.mapper.deleteCustomer(userInfo);
	}
	@Override
	public List<UserInfo> getAllMngUserInfo(Map<String, Object> map) {
		return this.mapper.getAllMngUserInfo(map);
	}
	@Override
	public int getTotalMngUser(Map<String, Object> sdid) {
		return this.mapper.getTotalMngUser(sdid);
	}
	@Override
	public UserInfo checkPwd(Map<String,String> map) {
		return this.mapper.checkPwd(map);
	}
	@Override
	public UserInfoPresent getUserInfoByPid(Integer pid) {
		return this.mapper.getUserInfoByPid(pid);
	}	
	
	@Override
	public int saveRoleUserMap(Map<String,Integer> map) {
		return this.mapper.saveRoleUserMap(map);
	}

	@Override
	public List<HolderInfoPresent> getFamilyAmount(Map<String, Object> map) {
		return this.mapper.getFamilyAmount(map);
	}

	@Override
	public int getTotalHolder(Map<String, Object> sdid) {
		return this.mapper.getTotalHolder(sdid);
	}

	@Override
	public List<UserInfo> getAllCustomerInfoByHolder(Map<String, Object> map) {
		return this.mapper.getAllCustomerInfoByHolder(map);
	}

	@Override
	public int getTotalUserByHolder(Map<String, Object> sdid) {
		return this.mapper.getTotalUserByHolder(sdid);
	}

	@Override
	public List<Org> getOrg() {
		return this.mapper.getOrg();
	}

	@Override
	public int updatePhone(Map<String, Object> map) {
		return this.mapper.updatePhone(map);
	}

	@Override
	public List<Org> getOrgByOid(int oid) {
		return this.mapper.getOrgByOid(oid);
	}

	@Override
	public int getDidByPid(int pid) {
		return this.mapper.getDidByPid(pid);
	}

	@Override
	public int getOidByPid(int pid) {
		return this.mapper.getOidByPid(pid);
	}

	@Override
	public List<UserInfoPresent> getSearchCustomerInfo(
			Map<String, Object> map) {
		return this.mapper.getSearchCustomerInfo(map);
	}

	@Override
	public int getTotalSearchCustomerInfo(Map<String, Object> map) {
		return this.mapper.getTotalSearchCustomerInfo(map);
	}

	@Override
	public List<UserInfoPresent> getSearchCustomerInfoForApp(
			Map<String, Object> map) {
		return this.mapper.getSearchCustomerInfoForApp(map);
	}

	@Override
	public int getTotalSearchCustomerInfoForApp(Map<String, Object> map) {
		return this.mapper.getTotalSearchCustomerInfoForApp(map);
	}

	@Override
	public List<Org> getOrg1(int conTypeId) {
		// TODO Auto-generated method stub
		return this.mapper.getOrg1(conTypeId);
	}

	@Override
	public Org getOrg2(int conTypeId) {
		// TODO Auto-generated method stub
		return this.mapper.getOrg2(conTypeId);
	}

}
