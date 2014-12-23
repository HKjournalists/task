package com.asiainfo.aiga.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOAigaSubTaskProblemValue extends DataStructInterface{

  public final static  String S_StpStatus = "STP_STATUS";
  public final static  String S_SubTaskId = "SUB_TASK_ID";
  public final static  String S_StpPhase = "STP_PHASE";
  public final static  String S_CreateTime = "CREATE_TIME";
  public final static  String S_CreateStaffId = "CREATE_STAFF_ID";
  public final static  String S_StpMainClass = "STP_MAIN_CLASS";
  public final static  String S_StpName = "STP_NAME";
  public final static  String S_SubTaskType = "SUB_TASK_TYPE";
  public final static  String S_SubTaskTag = "SUB_TASK_TAG";
  public final static  String S_StpSubClass = "STP_SUB_CLASS";
  public final static  String S_StartMark = "START_MARK";
  public final static  String S_SubTaskName = "SUB_TASK_NAME";
  public final static  String S_StpTag = "STP_TAG";
  public final static  String S_StpDscr = "STP_DSCR";
  public final static  String S_DefectDscr = "DEFECT_DSCR";
  public final static  String S_Id = "ID";
  public final static  String S_StpInto = "STP_INTO";
  public final static  String S_CreateStaffName = "CREATE_STAFF_NAME";


public long getStpStatus();

public long getSubTaskId();

public long getStpPhase();

public Timestamp getCreateTime();

public long getCreateStaffId();

public long getStpMainClass();

public String getStpName();

public long getSubTaskType();

public String getSubTaskTag();

public long getStpSubClass();

public long getStartMark();

public String getSubTaskName();

public String getStpTag();

public String getStpDscr();

public String getDefectDscr();

public long getId();

public long getStpInto();

public String getCreateStaffName();


public  void setStpStatus(long value);

public  void setSubTaskId(long value);

public  void setStpPhase(long value);

public  void setCreateTime(Timestamp value);

public  void setCreateStaffId(long value);

public  void setStpMainClass(long value);

public  void setStpName(String value);

public  void setSubTaskType(long value);

public  void setSubTaskTag(String value);

public  void setStpSubClass(long value);

public  void setStartMark(long value);

public  void setSubTaskName(String value);

public  void setStpTag(String value);

public  void setStpDscr(String value);

public  void setDefectDscr(String value);

public  void setId(long value);

public  void setStpInto(long value);

public  void setCreateStaffName(String value);
}
