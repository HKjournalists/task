package com.asiainfo.csc.common.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.csc.common.ivalues.*;

public class BOStakeholderBean extends DataContainer implements DataContainerInterface,IBOStakeholderValue{

  private static String  m_boName = "com.asiainfo.csc.common.bo.BOStakeholder";



  public final static  String S_Counter = "COUNTER";
  public final static  String S_ObjId = "OBJ_ID";
  public final static  String S_CreateTime = "CREATE_TIME";
  public final static  String S_TaskId = "TASK_ID";
  public final static  String S_LinkNo = "LINK_NO";
  public final static  String S_NoticeOperType = "NOTICE_OPER_TYPE";
  public final static  String S_StdholderStaffName = "STDHOLDER_STAFF_NAME";
  public final static  String S_RoleId = "ROLE_ID";
  public final static  String S_SeqNo = "SEQ_NO";
  public final static  String S_StdholderStaffId = "STDHOLDER_STAFF_ID";
  public final static  String S_StdholdeType = "STDHOLDE_TYPE";
  public final static  String S_ObjType = "OBJ_TYPE";
  public final static  String S_LinkId = "LINK_ID";
  public final static  String S_StdholderOrgStructs = "STDHOLDER_ORG_STRUCTS";
  public final static  String S_StdholderId = "STDHOLDER_ID";
  public final static  String S_StdholderOrgNo = "STDHOLDER_ORG_NO";
  public final static  String S_StdholderOrgId = "STDHOLDER_ORG_ID";
  public final static  String S_WorkflowId = "WORKFLOW_ID";
  public final static  String S_StdholderStaffNo = "STDHOLDER_STAFF_NO";

  public static ObjectType S_TYPE = null;
  static{
    try {
      S_TYPE = ServiceManager.getObjectTypeFactory().getInstance(m_boName);
    }catch(Exception e){
      throw new RuntimeException(e);
    }
  }
  public BOStakeholderBean() throws AIException{
      super(S_TYPE);
  }

 public static ObjectType getObjectTypeStatic() throws AIException{
   return S_TYPE;
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initCounter(int value){
     this.initProperty(S_Counter,new Integer(value));
  }
  public  void setCounter(int value){
     this.set(S_Counter,new Integer(value));
  }
  public  void setCounterNull(){
     this.set(S_Counter,null);
  }

  public int getCounter(){
        return DataType.getAsInt(this.get(S_Counter));
  
  }
  public int getCounterInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_Counter));
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

  public void initTaskId(long value){
     this.initProperty(S_TaskId,new Long(value));
  }
  public  void setTaskId(long value){
     this.set(S_TaskId,new Long(value));
  }
  public  void setTaskIdNull(){
     this.set(S_TaskId,null);
  }

  public long getTaskId(){
        return DataType.getAsLong(this.get(S_TaskId));
  
  }
  public long getTaskIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_TaskId));
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

  public void initNoticeOperType(String value){
     this.initProperty(S_NoticeOperType,value);
  }
  public  void setNoticeOperType(String value){
     this.set(S_NoticeOperType,value);
  }
  public  void setNoticeOperTypeNull(){
     this.set(S_NoticeOperType,null);
  }

  public String getNoticeOperType(){
       return DataType.getAsString(this.get(S_NoticeOperType));
  
  }
  public String getNoticeOperTypeInitialValue(){
        return DataType.getAsString(this.getOldObj(S_NoticeOperType));
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

  public void initSeqNo(long value){
     this.initProperty(S_SeqNo,new Long(value));
  }
  public  void setSeqNo(long value){
     this.set(S_SeqNo,new Long(value));
  }
  public  void setSeqNoNull(){
     this.set(S_SeqNo,null);
  }

  public long getSeqNo(){
        return DataType.getAsLong(this.get(S_SeqNo));
  
  }
  public long getSeqNoInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_SeqNo));
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

  public void initStdholderOrgStructs(String value){
     this.initProperty(S_StdholderOrgStructs,value);
  }
  public  void setStdholderOrgStructs(String value){
     this.set(S_StdholderOrgStructs,value);
  }
  public  void setStdholderOrgStructsNull(){
     this.set(S_StdholderOrgStructs,null);
  }

  public String getStdholderOrgStructs(){
       return DataType.getAsString(this.get(S_StdholderOrgStructs));
  
  }
  public String getStdholderOrgStructsInitialValue(){
        return DataType.getAsString(this.getOldObj(S_StdholderOrgStructs));
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

  public void initStdholderOrgNo(String value){
     this.initProperty(S_StdholderOrgNo,value);
  }
  public  void setStdholderOrgNo(String value){
     this.set(S_StdholderOrgNo,value);
  }
  public  void setStdholderOrgNoNull(){
     this.set(S_StdholderOrgNo,null);
  }

  public String getStdholderOrgNo(){
       return DataType.getAsString(this.get(S_StdholderOrgNo));
  
  }
  public String getStdholderOrgNoInitialValue(){
        return DataType.getAsString(this.getOldObj(S_StdholderOrgNo));
      }

  public void initStdholderOrgId(long value){
     this.initProperty(S_StdholderOrgId,new Long(value));
  }
  public  void setStdholderOrgId(long value){
     this.set(S_StdholderOrgId,new Long(value));
  }
  public  void setStdholderOrgIdNull(){
     this.set(S_StdholderOrgId,null);
  }

  public long getStdholderOrgId(){
        return DataType.getAsLong(this.get(S_StdholderOrgId));
  
  }
  public long getStdholderOrgIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_StdholderOrgId));
      }

  public void initWorkflowId(long value){
     this.initProperty(S_WorkflowId,new Long(value));
  }
  public  void setWorkflowId(long value){
     this.set(S_WorkflowId,new Long(value));
  }
  public  void setWorkflowIdNull(){
     this.set(S_WorkflowId,null);
  }

  public long getWorkflowId(){
        return DataType.getAsLong(this.get(S_WorkflowId));
  
  }
  public long getWorkflowIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_WorkflowId));
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

