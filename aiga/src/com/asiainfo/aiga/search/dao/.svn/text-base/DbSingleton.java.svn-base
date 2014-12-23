package com.asiainfo.aiga.search.dao;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.servlet.support.RequestContextUtils;

public class DbSingleton {
	private static DbSingleton dbSingleton;
	private DbSingleton(){}
	public static DbSingleton getDbSingletonInstance(){
		
		if(dbSingleton==null)dbSingleton=new DbSingleton();
		return dbSingleton;
		
	}
	public static  SessionFactory getSessionFactory(HttpServletRequest request){
		ApplicationContext applicationContext =RequestContextUtils.getWebApplicationContext(request);
		return (SessionFactory)applicationContext.getBean("sessionFactory");
	}
	public static  Session getCurrentSession(HttpServletRequest request){
		return getSessionFactory(request).getCurrentSession();
	}
}
