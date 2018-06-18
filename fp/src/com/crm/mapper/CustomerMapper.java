package com.crm.mapper;

import java.util.List;

import com.crm.entity.PageBean;
import com.crm.entity.UserInfo;

public interface CustomerMapper extends BaseMapper {
	public List<UserInfo> getAllCustomerInfo(PageBean pb);
	
	public int addCustomer(UserInfo c);
	
	public int getHolderIdByPid(int pid);
	
	public String getNameByPid(int pid);

	public int getTotalUser();

	public Integer getTest(Integer i);
}
