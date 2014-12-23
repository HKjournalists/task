package com.asiainfo.aiga.common.aigaUrlConfig;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import com.asiainfo.aiga.common.LoginFilter;

public class AigaUrlConfigUtil {

	private static Map<String,String> map = new HashMap<String, String>();
	
	static{
		InputStream in = LoginFilter.class.getClassLoader().getResourceAsStream("aigaUrlConfig.properties");
		Properties p = new Properties();
		try {
			p.load(in);
			for(Object key : p.keySet()){
				map.put(key.toString(), p.getProperty(key.toString()));
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("aigaUrlConfig.propertiesÎÄ¼þ¼ÓÔØÊ§°Ü");
			e.printStackTrace();
		}
	}
	
	public static String getValue(String key) {
		return map.get(key);
	}
}
