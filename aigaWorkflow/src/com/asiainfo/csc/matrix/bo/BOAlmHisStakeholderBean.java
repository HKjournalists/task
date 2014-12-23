package com.asiainfo.csc.matrix.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.csc.matrix.ivalues.*;

public class BOAlmHisStakeholderBean extends DataContainer implements DataContainerInterface,IBOAlmHisStakeholderValue{

  private static String  m_boName = "com.asiainfo.csc.matrix.bo.BOAlmHisStakeholder";



  public final static  String S_ObjId = "OBJ_ID";
  public final static  String S_CreateTime = "CREATE_TIME";
  public final static  String S_TemplateId = "TEMPLATE_ID";
  public final static  String S_LinkNo = "LINK_NO";
  public final static  String S_RoleCode = "ROLE_CODE";
  public final static  String S_HisStdholderId = "HIS_STDHOLDER_ID";
  public final static  String S_StdholderStaffOrgId = "STDHOLDER_STAFF_ORG_ID";
  public final static  String S_RoleId = "ROLE_ID";
  public final static  String S_StdholderStaffName = "STDHOLDER_STAFF_NAME";
  public final static  String S_OrderId = "ORDER_ID";
  public final static  String S_StdholderStaffId = "STDHOLDER_STAFF_ID";
  public final static  String S_StdholdeType = "STDHOLDE_TYPE";
  public final static  String S_ObjType = "OBJ_TYPE";
  public final static  String S_LinkId = "LINK_ID";
  public final static  String S_StdholderId = "STDHOLDER_ID";
  public final static  String S_StdholderStaffNo = "STDHOLDER_STAFF_NO";
  public BOAlmHisStakeholderBean() throws AIException{
      super(ServiceManager.getObjectTypeFactory().getInstance(m_boName));
  }


 public static ObjectType getObjectTypeStatic() throws AIException{
   return ServiceManager.getObjectTypeFactory().getInstance(m_boName);
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initObjId(long value){
     this.initProperty(S_ObjId,new Long(value));
  }
  public  void setObjId(long value){
     this.set(S_ObjId,new Long(value));
  }
  public  void setObjIdNull(){
     this.set(S_ObjId,null);
  }

  public long getObjId(){
        return DataType.getAsLong(this.get(S_ObjId));
  
  }
  public long getObjIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_ObjId));
      }

  public void initCreateTime(Timestamp value){
     this.initProperty(S_CreateTime,value);
  }
  public  void setCreateTime(Timestamp value){
     this.set(S_CreateTime,value);
  }
  public  void setCreateTimeNull(){
     this.set(S_CreateTime,null);
  }

  public Timestamp getCreateTime(){
        return DataType.getAsDateTime(this.get(S_CreateTime));
  
  }
  public Timestamp getCreateTimeInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_CreateTime));
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

  public void initLinkNo(String value){
     this.initProperty(S_LinkNo,value);
  }
  public  void setLinkNo(String value){
     this.set(S_LinkNo,value);
  }
  public  void setLinkNoNull(){
     this.set(S_LinkNo,null);
  }

  public String getLinkNo(){
       return DataType.getAsString(this.get(S_LinkNo));
  
  }
  public String getLinkNoInitialValue(){
        return DataType.getAsString(this.getOldObj(S_LinkNo));
      }

  public void initRoleCode(String value){
     this.initProperty(S_RoleCode,value);
  }
  public  void setRoleCode(String value){
     this.set(S_RoleCode,value);
  }
  public  void setRoleCodeNull(){
     this.set(S_RoleCode,null);
  }

  public String getRoleCode(){
       return DataType.getAsString(this.get(S_RoleCode));
  
  }
  public String getRoleCodeInitialValue(){
        return DataType.getAsString(this.getOldObj(S_RoleCode));
      }

  public void initHisStdholderId(long value){
     this.initProperty(S_HisStdholderId,new Long(value));
  }
  public  void setHisStdholderId(long value){
     this.set(S_HisStdholderId,new Long(value));
  }
  public  void setHisStdholderIdNull(){
     this.set(S_HisStdholderId,null);
  }

  public long getHisStdholderId(){
        return DataType.getAsLong(this.get(S_HisStdholderId));
  
  }
  public long getHisStdholderIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_HisStdholderId));
      }

  public void initStdholderStaffOrgId(long value){
     this.initProperty(S_StdholderStaffOrgId,new Long(value));
  }
  public  void setStdholderStaffOrgId(long value){
     this.set(S_StdholderStaffOrgId,new Long(value));
  }
  public  void setStdholderStaffOrgIdNull(){
     this.set(S_StdholderStaffOrgId,null);
  }

  public long getStdholderStaffOrgId(){
        return DataType.getAsLong(this.get(S_StdholderStaffOrgId));
  
  }
  public long getStdholderStaffOrgIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_StdholderStaffOrgId));
      }

  public void initRoleId(long value){
     this.initProperty(S_RoleId,new Long(value));
  }
  public  void setRoleId(long value){
     this.set(S_RoleId,new Long(value));
  }
  public  void setRoleIdNull(){
     this.set(S_RoleId,null);
  }

  public long getRoleId(){
        return DataType.getAsLong(this.get(S_RoleId));
  
  }
  public long getRoleIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_RoleId));
      }

  public void initStdholderStaffName(String value){
     this.initProperty(S_StdholderStaffName,value);
  }
  public  void setStdholderStaffName(String value){
     this.set(S_StdholderStaffName,value);
  }
  public  void setStdholderStaffNameNull(){
     this.set(S_StdholderStaffName,null);
  }

  public String getStdholderStaffName(){
       return DataType.getAsString(this.get(S_StdholderStaffName));
  
  }
  public String getStdholderStaffNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_StdholderStaffName));
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

  public void initStdholderStaffId(long value){
     this.initProperty(S_StdholderStaffId,new Long(value));
  }
  public  void setStdholderStaffId(long value){
     this.set(S_StdholderStaffId,new Long(value));
  }
  public  void setStdholderStaffIdNull(){
     this.set(S_StdholderStaffId,null);
  }

  public long getStdholderStaffId(){
        return DataType.getAsLong(this.get(S_StdholderStaffId));
  
  }
  public long getStdholderStaffIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_StdholderStaffId));
      }

  public void initStdholdeType(String value){
     this.initProperty(S_StdholdeType,value);
  }
  public  void setStdholdeType(String value){
     this.set(S_StdholdeType,value);
  }
  public  void setStdholdeTypeNull(){
     this.set(S_StdholdeType,null);
  }

  public String getStdholdeType(){
       return DataType.getAsString(this.get(S_StdholdeType));
  
  }
  public String getStdholdeTypeInitialValue(){
        return DataType.getAsString(this.getOldObj(S_StdholdeType));
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

  public void initLinkId(long value){
     this.initProperty(S_LinkId,new Long(value));
  }
  public  void setLinkId(long value){
     this.set(S_LinkId,new Long(value));
  }
  public  void setLinkIdNull(){
     this.set(S_LinkId,null);
  }

  public long getLinkId(){
        return DataType.getAsLong(this.get(S_LinkId));
  
  }
  public long getLinkIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_LinkId));
      }

  public void initStdholderId(long value){
     this.initProperty(S_StdholderId,new Long(value));
  }
  public  void setStdholderId(long value){
     this.set(S_StdholderId,new Long(value));
  }
  public  void setStdholderIdNull(){
     this.set(S_StdholderId,null);
  }

  public long getStdholderId(){
        return DataType.getAsLong(this.get(S_StdholderId));
  
  }
  public long getStdholderIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_StdholderId));
      }

  public void initStdholderStaffNo(String value){
     this.initProperty(S_StdholderStaffNo,value);
  }
  public  void setStdholderStaffNo(String value){
     this.set(S_StdholderStaffNo,value);
  }
  public  void setStdholderStaffNoNull(){
     this.set(S_StdholderStaffNo,null);
  }

  public String getStdholderStaffNo(){
       return DataType.getAsString(this.get(S_StdholderStaffNo));
  
  }
  public String getStdholderStaffNoInitialValue(){
        return DataType.getAsString(this.getOldObj(S_StdholderStaffNo));
      }


 
 }

