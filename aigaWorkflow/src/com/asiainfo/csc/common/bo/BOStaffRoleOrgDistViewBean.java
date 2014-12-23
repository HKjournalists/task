package com.asiainfo.csc.common.bo;

import java.sql.*;
import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.AIException;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.common.ObjectType;
import com.ai.appframe2.common.DataType;

import com.asiainfo.csc.common.ivalues.*;

public class BOStaffRoleOrgDistViewBean extends DataContainer implements DataContainerInterface,IBOStaffRoleOrgDistViewValue{

  private static String  m_boName = "com.asiainfo.csc.common.bo.BOStaffRoleOrgDistView";



  public final static  String S_ParentOrganizeId = "PARENT_ORGANIZE_ID";
  public final static  String S_OrganizeName = "ORGANIZE_NAME";
  public final static  String S_GroupId = "GROUP_ID";
  public final static  String S_StaffId = "STAFF_ID";
  public final static  String S_DistrictId = "DISTRICT_ID";
  public final static  String S_StaffName = "STAFF_NAME";
  public final static  String S_RoleName = "ROLE_NAME";
  public final static  String S_RoleCode = "ROLE_CODE";
  public final static  String S_RoleId = "ROLE_ID";
  public final static  String S_OrganizeId = "ORGANIZE_ID";
  public final static  String S_Code = "CODE";

  public static ObjectType S_TYPE = null;
  static{
    try {
      S_TYPE = ServiceManager.getObjectTypeFactory().getInstance(m_boName);
    }catch(Exception e){
      throw new RuntimeException(e);
    }
  }
  public BOStaffRoleOrgDistViewBean() throws AIException{
      super(S_TYPE);
  }

 public static ObjectType getObjectTypeStatic() throws AIException{
   return S_TYPE;
 }

 public void setObjectType(ObjectType  value) throws AIException{
   throw new AIException("此种数据容器不能重置业务对象类型");
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

  public void initGroupId(long value){
     this.initProperty(S_GroupId,new Long(value));
  }
  public  void setGroupId(long value){
     this.set(S_GroupId,new Long(value));
  }
  public  void setGroupIdNull(){
     this.set(S_GroupId,null);
  }

  public long getGroupId(){
        return DataType.getAsLong(this.get(S_GroupId));
  
  }
  public long getGroupIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_GroupId));
      }

  public void initStaffId(long value){
     this.initProperty(S_StaffId,new Long(value));
  }
  public  void setStaffId(long value){
     this.set(S_StaffId,new Long(value));
  }
  public  void setStaffIdNull(){
     this.set(S_StaffId,null);
  }

  public long getStaffId(){
        return DataType.getAsLong(this.get(S_StaffId));
  
  }
  public long getStaffIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_StaffId));
      }

  public void initDistrictId(long value){
     this.initProperty(S_DistrictId,new Long(value));
  }
  public  void setDistrictId(long value){
     this.set(S_DistrictId,new Long(value));
  }
  public  void setDistrictIdNull(){
     this.set(S_DistrictId,null);
  }

  public long getDistrictId(){
        return DataType.getAsLong(this.get(S_DistrictId));
  
  }
  public long getDistrictIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_DistrictId));
      }

  public void initStaffName(String value){
     this.initProperty(S_StaffName,value);
  }
  public  void setStaffName(String value){
     this.set(S_StaffName,value);
  }
  public  void setStaffNameNull(){
     this.set(S_StaffName,null);
  }

  public String getStaffName(){
       return DataType.getAsString(this.get(S_StaffName));
  
  }
  public String getStaffNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_StaffName));
      }

  public void initRoleName(String value){
     this.initProperty(S_RoleName,value);
  }
  public  void setRoleName(String value){
     this.set(S_RoleName,value);
  }
  public  void setRoleNameNull(){
     this.set(S_RoleName,null);
  }

  public String getRoleName(){
       return DataType.getAsString(this.get(S_RoleName));
  
  }
  public String getRoleNameInitialValue(){
        return DataType.getAsString(this.getOldObj(S_RoleName));
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

  public void initRoleId(long value){
     this.initProperty(S_RoleId,new Long(value));
  }
  public  void setRoleId(long value){
     this.set(S_RoleId,new Long(value));
  }
  public  void setRoleIdNull(){
     this.set(S_RoleId,null);
  }

  public long getRoleId(){
        return DataType.getAsLong(this.get(S_RoleId));
  
  }
  public long getRoleIdInitialValue(){
        return DataType.getAsLong(this.getOldObj(S_RoleId));
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


 
 }

