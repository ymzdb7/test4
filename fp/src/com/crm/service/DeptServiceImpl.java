package com.crm.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.crm.entity.Dept;
import com.crm.entity.DeptPresent;
import com.crm.entity.Level;
import com.crm.entity.Org;
import com.crm.entity.Role;
import com.crm.util.DeptUtil;
import com.crm.util.IntegerArrayUtil;
import com.crm.controller.CustomerController;
import com.crm.dao.DeptDao;
import com.sun.istack.internal.logging.Logger;

@Service
public class DeptServiceImpl implements DeptService {

	/* 日志 */
	Logger log = Logger.getLogger(DeptService.class);

	@Resource
	private DeptDao dao;

	@Override
	public List<Dept> getAllDept() {
		return dao.getAllDept();
	}

	
	/**
	 *  获取分页的部门信息
	 */
	@Override
	public Map<String, Object> getDeptInfo(int page, int rows, int f) {

		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("startIndex", ((Integer.valueOf(page)-1)*Integer.valueOf(rows)));
		map.put("rows", Integer.valueOf(rows));
		List<Dept> ld = this.dao.getDeptInfo(map);
		if (ld==null) return null;
		
		List<Level> ll = this.dao.getAllLevel();
		List<DeptPresent> ldp = new ArrayList<DeptPresent>();
		List<Dept> ldd = this.dao.getAllDept();
		for (Dept d: ld){
			DeptPresent dp = new DeptPresent();
			dp.setDid(d.getDid());
			dp.setDname(d.getDname());
			dp.setDescb(d.getDescb());
			dp.setSuperDid(d.getSuperDid());
			dp.setSuperDidName(getDeptNameById(ldd,d.getSuperDid()));
			dp.setLevel(d.getUlevel());
			dp.setLevelName(this.getLevelNameById(ll,d.getUlevel()));
			ldp.add(dp);
		}
		Map<String, Object> map2 = new HashMap<String, Object>();
		int countSize = this.dao.getTotalDept();
		if (f == 0){
			//手机端
			map2.put("data", ldp);
		}else{
			//web端
			map2.put("rows", ldp);
		}
		map2.put("total", countSize);
		map2.put("success", "true");
		map2.put("message", "获取行政区划信息成功");
		return map2;
	}

	
	/**
	 * 根据指定的PID，查找出所有的子节点Pid，一共支持5层 
	 */
	@Override
	public Integer[] getChildDidByDid(List<Dept> ds,int did){
		
		List<Integer> l = new ArrayList<Integer>();
		List<Integer> l0 = new ArrayList<Integer>();
		l0.add(did);
		
		//第1层
		List<Integer> l1 = getChild(ds,l0);
		//第2层
		List<Integer> l2 = getChild(ds,l1);
		//第3层
		List<Integer> l3 = getChild(ds,l2);
		//第4层
		List<Integer> l4 = getChild(ds,l3);
		//第5层
		List<Integer> l5 = getChild(ds,l4);
		//第6层
		List<Integer> l6 = getChild(ds,l5);
		
		l.addAll(l1);
		l.addAll(l2);
		l.addAll(l3);
		l.addAll(l4);
		l.addAll(l5);
		l.addAll(l6);
		if (l.size() == 0){
			l.add(0, did);
		}
		
		
		Integer[] all = new Integer[l.size()];
		for (int i=0; i<l.size(); i++){
			all[i] = l.get(i);
		}
		
		return all;
	}
	
	private List<Integer> getChild(List<Dept> ds, List<Integer> l) {
		List<Integer> ll = new ArrayList<Integer>();

		for (Iterator<Dept> id = ds.iterator(); id.hasNext();) {
			Dept dept = id.next();
			for (Iterator<Integer> i = l.iterator(); i.hasNext();) {
				Integer s = i.next();
				if (dept.getSuperDid() == s) {
					ll.add(dept.getDid());
					id.remove();
				}
			}
		}
		return ll;
	}

	@Override
	public String getDeptNameById(List<Dept> ds, int id) {
		return this.dao.getDeptNameById(ds, id);
	}

	@Override
	public String getLevelNameById(List<Level> ds, int id) {
		return this.dao.getLevelNameById(ds, id);
	}


	/**
	 * 获得部门/用户级别
	 */
	@Override
	public List<Level> getAllLevel() {
		return this.dao.getAllLevel();
	}

	/**
	 * 取得最大部门ID
	 */
	@Override
	public Object getMaxDid() {
		Map<String,Integer> map = new HashMap<String,Integer>();
		int maxDid = this.dao.getMaxDid();
		map.put("maxDid", maxDid+1);
		return map;
	}


	@Override
	public Object getSuperDept(String clevel) {
		List<Dept> list = new ArrayList<Dept>();
		int l = Integer.valueOf(clevel);
		List<Dept> tmp = this.getAllDept();
		
		for (int i = 0; i < tmp.size(); i++){
			Dept d = tmp.get(i);
			if (d.getUlevel() > l) {
				list.add(d);
			}
		}

		List<Dept> l2 = DeptUtil.buildFormatDept(list);
		list.clear();
		for (int i = 0; i < l2.size(); i++){
			Dept d = tmp.get(i);
			if (d.getUlevel() == (l+1)) {
				list.add(d);
			}
		}
		
		return list;
	}


	@Override
	public Map<String,String> saveDept(Dept dept) {
		int result = this.dao.saveDept(dept);
		Map<String,String> map = new HashMap<String,String>();

		if (result == 1) {
			map.put("success", "true");
			map.put("message", "保存信息成功");
		}else{
			map.put("success", "false");
			map.put("message", "保存信息失败");
		}
		return map;
	}


	@Override
	public Map<String, String> checkDeptIsUsed(Integer did) {
		Integer s = this.dao.checkDeptIsUsed(did);
		Map<String,String> map = new HashMap<String,String>();
		//log.info("********************************\ts = "+s);
		if (s >= 1) {
			map.put("isUsed", "true");
		}else{
			map.put("isUsed", "false");
		}
		
		return map;
	}


	@Override
	public Map<String, String> deleteDept(Integer did) {
		int result = this.dao.deleteDept(did);
		Map<String,String> map = new HashMap<String,String>();
		if (result == 1) {
			map.put("success", "true");
			map.put("message", "删除信息成功");
		}else{
			map.put("success", "false");
			map.put("message", "删除信息失败");
		}
		return map;
	}


	@Override
	public Object getMaxOid() {
		Map<String,Integer> map = new HashMap<String,Integer>();
		int maxOid = this.dao.getMaxOid();
		map.put("maxOid", maxOid+1);
		return map;
	}


	@Override
	public Object saveOrg(Org org) {
		int result = this.dao.saveOrg(org);
		Map<String,String> map = new HashMap<String,String>();

		if (result == 1) {
			map.put("success", "true");
			map.put("message", "保存信息成功");
		}else{
			map.put("success", "false");
			map.put("message", "删除信息失败");
		}
		return map;
	}


	@Override
	public Map<String, String> deleteOrg(Integer oid) {
		int result = this.dao.deleteOrg(oid);
		Map<String,String> map = new HashMap<String,String>();
		if (result == 1) {
			map.put("success", "true");
			map.put("message", "删除信息成功");
		}else{
			map.put("success", "false");
			map.put("message", "删除信息失败");
		}
		return map;
	}


	@Override
	public List<Dept> getDeptList() {
		// TODO Auto-generated method stub
		return this.dao.getDeptList();
	}


	@Override
	public List<Dept> getDeptVillaList(int superDid) {
		// TODO Auto-generated method stub
		return this.dao.getDeptVillaList(superDid);
	}

}
