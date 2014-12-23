package com.asiainfo.csc.common.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOStakeholderValue extends DataStructInterface{

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


public int getCounter();

public long getObjId();

public Timestamp getCreateTime();

public long getTaskId();

public String getLinkNo();

public String getNoticeOperType();

public String getStdholderStaffName();

public long getRoleId();

public long getSeqNo();

public long getStdholderStaffId();

public String getStdholdeType();

public String getObjType();

public long getLinkId();

public String getStdholderOrgStructs();

public long getStdholderId();

public String getStdholderOrgNo();

public long getStdholderOrgId();

public long getWorkflowId();

public String getStdholderStaffNo();


public  void setCounter(int value);

public  void setObjId(long value);

public  void setCreateTime(Timestamp value);

public  void setTaskId(long value);

public  void setLinkNo(String value);

public  void setNoticeOperType(String value);

public  void setStdholderStaffName(String value);

public  void setRoleId(long value);

public  void setSeqNo(long value);

public  void setStdholderStaffId(long value);

public  void setStdholdeType(String value);

public  void setObjType(String value);

public  void setLinkId(long value);

public  void setStdholderOrgStructs(String value);

public  void setStdholderId(long value);

public  void setStdholderOrgNo(String value);

public  void setStdholderOrgId(long value);

public  void setWorkflowId(long value);

public  void setStdholderStaffNo(String value);
}