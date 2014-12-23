package com.asiainfo.csc.common.bo;

import java.util.Iterator;
import java.util.Map;
import java.util.HashMap;
import java.sql.ResultSet;
import java.sql.Connection;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.util.criteria.Criteria;
import com.ai.appframe2.bo.DataContainerFactory;

import com.asiainfo.csc.common.ivalues.*;

public class BOStaffRoleOrgDistViewEngine {

  public static BOStaffRoleOrgDistViewBean[] getBeans(DataContainerInterface dc) throws
      Exception {
    Map ps = dc.getProperties();
    StringBuffer buffer = new StringBuffer();
    Map pList = new HashMap();
    for (java.util.Iterator cc = ps.entrySet().iterator(); cc.hasNext(); ) {
      Map.Entry e = (Map.Entry) cc.next();
      if(buffer.length() >0)
         buffer.append(" and ");
      buffer.append(e.getKey().toString() + " = :p_" + e.getKey().toString());
      pList.put("p_" + e.getKey().toString(),e.getValue());
    }
    Connection conn = ServiceManager.getSession().getConnection();
    try {
      return getBeans(buffer.toString(), pList);
    }finally{
      if (conn != null)
        conn.close();
    }
  }

  
  public static  BOStaffRoleOrgDistViewBean[] getBeans(Criteria sql) throws Exception{
   return getBeans(sql,-1,-1,false);
  }
 public static  BOStaffRoleOrgDistViewBean[] getBeans(Criteria sql,int startNum,int endNum,boolean isShowFK) throws Exception{
    String[] cols = null;
    String condition = "";
    Map param = null;
    if(sql != null){
      cols = (String[])sql.getSelectColumns().toArray(new String[0]);
      condition = sql.toString();
      param = sql.getParameters();
    }
    return (BOStaffRoleOrgDistViewBean[])getBeans(cols,condition,param,startNum,endNum,isShowFK);
  }




  public static  BOStaffRoleOrgDistViewBean[] getBeans(String condition,Map parameter) throws Exception{
	return getBeans(null,condition,parameter,-1,-1,false);
  }

  public static  BOStaffRoleOrgDistViewBean[] getBeans(String[] cols,String condition,Map parameter,
           int startNum,int endNum,boolean isShowFK) throws Exception{
        Connection conn = null;
        try {
                conn = ServiceManager.getSession().getConnection();
                return (BOStaffRoleOrgDistViewBean[])ServiceManager.getDataStore().retrieve(conn,BOStaffRoleOrgDistViewBean.class,BOStaffRoleOrgDistViewBean.getObjectTypeStatic(),cols,condition,parameter,startNum,endNum,isShowFK,false,null);
        }catch(Exception e){
                throw e;
        }finally{
           if (conn != null)
              conn.close();
        }
  }

   public static  BOStaffRoleOrgDistViewBean[] getBeans(String[] cols,String condition,Map parameter,
          int startNum,int endNum,boolean isShowFK,String[] extendBOAttrs) throws Exception{
          Connection conn = null;
          try {
                  conn = ServiceManager.getSession().getConnection();
                  return (BOStaffRoleOrgDistViewBean[])ServiceManager.getDataStore().retrieve(conn,BOStaffRoleOrgDistViewBean.class,BOStaffRoleOrgDistViewBean.getObjectTypeStatic(),cols,condition,parameter,startNum,endNum,isShowFK,false,extendBOAttrs);
          }catch(Exception e){
                  throw e;
          }finally{
        	if (conn != null)
                  conn.close();
          }
   }


   public static int getBeansCount(String condition,Map parameter) throws Exception{
     Connection conn = null;
      try {
              conn = ServiceManager.getSession().getConnection();
              return ServiceManager.getDataStore().retrieveCount(conn,BOStaffRoleOrgDistViewBean.getObjectTypeStatic(),condition,parameter,null);
      }catch(Exception e){
              throw e;
      }finally{
          if (conn != null)
              conn.close();
      }
   }

   public static int getBeansCount(String condition,Map parameter,String[] extendBOAttrs) throws Exception{
      	Connection conn = null;
        try {
                conn = ServiceManager.getSession().getConnection();
                return ServiceManager.getDataStore().retrieveCount(conn,BOStaffRoleOrgDistViewBean.getObjectTypeStatic(),condition,parameter,extendBOAttrs);
        }catch(Exception e){
                throw e;
        }finally{
          if (conn != null)
              conn.close();
        }
   }

  public static void save( BOStaffRoleOrgDistViewBean aBean) throws Exception
  {
  	Connection conn = null;
	try {
		conn = ServiceManager.getSession().getConnection();
   		ServiceManager.getDataStore().save(conn,aBean);
   	}catch(Exception e){
		throw e;
	}finally{
	  if (conn != null)
		  conn.close();
	}
  }

   public static  void save( BOStaffRoleOrgDistViewBean[] aBeans) throws Exception{
     	Connection conn = null;
        try {
                conn = ServiceManager.getSession().getConnection();
                ServiceManager.getDataStore().save(conn,aBeans);
        }catch(Exception e){
                throw e;
        }finally{
          if (conn != null)
              conn.close();
        }
   }

   public static  void saveBatch( BOStaffRoleOrgDistViewBean[] aBeans) throws Exception{
     	Connection conn = null;
        try {
                conn = ServiceManager.getSession().getConnection();
                ServiceManager.getDataStore().saveBatch(conn,aBeans);
        }catch(Exception e){
                throw e;
        }finally{
          if (conn != null)
              conn.close();
        }
   }


  public static  BOStaffRoleOrgDistViewBean[] getBeansFromQueryBO(String soureBO,Map parameter) throws Exception{
      Connection conn = null;
      ResultSet resultset = null;
      try {
              conn = ServiceManager.getSession().getConnection();
              String sql = ServiceManager.getObjectTypeFactory().getInstance(soureBO).getMapingEnty();
              resultset =ServiceManager.getDataStore().retrieve(conn,sql,parameter);
              return (BOStaffRoleOrgDistViewBean[])ServiceManager.getDataStore().crateDtaContainerFromResultSet(BOStaffRoleOrgDistViewBean.class,BOStaffRoleOrgDistViewBean.getObjectTypeStatic(),resultset,null,true);

      }catch(Exception e){
              throw e;
      }finally{
          if(resultset!=null)resultset.close();
          if (conn != null)
              conn.close();
      }
   }

     public static  BOStaffRoleOrgDistViewBean[] getBeansFromSql(String sql,Map parameter) throws Exception{
      Connection conn = null;
      ResultSet resultset = null;
      try {
              conn = ServiceManager.getSession().getConnection();
              resultset =ServiceManager.getDataStore().retrieve(conn,sql,parameter);
              return (BOStaffRoleOrgDistViewBean[])ServiceManager.getDataStore().crateDtaContainerFromResultSet(BOStaffRoleOrgDistViewBean.class,BOStaffRoleOrgDistViewBean.getObjectTypeStatic(),resultset,null,true);

      }catch(Exception e){
              throw e;
      }finally{
          if(resultset!=null)resultset.close();
          if (conn != null)
              conn.close();
      }
   }

   public static java.math.BigDecimal getNewId() throws Exception{
       return ServiceManager.getIdGenerator().getNewId(BOStaffRoleOrgDistViewBean.getObjectTypeStatic());
   }

/*
   public static java.sql.Timestamp getSysDate() throws Exception{
       return ServiceManager.getIdGenerator().getSysDate(BOStaffRoleOrgDistViewBean.getObjectTypeStatic());
   }
*/

   public static BOStaffRoleOrgDistViewBean wrap(DataContainerInterface source,Map colMatch,boolean canModify){
     try{
       return (BOStaffRoleOrgDistViewBean)DataContainerFactory.wrap(source,BOStaffRoleOrgDistViewBean.class,colMatch,canModify);
     }catch(Exception e){
       if(e.getCause()!=null)
         throw new RuntimeException(e.getCause());
       else
         throw new RuntimeException(e);
     }
   }
   public static BOStaffRoleOrgDistViewBean copy(DataContainerInterface source,Map colMatch,boolean canModify){
     try {
       BOStaffRoleOrgDistViewBean result = new BOStaffRoleOrgDistViewBean();
       DataContainerFactory.copy(source, result, colMatch);
       return result;
     }
     catch (AIException ex) {
       if(ex.getCause()!=null)
         throw new RuntimeException(ex.getCause());
       else
         throw new RuntimeException(ex);
     }
    }

   public static BOStaffRoleOrgDistViewBean transfer(IBOStaffRoleOrgDistViewValue value) {
   	if(value==null)
   		return null;
	try {
		if(value instanceof BOStaffRoleOrgDistViewBean){
			return (BOStaffRoleOrgDistViewBean)value;
		}
		BOStaffRoleOrgDistViewBean newBean = new BOStaffRoleOrgDistViewBean();

		DataContainerFactory.transfer(value ,newBean);
		return newBean;
	}catch (Exception ex) {
		if(ex.getCause()!=null)
			throw new RuntimeException(ex.getCause());
		else
			throw new RuntimeException(ex);
	}
   }

   public static BOStaffRoleOrgDistViewBean[] transfer(IBOStaffRoleOrgDistViewValue[] value) {
   	if(value==null || value.length==0)
   		return null;

	try {
		if(value instanceof BOStaffRoleOrgDistViewBean[]){
			return (BOStaffRoleOrgDistViewBean[])value;
		}
		BOStaffRoleOrgDistViewBean[] newBeans = new BOStaffRoleOrgDistViewBean[value.length];
   		for(int i=0;i<newBeans.length;i++){
   			newBeans[i] = new BOStaffRoleOrgDistViewBean();
			DataContainerFactory.transfer(value[i] ,newBeans[i]);
		}
		return newBeans;
	}catch (Exception ex) {
		if(ex.getCause()!=null)
			throw new RuntimeException(ex.getCause());
		else
			throw new RuntimeException(ex);
	}
   }
  public static void save(IBOStaffRoleOrgDistViewValue aValue) throws Exception
  {
     save(transfer(aValue));
  }

   public static  void save( IBOStaffRoleOrgDistViewValue[] aValues) throws Exception{
          save(transfer(aValues));
   }

   public static  void saveBatch( IBOStaffRoleOrgDistViewValue[] aValues) throws Exception{
     saveBatch(transfer(aValues));
   }
}
