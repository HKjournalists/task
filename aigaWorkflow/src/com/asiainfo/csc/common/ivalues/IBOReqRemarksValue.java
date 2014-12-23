package com.asiainfo.csc.common.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOReqRemarksValue extends DataStructInterface{

  public final static  String S_ObjTag = "OBJ_TAG";
  public final static  String S_Remarks = "REMARKS";
  public final static  String S_CreateTime = "CREATE_TIME";
  public final static  String S_ObjType = "OBJ_TYPE";
  public final static  String S_RemarkId = "REMARK_ID";
  public final static  String S_ChangeTime = "CHANGE_TIME";


public String getObjTag();

public String getRemarks();

public Timestamp getCreateTime();

public int getObjType();

public long getRemarkId();

public Timestamp getChangeTime();


public  void setObjTag(String value);

public  void setRemarks(String value);

public  void setCreateTime(Timestamp value);

public  void setObjType(int value);

public  void setRemarkId(long value);

public  void setChangeTime(Timestamp value);
}
