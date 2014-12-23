package com.asiainfo.csc.common.ivalues;
import com.ai.appframe2.common.DataStructInterface;
import java.sql.Timestamp;
public interface IBOOrganizeValue extends DataStructInterface{

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


public String getPostAddress();

public long getParentOrganizeId();

public int getState();

public String getOrgAddress();

public String getContactBillId();

public long getPostProvince();

public String getContactName();

public int getPostcode();

public String getShortName();

public String getOldParentCode();

public String getPhoneId();

public long getPostCity();

public Timestamp getValidDate();

public String getIsLeaf();

public String getEmail();

public long getDoneCode();

public String getFaxId();

public String getNotes();

public String getEnglishName();

public String getCode();

public Timestamp getExpireDate();

public long getOpId();

public String getOrganizeName();

public int getPostPostcod();

public String getOldCode();

public String getManagerName();

public int getOrgRoleTypeId();

public long getOrgId();

public String getDistrictId();

public long getCountyId();

public Timestamp getDoneDate();

public int getContactCardType();

public Timestamp getCreateDate();

public String getExt1();

public String getContactCardId();

public String getExt2();

public int getMemberNum();

public String getExt3();

public long getOrganizeId();


public  void setPostAddress(String value);

public  void setParentOrganizeId(long value);

public  void setState(int value);

public  void setOrgAddress(String value);

public  void setContactBillId(String value);

public  void setPostProvince(long value);

public  void setContactName(String value);

public  void setPostcode(int value);

public  void setShortName(String value);

public  void setOldParentCode(String value);

public  void setPhoneId(String value);

public  void setPostCity(long value);

public  void setValidDate(Timestamp value);

public  void setIsLeaf(String value);

public  void setEmail(String value);

public  void setDoneCode(long value);

public  void setFaxId(String value);

public  void setNotes(String value);

public  void setEnglishName(String value);

public  void setCode(String value);

public  void setExpireDate(Timestamp value);

public  void setOpId(long value);

public  void setOrganizeName(String value);

public  void setPostPostcod(int value);

public  void setOldCode(String value);

public  void setManagerName(String value);

public  void setOrgRoleTypeId(int value);

public  void setOrgId(long value);

public  void setDistrictId(String value);

public  void setCountyId(long value);

public  void setDoneDate(Timestamp value);

public  void setContactCardType(int value);

public  void setCreateDate(Timestamp value);

public  void setExt1(String value);

public  void setContactCardId(String value);

public  void setExt2(String value);

public  void setMemberNum(int value);

public  void setExt3(String value);

public  void setOrganizeId(long value);
}
