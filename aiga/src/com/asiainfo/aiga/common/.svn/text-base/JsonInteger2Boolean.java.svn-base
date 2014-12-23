package com.asiainfo.aiga.common;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

public class JsonInteger2Boolean implements JsonValueProcessor{
	public Object processArrayValue(Object value, JsonConfig config) {
	// TODO Auto-generated method stub
	return value;
}

public Object processObjectValue(String key, Object value, JsonConfig config) {
	if(key!=null&&key.startsWith("is")){
		if(value!=null&&value.toString().equals("1"))
		return "on";
		else return "";
	
	}
	else
	return value;
}

}
