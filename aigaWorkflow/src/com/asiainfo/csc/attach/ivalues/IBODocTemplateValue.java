package com.asiainfo.csc.attach.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBODocTemplateValue extends DataStructInterface{

  public final static  String S_TempCreater = "TEMP_CREATER";
  public final static  String S_TempSort = "TEMP_SORT";
  public final static  String S_TempVersionNo = "TEMP_VERSION_NO";
  public final static  String S_DocTempId = "DOC_TEMP_ID";
  public final static  String S_RoleRead = "ROLE_READ";
  public final static  String S_TempPath = "TEMP_PATH";
  public final static  String S_RoleReadName = "ROLE_READ_NAME";
  public final static  String S_RoleDownloadName = "ROLE_DOWNLOAD_NAME";
  public final static  String S_TempOrgId = "TEMP_ORG_ID";
  public final static  String S_TempFtpName = "TEMP_FTP_NAME";
  public final static  String S_FileType = "FILE_TYPE";
  public final static  String S_RoleModify = "ROLE_MODIFY";
  public final static  String S_DocTempName = "DOC_TEMP_NAME";
  public final static  String S_TempDesc = "TEMP_DESC";
  public final static  String S_RoleDownload = "ROLE_DOWNLOAD";
  public final static  String S_DocType = "DOC_TYPE";
  public final static  String S_TempReviser = "TEMP_REVISER";
  public final static  String S_TempCreateTime = "TEMP_CREATE_TIME";
  public final static  String S_RoleModifyName = "ROLE_MODIFY_NAME";
  public final static  String S_TempReviseTime = "TEMP_REVISE_TIME";


public String getTempCreater();

public String getTempSort();

public String getTempVersionNo();

public long getDocTempId();

public String getRoleRead();

public String getTempPath();

public String getRoleReadName();

public String getRoleDownloadName();

public long getTempOrgId();

public String getTempFtpName();

public String getFileType();

public String getRoleModify();

public String getDocTempName();

public String getTempDesc();

public String getRoleDownload();

public String getDocType();

public String getTempReviser();

public Timestamp getTempCreateTime();

public String getRoleModifyName();

public Timestamp getTempReviseTime();


public  void setTempCreater(String value);

public  void setTempSort(String value);

public  void setTempVersionNo(String value);

public  void setDocTempId(long value);

public  void setRoleRead(String value);

public  void setTempPath(String value);

public  void setRoleReadName(String value);

public  void setRoleDownloadName(String value);

public  void setTempOrgId(long value);

public  void setTempFtpName(String value);

public  void setFileType(String value);

public  void setRoleModify(String value);

public  void setDocTempName(String value);

public  void setTempDesc(String value);

public  void setRoleDownload(String value);

public  void setDocType(String value);

public  void setTempReviser(String value);

public  void setTempCreateTime(Timestamp value);

public  void setRoleModifyName(String value);

public  void setTempReviseTime(Timestamp value);
}
