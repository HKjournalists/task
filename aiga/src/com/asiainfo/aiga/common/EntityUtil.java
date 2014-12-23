package com.asiainfo.aiga.common;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.cfg.Configuration;
import org.hibernate.mapping.Column;
import org.hibernate.mapping.PersistentClass;
import org.hibernate.mapping.PrimaryKey;
import org.hibernate.mapping.Property;
import org.hibernate.mapping.Table;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.LocalSessionFactoryBean;
import org.springframework.web.servlet.support.RequestContextUtils;


/**
 * ��������������ʵ����õ���Ӧ�ı��������������ֶ���������
 * </p>
 * ע��po���������Ӧӳ���ļ���һ�£���Student.java��Student.hbm.xml<br>
 * //�޸�Ϊ��ע�ⷽʽ����hbm�ļ��Ѿ�����Ҫ
 * 
 * 
 * @Date��Nov 10, 2008
 * @Time��3:13:07 PM
 * 
 */
public class EntityUtil{

 private LocalSessionFactoryBean sessionFactory;
 
 public LocalSessionFactoryBean getSessionFactory()
{
	return sessionFactory;
}

 public EntityUtil(HttpServletRequest request){
	 ApplicationContext ctx=RequestContextUtils.getWebApplicationContext(request);
	 	this.sessionFactory=(LocalSessionFactoryBean)ctx.getBean("&sessionFactory");
 }

 public Configuration getHibernateConf()
{
	return this.getSessionFactory().getConfiguration();
}



private  PersistentClass getPersistentClass(Class<?> clazz) {
 
   PersistentClass pc = getHibernateConf().getClassMapping(
     clazz.getName());
   if (pc == null) {
//  hibernateConf = getHibernateConf().addClass(clazz);//*.hbm.xml��ʽ
    pc = getHibernateConf().getClassMapping(clazz.getName());

   }
   return pc;
  
 }

 /**
  * ������������ȡʵ���Ӧ�ı���
  * 
  * @param clazz
  *            ʵ����
  * @return ����
  */
 public String getTableName(Class<?> clazz) {
  return getPersistentClass(clazz).getTable().getName();
 }
 /**
  * ������������ȡ������Ӧ��ʵ����
  * 
  * @param String
  *            ����
  * @return ʵ����
  */
 public Object getClass(String tableName) {
	 
		   Iterator itTable = getHibernateConf().getTableMappings();
		   while(itTable.hasNext()){
			   Table table= (Table)itTable.next();
			   
			  if(table.getName().equals(tableName)){
				  System.out.println("key  "+table.getName().toString());
				  return table.getClass();
			  }
		   }
		return new Object();
	
	  
	 }
 /**
  * ������������ȡʵ���Ӧ��������ֶ����ƣ�ֻ������Ψһ���������
  * 
  * @param clazz
  *            ʵ����
  * @return �����ֶ�����
  */
 public  String getPrimaryKey(Class<?> clazz) {

  return getPrimaryKeys(clazz).getColumn(0).getName();

 }
 
 /**
  * ������������ȡʵ���Ӧ��������ֶ�����
  * 
  * @param clazz
  *            ʵ����
  * @return ��������primaryKey ������primaryKey.getColumn(i).getName()
  */
 public  PrimaryKey getPrimaryKeys(Class<?> clazz) {

  return getPersistentClass(clazz).getTable().getPrimaryKey();

 }

 /**
  * ����������ͨ��ʵ��������ԣ���ȡʵ�������Զ�Ӧ�ı��ֶ�����
  * 
  * @param clazz
  *            ʵ����
  * @param propertyName
  *            ��������
  * @return �ֶ�����
  */
 public  String getColumnName(Class<?> clazz, String propertyName) {
  PersistentClass persistentClass = getPersistentClass(clazz);
  Property property = persistentClass.getProperty(propertyName);
  Iterator<?> it = property.getColumnIterator();
  if (it.hasNext()) {
   Column column = (Column) it.next();
   return column.getName();
  }
  return null;
 }


}