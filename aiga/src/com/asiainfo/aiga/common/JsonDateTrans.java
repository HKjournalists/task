package com.asiainfo.aiga.common;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

public class JsonDateTrans implements JsonValueProcessor {

	private String format = "yyyy-MM-dd HH:mm:ss";
	private String filter="00:00:00";

	public Object processArrayValue(Object value, JsonConfig config) {
		return process(value);
	}

	public Object processObjectValue(String key, Object value, JsonConfig config) {
		return process(value);
	}

	private Object process(Object value) {

		if (value instanceof Date) {
			SimpleDateFormat sdf = new SimpleDateFormat(format);
			String timeFormat=sdf.format(value);
			return (timeFormat.endsWith(filter)?timeFormat.replace(filter, ""):timeFormat).trim();
		}
		if (value instanceof Timestamp) {
			SimpleDateFormat sdf = new SimpleDateFormat(format);
			Timestamp time = (Timestamp)value;
			String timeFormat= sdf.format(time.getTime());
			return (timeFormat.endsWith(filter)?timeFormat.replace(filter, ""):timeFormat).trim();
		}
		return value == null ? "" : value.toString();
	}
}
