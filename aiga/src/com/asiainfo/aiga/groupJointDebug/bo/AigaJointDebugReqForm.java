package com.asiainfo.aiga.groupJointDebug.bo;
// default package

import java.math.BigDecimal;
import java.sql.Timestamp;


/**
 * AigaJointDebugReqForm entity. @author MyEclipse Persistence Tools
 */

public class AigaJointDebugReqForm  implements java.io.Serializable {


    // Fields    

     private java.lang.Integer reqId;
     private String reqName;
     private Timestamp jointDebugPlanBeginTime;
     private Timestamp jointDebugPlanEndTime;
     private BigDecimal reqManagerStaffId;
     private String reqManagerStaffName;
     private String groupContactsName;
     private String groupContactsPhone;
     private String groupContactsEmail;
     private String groupContactsRemarks;
     private Timestamp groupReqDevEndTime;
     private Timestamp provincialReqDevEndTime;
     private Short isNeedMessage;
     private String messageRemarks;
     private String remarks;
     private Timestamp createTime;
     private Short isDelete;
     private Short isJoingDebugCompleted;
     private String reasonRemarks;
     private BigDecimal creatorId;
     private String creatorName;
     private String reqTag;


    // Constructors

    /** default constructor */
    public AigaJointDebugReqForm() {
    }

    
    /** full constructor */
    public AigaJointDebugReqForm(String reqName, Timestamp jointDebugPlanBeginTime, Timestamp jointDebugPlanEndTime, BigDecimal reqManagerStaffId, String reqManagerStaffName, String groupContactsName, String groupContactsPhone, String groupContactsEmail, String groupContactsRemarks, Timestamp groupReqDevEndTime, Timestamp provincialReqDevEndTime, Short isNeedMessage, String messageRemarks, String remarks, Timestamp createTime, Short isDelete, Short isJoingDebugCompleted, String reasonRemarks, BigDecimal creatorId, String creatorName, String reqTag) {
        this.reqName = reqName;
        this.jointDebugPlanBeginTime = jointDebugPlanBeginTime;
        this.jointDebugPlanEndTime = jointDebugPlanEndTime;
        this.reqManagerStaffId = reqManagerStaffId;
        this.reqManagerStaffName = reqManagerStaffName;
        this.groupContactsName = groupContactsName;
        this.groupContactsPhone = groupContactsPhone;
        this.groupContactsEmail = groupContactsEmail;
        this.groupContactsRemarks = groupContactsRemarks;
        this.groupReqDevEndTime = groupReqDevEndTime;
        this.provincialReqDevEndTime = provincialReqDevEndTime;
        this.isNeedMessage = isNeedMessage;
        this.messageRemarks = messageRemarks;
        this.remarks = remarks;
        this.createTime = createTime;
        this.isDelete = isDelete;
        this.isJoingDebugCompleted = isJoingDebugCompleted;
        this.reasonRemarks = reasonRemarks;
        this.creatorId = creatorId;
        this.creatorName = creatorName;
        this.reqTag = reqTag;
    }

   
    // Property accessors

    public java.lang.Integer getReqId() {
        return this.reqId;
    }
    
    public void setReqId(java.lang.Integer reqId) {
        this.reqId = reqId;
    }

    public String getReqName() {
        return this.reqName;
    }
    
    public void setReqName(String reqName) {
        this.reqName = reqName;
    }

    public Timestamp getJointDebugPlanBeginTime() {
        return this.jointDebugPlanBeginTime;
    }
    
    public void setJointDebugPlanBeginTime(Timestamp jointDebugPlanBeginTime) {
        this.jointDebugPlanBeginTime = jointDebugPlanBeginTime;
    }

    public Timestamp getJointDebugPlanEndTime() {
        return this.jointDebugPlanEndTime;
    }
    
    public void setJointDebugPlanEndTime(Timestamp jointDebugPlanEndTime) {
        this.jointDebugPlanEndTime = jointDebugPlanEndTime;
    }

    public BigDecimal getReqManagerStaffId() {
        return this.reqManagerStaffId;
    }
    
    public void setReqManagerStaffId(BigDecimal reqManagerStaffId) {
        this.reqManagerStaffId = reqManagerStaffId;
    }

    public String getReqManagerStaffName() {
        return this.reqManagerStaffName;
    }
    
    public void setReqManagerStaffName(String reqManagerStaffName) {
        this.reqManagerStaffName = reqManagerStaffName;
    }

    public String getGroupContactsName() {
        return this.groupContactsName;
    }
    
    public void setGroupContactsName(String groupContactsName) {
        this.groupContactsName = groupContactsName;
    }

    public String getGroupContactsPhone() {
        return this.groupContactsPhone;
    }
    
    public void setGroupContactsPhone(String groupContactsPhone) {
        this.groupContactsPhone = groupContactsPhone;
    }

    public String getGroupContactsEmail() {
        return this.groupContactsEmail;
    }
    
    public void setGroupContactsEmail(String groupContactsEmail) {
        this.groupContactsEmail = groupContactsEmail;
    }

    public String getGroupContactsRemarks() {
        return this.groupContactsRemarks;
    }
    
    public void setGroupContactsRemarks(String groupContactsRemarks) {
        this.groupContactsRemarks = groupContactsRemarks;
    }

    public Timestamp getGroupReqDevEndTime() {
        return this.groupReqDevEndTime;
    }
    
    public void setGroupReqDevEndTime(Timestamp groupReqDevEndTime) {
        this.groupReqDevEndTime = groupReqDevEndTime;
    }

    public Timestamp getProvincialReqDevEndTime() {
        return this.provincialReqDevEndTime;
    }
    
    public void setProvincialReqDevEndTime(Timestamp provincialReqDevEndTime) {
        this.provincialReqDevEndTime = provincialReqDevEndTime;
    }

    public Short getIsNeedMessage() {
        return this.isNeedMessage;
    }
    
    public void setIsNeedMessage(Short isNeedMessage) {
        this.isNeedMessage = isNeedMessage;
    }

    public String getMessageRemarks() {
        return this.messageRemarks;
    }
    
    public void setMessageRemarks(String messageRemarks) {
        this.messageRemarks = messageRemarks;
    }

    public String getRemarks() {
        return this.remarks;
    }
    
    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Timestamp getCreateTime() {
        return this.createTime;
    }
    
    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public Short getIsDelete() {
        return this.isDelete;
    }
    
    public void setIsDelete(Short isDelete) {
        this.isDelete = isDelete;
    }

    public Short getIsJoingDebugCompleted() {
        return this.isJoingDebugCompleted;
    }
    
    public void setIsJoingDebugCompleted(Short isJoingDebugCompleted) {
        this.isJoingDebugCompleted = isJoingDebugCompleted;
    }

    public String getReasonRemarks() {
        return this.reasonRemarks;
    }
    
    public void setReasonRemarks(String reasonRemarks) {
        this.reasonRemarks = reasonRemarks;
    }

    public BigDecimal getCreatorId() {
        return this.creatorId;
    }
    
    public void setCreatorId(BigDecimal creatorId) {
        this.creatorId = creatorId;
    }

    public String getCreatorName() {
        return this.creatorName;
    }
    
    public void setCreatorName(String creatorName) {
        this.creatorName = creatorName;
    }

    public String getReqTag() {
        return this.reqTag;
    }
    
    public void setReqTag(String reqTag) {
        this.reqTag = reqTag;
    }
   








}