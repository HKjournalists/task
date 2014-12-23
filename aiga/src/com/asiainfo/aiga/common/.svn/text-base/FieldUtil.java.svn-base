package com.asiainfo.aiga.common;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

public class FieldUtil {
	
	/**
	 * */
    public static Object getFieldValueByName(String fieldName, Object o) throws Exception {
        try {
            String firstLetter = fieldName.substring(0, 1).toUpperCase();
            String getter = "get" + firstLetter + fieldName.substring(1);
            Method method = o.getClass().getMethod(getter, new Class[] {});
            Object value = method.invoke(o, new Object[] {});
            return value;
        } catch (Exception e) {
//        	log.error(e.getMessage(),e);
            throw new Exception(e.getMessage());
        }  
    }
    
    public static Object castValueOf(Class curClass, String val) throws Exception {
    	Method method = curClass.getMethod("valueOf", String.class);
    	Object value = method.invoke(curClass, val);
    	return value;
    }
    
    public static void setFieldValueByName(String fieldName, Object o, Object val, Class type) throws Exception {
        try {
            String firstLetter = fieldName.substring(0, 1).toUpperCase();
            String setter = "set" + firstLetter + fieldName.substring(1);
            Method method = o.getClass().getMethod(setter, new Class[] {type});
            method.invoke(o, new Object[] {val});
        } catch (Exception e) {
//        	log.error(e.getMessage(),e);
			throw new Exception(e.getMessage());
        }  
    }
    
    /**
     * */
    public static String[] getFiledName(Object o) throws Exception {
    	Field[] fields=o.getClass().getDeclaredFields();
       	String[] fieldNames=new String[fields.length];
    	for(int i=0;i<fields.length;i++){
//    		System.out.println(fields[i].getType());
    		fieldNames[i]=fields[i].getName();
    	}
    	return fieldNames;
    }
    
    /**
     * */
    public static List getFiledsInfo(Object o) throws Exception {
    	Field[] fields=o.getClass().getDeclaredFields();
       	String[] fieldNames=new String[fields.length];
       	List list = new ArrayList();
       	Map infoMap=null;
    	for(int i=0;i<fields.length;i++){
    		infoMap = new HashMap();
    		infoMap.put("type", fields[i].getType());
    		infoMap.put("name", fields[i].getName());
    		infoMap.put("value", getFieldValueByName(fields[i].getName(), o));
    		list.add(infoMap);
    	}
    	return list;
    }
    
    /**
     * */
    public static Object[] getFiledValues(Object o) throws Exception {
    	String[] fieldNames = getFiledName(o);
    	Object[] value = new Object[fieldNames.length];
    	for(int i = 0; i < fieldNames.length; i++){
    		value[i] = getFieldValueByName(fieldNames[i], o);
    	}
    	return value;
    }
    
    public static JSONObject objToJson(Object o) throws Exception {
    	String[] fields = getFiledName(o);
    	JSONObject json = new JSONObject();
    	for(String field : fields) {
    		json.put(field, getFieldValueByName(field, o));
    	}
    	return json;
    }

}
