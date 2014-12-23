package com.asiainfo.csc.common.bo;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.AIDataBase;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.util.ITreeNodeInfo;

public class BOTreeReqFunctionPointsBean extends DataContainer implements
		AIDataBase, ITreeNodeInfo {
	public final static String S_ExecStaffNo = "EXEC_STAFF_NO";
	public final static String S_Cond = "COND";
	public final static String S_Opinion = "OPINION";
	public final static String S_ExecStaffId = "EXEC_STAFF_ID";
	public final static String S_VmTaskName = "VM_TASK_NAME";
	public final static String S_CreateTime = "CREATE_TIME";
	public final static String S_ParentVmTaskId = "PARENT_VM_TASK_ID";
	public final static String S_FinishTime = "FINISH_TIME";
	public final static String S_LinkNoType = "LINK_NO_TYPE";
	public final static String S_PhaseId = "PHASE_ID";
	public final static String S_ObjTag = "OBJ_TAG";
	public final static String S_SubmitStaffName = "SUBMIT_STAFF_NAME";
	public final static String S_GroupName = "GROUP_NAME";
	public final static String S_Status = "STATUS";
	public final static String S_EmployeeName = "EMPLOYEE_NAME";
	public final static String S_StatusStep = "STATUS_STEP";
	public final static String S_ObjName = "OBJ_NAME";
	public final static String S_LinkId = "LINK_ID";
	public final static String S_ObjType = "OBJ_TYPE";
	public final static String S_OrderType = "ORDER_TYPE";
	public final static String S_OrderId = "ORDER_ID";
	public final static String S_ApplyStaffName = "APPLY_STAFF_NAME";
	public final static String S_ObjId = "OBJ_ID";
	public final static String S_ConnectPoint = "CONNECT_POINT";
	public final static String S_LinkNo = "LINK_NO";
	public final static String S_Result = "RESULT";

	Map VALUE_MAP;

	public void setExecStaffNo(String value) {
		VALUE_MAP.put(this.S_ExecStaffNo, value);
	}

	public void setCond(String value) {
		VALUE_MAP.put(this.S_Cond, value);
	}

	public void setOpinion(String value) {
		VALUE_MAP.put(this.S_Opinion, value);
	}

	public void setExecStaffId(long value) {
		VALUE_MAP.put(this.S_ExecStaffId, value);
	}

	public void setVmTaskName(String value) {
		VALUE_MAP.put(this.S_VmTaskName, value);
	}

	public void setCreateTime(Timestamp value) {
		VALUE_MAP.put(this.S_CreateTime, value);
	}

	public void setParentVmTaskId(long value) {
		VALUE_MAP.put(this.S_ParentVmTaskId, value);
	}

	public void setFinishTime(Timestamp value) {
		VALUE_MAP.put(this.S_FinishTime, value);
	}

	public void setLinkNoType(String value) {
		VALUE_MAP.put(this.S_LinkNoType, value);
	}

	public void setPhaseId(String value) {
		VALUE_MAP.put(this.S_PhaseId, value);
	}

	public void setObjTag(String value) {
		VALUE_MAP.put(this.S_ObjTag, value);
	}

	public void setSubmitStaffName(String value) {
		VALUE_MAP.put(this.S_SubmitStaffName, value);
	}

	public void setGroupName(String value) {
		VALUE_MAP.put(this.S_GroupName, value);
	}

	public void setStatus(String value) {
		VALUE_MAP.put(this.S_Status, value);
	}

	public void setEmployeeName(String value) {
		VALUE_MAP.put(this.S_EmployeeName, value);
	}

	public void setStatusStep(long value) {
		VALUE_MAP.put(this.S_StatusStep, value);
	}

	public void setObjName(String value) {
		VALUE_MAP.put(this.S_ObjName, value);
	}

	public void setLinkId(long value) {
		VALUE_MAP.put(this.S_LinkId, value);
	}

	public void setObjType(String value) {
		VALUE_MAP.put(this.S_ObjType, value);
	}

	public void setOrderType(String value) {
		VALUE_MAP.put(this.S_OrderType, value);
	}

	public void setOrderId(long value) {
		VALUE_MAP.put(this.S_OrderId, value);
	}

	public void setApplyStaffName(String value) {
		VALUE_MAP.put(this.S_ApplyStaffName, value);
	}

	public void setObjId(long value) {
		VALUE_MAP.put(this.S_ObjId, value);
	}

	public void setConnectPoint(long value) {
		VALUE_MAP.put(this.S_ConnectPoint, value);
	}

	public void setLinkNo(String value) {
		VALUE_MAP.put(this.S_LinkNo, value);
	}

	public void setResult(String value) {
		VALUE_MAP.put(this.S_Result, value);
	}

	protected long m_id;
	protected long m_parentId;
	protected long m_sortId;
	protected int m_level;
	protected int m_childCount;
	protected String m_childRowIndexs;

	public BOTreeReqFunctionPointsBean() {
		this.VALUE_MAP = new HashMap();
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

	public Object get(String arg0) {
		return this.VALUE_MAP.get(arg0);
	}

	
	public Object getDispalyAttr(String arg0, String arg1) {
		return this.VALUE_MAP.get(arg0);
	}

	public void setM_parentId(long m_parentId) {
		this.m_parentId = m_parentId;
	}

	public void setM_id(long m_id) {
		this.m_id = m_id;
	}

	public long getOrderId() {
		return (Long) this.VALUE_MAP.get(S_OrderId);
	}

	public long getObjId() {
		return (Long) this.VALUE_MAP.get(S_ObjId);
	}

	public long getLinkId() {
		return (Long) this.VALUE_MAP.get(S_LinkId);
	}

}
