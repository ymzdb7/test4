package com.crm.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.crm.entity.HolderInfo;

public class ResultMapUtil {

	public static Map<String, Object> resultMapObject(String success,String message,Object obj){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("success", success);
		map.put("message", message);
		if (obj != null) {
			map.put("data", obj);
		}
		return map;
	}

	public static Map<String, Object> resultMapObject(String success,String message){
		//Map<String,Object> mp = new HashMap<String,Object>();

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("success", success);
		map.put("message", message);
		//map.put("data", mp);
		return map;
	}

	public static Map<String, Object> resultMapObject(String success,String message
			,String errcode){
		//Map<String,Object> mp = new HashMap<String,Object>();

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("success", success);
		map.put("message", message);
		map.put("errcode", errcode);
		//map.put("data", mp);
		return map;
	}

	public static Map<String, Object> resultMapObject(boolean b, String message) {
		return  resultMapObject(String.valueOf(b),message);
	}

	public static Map<String, Object> resultMapObject(boolean b, String message,
			Object obj) {
		return resultMapObject(String.valueOf(b),message, obj);
	}

}
