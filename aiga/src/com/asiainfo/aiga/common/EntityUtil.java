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
 * 功能描述：根据实体类得到对应的表名、主键名、字段名工具类
 * </p>
 * 注：po类名须与对应映射文件名一致，即Student.java与Student.hbm.xml<br>
 * //修改为主注解方式，此hbm文件已经不需要
 * 
 * 
 * @Date：Nov 10, 2008
 * @Time：3:13:07 PM
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
//  hibernateConf = getHibernateConf().addClass(clazz);//*.hbm.xml方式
    pc = getHibernateConf().getClassMapping(clazz.getName());

   }
   return pc;
  
 }

 /**
  * 功能描述：获取实体对应的表名
  * 
  * @param clazz
  *            实体类
  * @return 表名
  */
 public String getTableName(Class<?> clazz) {
  return getPersistentClass(clazz).getTable().getName();
 }
 /**
  * 功能描述：获取表名对应的实体类
  * 
  * @param String
  *            表名
  * @return 实体类
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
  * 功能描述：获取实体对应表的主键字段名称，只适用于唯一主键的情况
  * 
  * @param clazz
  *            实体类
  * @return 主键字段名称
  */
 public  String getPrimaryKey(Class<?> clazz) {

  return getPrimaryKeys(clazz).getColumn(0).getName();

 }
 
 /**
  * 功能描述：获取实体对应表的主键字段名称
  * 
  * @param clazz
  *            实体类
  * @return 主键对象primaryKey ，可用primaryKey.getColumn(i).getName()
  */
 public  PrimaryKey getPrimaryKeys(Class<?> clazz) {

  return getPersistentClass(clazz).getTable().getPrimaryKey();

 }

 /**
  * 功能描述：通过实体类和属性，获取实体类属性对应的表字段名称
  * 
  * @param clazz
  *            实体类
  * @param propertyName
  *            属性名称
  * @return 字段名称
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