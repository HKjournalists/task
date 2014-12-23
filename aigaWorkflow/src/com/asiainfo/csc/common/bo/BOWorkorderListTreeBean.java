package com.asiainfo.csc.common.bo;

import java.sql.Timestamp;

import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.AIDataBase;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.DataType;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.util.ITreeNodeInfo;

public class BOWorkorderListTreeBean extends DataContainer implements AIDataBase, ITreeNodeInfo{

  /**
	 * 
	 */
	private static final long serialVersionUID = 6280763433262130822L;

  public final static  String S_CreateTime = "CREATE_TIME";
  public final static  String S_ObjName = "OBJ_NAME";
  public final static  String S_Opinion = "OPINION";
  public final static  String S_TemplateId = "TEMPLATE_ID";
  public final static  String S_LinkNo = "LINK_NO";
  public final static  String S_FinishTime = "FINISH_TIME";
  public final static  String S_Status = "STATUS";
  public final static  String S_ExecStaffNo = "EXEC_STAFF_NO";
  public final static  String S_LinkNoType = "LINK_NO_TYPE";
  public final static  String S_ObjTag = "OBJ_TAG";
  public final static  String S_Result = "RESULT";
  public final static  String S_GroupName = "GROUP_NAME";
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
  public final static  String S_StatusStep = "STATUS_STEP";
  public final static  String S_ApplyStaffName = "APPLY_STAFF_NAME";
  public final static  String S_ExecStaffId = "EXEC_STAFF_ID";
  public final static  String S_PhaseId = "PHASE_ID";
  public final static String S_Seq = "SEQ";
  public final static String S_IsEdit = "IS_EDIT";

  public static ObjectType S_TYPE = null;

 public static ObjectType getObjectTypeStatic() throws AIException{
   return S_TYPE;
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
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

  public void initGroupName(String value){
     this.initProperty(S_GroupName,value);
  }
  public  void setGroupName(String value){
     this.set(S_GroupName,value);
  }
  public  void setGroupNameNull(){
     this.set(S_GroupName,null);
  }

  public String getGroupName(){
       return DataType.getAsString(this.get(S_GroupName));
  
  }
  public String getGroupNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_GroupName));
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

  public void initStatusStep(long value){
     this.initProperty(S_StatusStep,new Long(value));
  }
  public  void setStatusStep(long value){
     this.set(S_StatusStep,new Long(value));
  }
  public  void setStatusStepNull(){
     this.set(S_StatusStep,null);
  }

  public long getStatusStep(){
        return DataType.getAsLong(this.get(S_StatusStep));
  
  }
  public long getStatusStepInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_StatusStep));
      }

  public void initApplyStaffName(String value){
     this.initProperty(S_ApplyStaffName,value);
  }
  public  void setApplyStaffName(String value){
     this.set(S_ApplyStaffName,value);
  }
  public  void setApplyStaffNameNull(){
     this.set(S_ApplyStaffName,null);
  }

  public String getApplyStaffName(){
       return DataType.getAsString(this.get(S_ApplyStaffName));
  
  }
  public String getApplyStaffNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ApplyStaffName));
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
  
  public void setSeq(String value) {
	  this.set(S_Seq, value);
  }
  public String getSeq() {
	  return DataType.getAsString(this.get(S_Seq));
  }
  
  public void setIsEdit(String value) {
	  this.set(S_IsEdit, value);
  }
  public String getIsEdit() {
	  return DataType.getAsString(this.get(S_IsEdit));
  }
  
  protected long m_id;
	protected long m_parentId;
	protected long m_sortId;
	protected int m_level;
	protected int m_childCount;
	protected String m_childRowIndexs;




	public BOWorkorderListTreeBean() {
		this.m_id = 0L;
		this.m_parentId = 0L;
		this.m_sortId = 1L;
		this.m_level = -1;
		this.m_childCount = -1;
		this.m_childRowIndexs = "";
	}

	
	public int getChildCount() {

		return this.m_childCount;
	}

	
	public String getChildRowIndexs() {

		return this.m_childRowIndexs;
	}

	
	public long getId() {

		return this.m_id;
	}

	
	public int getLevel() {

		return this.m_level;
	}

	
	public long getParentId() {

		return this.m_parentId;
	}

	
	public long getSortId() {

		return this.m_sortId;
	}

	
	public void setChildCount(int arg0) {
		this.m_childCount = arg0;
	}

	
	public void setChildRowIndexs(String arg0) {
		this.m_childRowIndexs = arg0;
	}

	
	public void setLevel(int arg0) {
		this.m_level = arg0;
	}

	public void setM_parentId(long m_parentId) {
		this.m_parentId = m_parentId;
	}

	public void setM_id(long m_id) {
		this.m_id = m_id;
	}

}

