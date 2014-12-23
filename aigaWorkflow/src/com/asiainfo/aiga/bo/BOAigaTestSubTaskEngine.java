package com.asiainfo.aiga.bo;

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

import com.asiainfo.aiga.ivalues.*;

public class BOAigaTestSubTaskEngine {

  public static BOAigaTestSubTaskBean[] getBeans(DataContainerInterface dc) throws
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

    public static BOAigaTestSubTaskBean getBean(long _SubTaskId) throws Exception{
    String condition = "SUB_TASK_ID = " + _SubTaskId;
      Map map = new HashMap();
      BOAigaTestSubTaskBean[] beans = getBeans(condition,map);
      if(beans!=null && beans.length==1)
              return beans[0];
      else if(beans!=null && beans.length>1){
              throw new Exception("[����]����������ѯ����һ�����ϼ�¼");
      }else{
              BOAigaTestSubTaskBean bean = new BOAigaTestSubTaskBean();
                            bean.setSubTaskId(_SubTaskId);
                            return bean;
      }
 }

  public static  BOAigaTestSubTaskBean[] getBeans(Criteria sql) throws Exception{
   return getBeans(sql,-1,-1,false);
  }
 public static  BOAigaTestSubTaskBean[] getBeans(Criteria sql,int startNum,int endNum,boolean isShowFK) throws Exception{
    String[] cols = null;
    String condition = "";
    if(sql != null){
      cols = (String[])sql.getSelectColumns().toArray(new String[0]);
      condition = sql.toString();
    }
    return (BOAigaTestSubTaskBean[])getBeans(cols,condition,sql.getParameters(), startNum,endNum,isShowFK);
  }




  public static  BOAigaTestSubTaskBean[] getBeans(String condition,Map parameter) throws Exception{
	return getBeans(null,condition,parameter,-1,-1,false);
  }

  public static  BOAigaTestSubTaskBean[] getBeans(String[] cols,String condition,Map parameter,
           int startNum,int endNum,boolean isShowFK) throws Exception{
        Connection conn = null;
        try {
                conn = ServiceManager.getSession().getConnection();
                return (BOAigaTestSubTaskBean[])ServiceManager.getDataStore().retrieve(conn,BOAigaTestSubTaskBean.class,BOAigaTestSubTaskBean.getObjectTypeStatic(),cols,condition,parameter,startNum,endNum,isShowFK,false,null);
        }catch(Exception e){
                throw e;
        }finally{
           if (conn != null)
              conn.close();
        }
  }

   public static  BOAigaTestSubTaskBean[] getBeans(String[] cols,String condition,Map parameter,
          int startNum,int endNum,boolean isShowFK,String[] extendBOAttrs) throws Exception{
          Connection conn = null;
          try {
                  conn = ServiceManager.getSession().getConnection();
                  return (BOAigaTestSubTaskBean[])ServiceManager.getDataStore().retrieve(conn,BOAigaTestSubTaskBean.class,BOAigaTestSubTaskBean.getObjectTypeStatic(),cols,condition,parameter,startNum,endNum,isShowFK,false,extendBOAttrs);
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
              return ServiceManager.getDataStore().retrieveCount(conn,BOAigaTestSubTaskBean.getObjectTypeStatic(),condition,parameter,null);
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
                return ServiceManager.getDataStore().retrieveCount(conn,BOAigaTestSubTaskBean.getObjectTypeStatic(),condition,parameter,extendBOAttrs);
        }catch(Exception e){
                throw e;
        }finally{
          if (conn != null)
              conn.close();
        }
   }

  public static void save( BOAigaTestSubTaskBean aBean) throws Exception
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

   public static  void save( BOAigaTestSubTaskBean[] aBeans) throws Exception{
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

   public static  void saveBatch( BOAigaTestSubTaskBean[] aBeans) throws Exception{
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


  public static  BOAigaTestSubTaskBean[] getBeansFromQueryBO(String soureBO,Map parameter) throws Exception{
      Connection conn = null;
      ResultSet resultset = null;
      try {
              conn = ServiceManager.getSession().getConnection();
              String sql = ServiceManager.getObjectTypeFactory().getInstance(soureBO).getMapingEnty();
              resultset =ServiceManager.getDataStore().retrieve(conn,sql,parameter);
              return (BOAigaTestSubTaskBean[])ServiceManager.getDataStore().crateDtaContainerFromResultSet(BOAigaTestSubTaskBean.class,BOAigaTestSubTaskBean.getObjectTypeStatic(),resultset,null,true);

      }catch(Exception e){
              throw e;
      }finally{
          if(resultset!=null)resultset.close();
          if (conn != null)
              conn.close();
      }
   }

     public static  BOAigaTestSubTaskBean[] getBeansFromSql(String sql,Map parameter) throws Exception{
      Connection conn = null;
      ResultSet resultset = null;
      try {
              conn = ServiceManager.getSession().getConnection();
              resultset =ServiceManager.getDataStore().retrieve(conn,sql,parameter);
              return (BOAigaTestSubTaskBean[])ServiceManager.getDataStore().crateDtaContainerFromResultSet(BOAigaTestSubTaskBean.class,BOAigaTestSubTaskBean.getObjectTypeStatic(),resultset,null,true);

      }catch(Exception e){
              throw e;
      }finally{
          if(resultset!=null)resultset.close();
          if (conn != null)
              conn.close();
      }
   }

   public static java.math.BigDecimal getNewId() throws Exception{
       return ServiceManager.getIdGenerator().getNewId(BOAigaTestSubTaskBean.getObjectTypeStatic());
   }


   public static java.sql.Timestamp getSysDate() throws Exception{
       return ServiceManager.getIdGenerator().getSysDate(BOAigaTestSubTaskBean.getObjectTypeStatic());
   }


   public static BOAigaTestSubTaskBean wrap(DataContainerInterface source,Map colMatch,boolean canModify){
     try{
       return (BOAigaTestSubTaskBean)DataContainerFactory.wrap(source,BOAigaTestSubTaskBean.class,colMatch,canModify);
     }catch(Exception e){
       if(e.getCause()!=null)
         throw new RuntimeException(e.getCause());
       else
         throw new RuntimeException(e);
     }
   }
   public static BOAigaTestSubTaskBean copy(DataContainerInterface source,Map colMatch,boolean canModify){
     try {
       BOAigaTestSubTaskBean result = new BOAigaTestSubTaskBean();
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

   public static BOAigaTestSubTaskBean transfer(IBOAigaTestSubTaskValue value) {
   	if(value==null)
   		return null;
	try {
		if(value instanceof BOAigaTestSubTaskBean){
			return (BOAigaTestSubTaskBean)value;
		}
		BOAigaTestSubTaskBean newBean = new BOAigaTestSubTaskBean();

		DataContainerFactory.transfer(value ,newBean);
		return newBean;
	}catch (Exception ex) {
		if(ex.getCause()!=null)
			throw new RuntimeException(ex.getCause());
		else
			throw new RuntimeException(ex);
	}
   }

   public static BOAigaTestSubTaskBean[] transfer(IBOAigaTestSubTaskValue[] value) {
   	if(value==null || value.length==0)
   		return null;

	try {
		if(value instanceof BOAigaTestSubTaskBean[]){
			return (BOAigaTestSubTaskBean[])value;
		}
		BOAigaTestSubTaskBean[] newBeans = new BOAigaTestSubTaskBean[value.length];
   		for(int i=0;i<newBeans.length;i++){
   			newBeans[i] = new BOAigaTestSubTaskBean();
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
  public static void save(IBOAigaTestSubTaskValue aValue) throws Exception
  {
     save(transfer(aValue));
  }

   public static  void save( IBOAigaTestSubTaskValue[] aValues) throws Exception{
          save(transfer(aValues));
   }

   public static  void saveBatch( IBOAigaTestSubTaskValue[] aValues) throws Exception{
     saveBatch(transfer(aValues));
   }
}
