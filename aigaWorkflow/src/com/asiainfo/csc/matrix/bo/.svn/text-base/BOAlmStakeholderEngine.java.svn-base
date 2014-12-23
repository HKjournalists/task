package com.asiainfo.csc.matrix.bo;

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

import com.asiainfo.csc.matrix.ivalues.*;

public class BOAlmStakeholderEngine {

  public static BOAlmStakeholderBean[] getBeans(DataContainerInterface dc) throws
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

    public static BOAlmStakeholderBean getBean(long _StdholderId) throws Exception{
            /**new create*/
    String condition = "STDHOLDER_ID = :S_STDHOLDER_ID";
      Map map = new HashMap();
      map.put("S_STDHOLDER_ID",new Long(_StdholderId));
;
      BOAlmStakeholderBean[] beans = getBeans(condition,map);
      if(beans!=null && beans.length==1)
              return beans[0];
      else if(beans!=null && beans.length>1){
              throw new Exception("[错误]根据主键查询出现一条以上记录");
      }else{
              BOAlmStakeholderBean bean = new BOAlmStakeholderBean();
                            bean.setStdholderId(_StdholderId);
                            return bean;
      }
 }

  public static  BOAlmStakeholderBean[] getBeans(Criteria sql) throws Exception{
   return getBeans(sql,-1,-1,false);
  }
 public static  BOAlmStakeholderBean[] getBeans(Criteria sql,int startNum,int endNum,boolean isShowFK) throws Exception{
    String[] cols = null;
    String condition = "";
    Map param = null;
    if(sql != null){
      cols = (String[])sql.getSelectColumns().toArray(new String[0]);
      condition = sql.toString();
      param = sql.getParameters();
    }
    return (BOAlmStakeholderBean[])getBeans(cols,condition,param,startNum,endNum,isShowFK);
  }




  public static  BOAlmStakeholderBean[] getBeans(String condition,Map parameter) throws Exception{
	return getBeans(null,condition,parameter,-1,-1,false);
  }

  public static  BOAlmStakeholderBean[] getBeans(String[] cols,String condition,Map parameter,
           int startNum,int endNum,boolean isShowFK) throws Exception{
        Connection conn = null;
        try {
                conn = ServiceManager.getSession().getConnection();
                return (BOAlmStakeholderBean[])ServiceManager.getDataStore().retrieve(conn,BOAlmStakeholderBean.class,BOAlmStakeholderBean.getObjectTypeStatic(),cols,condition,parameter,startNum,endNum,isShowFK,false,null);
        }catch(Exception e){
                throw e;
        }finally{
           if (conn != null)
              conn.close();
        }
  }

   public static  BOAlmStakeholderBean[] getBeans(String[] cols,String condition,Map parameter,
          int startNum,int endNum,boolean isShowFK,String[] extendBOAttrs) throws Exception{
          Connection conn = null;
          try {
                  conn = ServiceManager.getSession().getConnection();
                  return (BOAlmStakeholderBean[])ServiceManager.getDataStore().retrieve(conn,BOAlmStakeholderBean.class,BOAlmStakeholderBean.getObjectTypeStatic(),cols,condition,parameter,startNum,endNum,isShowFK,false,extendBOAttrs);
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
              return ServiceManager.getDataStore().retrieveCount(conn,BOAlmStakeholderBean.getObjectTypeStatic(),condition,parameter,null);
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
                return ServiceManager.getDataStore().retrieveCount(conn,BOAlmStakeholderBean.getObjectTypeStatic(),condition,parameter,extendBOAttrs);
        }catch(Exception e){
                throw e;
        }finally{
          if (conn != null)
              conn.close();
        }
   }

  public static void save( BOAlmStakeholderBean aBean) throws Exception
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

   public static  void save( BOAlmStakeholderBean[] aBeans) throws Exception{
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

   public static  void saveBatch( BOAlmStakeholderBean[] aBeans) throws Exception{
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


  public static  BOAlmStakeholderBean[] getBeansFromQueryBO(String soureBO,Map parameter) throws Exception{
      Connection conn = null;
      ResultSet resultset = null;
      try {
              conn = ServiceManager.getSession().getConnection();
              String sql = ServiceManager.getObjectTypeFactory().getInstance(soureBO).getMapingEnty();
              resultset =ServiceManager.getDataStore().retrieve(conn,sql,parameter);
              return (BOAlmStakeholderBean[])ServiceManager.getDataStore().crateDtaContainerFromResultSet(BOAlmStakeholderBean.class,BOAlmStakeholderBean.getObjectTypeStatic(),resultset,null,true);

      }catch(Exception e){
              throw e;
      }finally{
          if(resultset!=null)resultset.close();
          if (conn != null)
              conn.close();
      }
   }

     public static  BOAlmStakeholderBean[] getBeansFromSql(String sql,Map parameter) throws Exception{
      Connection conn = null;
      ResultSet resultset = null;
      try {
              conn = ServiceManager.getSession().getConnection();
              resultset =ServiceManager.getDataStore().retrieve(conn,sql,parameter);
              return (BOAlmStakeholderBean[])ServiceManager.getDataStore().crateDtaContainerFromResultSet(BOAlmStakeholderBean.class,BOAlmStakeholderBean.getObjectTypeStatic(),resultset,null,true);

      }catch(Exception e){
              throw e;
      }finally{
          if(resultset!=null)resultset.close();
          if (conn != null)
              conn.close();
      }
   }

   public static java.math.BigDecimal getNewId() throws Exception{
       return ServiceManager.getIdGenerator().getNewId(BOAlmStakeholderBean.getObjectTypeStatic());
   }

/*
   public static java.sql.Timestamp getSysDate() throws Exception{
       return ServiceManager.getIdGenerator().getSysDate(BOAlmStakeholderBean.getObjectTypeStatic());
   }
*/

   public static BOAlmStakeholderBean wrap(DataContainerInterface source,Map colMatch,boolean canModify){
     try{
       return (BOAlmStakeholderBean)DataContainerFactory.wrap(source,BOAlmStakeholderBean.class,colMatch,canModify);
     }catch(Exception e){
       if(e.getCause()!=null)
         throw new RuntimeException(e.getCause());
       else
         throw new RuntimeException(e);
     }
   }
   public static BOAlmStakeholderBean copy(DataContainerInterface source,Map colMatch,boolean canModify){
     try {
       BOAlmStakeholderBean result = new BOAlmStakeholderBean();
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

   public static BOAlmStakeholderBean transfer(IBOAlmStakeholderValue value) {
   	if(value==null)
   		return null;
	try {
		if(value instanceof BOAlmStakeholderBean){
			return (BOAlmStakeholderBean)value;
		}
		BOAlmStakeholderBean newBean = new BOAlmStakeholderBean();

		DataContainerFactory.transfer(value ,newBean);
		return newBean;
	}catch (Exception ex) {
		if(ex.getCause()!=null)
			throw new RuntimeException(ex.getCause());
		else
			throw new RuntimeException(ex);
	}
   }

   public static BOAlmStakeholderBean[] transfer(IBOAlmStakeholderValue[] value) {
   	if(value==null || value.length==0)
   		return null;

	try {
		if(value instanceof BOAlmStakeholderBean[]){
			return (BOAlmStakeholderBean[])value;
		}
		BOAlmStakeholderBean[] newBeans = new BOAlmStakeholderBean[value.length];
   		for(int i=0;i<newBeans.length;i++){
   			newBeans[i] = new BOAlmStakeholderBean();
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
  public static void save(IBOAlmStakeholderValue aValue) throws Exception
  {
     save(transfer(aValue));
  }

   public static  void save( IBOAlmStakeholderValue[] aValues) throws Exception{
          save(transfer(aValues));
   }

   public static  void saveBatch( IBOAlmStakeholderValue[] aValues) throws Exception{
     saveBatch(transfer(aValues));
   }
}
