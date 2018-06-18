package com.crm.util;

public class IntegerArrayUtil {

	public static Integer[] concat(Integer[] a, Integer[] b) {
		Integer[] c = new Integer[a.length + b.length];
		System.arraycopy(a, 0, c, 0, a.length);
		System.arraycopy(b, 0, c, a.length, b.length);
		return c;
	}

}
