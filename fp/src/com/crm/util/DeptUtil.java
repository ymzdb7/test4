package com.crm.util;

import java.util.ArrayList;
import java.util.List;

import com.crm.entity.Dept;

public class DeptUtil {

	public static List<Dept> buildFormatDept(List<Dept> ld){

		List<Dept> ld0 = new ArrayList<Dept>();
		List<Dept> ld4 = getListDept(ld,4);
		List<Dept> ld3 = getListDept(ld,3);
		List<Dept> ld2 = getListDept(ld,2);
		List<Dept> ld1 = getListDept(ld,1);
		
		ld0.addAll(ld4);
		ld0.addAll(build(ld3,ld4));
		ld0.addAll(build(ld2,ld3));
		ld0.addAll(build(ld1,ld2));
		
		return ld0;
	}
	
	public static List<Dept> build(List<Dept> ld1,List<Dept> ld2){
		List<Dept> list = new ArrayList<Dept>();
		for (Dept d1 : ld1){				
			for (Dept d2 : ld2){
				if (d1.getSuperDid() == d2.getDid()){
					list.add(d1);
					d1.setDname(d2.getDname()+" "+d1.getDname());
				}
			}
		}
		
		return list;
	}

	public static List<Dept> getListDept(List<Dept> ld, int level){
		List<Dept> list = new ArrayList<Dept>();
		for (Dept d : ld){
			if (d.getUlevel()==level){
				list.add(d);
			}
		}
		return list;
	}
}





