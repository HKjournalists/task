package com.asiainfo.aiga.search.test;

import java.lang.reflect.Field;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.asiainfo.aiga.requisition.bo.AigaRequisition;
import com.asiainfo.aiga.search.dao.FileDAO;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.bo.extend.AigaInstCase;
import com.asiainfo.lucene.LuceneEntities.LuceneManager.LuceneIndexManager;

public class test {
	public enum Day

	{

		SUNDAY, MONDAY, TUESDAY, WEDNESDAY,

		THURSDAY, FRIDAY, SATURDAY,

		NOVALUE;

		public static Day toDay(String str)

		{

			try {

				return valueOf(str);

			}

			catch (Exception ex) {

				return NOVALUE;

			}

		}

	}

	public static void testMethod() {
		AigaCase ag = new AigaInstCase();
		ag.setCaseId(1);
		ag.setFunFolderId(1);
		ag.setCreateTime(new Timestamp(System.currentTimeMillis()));
		java.lang.reflect.Field[] classFields = ag.getClass()
				.getDeclaredFields();
		for (Field field : classFields) {
			String name = field.getName();

			String type = field.getGenericType().toString();
			System.out.println(name.lastIndexOf("."));
			String shortName = type.substring(type.lastIndexOf(".") + 1);
			System.out.println("name:" + shortName);
			// System.out.println("type:"+type);
		}
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception {

		LuceneIndexManager lim =new LuceneIndexManager();
		/*
		 * Scanner s=new Scanner(System.in);
		 * 
		 * String day=s.next();//输入的字符串
		 * 
		 * switch(Day.toDay(day.toUpperCase())){
		 * 
		 * case SUNDAY:
		 * 
		 * System.out.println("星期天");
		 * 
		 * break;
		 * 
		 * case MONDAY:
		 * 
		 * System.out.println("星期一");
		 * 
		 * break;
		 * 
		 * case TUESDAY:
		 * 
		 * System.out.println("星期二");
		 * 
		 * break;
		 * 
		 * }
		 */

		// 初始化索引
		// FileDAO f = new FileDAO();
		// List listIndex = f.getFile();
		// lim.createALL(listIndex);

		// 查询

	

		// testMethod();
//		createIndex();
		updateList();
//		testSearch();
	}
	public static  void createIndex() throws Exception{
		LuceneIndexManager lim =new LuceneIndexManager();
		FileDAO f = new FileDAO();
		List listIndex = f.getFile();
		lim.createALL(listIndex);
	}
	
	public static  void updateList() throws Exception{
		LuceneIndexManager lim =new LuceneIndexManager();
		FileDAO f = new FileDAO();
		System.out.println("begin delete index");
		List listIndex = f.getFile();
		for(Object obj : listIndex) {
			lim.delete(obj);
		}
		System.out.println("end delete index");
		lim.createALL(listIndex);
	}
	
	public static  void testSearch() throws Exception{
		LuceneIndexManager lim =new LuceneIndexManager();
		
		Map map1 = new HashMap();
	//	map1.put("caseName", "敏感"); //
		map1.put("reqName", "翁环宇");
		List list = lim.search(map1, AigaRequisition.class);
		System.out.println("-----------------------------------------");
		for (int i = 0; i < list.size(); i++) {
			AigaRequisition aigaReq = (AigaRequisition) list.get(i);
			System.out.println(aigaReq.getReqName());
	//		System.out.println(map.get(AigaCaseConstant.CASE_ID));
			System.out.println("-----------------------------------------");
	
		}
	}
}
