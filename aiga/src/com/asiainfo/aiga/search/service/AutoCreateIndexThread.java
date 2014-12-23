package com.asiainfo.aiga.search.service;

import java.lang.reflect.Method;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.asiainfo.aiga.search.bo.AigaExtIndex;
import com.asiainfo.aiga.search.dao.ILuceneSearchDAO;
import com.asiainfo.lucene.LuceneEntities.LuceneManager.LuceneIndexManager;

public class AutoCreateIndexThread implements Runnable {
	
	private static Thread thread;
	
	private LuceneIndexManager lim;
	
	private ILuceneSearchDAO searchDAO;
	
	
	public void setSearchDAO(ILuceneSearchDAO searchDAO) {
		this.searchDAO = searchDAO;
	}
	
	public void run() {
		String circleStr = lim.getRefreshCircle();
		int circle = (circleStr == null || "".equals(circleStr)) ? 5: Integer.parseInt(circleStr);
		try {
			searchDAO.initStatus("0");
		} catch (SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		while (true) {
			try {
				List<String> list=searchDAO.getAddWords();
				for(String str:list){
//				System.out.println("添加字典单词-->"+str);
				}
				if(list.size()>0)searchDAO.setWordStatus(list);
				this.lim.setAddWords(list);
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			List tempList=new ArrayList();
			List<AigaExtIndex> newIndexes = null;
			
			try {
				newIndexes = searchDAO.getNewExtIndexList();
				for(AigaExtIndex index : newIndexes) {
					Object obj = getIndexVals(index);
					tempList.add(obj);
				}
				
				if(tempList.size()>0)lim.createALL(tempList);
				for(AigaExtIndex index : newIndexes) {
					index.setDealStatus(1);
					index.setDealTime(new Date());
					searchDAO.saveExtIndex(index);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (InterruptedException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					Thread.sleep(circle *60* 1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	private Object getIndexVals(AigaExtIndex index) throws Exception {
		Class curIndex = Class.forName(index.getIndexClass());
		Object obj = curIndex.newInstance();
		invokeIndexMethod(obj, index.getIndexIdName(), index.getIndexIdValue(), Integer.class);
		invokeIndexMethod(obj, index.getExtField1(), index.getExtField1Val(), String.class);
		invokeIndexMethod(obj, index.getExtField2(), index.getExtField2Val(), String.class);
		
		return obj;
	}
	
	private void invokeIndexMethod(Object obj, String fieldName, Object fieldVal, Class typeClass) throws Exception {
		String methodName = "set" + fieldName.substring(0, 1).toUpperCase() + fieldName.substring(1);
		Method method = obj.getClass().getMethod(methodName, typeClass);
		if(typeClass.getName().equals("com.asiainfo.aiga.userCase.bo.AigaFunFolder") && "sysName".equals(fieldName)) {
			String[] ary = fieldVal.toString().split(",,,");
			if(ary.length == 2) {
				String sysName = ary[0];
				String menuPath = ary[1];
				String[] menuAry = menuPath.split("-->");
				if(menuAry.length > 2) {
					fieldVal = sysName + "-->" + menuAry[menuAry.length-1];
				} else {
					fieldVal = sysName;
				}
			}
		}
		method.invoke(obj, fieldVal);
	}
	
	public void initMethod() throws Exception {
		try {
			lim = new LuceneIndexManager();
			thread = new Thread(this, "索引自动更新");
			thread.start();
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
	}
	
	public void destroyMethod() throws Exception {
		thread.interrupt();
	}

}
