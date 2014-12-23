package com.asiainfo.csc.matrix.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.csc.matrix.ivalues.*;

public class BOAlmWorkflowDrivingBean extends DataContainer implements DataContainerInterface,IBOAlmWorkflowDrivingValue{

  private static String  m_boName = "com.asiainfo.csc.matrix.bo.BOAlmWorkflowDriving";



  public final static  String S_LinkRelativePhase = "LINK_RELATIVE_PHASE";
  public final static  String S_PassiveTemplateId = "PASSIVE_TEMPLATE_ID";
  public final static  String S_DrivingId = "DRIVING_ID";
  public final static  String S_ActivePoint = "ACTIVE_POINT";
  public final static  String S_PassivePoint = "PASSIVE_POINT";
  public final static  String S_ActiveTemplateId = "ACTIVE_TEMPLATE_ID";
  public BOAlmWorkflowDrivingBean() throws AIException{
      super(ServiceManager.getObjectTypeFactory().getInstance(m_boName));
  }


 public static ObjectType getObjectTypeStatic() throws AIException{
   return ServiceManager.getObjectTypeFactory().getInstance(m_boName);
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initLinkRelativePhase(long value){
     this.initProperty(S_LinkRelativePhase,new Long(value));
  }
  public  void setLinkRelativePhase(long value){
     this.set(S_LinkRelativePhase,new Long(value));
  }
  public  void setLinkRelativePhaseNull(){
     this.set(S_LinkRelativePhase,null);
  }

  public long getLinkRelativePhase(){
        return DataType.getAsLong(this.get(S_LinkRelativePhase));
  
  }
  public long getLinkRelativePhaseInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_LinkRelativePhase));
      }

  public void initPassiveTemplateId(long value){
     this.initProperty(S_PassiveTemplateId,new Long(value));
  }
  public  void setPassiveTemplateId(long value){
     this.set(S_PassiveTemplateId,new Long(value));
  }
  public  void setPassiveTemplateIdNull(){
     this.set(S_PassiveTemplateId,null);
  }

  public long getPassiveTemplateId(){
        return DataType.getAsLong(this.get(S_PassiveTemplateId));
  
  }
  public long getPassiveTemplateIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_PassiveTemplateId));
      }

  public void initDrivingId(long value){
     this.initProperty(S_DrivingId,new Long(value));
  }
  public  void setDrivingId(long value){
     this.set(S_DrivingId,new Long(value));
  }
  public  void setDrivingIdNull(){
     this.set(S_DrivingId,null);
  }

  public long getDrivingId(){
        return DataType.getAsLong(this.get(S_DrivingId));
  
  }
  public long getDrivingIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_DrivingId));
      }

  public void initActivePoint(String value){
     this.initProperty(S_ActivePoint,value);
  }
  public  void setActivePoint(String value){
     this.set(S_ActivePoint,value);
  }
  public  void setActivePointNull(){
     this.set(S_ActivePoint,null);
  }

  public String getActivePoint(){
       return DataType.getAsString(this.get(S_ActivePoint));
  
  }
  public String getActivePointInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ActivePoint));
      }

  public void initPassivePoint(String value){
     this.initProperty(S_PassivePoint,value);
  }
  public  void setPassivePoint(String value){
     this.set(S_PassivePoint,value);
  }
  public  void setPassivePointNull(){
     this.set(S_PassivePoint,null);
  }

  public String getPassivePoint(){
       return DataType.getAsString(this.get(S_PassivePoint));
  
  }
  public String getPassivePointInitialValue(){
        return DataType.getAsString(this.getOldObj(S_PassivePoint));
      }

  public void initActiveTemplateId(long value){
     this.initProperty(S_ActiveTemplateId,new Long(value));
  }
  public  void setActiveTemplateId(long value){
     this.set(S_ActiveTemplateId,new Long(value));
  }
  public  void setActiveTemplateIdNull(){
     this.set(S_ActiveTemplateId,null);
  }

  public long getActiveTemplateId(){
        return DataType.getAsLong(this.get(S_ActiveTemplateId));
  
  }
  public long getActiveTemplateIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_ActiveTemplateId));
      }


 
 }

