package com.asiainfo.lucene.test;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import com.asiainfo.aiga.common.DynamicBean;
import com.asiainfo.aiga.common.Tree;
import com.asiainfo.aiga.r_case_comp.bo.AigaRCaseComp;
import com.asiainfo.aiga.r_case_comp.bo.extend.AigaBaseRCaseComp;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.bo.extend.AigaBaseCase;

public class DynamicBeanTest {
	public static void main(String[] args) throws ClassNotFoundException {  
//		testClass();
//		testMap();
//		testStringBuffer();
//		testobjs();
		testExtendTree();
		
    } 
	public static void testobjs(){
		AigaCase aigaCase=new AigaBaseCase();
		AigaRCaseComp aigaRCaseComp=new AigaBaseRCaseComp();
		aigaCase.setAuthor("翁");
		aigaCase.setCaseName("你");
		aigaRCaseComp.setCaseId(1);
		aigaRCaseComp.setInVal("ss");
		Object[] objs=new Object[]{aigaCase,aigaRCaseComp};
		DynamicBean bean = new DynamicBean(objs);
		JSONObject json=JSONObject.fromObject(bean.getObject());
		System.out.println(json);
	}
	public static void testClass(){
		
		Class[] clazzs=new Class[]{AigaCase.class,AigaRCaseComp.class};
		  DynamicBean bean = new DynamicBean(clazzs); 
		  Object object = bean.getObject(); 
		  // 通过反射查看所有方法名  
	        Class clazz = object.getClass();  
	        Method[] methods = clazz.getDeclaredMethods();
	        for (int i = 0; i < methods.length; i++) {  
	        }
	       System.out.println(bean.getValue("caseId"));
	}
	public static void testMap() throws ClassNotFoundException{
		  
        // 设置类成员属性  
        HashMap propertyMap = new HashMap();  
  
        propertyMap.put("id", Class.forName("java.lang.Integer"));  
  
        propertyMap.put("name", Class.forName("java.lang.String"));  
  
        propertyMap.put("address", Class.forName("java.lang.String"));  
  
        // 生成动态 Bean  
        DynamicBean bean = new DynamicBean(propertyMap);  
  
        // 给 Bean 设置值  
        bean.setValue("id", new Integer(123));  
  
        bean.setValue("name", "454");  
  
        bean.setValue("address", "789");  
  
        // 从 Bean 中获取值，当然了获得值的类型是 Object  
  
        System.out.println("  >> id      = " + bean.getValue("id"));  
  
        System.out.println("  >> name    = " + bean.getValue("name"));  
  
        System.out.println("  >> address = " + bean.getValue("address"));
  
        // 获得bean的实体  
        Object object = bean.getObject();  
  
        // 通过反射查看所有方法名  
        Class clazz = object.getClass();  
        Method[] methods = clazz.getDeclaredMethods();  
        for (int i = 0; i < methods.length; i++) {  
            System.out.println(methods[i].getName());   
        } 
	}
	public static void testStringBuffer(){
		StringBuffer buffer=new StringBuffer();
		buffer.append("abc");
		buffer.append("abc");
		System.out.println(buffer);
		System.out.println(buffer.indexOf("ca"));
		
	}
	public static void testExtendTree(){
		Tree tree=new Tree();
		tree.setExpanded(false);
		tree.setId(1);
		tree.setParentId(2);
		tree.setQtip("sss");
//		testClass t=new com.asiainfo.lucene.test.testClass();
//		t.setCheckbox(true);
		boolean chekBox=true;
//		Object[] objs={tree,chekBox};
		Map map=new HashMap();
		map.put("checkBox", chekBox);
		 DynamicBean bean = new DynamicBean(tree,map); 
		 JSONObject json=new JSONObject();
		 json=JSONObject.fromObject(bean.getObject());
		 System.out.println(json);
	}
}
