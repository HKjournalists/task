package com.asiainfo.aiga.common;
import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import net.sf.cglib.beans.BeanGenerator;
import net.sf.cglib.beans.BeanMap;
  
/** 
 *  
 * @author wenghy
 * 
 */  
public class DynamicBean {  
  
    /** 
      * 实体Object 
      */  
    private  Object object = null;  
  
    /** 
      * 属性map 
      */  
    private  BeanMap beanMap = null;
    /**
     * 存值map
     */
    private Map valMap=null;
  
    public DynamicBean() {  
        super();  
    }  
    /**
     * 构造函数[空值]
     * @param propertyMap
     */
    public DynamicBean(Map propertyMap) {  
      this.object = generateBean(propertyMap);  
      this.beanMap = BeanMap.create(this.object);
    }
    /**
     * 构造函数[空值]
     * @param clazzs
     */
    public DynamicBean(Class[] clazzs) {  
        this.object = generateBean(clazzs);  
        this.beanMap = BeanMap.create(this.object);
      }
    /**
     * 构造函数[带值]
     * @param objs
     */
    public DynamicBean(Object[] objs) {  
        this.object = generateBean(objs);  
        this.beanMap = BeanMap.create(this.object);
        if(this.valMap!=null){
        	this.beanMap.putAll(valMap);
        }
      } 
    /**
     * 构造函数[带值]
     * @param objs
     */
    public DynamicBean(Object obj,Map objMap) {  
        this.object = generateBean(obj,objMap);  
        this.beanMap = BeanMap.create(this.object);
        if(this.valMap!=null){
        	this.beanMap.putAll(valMap);
        }
      } 
    /** 
      * 给bean属性赋值 
      * @param property 属性名 
      * @param value 值 
      */  
    public void setValue(String property, Object value) {
      beanMap.put(property, value);
    }  
  
    /** 
      * 通过属性名得到属性值 
      * @param property 属性名 
      * @return 值 
      */  
    public Object getValue(String property) {  
      return beanMap.get(property);  
    }  
  
    /** 
      * 得到该实体bean对象 
      * @return 
      */  
    public Object getObject() {  
      return this.object;  
    }  
  
    /**
     * 生成对象
     * @param propertyMap
     * @return
     */
    private Object generateBean(Map propertyMap) {  
      BeanGenerator generator = new BeanGenerator();  
      Set keySet = propertyMap.keySet();  
      for (Iterator i = keySet.iterator(); i.hasNext();) {  
       String key = (String) i.next();  
       generator.addProperty(key, (Class) propertyMap.get(key));
      }  
      return generator.create();  
    }
    /**
     * 生成对象
     * @param clazzs
     * @return
     */
    private Object generateBean(Class[] clazzs) {  
        BeanGenerator generator = new BeanGenerator();
        StringBuffer strBf=new StringBuffer();
        for(Class clazz:clazzs){
        	Field[] fields=clazz.getDeclaredFields();
        	for(Field field:fields){
        		Class fieldClass=field.getType();
        		String strField=field.getName();
    	        if(strBf.indexOf(strField)==-1){
    	        	generator.addProperty(strField,fieldClass );
    	        	strBf.append(strField+"-");
    	        }
        	}
        }

        return generator.create();  
      }
    /** 
     * 生成对象
     * @param objs
     * @return
     */
    private Object generateBean(Object[] objs) {
      BeanGenerator generator = new BeanGenerator();
      valMap=new HashMap();
      StringBuffer strBf=new StringBuffer();
      for(Object obj:objs){
    	  Class clazz=obj.getClass();
    	  do{
    		  setClassValue(obj,clazz,generator,strBf);
    		  clazz=clazz.getSuperclass();
    	  }while(!clazz.equals(Object.class));
      }
 
      return generator.create();  
    } 
    /** 
     * 生成对象
     * @param objs
     * @return
     */
    private Object generateBean(Object obj,Map objMap) {
      BeanGenerator generator = new BeanGenerator();
      valMap=new HashMap();
      StringBuffer strBf=new StringBuffer();
      Set keySet = objMap.keySet();  
      for (Iterator i = keySet.iterator(); i.hasNext();) {  
       String key = (String) i.next();  
       strBf.append(key+"-");
       if(objMap.get(key)!=null){
    	   generator.addProperty(key, objMap.get(key).getClass());
       }else{
    	   
       }
       valMap.put(key,objMap.get(key) );
      } 
    	  Class clazz=obj.getClass();
    	  do{
    		  setClassValue(obj,clazz,generator,strBf);
    		  clazz=clazz.getSuperclass();
    	  }while(!clazz.equals(Object.class));
      
 
      return generator.create();  
    }
    public void setClassValue(Object obj,Class clazz,BeanGenerator generator,StringBuffer strBf){
	  	Field[] fields=clazz.getDeclaredFields();
    	for(Field field:fields){
    		 field.setAccessible(true);
    		 //获取属性类型
    		Class fieldClass=field.getType();
    		//获取属性名
    		String strField=field.getName();
	        if(strBf.indexOf(strField)==-1){
	        	generator.addProperty(strField,fieldClass );
	        	strBf.append(strField+"-");
	        	try {
	        		//获取属性值
	        		valMap.put(strField, field.get(obj));
				} catch (IllegalArgumentException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				}
	        }
    	}
    }
}  