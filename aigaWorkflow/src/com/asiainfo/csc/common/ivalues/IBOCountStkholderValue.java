package com.asiainfo.csc.common.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOCountStkholderValue extends DataStructInterface{

  public final static  String S_ObjId = "OBJ_ID";
  public final static  String S_ObjType = "OBJ_TYPE";
  public final static  String S_LinkId = "LINK_ID";
  public final static  String S_LinkNo = "LINK_NO";
  public final static  String S_NumOfOrder = "NUM_OF_ORDER";


public long getObjId();

public String getObjType();

public long getLinkId();

public String getLinkNo();

public int getNumOfOrder();


public  void setObjId(long value);

public  void setObjType(String value);

public  void setLinkId(long value);

public  void setLinkNo(String value);

public  void setNumOfOrder(int value);
}
