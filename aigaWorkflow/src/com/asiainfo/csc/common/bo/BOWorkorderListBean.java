package com.asiainfo.csc.common.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.csc.common.ivalues.*;

public class BOWorkorderListBean extends DataContainer implements DataContainerInterface,IBOWorkorderListValue{

  private static String  m_boName = "com.asiainfo.csc.common.bo.BOWorkorderList";



  public final static  String S_FactCompleteTime = "FACT_COMPLETE_TIME";
  public final static  String S_CreateTime = "CREATE_TIME";
  public final static  String S_ObjName = "OBJ_NAME";
  public final static  String S_AdviceCompTime = "ADVICE_COMP_TIME";
  public final static  String S_Opinion = "OPINION";
  public final static  String S_LinkNo = "LINK_NO";
  public final static  String S_FinishTime = "FINISH_TIME";
  public final static  String S_TemplateId = "TEMPLATE_ID";
  public final static  String S_Status = "STATUS";
  public final static  String S_ExecStaffNo = "EXEC_STAFF_NO";
  public final static  String S_LinkNoType = "LINK_NO_TYPE";
  public final static  String S_ObjTag = "OBJ_TAG";
  public final static  String S_Result = "RESULT";
  public final static  String S_ObjType = "OBJ_TYPE";
  public final static  String S_LinkId = "LINK_ID";
  public final static  String S_EmployeeName = "EMPLOYEE_NAME";
  public final static  String S_ParentVmTaskId = "PARENT_VM_TASK_ID";
  public final static  String S_OrderType = "ORDER_TYPE";
  public final static  String S_ObjId = "OBJ_ID";
  public final static  String S_ConnectPoint = "CONNECT_POINT";
  public final static  String S_OrderId = "ORDER_ID";
  public final static  String S_VmTaskName = "VM_TASK_NAME";
  public final static  String S_SubmitStaffName = "SUBMIT_STAFF_NAME";
  public final static  String S_Cond = "COND";
  public final static  String S_ExecStaffId = "EXEC_STAFF_ID";
  public final static  String S_PhaseId = "PHASE_ID";
  public BOWorkorderListBean() throws AIException{
      super(ServiceManager.getObjectTypeFactory().getInstance(m_boName));
  }


 public static ObjectType getObjectTypeStatic() throws AIException{
   return ServiceManager.getObjectTypeFactory().getInstance(m_boName);
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initFactCompleteTime(Timestamp value){
     this.initProperty(S_FactCompleteTime,value);
  }
  public  void setFactCompleteTime(Timestamp value){
     this.set(S_FactCompleteTime,value);
  }
  public  void setFactCompleteTimeNull(){
     this.set(S_FactCompleteTime,null);
  }

  public Timestamp getFactCompleteTime(){
        return DataType.getAsDateTime(this.get(S_FactCompleteTime));
  
  }
  public Timestamp getFactCompleteTimeInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_FactCompleteTime));
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

  public void initObjName(String value){
     this.initProperty(S_ObjName,value);
  }
  public  void setObjName(String value){
     this.set(S_ObjName,value);
  }
  public  void setObjNameNull(){
     this.set(S_ObjName,null);
  }

  public String getObjName(){
       return DataType.getAsString(this.get(S_ObjName));
  
  }
  public String getObjNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ObjName));
      }

  public void initAdviceCompTime(Timestamp value){
     this.initProperty(S_AdviceCompTime,value);
  }
  public  void setAdviceCompTime(Timestamp value){
     this.set(S_AdviceCompTime,value);
  }
  public  void setAdviceCompTimeNull(){
     this.set(S_AdviceCompTime,null);
  }

  public Timestamp getAdviceCompTime(){
        return DataType.getAsDateTime(this.get(S_AdviceCompTime));
  
  }
  public Timestamp getAdviceCompTimeInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_AdviceCompTime));
      }

  public void initOpinion(String value){
     this.initProperty(S_Opinion,value);
  }
  public  void setOpinion(String value){
     this.set(S_Opinion,value);
  }
  public  void setOpinionNull(){
     this.set(S_Opinion,null);
  }

  public String getOpinion(){
       return DataType.getAsString(this.get(S_Opinion));
  
  }
  public String getOpinionInitialValue(){
        return DataType.getAsString(this.getOldObj(S_Opinion));
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

  public void initFinishTime(Timestamp value){
     this.initProperty(S_FinishTime,value);
  }
  public  void setFinishTime(Timestamp value){
     this.set(S_FinishTime,value);
  }
  public  void setFinishTimeNull(){
     this.set(S_FinishTime,null);
  }

  public Timestamp getFinishTime(){
        return DataType.getAsDateTime(this.get(S_FinishTime));
  
  }
  public Timestamp getFinishTimeInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_FinishTime));
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

  public void initStatus(String value){
     this.initProperty(S_Status,value);
  }
  public  void setStatus(String value){
     this.set(S_Status,value);
  }
  public  void setStatusNull(){
     this.set(S_Status,null);
  }

  public String getStatus(){
       return DataType.getAsString(this.get(S_Status));
  
  }
  public String getStatusInitialValue(){
        return DataType.getAsString(this.getOldObj(S_Status));
      }

  public void initExecStaffNo(String value){
     this.initProperty(S_ExecStaffNo,value);
  }
  public  void setExecStaffNo(String value){
     this.set(S_ExecStaffNo,value);
  }
  public  void setExecStaffNoNull(){
     this.set(S_ExecStaffNo,null);
  }

  public String getExecStaffNo(){
       return DataType.getAsString(this.get(S_ExecStaffNo));
  
  }
  public String getExecStaffNoInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ExecStaffNo));
      }

  public void initLinkNoType(String value){
     this.initProperty(S_LinkNoType,value);
  }
  public  void setLinkNoType(String value){
     this.set(S_LinkNoType,value);
  }
  public  void setLinkNoTypeNull(){
     this.set(S_LinkNoType,null);
  }

  public String getLinkNoType(){
       return DataType.getAsString(this.get(S_LinkNoType));
  
  }
  public String getLinkNoTypeInitialValue(){
        return DataType.getAsString(this.getOldObj(S_LinkNoType));
      }

  public void initObjTag(String value){
     this.initProperty(S_ObjTag,value);
  }
  public  void setObjTag(String value){
     this.set(S_ObjTag,value);
  }
  public  void setObjTagNull(){
     this.set(S_ObjTag,null);
  }

  public String getObjTag(){
       return DataType.getAsString(this.get(S_ObjTag));
  
  }
  public String getObjTagInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ObjTag));
      }

  public void initResult(String value){
     this.initProperty(S_Result,value);
  }
  public  void setResult(String value){
     this.set(S_Result,value);
  }
  public  void setResultNull(){
     this.set(S_Result,null);
  }

  public String getResult(){
       return DataType.getAsString(this.get(S_Result));
  
  }
  public String getResultInitialValue(){
        return DataType.getAsString(this.getOldObj(S_Result));
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

  public void initEmployeeName(String value){
     this.initProperty(S_EmployeeName,value);
  }
  public  void setEmployeeName(String value){
     this.set(S_EmployeeName,value);
  }
  public  void setEmployeeNameNull(){
     this.set(S_EmployeeName,null);
  }

  public String getEmployeeName(){
       return DataType.getAsString(this.get(S_EmployeeName));
  
  }
  public String getEmployeeNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_EmployeeName));
      }

  public void initParentVmTaskId(long value){
     this.initProperty(S_ParentVmTaskId,new Long(value));
  }
  public  void setParentVmTaskId(long value){
     this.set(S_ParentVmTaskId,new Long(value));
  }
  public  void setParentVmTaskIdNull(){
     this.set(S_ParentVmTaskId,null);
  }

  public long getParentVmTaskId(){
        return DataType.getAsLong(this.get(S_ParentVmTaskId));
  
  }
  public long getParentVmTaskIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_ParentVmTaskId));
      }

  public void initOrderType(String value){
     this.initProperty(S_OrderType,value);
  }
  public  void setOrderType(String value){
     this.set(S_OrderType,value);
  }
  public  void setOrderTypeNull(){
     this.set(S_OrderType,null);
  }

  public String getOrderType(){
       return DataType.getAsString(this.get(S_OrderType));
  
  }
  public String getOrderTypeInitialValue(){
        return DataType.getAsString(this.getOldObj(S_OrderType));
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

  public void initConnectPoint(String value){
     this.initProperty(S_ConnectPoint,value);
  }
  public  void setConnectPoint(String value){
     this.set(S_ConnectPoint,value);
  }
  public  void setConnectPointNull(){
     this.set(S_ConnectPoint,null);
  }

  public String getConnectPoint(){
       return DataType.getAsString(this.get(S_ConnectPoint));
  
  }
  public String getConnectPointInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ConnectPoint));
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

  public void initVmTaskName(String value){
     this.initProperty(S_VmTaskName,value);
  }
  public  void setVmTaskName(String value){
     this.set(S_VmTaskName,value);
  }
  public  void setVmTaskNameNull(){
     this.set(S_VmTaskName,null);
  }

  public String getVmTaskName(){
       return DataType.getAsString(this.get(S_VmTaskName));
  
  }
  public String getVmTaskNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_VmTaskName));
      }

  public void initSubmitStaffName(String value){
     this.initProperty(S_SubmitStaffName,value);
  }
  public  void setSubmitStaffName(String value){
     this.set(S_SubmitStaffName,value);
  }
  public  void setSubmitStaffNameNull(){
     this.set(S_SubmitStaffName,null);
  }

  public String getSubmitStaffName(){
       return DataType.getAsString(this.get(S_SubmitStaffName));
  
  }
  public String getSubmitStaffNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_SubmitStaffName));
      }

  public void initCond(String value){
     this.initProperty(S_Cond,value);
  }
  public  void setCond(String value){
     this.set(S_Cond,value);
  }
  public  void setCondNull(){
     this.set(S_Cond,null);
  }

  public String getCond(){
       return DataType.getAsString(this.get(S_Cond));
  
  }
  public String getCondInitialValue(){
        return DataType.getAsString(this.getOldObj(S_Cond));
      }

  public void initExecStaffId(long value){
     this.initProperty(S_ExecStaffId,new Long(value));
  }
  public  void setExecStaffId(long value){
     this.set(S_ExecStaffId,new Long(value));
  }
  public  void setExecStaffIdNull(){
     this.set(S_ExecStaffId,null);
  }

  public long getExecStaffId(){
        return DataType.getAsLong(this.get(S_ExecStaffId));
  
  }
  public long getExecStaffIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_ExecStaffId));
      }

  public void initPhaseId(String value){
     this.initProperty(S_PhaseId,value);
  }
  public  void setPhaseId(String value){
     this.set(S_PhaseId,value);
  }
  public  void setPhaseIdNull(){
     this.set(S_PhaseId,null);
  }

  public String getPhaseId(){
       return DataType.getAsString(this.get(S_PhaseId));
  
  }
  public String getPhaseIdInitialValue(){
        return DataType.getAsString(this.getOldObj(S_PhaseId));
      }


 
 }

