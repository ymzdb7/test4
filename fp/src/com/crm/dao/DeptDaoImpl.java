package com.crm.dao;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.crm.entity.Dept;
import com.crm.entity.Level;
import com.crm.entity.Org;
import com.crm.entity.Role;
import com.crm.mapper.DeptMapper;

@Repository
public class DeptDaoImpl implements DeptDao {

	@Resource
	private DeptMapper mapper;

	@Override
	public List<Dept> getAllDept() {
		return this.mapper.getAllDept();
	}

	@Override
	public List<Dept> getDeptInfo(Map<String, Integer> map) {
		return this.mapper.getDeptInfo(map);
	}

	/**
	 * 根据部门ID活动部门名称
	 * 
	 * @param ds
	 * @param id
	 * @return
	 */
	@Override
	public Dept getDeptNameById( int id) {
		return this.mapper.getDeptNameById(id);
	}

	/**
	 * 根据部门ID活动部门名称
	 * 
	 * @param ds
	 * @param id
	 * @return
	 */
	@Override
	public String getDeptNameById(List<Dept> ds, int id) {

		List<Dept> td = null;
		if (ds != null) {
			td = ds;
		} else {
			td = this.getAllDept();
		}

		for (Iterator<Dept> i = td.iterator(); i.hasNext();) {
			Dept dd = i.next();
			if (dd.getDid() == id) {
				return dd.getDname();
			}
		}
		return null;
	}

	@Override
	public List<Level> getAllLevel() {
		return this.mapper.getAllLevel();
	}

	public String getLevelNameById(List<Level> ds, int id) {
		List<Level> td = null;
		if (ds != null) {
			td = ds;
		} else {
			td = this.getAllLevel();
		}

		for (Level d : td) {
			Level dd = d;
			if (dd.getUlevel() == id) {
				return dd.getDlname();
			}
		}
		return null;
	}

	@Override
	public int getTotalDept() {
		return this.mapper.getTotalDept();
	}

	@Override
	public int getMaxDid() {
		return this.mapper.getMaxDid();
	}

	@Override
	public List<Dept> getSuperDept(Integer cl) {
		return this.mapper.getSuperDept(cl);
	}

	@Override
	public int saveDept(Dept dept) {
		// 新增
		if (dept.getFlaged().equals("a")) {
			return this.mapper.insertDept(dept);
			// 修改
		} else if (dept.getFlaged().equals("m")) {
			return this.mapper.updateDept(dept);
		}
		return 0;

	}

	@Override
	public Integer checkDeptIsUsed(Integer did) {
		return this.mapper.checkDeptIsUsed(did);
	}

	@Override
	public int deleteDept(Integer did) {
		return this.mapper.deleteDept(did);
	}

	@Override
	public int getMaxOid() {
		return this.mapper.getMaxOid();
	}

	@Override
	public int saveOrg(Org org) {
		// 新增
		if (org.getFlaged().equals("a")) {
			return this.mapper.insertOrg(org);
			// 修改
		} else if (org.getFlaged().equals("m")) {
			return this.mapper.updateOrg(org);
		}
		return 0;

	}

	@Override
	public int deleteOrg(Integer oid) {
		return this.mapper.deleteOrg(oid);
	}

	@Override
	public List<Dept> getDeptList() {
		// TODO Auto-generated method stub
		return this.mapper.getDeptList();
	}

	@Override
	public List<Dept> getDeptVillaList(int superDid) {
		// TODO Auto-generated method stub
		return this.mapper.getDeptVillaList(superDid);
	}

}
