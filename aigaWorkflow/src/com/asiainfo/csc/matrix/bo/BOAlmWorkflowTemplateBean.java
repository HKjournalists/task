package com.asiainfo.csc.matrix.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.csc.matrix.ivalues.*;

public class BOAlmWorkflowTemplateBean extends DataContainer implements DataContainerInterface,IBOAlmWorkflowTemplateValue{

  private static String  m_boName = "com.asiainfo.csc.matrix.bo.BOAlmWorkflowTemplate";



  public final static  String S_TemplateName = "TEMPLATE_NAME";
  public final static  String S_ObjType = "OBJ_TYPE";
  public final static  String S_TemplateType = "TEMPLATE_TYPE";
  public final static  String S_TemplateId = "TEMPLATE_ID";
  public BOAlmWorkflowTemplateBean() throws AIException{
      super(ServiceManager.getObjectTypeFactory().getInstance(m_boName));
  }


 public static ObjectType getObjectTypeStatic() throws AIException{
   return ServiceManager.getObjectTypeFactory().getInstance(m_boName);
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initTemplateName(String value){
     this.initProperty(S_TemplateName,value);
  }
  public  void setTemplateName(String value){
     this.set(S_TemplateName,value);
  }
  public  void setTemplateNameNull(){
     this.set(S_TemplateName,null);
  }

  public String getTemplateName(){
       return DataType.getAsString(this.get(S_TemplateName));
  
  }
  public String getTemplateNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_TemplateName));
      }

  public void initObjType(String value){
     this.initProperty(S_ObjType,value);
  }
  public  void setObjType(String value){
     this.set(S_ObjType,value);
  }
  public  void setObjTypeNull(){
     this.set(S_ObjType,null);
  }

  public String getObjType(){
       return DataType.getAsString(this.get(S_ObjType));
  
  }
  public String getObjTypeInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ObjType));
      }

  public void initTemplateType(String value){
     this.initProperty(S_TemplateType,value);
  }
  public  void setTemplateType(String value){
     this.set(S_TemplateType,value);
  }
  public  void setTemplateTypeNull(){
     this.set(S_TemplateType,null);
  }

  public String getTemplateType(){
       return DataType.getAsString(this.get(S_TemplateType));
  
  }
  public String getTemplateTypeInitialValue(){
        return DataType.getAsString(this.getOldObj(S_TemplateType));
      }

  public void initTemplateId(long value){
     this.initProperty(S_TemplateId,new Long(value));
  }
  public  void setTemplateId(long value){
     this.set(S_TemplateId,new Long(value));
  }
  public  void setTemplateIdNull(){
     this.set(S_TemplateId,null);
  }

  public long getTemplateId(){
        return DataType.getAsLong(this.get(S_TemplateId));
  
  }
  public long getTemplateIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_TemplateId));
      }


 
 }

