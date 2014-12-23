package com.asiainfo.aiga.sysConstant.util;

import java.util.Map;
import java.util.TreeMap;

import com.asiainfo.aiga.userCase.bo.AigaBaseBusi;
import com.asiainfo.aiga.userCase.bo.AigaBusi;
import com.asiainfo.aiga.userCase.dao.IAigaBaseBusiDAO;
import com.asiainfo.aiga.userCase.dao.IAigaBusiDAO;

public class LabelMapUtil {
	private IAigaBusiDAO busiDao;
	private IAigaBaseBusiDAO baseBusiDao;
	
	public static Map<String, Map<String, String>> getLabelNameMap() {
		return labelNameMap;
	}

	public void setBusiDao(IAigaBusiDAO busiDao) {
		this.busiDao = busiDao;
	}

	public void setBaseBusiDao(IAigaBaseBusiDAO baseBusiDao) {
		this.baseBusiDao = baseBusiDao;
	}

	
	public static Map<String, Map<String, String>> getLabelIdMap() {
		return labelIdMap;
	}

	public static void setLabelIdMap(Map<String, Map<String, String>> labelIdMap) {
		LabelMapUtil.labelIdMap = labelIdMap;
	}

	private static Map<String,Map<String,String>> labelNameMap;
	private static Map<String,Map<String,String>> labelIdMap;
	
	static{
		labelNameMap = new TreeMap<String, Map<String,String>>();
		labelIdMap = new TreeMap<String, Map<String,String>>();
	}
	
	public void initAigaBusi()throws Exception{
		labelNameMap.remove("aigaBusiMap");
		labelIdMap.remove("aigaBusiMap");
		String querySql = "from AigaBusi a";
		AigaBusi[] aigaBusis = busiDao.getAigaBusiBySql(querySql);
		Map<String,String> rowMap = new TreeMap<String, String>();
		Map<String,String> rowMap2 = new TreeMap<String, String>();
		for(int i=0,n=aigaBusis.length;i<n;i++){
			String busiId = aigaBusis[i].getBusiId().toString();
			rowMap.put(busiId, aigaBusis[i].getBusiName());
			rowMap2.put(aigaBusis[i].getBusiName(), busiId);
		}
		labelNameMap.put("aigaBusiMap", rowMap);
		labelIdMap.put("aigaBusiMap", rowMap2);
	}
	
	public static String getAigaBusiName(String busiId){
		Map<String, String> rowMap = labelNameMap.get("aigaBusiMap");
		if(rowMap==null){
			return null;
		}
		else{
			String name = rowMap.get(busiId);
			if(name==null){
				return null;
			}
			else{
				return name;
			}
		}
	}
	public static String getAigaBusiId(String busiName){
		Map<String, String> rowMap2 = labelIdMap.get("aigaBusiMap");
		if(rowMap2==null){
			return null;
		}
		else{
			String id = rowMap2.get(busiName);
			if(id==null){
				return null;
			}
			else{
				return id;
			}
		}
	}
	
	public void initLabelMap()throws Exception{
		labelNameMap.clear();
		labelIdMap.clear();
		this.initAigaBusi();
		this.initAigaBaseBusi();
	}
	
	public void initAigaBaseBusi()throws Exception{
		labelNameMap.remove("aigaBaseBusiMap");
		labelIdMap.remove("aigaBaseBusiMap");
		String querySql = "from AigaBaseBusi a";
		AigaBaseBusi[] aigaBaseBusis = baseBusiDao.getAigaBaseBusiBySql(querySql);
		Map<String,String> rowMap = new TreeMap<String, String>();
		Map<String,String> rowMap2 = new TreeMap<String, String>();
		for(int i=0,n=aigaBaseBusis.length;i<n;i++){
			String busiId = aigaBaseBusis[i].getBusiId().toString();
			rowMap.put(busiId, aigaBaseBusis[i].getBusiName());
			rowMap2.put(aigaBaseBusis[i].getBusiName(), busiId);
		}
		labelNameMap.put("aigaBaseBusiMap", rowMap);
		labelIdMap.put("aigaBaseBusiMap", rowMap2);
	}
	
	public static String getAigaBaseBusiName(String busiId){
		Map<String, String> rowMap = labelNameMap.get("aigaBaseBusiMap");
		if(rowMap==null){
			return null;
		}
		else{
			String name = rowMap.get(busiId);
			if(name==null){
				return null;
			}
			else{
				return name;
			}
		}
	}
	
	public static String getAigaBaseBusiId(String busiName){
		Map<String, String> rowMap2 = labelIdMap.get("aigaBaseBusiMap");
		if(rowMap2==null){
			return null;
		}
		else{
			String id = rowMap2.get(busiName);
			if(id==null){
				return null;
			}
			else{
				return id;
			}
		}
	}
	
	public static void main(String[] args)throws Exception{
/*		ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
		applicationContext.getBean("labelMapInt");
		System.out.println("0>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+LabelMapUtil.getAigaBaseBusiName("2"));*/
	}
}
