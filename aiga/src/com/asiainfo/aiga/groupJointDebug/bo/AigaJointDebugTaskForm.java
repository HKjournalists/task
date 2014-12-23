package com.asiainfo.aiga.groupJointDebug.bo;
// default package

import java.math.BigDecimal;
import java.sql.Timestamp;


/**
 * AigaJointDebugTaskForm entity. @author MyEclipse Persistence Tools
 */

public class AigaJointDebugTaskForm  implements java.io.Serializable {


    // Fields    

     private java.lang.Integer taskId;
     private String taskName;
     private String taskTag;
     private Timestamp createTime;
     private BigDecimal creatorId;
     private String creatorName;
     private Short isDelete;
     private Timestamp taskPlanBeginCommitTime;
     private Timestamp taskPlanEndCommitTime;
     private BigDecimal devManagerId;
     private String devManagerName;
     private BigDecimal bigType;
     private BigDecimal subType;
     private Short taskType;
     private String reqTag;
     private Timestamp reqPlanAccomplishTime;
     private String reasonRemarks;
     private Timestamp jointDebugPlanBeginTime;
     private Timestamp jointDebugPlanEndTime;
     private Timestamp provincialReqDevEndTime;
     private Short isNeedMessage;
     private String messageRemarks;
     private String platformReqTag;
     private BigDecimal jointDebugManagerId;
     private String jointDebugManagerName;
     


    // Constructors

    /** default constructor */
    public AigaJointDebugTaskForm() {
    }

    
    /** full constructor */
    public AigaJointDebugTaskForm(String taskName, String taskTag, Timestamp createTime, BigDecimal creatorId, String creatorName, Short isDelete, Timestamp taskPlanBeginCommitTime, Timestamp taskPlanEndCommitTime, BigDecimal devManagerId, String devManagerName, BigDecimal bigType, BigDecimal subType, Short taskType, String reqTag, Timestamp reqPlanAccomplishTime, String reasonRemarks, Timestamp jointDebugPlanBeginTime, Timestamp jointDebugPlanEndTime, Timestamp provincialReqDevEndTime, Short isNeedMessage, String messageRemarks, String platformReqTag, BigDecimal jointDebugManagerId, String jointDebugManagerName) {
        this.taskName = taskName;
        this.taskTag = taskTag;
        this.createTime = createTime;
        this.creatorId = creatorId;
        this.creatorName = creatorName;
        this.isDelete = isDelete;
        this.taskPlanBeginCommitTime = taskPlanBeginCommitTime;
        this.taskPlanEndCommitTime = taskPlanEndCommitTime;
        this.devManagerId = devManagerId;
        this.devManagerName = devManagerName;
        this.bigType = bigType;
        this.subType = subType;
        this.taskType = taskType;
        this.reqTag = reqTag;
        this.reqPlanAccomplishTime = reqPlanAccomplishTime;
        this.reasonRemarks = reasonRemarks;
        this.jointDebugPlanBeginTime = jointDebugPlanBeginTime;
        this.jointDebugPlanEndTime = jointDebugPlanEndTime;
        this.provincialReqDevEndTime = provincialReqDevEndTime;
        this.isNeedMessage = isNeedMessage;
        this.messageRemarks = messageRemarks;
        this.platformReqTag = platformReqTag;
        this.jointDebugManagerId = jointDebugManagerId;
        this.jointDebugManagerName = jointDebugManagerName;
    }

   
    // Property accessors

    public java.lang.Integer getTaskId() {
        return this.taskId;
    }
    
    public void setTaskId(java.lang.Integer taskId) {
        this.taskId = taskId;
    }

    public String getTaskName() {
        return this.taskName;
    }
    
    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getTaskTag() {
        return this.taskTag;
    }
    
    public void setTaskTag(String taskTag) {
        this.taskTag = taskTag;
    }

    public Timestamp getCreateTime() {
        return this.createTime;
    }
    
    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
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

    public Short getIsDelete() {
        return this.isDelete;
    }
    
    public void setIsDelete(Short isDelete) {
        this.isDelete = isDelete;
    }

    public Timestamp getTaskPlanBeginCommitTime() {
        return this.taskPlanBeginCommitTime;
    }
    
    public void setTaskPlanBeginCommitTime(Timestamp taskPlanBeginCommitTime) {
        this.taskPlanBeginCommitTime = taskPlanBeginCommitTime;
    }

    public Timestamp getTaskPlanEndCommitTime() {
        return this.taskPlanEndCommitTime;
    }
    
    public void setTaskPlanEndCommitTime(Timestamp taskPlanEndCommitTime) {
        this.taskPlanEndCommitTime = taskPlanEndCommitTime;
    }

    public BigDecimal getDevManagerId() {
        return this.devManagerId;
    }
    
    public void setDevManagerId(BigDecimal devManagerId) {
        this.devManagerId = devManagerId;
    }

    public String getDevManagerName() {
        return this.devManagerName;
    }
    
    public void setDevManagerName(String devManagerName) {
        this.devManagerName = devManagerName;
    }

    public BigDecimal getBigType() {
        return this.bigType;
    }
    
    public void setBigType(BigDecimal bigType) {
        this.bigType = bigType;
    }

    public BigDecimal getSubType() {
        return this.subType;
    }
    
    public void setSubType(BigDecimal subType) {
        this.subType = subType;
    }

    public Short getTaskType() {
        return this.taskType;
    }
    
    public void setTaskType(Short taskType) {
        this.taskType = taskType;
    }

    public String getReqTag() {
        return this.reqTag;
    }
    
    public void setReqTag(String reqTag) {
        this.reqTag = reqTag;
    }

    public Timestamp getReqPlanAccomplishTime() {
        return this.reqPlanAccomplishTime;
    }
    
    public void setReqPlanAccomplishTime(Timestamp reqPlanAccomplishTime) {
        this.reqPlanAccomplishTime = reqPlanAccomplishTime;
    }

    public String getReasonRemarks() {
        return this.reasonRemarks;
    }
    
    public void setReasonRemarks(String reasonRemarks) {
        this.reasonRemarks = reasonRemarks;
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

    public String getPlatformReqTag() {
        return this.platformReqTag;
    }
    
    public void setPlatformReqTag(String platformReqTag) {
        this.platformReqTag = platformReqTag;
    }


	public BigDecimal getJointDebugManagerId() {
		return jointDebugManagerId;
	}


	public void setJointDebugManagerId(BigDecimal jointDebugManagerId) {
		this.jointDebugManagerId = jointDebugManagerId;
	}


	public String getJointDebugManagerName() {
		return jointDebugManagerName;
	}


	public void setJointDebugManagerName(String jointDebugManagerName) {
		this.jointDebugManagerName = jointDebugManagerName;
	}
    








}