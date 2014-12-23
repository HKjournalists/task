package com.asiainfo.csc.attach.bo;

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

import com.asiainfo.csc.attach.ivalues.*;

public class BOAttachTypeConfigEngine {

  public static BOAttachTypeConfigBean[] getBeans(DataContainerInterface dc) throws
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

    public static BOAttachTypeConfigBean getBean(long _AttConfId) throws Exception{
    String condition = "ATT_CONF_ID = " + _AttConfId;
      Map map = new HashMap();
      BOAttachTypeConfigBean[] beans = getBeans(condition,map);
      if(beans!=null && beans.length==1)
              return beans[0];
      else if(beans!=null && beans.length>1){
              throw new Exception("[错误]根据主键查询出现一条以上记录");
      }else{
              BOAttachTypeConfigBean bean = new BOAttachTypeConfigBean();
                            bean.setAttConfId(_AttConfId);
                            return bean;
      }
 }

  public static  BOAttachTypeConfigBean[] getBeans(Criteria sql) throws Exception{
   return getBeans(sql,-1,-1,false);
  }
 public static  BOAttachTypeConfigBean[] getBeans(Criteria sql,int startNum,int endNum,boolean isShowFK) throws Exception{
    String[] cols = null;
    String condition = "";
    if(sql != null){
      cols = (String[])sql.getSelectColumns().toArray(new String[0]);
      condition = sql.toString();
    }
    return (BOAttachTypeConfigBean[])getBeans(cols,condition,sql.getParameters(), startNum,endNum,isShowFK);
  }




  public static  BOAttachTypeConfigBean[] getBeans(String condition,Map parameter) throws Exception{
	return getBeans(null,condition,parameter,-1,-1,false);
  }

  public static  BOAttachTypeConfigBean[] getBeans(String[] cols,String condition,Map parameter,
           int startNum,int endNum,boolean isShowFK) throws Exception{
        Connection conn = null;
        try {
                conn = ServiceManager.getSession().getConnection();
                return (BOAttachTypeConfigBean[])ServiceManager.getDataStore().retrieve(conn,BOAttachTypeConfigBean.class,BOAttachTypeConfigBean.getObjectTypeStatic(),cols,condition,parameter,startNum,endNum,isShowFK,false,null);
        }catch(Exception e){
                throw e;
        }finally{
           if (conn != null)
              conn.close();
        }
  }

   public static  BOAttachTypeConfigBean[] getBeans(String[] cols,String condition,Map parameter,
          int startNum,int endNum,boolean isShowFK,String[] extendBOAttrs) throws Exception{
          Connection conn = null;
          try {
                  conn = ServiceManager.getSession().getConnection();
                  return (BOAttachTypeConfigBean[])ServiceManager.getDataStore().retrieve(conn,BOAttachTypeConfigBean.class,BOAttachTypeConfigBean.getObjectTypeStatic(),cols,condition,parameter,startNum,endNum,isShowFK,false,extendBOAttrs);
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
              return ServiceManager.getDataStore().retrieveCount(conn,BOAttachTypeConfigBean.getObjectTypeStatic(),condition,parameter,null);
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
                return ServiceManager.getDataStore().retrieveCount(conn,BOAttachTypeConfigBean.getObjectTypeStatic(),condition,parameter,extendBOAttrs);
        }catch(Exception e){
                throw e;
        }finally{
          if (conn != null)
              conn.close();
        }
   }

  public static void save( BOAttachTypeConfigBean aBean) throws Exception
  {
  	Connection conn = null;
	try {
		conn = ServiceManager.getSession().getConnection();
   		ServiceManager.getDataStore().save(conn,aBean);
   	}catch(Exception e){
		throw e;
	}finally{
		conn.close();
	}
  }

   public static  void save( BOAttachTypeConfigBean[] aBeans) throws Exception{
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

   public static  void saveBatch( BOAttachTypeConfigBean[] aBeans) throws Exception{
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


  public static  BOAttachTypeConfigBean[] getBeansFromQueryBO(String soureBO,Map parameter) throws Exception{
      Connection conn = null;
      ResultSet resultset = null;
      try {
              conn = ServiceManager.getSession().getConnection();
              String sql = ServiceManager.getObjectTypeFactory().getInstance(soureBO).getMapingEnty();
              resultset =ServiceManager.getDataStore().retrieve(conn,sql,parameter);
              return (BOAttachTypeConfigBean[])ServiceManager.getDataStore().crateDtaContainerFromResultSet(BOAttachTypeConfigBean.class,BOAttachTypeConfigBean.getObjectTypeStatic(),resultset,null,true);

      }catch(Exception e){
              throw e;
      }finally{
          if(resultset!=null)resultset.close();
          if (conn != null)
              conn.close();
      }
   }

     public static  BOAttachTypeConfigBean[] getBeansFromSql(String sql,Map parameter) throws Exception{
      Connection conn = null;
      ResultSet resultset = null;
      try {
              conn = ServiceManager.getSession().getConnection();
              resultset =ServiceManager.getDataStore().retrieve(conn,sql,parameter);
              return (BOAttachTypeConfigBean[])ServiceManager.getDataStore().crateDtaContainerFromResultSet(BOAttachTypeConfigBean.class,BOAttachTypeConfigBean.getObjectTypeStatic(),resultset,null,true);

      }catch(Exception e){
              throw e;
      }finally{
          if(resultset!=null)resultset.close();
          if (conn != null)
              conn.close();
      }
   }

   public static java.math.BigDecimal getNewId() throws Exception{
       return ServiceManager.getIdGenerator().getNewId(BOAttachTypeConfigBean.getObjectTypeStatic());
   }


   public static java.sql.Timestamp getSysDate() throws Exception{
       return ServiceManager.getIdGenerator().getSysDate(BOAttachTypeConfigBean.getObjectTypeStatic());
   }


   public static BOAttachTypeConfigBean wrap(DataContainerInterface source,Map colMatch,boolean canModify){
     try{
       return (BOAttachTypeConfigBean)DataContainerFactory.wrap(source,BOAttachTypeConfigBean.class,colMatch,canModify);
     }catch(Exception e){
       if(e.getCause()!=null)
         throw new RuntimeException(e.getCause());
       else
         throw new RuntimeException(e);
     }
   }
   public static BOAttachTypeConfigBean copy(DataContainerInterface source,Map colMatch,boolean canModify){
     try {
       BOAttachTypeConfigBean result = new BOAttachTypeConfigBean();
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

   public static BOAttachTypeConfigBean transfer(IBOAttachTypeConfigValue value) {
   	if(value==null)
   		return null;
	try {
		if(value instanceof BOAttachTypeConfigBean){
			return (BOAttachTypeConfigBean)value;
		}
		BOAttachTypeConfigBean newBean = new BOAttachTypeConfigBean();

		DataContainerFactory.transfer(value ,newBean);
		return newBean;
	}catch (Exception ex) {
		if(ex.getCause()!=null)
			throw new RuntimeException(ex.getCause());
		else
			throw new RuntimeException(ex);
	}
   }

   public static BOAttachTypeConfigBean[] transfer(IBOAttachTypeConfigValue[] value) {
   	if(value==null || value.length==0)
   		return null;

	try {
		if(value instanceof BOAttachTypeConfigBean[]){
			return (BOAttachTypeConfigBean[])value;
		}
		BOAttachTypeConfigBean[] newBeans = new BOAttachTypeConfigBean[value.length];
   		for(int i=0;i<newBeans.length;i++){
   			newBeans[i] = new BOAttachTypeConfigBean();
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
  public static void save(IBOAttachTypeConfigValue aValue) throws Exception
  {
     save(transfer(aValue));
  }

   public static  void save( IBOAttachTypeConfigValue[] aValues) throws Exception{
          save(transfer(aValues));
   }

   public static  void saveBatch( IBOAttachTypeConfigValue[] aValues) throws Exception{
     saveBatch(transfer(aValues));
   }
}
