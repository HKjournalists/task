package com.asiainfo.aiga.common;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

public class JsonStringTrans implements JsonValueProcessor{

	public Object processArrayValue(Object value, JsonConfig config) {
		// TODO Auto-generated method stub
		return process(value);
	}

	public Object processObjectValue(String key, Object value, JsonConfig config) {
		// TODO Auto-generated method stub
		return process(value);
	}

	private Object process(Object value) {
		if(value==null)
			return "";
		else{
			String val = value.toString();
			if(val.indexOf("[")==0&&val.lastIndexOf("]")==val.length()-1){
				return "\""+val+"\"";
			}
			else
				return val;//.replaceAll("<", "&lt; ").replaceAll(">", " &gt;").replaceAll(">", "&gt;").replaceAll("\"", "&quot;").replaceAll("\'", "&acute;").toString();
		}
	}
}
