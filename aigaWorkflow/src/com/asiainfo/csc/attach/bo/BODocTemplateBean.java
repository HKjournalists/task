package com.asiainfo.csc.attach.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.csc.attach.ivalues.*;

public class BODocTemplateBean extends DataContainer implements DataContainerInterface,IBODocTemplateValue{

  private static String  m_boName = "com.asiainfo.csc.attach.bo.BODocTemplate";



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

  public static ObjectType S_TYPE = null;
  static{
    try {
      S_TYPE = ServiceManager.getObjectTypeFactory().getInstance(m_boName);
    }catch(Exception e){
      throw new RuntimeException(e);
    }
  }
  public BODocTemplateBean() throws AIException{
      super(S_TYPE);
  }

 public static ObjectType getObjectTypeStatic() throws AIException{
   return S_TYPE;
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initTempCreater(String value){
     this.initProperty(S_TempCreater,value);
  }
  public  void setTempCreater(String value){
     this.set(S_TempCreater,value);
  }
  public  void setTempCreaterNull(){
     this.set(S_TempCreater,null);
  }

  public String getTempCreater(){
       return DataType.getAsString(this.get(S_TempCreater));
  
  }
  public String getTempCreaterInitialValue(){
        return DataType.getAsString(this.getOldObj(S_TempCreater));
      }

  public void initTempSort(String value){
     this.initProperty(S_TempSort,value);
  }
  public  void setTempSort(String value){
     this.set(S_TempSort,value);
  }
  public  void setTempSortNull(){
     this.set(S_TempSort,null);
  }

  public String getTempSort(){
       return DataType.getAsString(this.get(S_TempSort));
  
  }
  public String getTempSortInitialValue(){
        return DataType.getAsString(this.getOldObj(S_TempSort));
      }

  public void initTempVersionNo(String value){
     this.initProperty(S_TempVersionNo,value);
  }
  public  void setTempVersionNo(String value){
     this.set(S_TempVersionNo,value);
  }
  public  void setTempVersionNoNull(){
     this.set(S_TempVersionNo,null);
  }

  public String getTempVersionNo(){
       return DataType.getAsString(this.get(S_TempVersionNo));
  
  }
  public String getTempVersionNoInitialValue(){
        return DataType.getAsString(this.getOldObj(S_TempVersionNo));
      }

  public void initDocTempId(long value){
     this.initProperty(S_DocTempId,new Long(value));
  }
  public  void setDocTempId(long value){
     this.set(S_DocTempId,new Long(value));
  }
  public  void setDocTempIdNull(){
     this.set(S_DocTempId,null);
  }

  public long getDocTempId(){
        return DataType.getAsLong(this.get(S_DocTempId));
  
  }
  public long getDocTempIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_DocTempId));
      }

  public void initRoleRead(String value){
     this.initProperty(S_RoleRead,value);
  }
  public  void setRoleRead(String value){
     this.set(S_RoleRead,value);
  }
  public  void setRoleReadNull(){
     this.set(S_RoleRead,null);
  }

  public String getRoleRead(){
       return DataType.getAsString(this.get(S_RoleRead));
  
  }
  public String getRoleReadInitialValue(){
        return DataType.getAsString(this.getOldObj(S_RoleRead));
      }

  public void initTempPath(String value){
     this.initProperty(S_TempPath,value);
  }
  public  void setTempPath(String value){
     this.set(S_TempPath,value);
  }
  public  void setTempPathNull(){
     this.set(S_TempPath,null);
  }

  public String getTempPath(){
       return DataType.getAsString(this.get(S_TempPath));
  
  }
  public String getTempPathInitialValue(){
        return DataType.getAsString(this.getOldObj(S_TempPath));
      }

  public void initRoleReadName(String value){
     this.initProperty(S_RoleReadName,value);
  }
  public  void setRoleReadName(String value){
     this.set(S_RoleReadName,value);
  }
  public  void setRoleReadNameNull(){
     this.set(S_RoleReadName,null);
  }

  public String getRoleReadName(){
       return DataType.getAsString(this.get(S_RoleReadName));
  
  }
  public String getRoleReadNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_RoleReadName));
      }

  public void initRoleDownloadName(String value){
     this.initProperty(S_RoleDownloadName,value);
  }
  public  void setRoleDownloadName(String value){
     this.set(S_RoleDownloadName,value);
  }
  public  void setRoleDownloadNameNull(){
     this.set(S_RoleDownloadName,null);
  }

  public String getRoleDownloadName(){
       return DataType.getAsString(this.get(S_RoleDownloadName));
  
  }
  public String getRoleDownloadNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_RoleDownloadName));
      }

  public void initTempOrgId(long value){
     this.initProperty(S_TempOrgId,new Long(value));
  }
  public  void setTempOrgId(long value){
     this.set(S_TempOrgId,new Long(value));
  }
  public  void setTempOrgIdNull(){
     this.set(S_TempOrgId,null);
  }

  public long getTempOrgId(){
        return DataType.getAsLong(this.get(S_TempOrgId));
  
  }
  public long getTempOrgIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_TempOrgId));
      }

  public void initTempFtpName(String value){
     this.initProperty(S_TempFtpName,value);
  }
  public  void setTempFtpName(String value){
     this.set(S_TempFtpName,value);
  }
  public  void setTempFtpNameNull(){
     this.set(S_TempFtpName,null);
  }

  public String getTempFtpName(){
       return DataType.getAsString(this.get(S_TempFtpName));
  
  }
  public String getTempFtpNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_TempFtpName));
      }

  public void initFileType(String value){
     this.initProperty(S_FileType,value);
  }
  public  void setFileType(String value){
     this.set(S_FileType,value);
  }
  public  void setFileTypeNull(){
     this.set(S_FileType,null);
  }

  public String getFileType(){
       return DataType.getAsString(this.get(S_FileType));
  
  }
  public String getFileTypeInitialValue(){
        return DataType.getAsString(this.getOldObj(S_FileType));
      }

  public void initRoleModify(String value){
     this.initProperty(S_RoleModify,value);
  }
  public  void setRoleModify(String value){
     this.set(S_RoleModify,value);
  }
  public  void setRoleModifyNull(){
     this.set(S_RoleModify,null);
  }

  public String getRoleModify(){
       return DataType.getAsString(this.get(S_RoleModify));
  
  }
  public String getRoleModifyInitialValue(){
        return DataType.getAsString(this.getOldObj(S_RoleModify));
      }

  public void initDocTempName(String value){
     this.initProperty(S_DocTempName,value);
  }
  public  void setDocTempName(String value){
     this.set(S_DocTempName,value);
  }
  public  void setDocTempNameNull(){
     this.set(S_DocTempName,null);
  }

  public String getDocTempName(){
       return DataType.getAsString(this.get(S_DocTempName));
  
  }
  public String getDocTempNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_DocTempName));
      }

  public void initTempDesc(String value){
     this.initProperty(S_TempDesc,value);
  }
  public  void setTempDesc(String value){
     this.set(S_TempDesc,value);
  }
  public  void setTempDescNull(){
     this.set(S_TempDesc,null);
  }

  public String getTempDesc(){
       return DataType.getAsString(this.get(S_TempDesc));
  
  }
  public String getTempDescInitialValue(){
        return DataType.getAsString(this.getOldObj(S_TempDesc));
      }

  public void initRoleDownload(String value){
     this.initProperty(S_RoleDownload,value);
  }
  public  void setRoleDownload(String value){
     this.set(S_RoleDownload,value);
  }
  public  void setRoleDownloadNull(){
     this.set(S_RoleDownload,null);
  }

  public String getRoleDownload(){
       return DataType.getAsString(this.get(S_RoleDownload));
  
  }
  public String getRoleDownloadInitialValue(){
        return DataType.getAsString(this.getOldObj(S_RoleDownload));
      }

  public void initDocType(String value){
     this.initProperty(S_DocType,value);
  }
  public  void setDocType(String value){
     this.set(S_DocType,value);
  }
  public  void setDocTypeNull(){
     this.set(S_DocType,null);
  }

  public String getDocType(){
       return DataType.getAsString(this.get(S_DocType));
  
  }
  public String getDocTypeInitialValue(){
        return DataType.getAsString(this.getOldObj(S_DocType));
      }

  public void initTempReviser(String value){
     this.initProperty(S_TempReviser,value);
  }
  public  void setTempReviser(String value){
     this.set(S_TempReviser,value);
  }
  public  void setTempReviserNull(){
     this.set(S_TempReviser,null);
  }

  public String getTempReviser(){
       return DataType.getAsString(this.get(S_TempReviser));
  
  }
  public String getTempReviserInitialValue(){
        return DataType.getAsString(this.getOldObj(S_TempReviser));
      }

  public void initTempCreateTime(Timestamp value){
     this.initProperty(S_TempCreateTime,value);
  }
  public  void setTempCreateTime(Timestamp value){
     this.set(S_TempCreateTime,value);
  }
  public  void setTempCreateTimeNull(){
     this.set(S_TempCreateTime,null);
  }

  public Timestamp getTempCreateTime(){
        return DataType.getAsDateTime(this.get(S_TempCreateTime));
  
  }
  public Timestamp getTempCreateTimeInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_TempCreateTime));
      }

  public void initRoleModifyName(String value){
     this.initProperty(S_RoleModifyName,value);
  }
  public  void setRoleModifyName(String value){
     this.set(S_RoleModifyName,value);
  }
  public  void setRoleModifyNameNull(){
     this.set(S_RoleModifyName,null);
  }

  public String getRoleModifyName(){
       return DataType.getAsString(this.get(S_RoleModifyName));
  
  }
  public String getRoleModifyNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_RoleModifyName));
      }

  public void initTempReviseTime(Timestamp value){
     this.initProperty(S_TempReviseTime,value);
  }
  public  void setTempReviseTime(Timestamp value){
     this.set(S_TempReviseTime,value);
  }
  public  void setTempReviseTimeNull(){
     this.set(S_TempReviseTime,null);
  }

  public Timestamp getTempReviseTime(){
        return DataType.getAsDateTime(this.get(S_TempReviseTime));
  
  }
  public Timestamp getTempReviseTimeInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_TempReviseTime));
      }


 
 }

