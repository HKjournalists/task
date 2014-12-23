package com.asiainfo.aiga.userCase.bo;
// default package

import java.math.BigDecimal;
import java.sql.Timestamp;


/**
 * AigaSystemFolder entity. @author MyEclipse Persistence Tools
 */

public class AigaSystemFolder  implements java.io.Serializable {


    // Fields    

     private java.lang.Integer sysId;
     private String sysName;
     private Timestamp createTime;
     private Timestamp updateTime;
     private String remarks;
     private String firm;
     private Short importantClass;
     private Short sysOfDomain;
     private Short isInvalid;


    // Constructors

    /** default constructor */
    public AigaSystemFolder() {
    }

    
    /** full constructor */
    public AigaSystemFolder(String sysName, Timestamp createTime, Timestamp updateTime, String remarks, String firm, Short importantClass, Short sysOfDomain, Short isInvalid) {
        this.sysName = sysName;
        this.createTime = createTime;
        this.updateTime = updateTime;
        this.remarks = remarks;
        this.firm = firm;
        this.importantClass = importantClass;
        this.sysOfDomain = sysOfDomain;
        this.isInvalid = isInvalid;
    }

   
    // Property accessors

    public java.lang.Integer getSysId() {
        return this.sysId;
    }
    
    public void setSysId(java.lang.Integer sysId) {
        this.sysId = sysId;
    }

    public String getSysName() {
        return this.sysName;
    }
    
    public void setSysName(String sysName) {
        this.sysName = sysName;
    }

    public Timestamp getCreateTime() {
        return this.createTime;
    }
    
    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public Timestamp getUpdateTime() {
        return this.updateTime;
    }
    
    public void setUpdateTime(Timestamp updateTime) {
        this.updateTime = updateTime;
    }

    public String getRemarks() {
        return this.remarks;
    }
    
    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getFirm() {
        return this.firm;
    }
    
    public void setFirm(String firm) {
        this.firm = firm;
    }

    public Short getImportantClass() {
        return this.importantClass;
    }
    
    public void setImportantClass(Short importantClass) {
        this.importantClass = importantClass;
    }

    public Short getSysOfDomain() {
        return this.sysOfDomain;
    }
    
    public void setSysOfDomain(Short sysOfDomain) {
        this.sysOfDomain = sysOfDomain;
    }

    public Short getIsInvalid() {
        return this.isInvalid;
    }
    
    public void setIsInvalid(Short isInvalid) {
        this.isInvalid = isInvalid;
    }
   








}