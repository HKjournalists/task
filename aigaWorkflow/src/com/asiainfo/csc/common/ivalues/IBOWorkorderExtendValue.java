package com.asiainfo.csc.common.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOWorkorderExtendValue extends DataStructInterface{

  public final static  String S_WorkflowParam = "WORKFLOW_PARAM";
  public final static  String S_OrderId = "ORDER_ID";


public String getWorkflowParam();

public long getOrderId();


public  void setWorkflowParam(String value);

public  void setOrderId(long value);
}
