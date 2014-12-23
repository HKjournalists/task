package com.asiainfo.csc.matrix.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOAlmWorkflowTemplateValue extends DataStructInterface{

  public final static  String S_TemplateName = "TEMPLATE_NAME";
  public final static  String S_ObjType = "OBJ_TYPE";
  public final static  String S_TemplateType = "TEMPLATE_TYPE";
  public final static  String S_TemplateId = "TEMPLATE_ID";


public String getTemplateName();

public String getObjType();

public String getTemplateType();

public long getTemplateId();


public  void setTemplateName(String value);

public  void setObjType(String value);

public  void setTemplateType(String value);

public  void setTemplateId(long value);
}
