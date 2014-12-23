package com.asiainfo.csc.common.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.csc.common.ivalues.*;

public class BOWorkorderExtendBean extends DataContainer implements DataContainerInterface,IBOWorkorderExtendValue{

  private static String  m_boName = "com.asiainfo.csc.common.bo.BOWorkorderExtend";



  public final static  String S_WorkflowParam = "WORKFLOW_PARAM";
  public final static  String S_OrderId = "ORDER_ID";

  public static ObjectType S_TYPE = null;
  static{
    try {
      S_TYPE = ServiceManager.getObjectTypeFactory().getInstance(m_boName);
    }catch(Exception e){
      throw new RuntimeException(e);
    }
  }
  public BOWorkorderExtendBean() throws AIException{
      super(S_TYPE);
  }

 public static ObjectType getObjectTypeStatic() throws AIException{
   return S_TYPE;
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initWorkflowParam(String value){
     this.initProperty(S_WorkflowParam,value);
  }
  public  void setWorkflowParam(String value){
     this.set(S_WorkflowParam,value);
  }
  public  void setWorkflowParamNull(){
     this.set(S_WorkflowParam,null);
  }

  public String getWorkflowParam(){
       return DataType.getAsString(this.get(S_WorkflowParam));
  
  }
  public String getWorkflowParamInitialValue(){
        return DataType.getAsString(this.getOldObj(S_WorkflowParam));
      }

  public void initOrderId(long value){
     this.initProperty(S_OrderId,new Long(value));
  }
  public  void setOrderId(long value){
     this.set(S_OrderId,new Long(value));
  }
  public  void setOrderIdNull(){
     this.set(S_OrderId,null);
  }

  public long getOrderId(){
        return DataType.getAsLong(this.get(S_OrderId));
  
  }
  public long getOrderIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_OrderId));
      }


 
 }

