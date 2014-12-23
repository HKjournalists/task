package com.asiainfo.csc.common.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.csc.common.ivalues.*;

public class BOWorkflowBean extends DataContainer implements DataContainerInterface,IBOWorkflowValue{

  private static String  m_boName = "com.asiainfo.csc.common.bo.BOWorkflow";



  public final static  String S_VmTaskNo = "VM_TASK_NO";
  public final static  String S_IsCompany = "IS_COMPANY";
  public final static  String S_IsRole = "IS_ROLE";
  public final static  String S_PhaseName = "PHASE_NAME";
  public final static  String S_CreateTime = "CREATE_TIME";
  public final static  String S_CreateStaffId = "CREATE_STAFF_ID";
  public final static  String S_TemplateType = "TEMPLATE_TYPE";
  public final static  String S_InitLinkId = "INIT_LINK_ID";
  public final static  String S_TemplateId = "TEMPLATE_ID";
  public final static  String S_RoleCode = "ROLE_CODE";
  public final static  String S_IsNotice = "IS_NOTICE";
  public final static  String S_LinkNo = "LINK_NO";
  public final static  String S_ValidTag = "VALID_TAG";
  public final static  String S_LinkNoType = "LINK_NO_TYPE";
  public final static  String S_WfItemId = "WF_ITEM_ID";
  public final static  String S_LinkUrl = "LINK_URL";
  public final static  String S_Version = "VERSION";
  public final static  String S_BackLinkNo = "BACK_LINK_NO";
  public final static  String S_TemplateName = "TEMPLATE_NAME";
  public final static  String S_IsPrint = "IS_PRINT";
  public final static  String S_LinkId = "LINK_ID";
  public final static  String S_NeedInitStaff = "NEED_INIT_STAFF";
  public final static  String S_IsDisplay = "IS_DISPLAY";
  public final static  String S_BackCond = "BACK_COND";
  public final static  String S_HtmlTagName = "HTML_TAG_NAME";
  public final static  String S_VmLinkId = "VM_LINK_ID";
  public final static  String S_InitLinkNo = "INIT_LINK_NO";
  public final static  String S_StartTime = "START_TIME";
  public final static  String S_IsTerminate = "IS_TERMINATE";
  public final static  String S_ConnectPoint = "CONNECT_POINT";
  public final static  String S_IsBack = "IS_BACK";
  public final static  String S_IsDepart = "IS_DEPART";
  public final static  String S_IsDiscuss = "IS_DISCUSS";
  public final static  String S_VmTaskName = "VM_TASK_NAME";
  public final static  String S_IsReauthorize = "IS_REAUTHORIZE";
  public final static  String S_EndTime = "END_TIME";
  public final static  String S_HtmlTagDesc = "HTML_TAG_DESC";
  public final static  String S_NextLinkCondTree = "NEXT_LINK_COND_TREE";
  public final static  String S_IsGroup = "IS_GROUP";
  public final static  String S_PhaseId = "PHASE_ID";

  public static ObjectType S_TYPE = null;
  static{
    try {
      S_TYPE = ServiceManager.getObjectTypeFactory().getInstance(m_boName);
    }catch(Exception e){
      throw new RuntimeException(e);
    }
  }
  public BOWorkflowBean() throws AIException{
      super(S_TYPE);
  }

 public static ObjectType getObjectTypeStatic() throws AIException{
   return S_TYPE;
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initVmTaskNo(String value){
     this.initProperty(S_VmTaskNo,value);
  }
  public  void setVmTaskNo(String value){
     this.set(S_VmTaskNo,value);
  }
  public  void setVmTaskNoNull(){
     this.set(S_VmTaskNo,null);
  }

  public String getVmTaskNo(){
       return DataType.getAsString(this.get(S_VmTaskNo));
  
  }
  public String getVmTaskNoInitialValue(){
        return DataType.getAsString(this.getOldObj(S_VmTaskNo));
      }

  public void initIsCompany(int value){
     this.initProperty(S_IsCompany,new Integer(value));
  }
  public  void setIsCompany(int value){
     this.set(S_IsCompany,new Integer(value));
  }
  public  void setIsCompanyNull(){
     this.set(S_IsCompany,null);
  }

  public int getIsCompany(){
        return DataType.getAsInt(this.get(S_IsCompany));
  
  }
  public int getIsCompanyInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_IsCompany));
      }

  public void initIsRole(int value){
     this.initProperty(S_IsRole,new Integer(value));
  }
  public  void setIsRole(int value){
     this.set(S_IsRole,new Integer(value));
  }
  public  void setIsRoleNull(){
     this.set(S_IsRole,null);
  }

  public int getIsRole(){
        return DataType.getAsInt(this.get(S_IsRole));
  
  }
  public int getIsRoleInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_IsRole));
      }

  public void initPhaseName(String value){
     this.initProperty(S_PhaseName,value);
  }
  public  void setPhaseName(String value){
     this.set(S_PhaseName,value);
  }
  public  void setPhaseNameNull(){
     this.set(S_PhaseName,null);
  }

  public String getPhaseName(){
       return DataType.getAsString(this.get(S_PhaseName));
  
  }
  public String getPhaseNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_PhaseName));
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

  public void initCreateStaffId(long value){
     this.initProperty(S_CreateStaffId,new Long(value));
  }
  public  void setCreateStaffId(long value){
     this.set(S_CreateStaffId,new Long(value));
  }
  public  void setCreateStaffIdNull(){
     this.set(S_CreateStaffId,null);
  }

  public long getCreateStaffId(){
        return DataType.getAsLong(this.get(S_CreateStaffId));
  
  }
  public long getCreateStaffIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_CreateStaffId));
      }

  public void initTemplateType(int value){
     this.initProperty(S_TemplateType,new Integer(value));
  }
  public  void setTemplateType(int value){
     this.set(S_TemplateType,new Integer(value));
  }
  public  void setTemplateTypeNull(){
     this.set(S_TemplateType,null);
  }

  public int getTemplateType(){
        return DataType.getAsInt(this.get(S_TemplateType));
  
  }
  public int getTemplateTypeInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_TemplateType));
      }

  public void initInitLinkId(long value){
     this.initProperty(S_InitLinkId,new Long(value));
  }
  public  void setInitLinkId(long value){
     this.set(S_InitLinkId,new Long(value));
  }
  public  void setInitLinkIdNull(){
     this.set(S_InitLinkId,null);
  }

  public long getInitLinkId(){
        return DataType.getAsLong(this.get(S_InitLinkId));
  
  }
  public long getInitLinkIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_InitLinkId));
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

  public void initRoleCode(String value){
     this.initProperty(S_RoleCode,value);
  }
  public  void setRoleCode(String value){
     this.set(S_RoleCode,value);
  }
  public  void setRoleCodeNull(){
     this.set(S_RoleCode,null);
  }

  public String getRoleCode(){
       return DataType.getAsString(this.get(S_RoleCode));
  
  }
  public String getRoleCodeInitialValue(){
        return DataType.getAsString(this.getOldObj(S_RoleCode));
      }

  public void initIsNotice(int value){
     this.initProperty(S_IsNotice,new Integer(value));
  }
  public  void setIsNotice(int value){
     this.set(S_IsNotice,new Integer(value));
  }
  public  void setIsNoticeNull(){
     this.set(S_IsNotice,null);
  }

  public int getIsNotice(){
        return DataType.getAsInt(this.get(S_IsNotice));
  
  }
  public int getIsNoticeInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_IsNotice));
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

  public void initValidTag(int value){
     this.initProperty(S_ValidTag,new Integer(value));
  }
  public  void setValidTag(int value){
     this.set(S_ValidTag,new Integer(value));
  }
  public  void setValidTagNull(){
     this.set(S_ValidTag,null);
  }

  public int getValidTag(){
        return DataType.getAsInt(this.get(S_ValidTag));
  
  }
  public int getValidTagInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_ValidTag));
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

  public void initWfItemId(long value){
     this.initProperty(S_WfItemId,new Long(value));
  }
  public  void setWfItemId(long value){
     this.set(S_WfItemId,new Long(value));
  }
  public  void setWfItemIdNull(){
     this.set(S_WfItemId,null);
  }

  public long getWfItemId(){
        return DataType.getAsLong(this.get(S_WfItemId));
  
  }
  public long getWfItemIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_WfItemId));
      }

  public void initLinkUrl(String value){
     this.initProperty(S_LinkUrl,value);
  }
  public  void setLinkUrl(String value){
     this.set(S_LinkUrl,value);
  }
  public  void setLinkUrlNull(){
     this.set(S_LinkUrl,null);
  }

  public String getLinkUrl(){
       return DataType.getAsString(this.get(S_LinkUrl));
  
  }
  public String getLinkUrlInitialValue(){
        return DataType.getAsString(this.getOldObj(S_LinkUrl));
      }

  public void initVersion(String value){
     this.initProperty(S_Version,value);
  }
  public  void setVersion(String value){
     this.set(S_Version,value);
  }
  public  void setVersionNull(){
     this.set(S_Version,null);
  }

  public String getVersion(){
       return DataType.getAsString(this.get(S_Version));
  
  }
  public String getVersionInitialValue(){
        return DataType.getAsString(this.getOldObj(S_Version));
      }

  public void initBackLinkNo(String value){
     this.initProperty(S_BackLinkNo,value);
  }
  public  void setBackLinkNo(String value){
     this.set(S_BackLinkNo,value);
  }
  public  void setBackLinkNoNull(){
     this.set(S_BackLinkNo,null);
  }

  public String getBackLinkNo(){
       return DataType.getAsString(this.get(S_BackLinkNo));
  
  }
  public String getBackLinkNoInitialValue(){
        return DataType.getAsString(this.getOldObj(S_BackLinkNo));
      }

  public void initTemplateName(String value){
     this.initProperty(S_TemplateName,value);
  }
  public  void setTemplateName(String value){
     this.set(S_TemplateName,value);
  }
  public  void setTemplateNameNull(){
     this.set(S_TemplateName,null);
  }

  public String getTemplateName(){
       return DataType.getAsString(this.get(S_TemplateName));
  
  }
  public String getTemplateNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_TemplateName));
      }

  public void initIsPrint(int value){
     this.initProperty(S_IsPrint,new Integer(value));
  }
  public  void setIsPrint(int value){
     this.set(S_IsPrint,new Integer(value));
  }
  public  void setIsPrintNull(){
     this.set(S_IsPrint,null);
  }

  public int getIsPrint(){
        return DataType.getAsInt(this.get(S_IsPrint));
  
  }
  public int getIsPrintInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_IsPrint));
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

  public void initNeedInitStaff(long value){
     this.initProperty(S_NeedInitStaff,new Long(value));
  }
  public  void setNeedInitStaff(long value){
     this.set(S_NeedInitStaff,new Long(value));
  }
  public  void setNeedInitStaffNull(){
     this.set(S_NeedInitStaff,null);
  }

  public long getNeedInitStaff(){
        return DataType.getAsLong(this.get(S_NeedInitStaff));
  
  }
  public long getNeedInitStaffInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_NeedInitStaff));
      }

  public void initIsDisplay(int value){
     this.initProperty(S_IsDisplay,new Integer(value));
  }
  public  void setIsDisplay(int value){
     this.set(S_IsDisplay,new Integer(value));
  }
  public  void setIsDisplayNull(){
     this.set(S_IsDisplay,null);
  }

  public int getIsDisplay(){
        return DataType.getAsInt(this.get(S_IsDisplay));
  
  }
  public int getIsDisplayInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_IsDisplay));
      }

  public void initBackCond(String value){
     this.initProperty(S_BackCond,value);
  }
  public  void setBackCond(String value){
     this.set(S_BackCond,value);
  }
  public  void setBackCondNull(){
     this.set(S_BackCond,null);
  }

  public String getBackCond(){
       return DataType.getAsString(this.get(S_BackCond));
  
  }
  public String getBackCondInitialValue(){
        return DataType.getAsString(this.getOldObj(S_BackCond));
      }

  public void initHtmlTagName(String value){
     this.initProperty(S_HtmlTagName,value);
  }
  public  void setHtmlTagName(String value){
     this.set(S_HtmlTagName,value);
  }
  public  void setHtmlTagNameNull(){
     this.set(S_HtmlTagName,null);
  }

  public String getHtmlTagName(){
       return DataType.getAsString(this.get(S_HtmlTagName));
  
  }
  public String getHtmlTagNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_HtmlTagName));
      }

  public void initVmLinkId(long value){
     this.initProperty(S_VmLinkId,new Long(value));
  }
  public  void setVmLinkId(long value){
     this.set(S_VmLinkId,new Long(value));
  }
  public  void setVmLinkIdNull(){
     this.set(S_VmLinkId,null);
  }

  public long getVmLinkId(){
        return DataType.getAsLong(this.get(S_VmLinkId));
  
  }
  public long getVmLinkIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_VmLinkId));
      }

  public void initInitLinkNo(String value){
     this.initProperty(S_InitLinkNo,value);
  }
  public  void setInitLinkNo(String value){
     this.set(S_InitLinkNo,value);
  }
  public  void setInitLinkNoNull(){
     this.set(S_InitLinkNo,null);
  }

  public String getInitLinkNo(){
       return DataType.getAsString(this.get(S_InitLinkNo));
  
  }
  public String getInitLinkNoInitialValue(){
        return DataType.getAsString(this.getOldObj(S_InitLinkNo));
      }

  public void initStartTime(Timestamp value){
     this.initProperty(S_StartTime,value);
  }
  public  void setStartTime(Timestamp value){
     this.set(S_StartTime,value);
  }
  public  void setStartTimeNull(){
     this.set(S_StartTime,null);
  }

  public Timestamp getStartTime(){
        return DataType.getAsDateTime(this.get(S_StartTime));
  
  }
  public Timestamp getStartTimeInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_StartTime));
      }

  public void initIsTerminate(int value){
     this.initProperty(S_IsTerminate,new Integer(value));
  }
  public  void setIsTerminate(int value){
     this.set(S_IsTerminate,new Integer(value));
  }
  public  void setIsTerminateNull(){
     this.set(S_IsTerminate,null);
  }

  public int getIsTerminate(){
        return DataType.getAsInt(this.get(S_IsTerminate));
  
  }
  public int getIsTerminateInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_IsTerminate));
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

  public void initIsBack(int value){
     this.initProperty(S_IsBack,new Integer(value));
  }
  public  void setIsBack(int value){
     this.set(S_IsBack,new Integer(value));
  }
  public  void setIsBackNull(){
     this.set(S_IsBack,null);
  }

  public int getIsBack(){
        return DataType.getAsInt(this.get(S_IsBack));
  
  }
  public int getIsBackInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_IsBack));
      }

  public void initIsDepart(int value){
     this.initProperty(S_IsDepart,new Integer(value));
  }
  public  void setIsDepart(int value){
     this.set(S_IsDepart,new Integer(value));
  }
  public  void setIsDepartNull(){
     this.set(S_IsDepart,null);
  }

  public int getIsDepart(){
        return DataType.getAsInt(this.get(S_IsDepart));
  
  }
  public int getIsDepartInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_IsDepart));
      }

  public void initIsDiscuss(int value){
     this.initProperty(S_IsDiscuss,new Integer(value));
  }
  public  void setIsDiscuss(int value){
     this.set(S_IsDiscuss,new Integer(value));
  }
  public  void setIsDiscussNull(){
     this.set(S_IsDiscuss,null);
  }

  public int getIsDiscuss(){
        return DataType.getAsInt(this.get(S_IsDiscuss));
  
  }
  public int getIsDiscussInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_IsDiscuss));
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

  public void initIsReauthorize(int value){
     this.initProperty(S_IsReauthorize,new Integer(value));
  }
  public  void setIsReauthorize(int value){
     this.set(S_IsReauthorize,new Integer(value));
  }
  public  void setIsReauthorizeNull(){
     this.set(S_IsReauthorize,null);
  }

  public int getIsReauthorize(){
        return DataType.getAsInt(this.get(S_IsReauthorize));
  
  }
  public int getIsReauthorizeInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_IsReauthorize));
      }

  public void initEndTime(Timestamp value){
     this.initProperty(S_EndTime,value);
  }
  public  void setEndTime(Timestamp value){
     this.set(S_EndTime,value);
  }
  public  void setEndTimeNull(){
     this.set(S_EndTime,null);
  }

  public Timestamp getEndTime(){
        return DataType.getAsDateTime(this.get(S_EndTime));
  
  }
  public Timestamp getEndTimeInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_EndTime));
      }

  public void initHtmlTagDesc(String value){
     this.initProperty(S_HtmlTagDesc,value);
  }
  public  void setHtmlTagDesc(String value){
     this.set(S_HtmlTagDesc,value);
  }
  public  void setHtmlTagDescNull(){
     this.set(S_HtmlTagDesc,null);
  }

  public String getHtmlTagDesc(){
       return DataType.getAsString(this.get(S_HtmlTagDesc));
  
  }
  public String getHtmlTagDescInitialValue(){
        return DataType.getAsString(this.getOldObj(S_HtmlTagDesc));
      }

  public void initNextLinkCondTree(long value){
     this.initProperty(S_NextLinkCondTree,new Long(value));
  }
  public  void setNextLinkCondTree(long value){
     this.set(S_NextLinkCondTree,new Long(value));
  }
  public  void setNextLinkCondTreeNull(){
     this.set(S_NextLinkCondTree,null);
  }

  public long getNextLinkCondTree(){
        return DataType.getAsLong(this.get(S_NextLinkCondTree));
  
  }
  public long getNextLinkCondTreeInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_NextLinkCondTree));
      }

  public void initIsGroup(int value){
     this.initProperty(S_IsGroup,new Integer(value));
  }
  public  void setIsGroup(int value){
     this.set(S_IsGroup,new Integer(value));
  }
  public  void setIsGroupNull(){
     this.set(S_IsGroup,null);
  }

  public int getIsGroup(){
        return DataType.getAsInt(this.get(S_IsGroup));
  
  }
  public int getIsGroupInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_IsGroup));
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


 
 }

