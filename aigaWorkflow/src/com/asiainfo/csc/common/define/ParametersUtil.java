package com.asiainfo.csc.common.define;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class ParametersUtil {
	private static Properties pro = new Properties();
	private static String PARAM_FILE_NAME = "interfaceConfig.properties";
	private static Map<String, String> params = new HashMap<String, String>();

	static {
		init();
	}

	public static String getPro(String key) {
		String val = params.get(key);
		if(val==null){
			val = pro.getProperty(key);
			params.put(key, val);
		}return val;
	}

	private static void init() {
		InputStream is = ParametersUtil.class.getClassLoader().getResourceAsStream(PARAM_FILE_NAME);

		try {
			pro.load(is);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (null != is) {
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
