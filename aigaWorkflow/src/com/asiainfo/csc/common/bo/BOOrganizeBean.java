package com.asiainfo.csc.common.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.csc.common.ivalues.*;

public class BOOrganizeBean extends DataContainer implements DataContainerInterface,IBOOrganizeValue{

  private static String  m_boName = "com.asiainfo.csc.common.bo.BOOrganize";



  public final static  String S_PostAddress = "POST_ADDRESS";
  public final static  String S_ParentOrganizeId = "PARENT_ORGANIZE_ID";
  public final static  String S_State = "STATE";
  public final static  String S_OrgAddress = "ORG_ADDRESS";
  public final static  String S_ContactBillId = "CONTACT_BILL_ID";
  public final static  String S_PostProvince = "POST_PROVINCE";
  public final static  String S_ContactName = "CONTACT_NAME";
  public final static  String S_Postcode = "POSTCODE";
  public final static  String S_ShortName = "SHORT_NAME";
  public final static  String S_OldParentCode = "OLD_PARENT_CODE";
  public final static  String S_PhoneId = "PHONE_ID";
  public final static  String S_PostCity = "POST_CITY";
  public final static  String S_ValidDate = "VALID_DATE";
  public final static  String S_IsLeaf = "IS_LEAF";
  public final static  String S_Email = "EMAIL";
  public final static  String S_DoneCode = "DONE_CODE";
  public final static  String S_FaxId = "FAX_ID";
  public final static  String S_Notes = "NOTES";
  public final static  String S_EnglishName = "ENGLISH_NAME";
  public final static  String S_Code = "CODE";
  public final static  String S_ExpireDate = "EXPIRE_DATE";
  public final static  String S_OpId = "OP_ID";
  public final static  String S_OrganizeName = "ORGANIZE_NAME";
  public final static  String S_PostPostcod = "POST_POSTCOD";
  public final static  String S_OldCode = "OLD_CODE";
  public final static  String S_ManagerName = "MANAGER_NAME";
  public final static  String S_OrgRoleTypeId = "ORG_ROLE_TYPE_ID";
  public final static  String S_OrgId = "ORG_ID";
  public final static  String S_DistrictId = "DISTRICT_ID";
  public final static  String S_CountyId = "COUNTY_ID";
  public final static  String S_DoneDate = "DONE_DATE";
  public final static  String S_ContactCardType = "CONTACT_CARD_TYPE";
  public final static  String S_CreateDate = "CREATE_DATE";
  public final static  String S_Ext1 = "EXT1";
  public final static  String S_ContactCardId = "CONTACT_CARD_ID";
  public final static  String S_Ext2 = "EXT2";
  public final static  String S_MemberNum = "MEMBER_NUM";
  public final static  String S_Ext3 = "EXT3";
  public final static  String S_OrganizeId = "ORGANIZE_ID";

  public static ObjectType S_TYPE = null;
  static{
    try {
      S_TYPE = ServiceManager.getObjectTypeFactory().getInstance(m_boName);
    }catch(Exception e){
      throw new RuntimeException(e);
    }
  }
  public BOOrganizeBean() throws AIException{
      super(S_TYPE);
  }

 public static ObjectType getObjectTypeStatic() throws AIException{
   return S_TYPE;
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
 }


  public void initPostAddress(String value){
     this.initProperty(S_PostAddress,value);
  }
  public  void setPostAddress(String value){
     this.set(S_PostAddress,value);
  }
  public  void setPostAddressNull(){
     this.set(S_PostAddress,null);
  }

  public String getPostAddress(){
       return DataType.getAsString(this.get(S_PostAddress));
  
  }
  public String getPostAddressInitialValue(){
        return DataType.getAsString(this.getOldObj(S_PostAddress));
      }

  public void initParentOrganizeId(long value){
     this.initProperty(S_ParentOrganizeId,new Long(value));
  }
  public  void setParentOrganizeId(long value){
     this.set(S_ParentOrganizeId,new Long(value));
  }
  public  void setParentOrganizeIdNull(){
     this.set(S_ParentOrganizeId,null);
  }

  public long getParentOrganizeId(){
        return DataType.getAsLong(this.get(S_ParentOrganizeId));
  
  }
  public long getParentOrganizeIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_ParentOrganizeId));
      }

  public void initState(int value){
     this.initProperty(S_State,new Integer(value));
  }
  public  void setState(int value){
     this.set(S_State,new Integer(value));
  }
  public  void setStateNull(){
     this.set(S_State,null);
  }

  public int getState(){
        return DataType.getAsInt(this.get(S_State));
  
  }
  public int getStateInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_State));
      }

  public void initOrgAddress(String value){
     this.initProperty(S_OrgAddress,value);
  }
  public  void setOrgAddress(String value){
     this.set(S_OrgAddress,value);
  }
  public  void setOrgAddressNull(){
     this.set(S_OrgAddress,null);
  }

  public String getOrgAddress(){
       return DataType.getAsString(this.get(S_OrgAddress));
  
  }
  public String getOrgAddressInitialValue(){
        return DataType.getAsString(this.getOldObj(S_OrgAddress));
      }

  public void initContactBillId(String value){
     this.initProperty(S_ContactBillId,value);
  }
  public  void setContactBillId(String value){
     this.set(S_ContactBillId,value);
  }
  public  void setContactBillIdNull(){
     this.set(S_ContactBillId,null);
  }

  public String getContactBillId(){
       return DataType.getAsString(this.get(S_ContactBillId));
  
  }
  public String getContactBillIdInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ContactBillId));
      }

  public void initPostProvince(long value){
     this.initProperty(S_PostProvince,new Long(value));
  }
  public  void setPostProvince(long value){
     this.set(S_PostProvince,new Long(value));
  }
  public  void setPostProvinceNull(){
     this.set(S_PostProvince,null);
  }

  public long getPostProvince(){
        return DataType.getAsLong(this.get(S_PostProvince));
  
  }
  public long getPostProvinceInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_PostProvince));
      }

  public void initContactName(String value){
     this.initProperty(S_ContactName,value);
  }
  public  void setContactName(String value){
     this.set(S_ContactName,value);
  }
  public  void setContactNameNull(){
     this.set(S_ContactName,null);
  }

  public String getContactName(){
       return DataType.getAsString(this.get(S_ContactName));
  
  }
  public String getContactNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ContactName));
      }

  public void initPostcode(int value){
     this.initProperty(S_Postcode,new Integer(value));
  }
  public  void setPostcode(int value){
     this.set(S_Postcode,new Integer(value));
  }
  public  void setPostcodeNull(){
     this.set(S_Postcode,null);
  }

  public int getPostcode(){
        return DataType.getAsInt(this.get(S_Postcode));
  
  }
  public int getPostcodeInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_Postcode));
      }

  public void initShortName(String value){
     this.initProperty(S_ShortName,value);
  }
  public  void setShortName(String value){
     this.set(S_ShortName,value);
  }
  public  void setShortNameNull(){
     this.set(S_ShortName,null);
  }

  public String getShortName(){
       return DataType.getAsString(this.get(S_ShortName));
  
  }
  public String getShortNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ShortName));
      }

  public void initOldParentCode(String value){
     this.initProperty(S_OldParentCode,value);
  }
  public  void setOldParentCode(String value){
     this.set(S_OldParentCode,value);
  }
  public  void setOldParentCodeNull(){
     this.set(S_OldParentCode,null);
  }

  public String getOldParentCode(){
       return DataType.getAsString(this.get(S_OldParentCode));
  
  }
  public String getOldParentCodeInitialValue(){
        return DataType.getAsString(this.getOldObj(S_OldParentCode));
      }

  public void initPhoneId(String value){
     this.initProperty(S_PhoneId,value);
  }
  public  void setPhoneId(String value){
     this.set(S_PhoneId,value);
  }
  public  void setPhoneIdNull(){
     this.set(S_PhoneId,null);
  }

  public String getPhoneId(){
       return DataType.getAsString(this.get(S_PhoneId));
  
  }
  public String getPhoneIdInitialValue(){
        return DataType.getAsString(this.getOldObj(S_PhoneId));
      }

  public void initPostCity(long value){
     this.initProperty(S_PostCity,new Long(value));
  }
  public  void setPostCity(long value){
     this.set(S_PostCity,new Long(value));
  }
  public  void setPostCityNull(){
     this.set(S_PostCity,null);
  }

  public long getPostCity(){
        return DataType.getAsLong(this.get(S_PostCity));
  
  }
  public long getPostCityInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_PostCity));
      }

  public void initValidDate(Timestamp value){
     this.initProperty(S_ValidDate,value);
  }
  public  void setValidDate(Timestamp value){
     this.set(S_ValidDate,value);
  }
  public  void setValidDateNull(){
     this.set(S_ValidDate,null);
  }

  public Timestamp getValidDate(){
        return DataType.getAsDateTime(this.get(S_ValidDate));
  
  }
  public Timestamp getValidDateInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_ValidDate));
      }

  public void initIsLeaf(String value){
     this.initProperty(S_IsLeaf,value);
  }
  public  void setIsLeaf(String value){
     this.set(S_IsLeaf,value);
  }
  public  void setIsLeafNull(){
     this.set(S_IsLeaf,null);
  }

  public String getIsLeaf(){
       return DataType.getAsString(this.get(S_IsLeaf));
  
  }
  public String getIsLeafInitialValue(){
        return DataType.getAsString(this.getOldObj(S_IsLeaf));
      }

  public void initEmail(String value){
     this.initProperty(S_Email,value);
  }
  public  void setEmail(String value){
     this.set(S_Email,value);
  }
  public  void setEmailNull(){
     this.set(S_Email,null);
  }

  public String getEmail(){
       return DataType.getAsString(this.get(S_Email));
  
  }
  public String getEmailInitialValue(){
        return DataType.getAsString(this.getOldObj(S_Email));
      }

  public void initDoneCode(long value){
     this.initProperty(S_DoneCode,new Long(value));
  }
  public  void setDoneCode(long value){
     this.set(S_DoneCode,new Long(value));
  }
  public  void setDoneCodeNull(){
     this.set(S_DoneCode,null);
  }

  public long getDoneCode(){
        return DataType.getAsLong(this.get(S_DoneCode));
  
  }
  public long getDoneCodeInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_DoneCode));
      }

  public void initFaxId(String value){
     this.initProperty(S_FaxId,value);
  }
  public  void setFaxId(String value){
     this.set(S_FaxId,value);
  }
  public  void setFaxIdNull(){
     this.set(S_FaxId,null);
  }

  public String getFaxId(){
       return DataType.getAsString(this.get(S_FaxId));
  
  }
  public String getFaxIdInitialValue(){
        return DataType.getAsString(this.getOldObj(S_FaxId));
      }

  public void initNotes(String value){
     this.initProperty(S_Notes,value);
  }
  public  void setNotes(String value){
     this.set(S_Notes,value);
  }
  public  void setNotesNull(){
     this.set(S_Notes,null);
  }

  public String getNotes(){
       return DataType.getAsString(this.get(S_Notes));
  
  }
  public String getNotesInitialValue(){
        return DataType.getAsString(this.getOldObj(S_Notes));
      }

  public void initEnglishName(String value){
     this.initProperty(S_EnglishName,value);
  }
  public  void setEnglishName(String value){
     this.set(S_EnglishName,value);
  }
  public  void setEnglishNameNull(){
     this.set(S_EnglishName,null);
  }

  public String getEnglishName(){
       return DataType.getAsString(this.get(S_EnglishName));
  
  }
  public String getEnglishNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_EnglishName));
      }

  public void initCode(String value){
     this.initProperty(S_Code,value);
  }
  public  void setCode(String value){
     this.set(S_Code,value);
  }
  public  void setCodeNull(){
     this.set(S_Code,null);
  }

  public String getCode(){
       return DataType.getAsString(this.get(S_Code));
  
  }
  public String getCodeInitialValue(){
        return DataType.getAsString(this.getOldObj(S_Code));
      }

  public void initExpireDate(Timestamp value){
     this.initProperty(S_ExpireDate,value);
  }
  public  void setExpireDate(Timestamp value){
     this.set(S_ExpireDate,value);
  }
  public  void setExpireDateNull(){
     this.set(S_ExpireDate,null);
  }

  public Timestamp getExpireDate(){
        return DataType.getAsDateTime(this.get(S_ExpireDate));
  
  }
  public Timestamp getExpireDateInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_ExpireDate));
      }

  public void initOpId(long value){
     this.initProperty(S_OpId,new Long(value));
  }
  public  void setOpId(long value){
     this.set(S_OpId,new Long(value));
  }
  public  void setOpIdNull(){
     this.set(S_OpId,null);
  }

  public long getOpId(){
        return DataType.getAsLong(this.get(S_OpId));
  
  }
  public long getOpIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_OpId));
      }

  public void initOrganizeName(String value){
     this.initProperty(S_OrganizeName,value);
  }
  public  void setOrganizeName(String value){
     this.set(S_OrganizeName,value);
  }
  public  void setOrganizeNameNull(){
     this.set(S_OrganizeName,null);
  }

  public String getOrganizeName(){
       return DataType.getAsString(this.get(S_OrganizeName));
  
  }
  public String getOrganizeNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_OrganizeName));
      }

  public void initPostPostcod(int value){
     this.initProperty(S_PostPostcod,new Integer(value));
  }
  public  void setPostPostcod(int value){
     this.set(S_PostPostcod,new Integer(value));
  }
  public  void setPostPostcodNull(){
     this.set(S_PostPostcod,null);
  }

  public int getPostPostcod(){
        return DataType.getAsInt(this.get(S_PostPostcod));
  
  }
  public int getPostPostcodInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_PostPostcod));
      }

  public void initOldCode(String value){
     this.initProperty(S_OldCode,value);
  }
  public  void setOldCode(String value){
     this.set(S_OldCode,value);
  }
  public  void setOldCodeNull(){
     this.set(S_OldCode,null);
  }

  public String getOldCode(){
       return DataType.getAsString(this.get(S_OldCode));
  
  }
  public String getOldCodeInitialValue(){
        return DataType.getAsString(this.getOldObj(S_OldCode));
      }

  public void initManagerName(String value){
     this.initProperty(S_ManagerName,value);
  }
  public  void setManagerName(String value){
     this.set(S_ManagerName,value);
  }
  public  void setManagerNameNull(){
     this.set(S_ManagerName,null);
  }

  public String getManagerName(){
       return DataType.getAsString(this.get(S_ManagerName));
  
  }
  public String getManagerNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ManagerName));
      }

  public void initOrgRoleTypeId(int value){
     this.initProperty(S_OrgRoleTypeId,new Integer(value));
  }
  public  void setOrgRoleTypeId(int value){
     this.set(S_OrgRoleTypeId,new Integer(value));
  }
  public  void setOrgRoleTypeIdNull(){
     this.set(S_OrgRoleTypeId,null);
  }

  public int getOrgRoleTypeId(){
        return DataType.getAsInt(this.get(S_OrgRoleTypeId));
  
  }
  public int getOrgRoleTypeIdInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_OrgRoleTypeId));
      }

  public void initOrgId(long value){
     this.initProperty(S_OrgId,new Long(value));
  }
  public  void setOrgId(long value){
     this.set(S_OrgId,new Long(value));
  }
  public  void setOrgIdNull(){
     this.set(S_OrgId,null);
  }

  public long getOrgId(){
        return DataType.getAsLong(this.get(S_OrgId));
  
  }
  public long getOrgIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_OrgId));
      }

  public void initDistrictId(String value){
     this.initProperty(S_DistrictId,value);
  }
  public  void setDistrictId(String value){
     this.set(S_DistrictId,value);
  }
  public  void setDistrictIdNull(){
     this.set(S_DistrictId,null);
  }

  public String getDistrictId(){
       return DataType.getAsString(this.get(S_DistrictId));
  
  }
  public String getDistrictIdInitialValue(){
        return DataType.getAsString(this.getOldObj(S_DistrictId));
      }

  public void initCountyId(long value){
     this.initProperty(S_CountyId,new Long(value));
  }
  public  void setCountyId(long value){
     this.set(S_CountyId,new Long(value));
  }
  public  void setCountyIdNull(){
     this.set(S_CountyId,null);
  }

  public long getCountyId(){
        return DataType.getAsLong(this.get(S_CountyId));
  
  }
  public long getCountyIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_CountyId));
      }

  public void initDoneDate(Timestamp value){
     this.initProperty(S_DoneDate,value);
  }
  public  void setDoneDate(Timestamp value){
     this.set(S_DoneDate,value);
  }
  public  void setDoneDateNull(){
     this.set(S_DoneDate,null);
  }

  public Timestamp getDoneDate(){
        return DataType.getAsDateTime(this.get(S_DoneDate));
  
  }
  public Timestamp getDoneDateInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_DoneDate));
      }

  public void initContactCardType(int value){
     this.initProperty(S_ContactCardType,new Integer(value));
  }
  public  void setContactCardType(int value){
     this.set(S_ContactCardType,new Integer(value));
  }
  public  void setContactCardTypeNull(){
     this.set(S_ContactCardType,null);
  }

  public int getContactCardType(){
        return DataType.getAsInt(this.get(S_ContactCardType));
  
  }
  public int getContactCardTypeInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_ContactCardType));
      }

  public void initCreateDate(Timestamp value){
     this.initProperty(S_CreateDate,value);
  }
  public  void setCreateDate(Timestamp value){
     this.set(S_CreateDate,value);
  }
  public  void setCreateDateNull(){
     this.set(S_CreateDate,null);
  }

  public Timestamp getCreateDate(){
        return DataType.getAsDateTime(this.get(S_CreateDate));
  
  }
  public Timestamp getCreateDateInitialValue(){
        return DataType.getAsDateTime(this.getOldObj(S_CreateDate));
      }

  public void initExt1(String value){
     this.initProperty(S_Ext1,value);
  }
  public  void setExt1(String value){
     this.set(S_Ext1,value);
  }
  public  void setExt1Null(){
     this.set(S_Ext1,null);
  }

  public String getExt1(){
       return DataType.getAsString(this.get(S_Ext1));
  
  }
  public String getExt1InitialValue(){
        return DataType.getAsString(this.getOldObj(S_Ext1));
      }

  public void initContactCardId(String value){
     this.initProperty(S_ContactCardId,value);
  }
  public  void setContactCardId(String value){
     this.set(S_ContactCardId,value);
  }
  public  void setContactCardIdNull(){
     this.set(S_ContactCardId,null);
  }

  public String getContactCardId(){
       return DataType.getAsString(this.get(S_ContactCardId));
  
  }
  public String getContactCardIdInitialValue(){
        return DataType.getAsString(this.getOldObj(S_ContactCardId));
      }

  public void initExt2(String value){
     this.initProperty(S_Ext2,value);
  }
  public  void setExt2(String value){
     this.set(S_Ext2,value);
  }
  public  void setExt2Null(){
     this.set(S_Ext2,null);
  }

  public String getExt2(){
       return DataType.getAsString(this.get(S_Ext2));
  
  }
  public String getExt2InitialValue(){
        return DataType.getAsString(this.getOldObj(S_Ext2));
      }

  public void initMemberNum(int value){
     this.initProperty(S_MemberNum,new Integer(value));
  }
  public  void setMemberNum(int value){
     this.set(S_MemberNum,new Integer(value));
  }
  public  void setMemberNumNull(){
     this.set(S_MemberNum,null);
  }

  public int getMemberNum(){
        return DataType.getAsInt(this.get(S_MemberNum));
  
  }
  public int getMemberNumInitialValue(){
        return DataType.getAsInt(this.getOldObj(S_MemberNum));
      }

  public void initExt3(String value){
     this.initProperty(S_Ext3,value);
  }
  public  void setExt3(String value){
     this.set(S_Ext3,value);
  }
  public  void setExt3Null(){
     this.set(S_Ext3,null);
  }

  public String getExt3(){
       return DataType.getAsString(this.get(S_Ext3));
  
  }
  public String getExt3InitialValue(){
        return DataType.getAsString(this.getOldObj(S_Ext3));
      }

  public void initOrganizeId(long value){
     this.initProperty(S_OrganizeId,new Long(value));
  }
  public  void setOrganizeId(long value){
     this.set(S_OrganizeId,new Long(value));
  }
  public  void setOrganizeIdNull(){
     this.set(S_OrganizeId,null);
  }

  public long getOrganizeId(){
        return DataType.getAsLong(this.get(S_OrganizeId));
  
  }
  public long getOrganizeIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_OrganizeId));
      }


 
 }

