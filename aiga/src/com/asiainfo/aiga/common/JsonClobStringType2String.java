package com.asiainfo.aiga.common;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

import org.hibernate.lob.SerializableClob;

public class JsonClobStringType2String implements JsonValueProcessor {

	public Object processArrayValue(Object value, JsonConfig config) {
		return process(value);
	}

	public Object processObjectValue(String key, Object value, JsonConfig config) {
		return process(value);
	}

	private Object process(Object value) {
		if (value == null){
			return "";
		}else {
			SerializableClob sc = (SerializableClob) value;
			char[] buffer = null;
			try {
				// 根据CLOB长度创建字符数组
				buffer = new char[(int) sc.length()];
				// 获取CLOB的字符流Reader,并将内容读入到字符数组中
				sc.getCharacterStream().read(buffer);
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 转换为字符串
			return String.valueOf(buffer);
		}
	}

}
