package com.asiainfo.csc.attach.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.csc.attach.ivalues.*;

public class BODocTempTreeBean extends DataContainer implements DataContainerInterface,IBODocTempTreeValue{

  private static String  m_boName = "com.asiainfo.csc.attach.bo.BODocTempTree";



  public final static  String S_ParentNodeName = "PARENT_NODE_NAME";
  public final static  String S_IsDocTemp = "IS_DOC_TEMP";
  public final static  String S_DocTempTreeId = "DOC_TEMP_TREE_ID";
  public final static  String S_NodeName = "NODE_NAME";
  public final static  String S_NodeNo = "NODE_NO";
  public final static  String S_ParentNodeNo = "PARENT_NODE_NO";

  public static ObjectType S_TYPE = null;
  static{
    try {
      S_TYPE = ServiceManager.getObjectTypeFactory().getInstance(m_boName);
    }catch(Exception e){
      throw new RuntimeException(e);
    }
  }
  public BODocTempTreeBean() throws AIException{
      super(S_TYPE);
  }

 public static ObjectType getObjectTypeStatic() throws AIException{
   return S_TYPE;
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initParentNodeName(String value){
     this.initProperty(S_ParentNodeName,value);
  }
  public  void setParentNodeName(String value){
     this.set(S_ParentNodeName,value);
  }
  public  void setParentNodeNameNull(){
     this.set(S_ParentNodeName,null);
  }

  public String getParentNodeName(){
       return DataType.getAsString(this.get(S_ParentNodeName));
  
  }
  public String getParentNodeNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ParentNodeName));
      }

  public void initIsDocTemp(int value){
     this.initProperty(S_IsDocTemp,new Integer(value));
  }
  public  void setIsDocTemp(int value){
     this.set(S_IsDocTemp,new Integer(value));
  }
  public  void setIsDocTempNull(){
     this.set(S_IsDocTemp,null);
  }

  public int getIsDocTemp(){
        return DataType.getAsInt(this.get(S_IsDocTemp));
  
  }
  public int getIsDocTempInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_IsDocTemp));
      }

  public void initDocTempTreeId(long value){
     this.initProperty(S_DocTempTreeId,new Long(value));
  }
  public  void setDocTempTreeId(long value){
     this.set(S_DocTempTreeId,new Long(value));
  }
  public  void setDocTempTreeIdNull(){
     this.set(S_DocTempTreeId,null);
  }

  public long getDocTempTreeId(){
        return DataType.getAsLong(this.get(S_DocTempTreeId));
  
  }
  public long getDocTempTreeIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_DocTempTreeId));
      }

  public void initNodeName(String value){
     this.initProperty(S_NodeName,value);
  }
  public  void setNodeName(String value){
     this.set(S_NodeName,value);
  }
  public  void setNodeNameNull(){
     this.set(S_NodeName,null);
  }

  public String getNodeName(){
       return DataType.getAsString(this.get(S_NodeName));
  
  }
  public String getNodeNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_NodeName));
      }

  public void initNodeNo(String value){
     this.initProperty(S_NodeNo,value);
  }
  public  void setNodeNo(String value){
     this.set(S_NodeNo,value);
  }
  public  void setNodeNoNull(){
     this.set(S_NodeNo,null);
  }

  public String getNodeNo(){
       return DataType.getAsString(this.get(S_NodeNo));
  
  }
  public String getNodeNoInitialValue(){
        return DataType.getAsString(this.getOldObj(S_NodeNo));
      }

  public void initParentNodeNo(String value){
     this.initProperty(S_ParentNodeNo,value);
  }
  public  void setParentNodeNo(String value){
     this.set(S_ParentNodeNo,value);
  }
  public  void setParentNodeNoNull(){
     this.set(S_ParentNodeNo,null);
  }

  public String getParentNodeNo(){
       return DataType.getAsString(this.get(S_ParentNodeNo));
  
  }
  public String getParentNodeNoInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ParentNodeNo));
      }


 
 }

