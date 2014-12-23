package com.asiainfo.aiga.requisition.bo;

import java.util.Date;


/**
 * AigaTestSubTask entity. @author MyEclipse Persistence Tools
 */

public class AigaTestSubTask implements java.io.Serializable {

	// Fields

	private java.lang.Integer subTaskId;
	private String subTaskTag;
	private String taskTag;
	private String subTaskName;
	private String reqTag;
	private String creator;
	private java.lang.Integer subTaskStatus;
	private Date createTime;
	private Date plCompleteTime;
	private Date factCompleteTime;
	private java.lang.Integer subTaskPriority;
	private String devWorkDay;
	private String testWorkDay;
	private java.lang.Integer possibleProduct;
	private java.lang.Integer possibleBack;
	private java.lang.Integer possibleTest;
	private java.lang.Integer isPerformance;
	private java.lang.Integer taskId;
	private Integer subTaskType;
	private String creatorStaff;
	private java.lang.Integer curPhase;
	private java.lang.Integer testorId;
	private String testorName;
	private String possibleProductReason;
	private String possibleBackReason;
	private String possibleTestReason;
	private java.lang.Integer isJointDebug;
	private java.lang.Integer jointEnvironment;
	private java.lang.Integer submitStaffId;
	private String submitStaffName;
	
	private Long operId;
	private String operName;
	private Date reviewTime;
	
	private Integer bigType;
	
	private Integer subType;
	
	private String testReply;
	
	private String reqAnalysis;
	
	private String nowTestInfo;
	
	private Integer usable;
	
	private Integer subTaskClass;
	
	private String joinDebugVals;
	
	private String joinDebugValsOther;
	
	private Integer joinType;

	private Integer reviewResult;
	
	private String auditRate;
	
	private String scriptFunRate;
	
	private String scriptPerRate;
	
	public String getAuditRate() {
		return auditRate;
	}

	public void setAuditRate(String auditRate) {
		this.auditRate = auditRate;
	}

	public String getScriptFunRate() {
		return scriptFunRate;
	}

	public void setScriptFunRate(String scriptFunRate) {
		this.scriptFunRate = scriptFunRate;
	}

	public String getScriptPerRate() {
		return scriptPerRate;
	}

	public void setScriptPerRate(String scriptPerRate) {
		this.scriptPerRate = scriptPerRate;
	}

	public Integer getJoinType() {
		return joinType;
	}

	public void setJoinType(Integer joinType) {
		this.joinType = joinType;
	}

	public Integer getSubTaskClass() {
		return subTaskClass;
	}

	public void setSubTaskClass(Integer subTaskClass) {
		this.subTaskClass = subTaskClass;
	}

	public String getJoinDebugVals() {
		return joinDebugVals;
	}

	public void setJoinDebugVals(String joinDebugVals) {
		this.joinDebugVals = joinDebugVals;
	}

	public Integer getUsable() {
		return usable;
	}

	public void setUsable(Integer usable) {
		this.usable = usable;
	}

	public String getTestReply() {
		return testReply;
	}

	public void setTestReply(String testReply) {
		this.testReply = testReply;
	}

	public String getReqAnalysis() {
		return reqAnalysis;
	}

	public void setReqAnalysis(String reqAnalysis) {
		this.reqAnalysis = reqAnalysis;
	}

	public String getNowTestInfo() {
		return nowTestInfo;
	}

	public void setNowTestInfo(String nowTestInfo) {
		this.nowTestInfo = nowTestInfo;
	}

	public Integer getBigType() {
		return bigType;
	}

	public void setBigType(Integer bigType) {
		this.bigType = bigType;
	}

	public Integer getSubType() {
		return subType;
	}

	public void setSubType(Integer subType) {
		this.subType = subType;
	}

	/** default constructor */
	public AigaTestSubTask() {
	}

	/** minimal constructor */
	public AigaTestSubTask(java.lang.Integer subTaskId) {
		this.subTaskId = subTaskId;
	}

	public java.lang.Integer getSubTaskId() {
		return this.subTaskId;
	}

	public void setSubTaskId(java.lang.Integer subTaskId) {
		this.subTaskId = subTaskId;
	}

	public String getSubTaskTag() {
		return this.subTaskTag;
	}

	public void setSubTaskTag(String subTaskTag) {
		this.subTaskTag = subTaskTag;
	}

	public String getTaskTag() {
		return this.taskTag;
	}

	public void setTaskTag(String taskTag) {
		this.taskTag = taskTag;
	}

	public String getSubTaskName() {
		return this.subTaskName;
	}

	public void setSubTaskName(String subTaskName) {
		this.subTaskName = subTaskName;
	}

	public String getReqTag() {
		return this.reqTag;
	}

	public void setReqTag(String reqTag) {
		this.reqTag = reqTag;
	}

	public String getCreator() {
		return this.creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public java.lang.Integer getSubTaskStatus() {
		return this.subTaskStatus;
	}

	public void setSubTaskStatus(java.lang.Integer subTaskStatus) {
		this.subTaskStatus = subTaskStatus;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getPlCompleteTime() {
		return this.plCompleteTime;
	}

	public void setPlCompleteTime(Date plCompleteTime) {
		this.plCompleteTime = plCompleteTime;
	}

	public Date getFactCompleteTime() {
		return this.factCompleteTime;
	}

	public void setFactCompleteTime(Date factCompleteTime) {
		this.factCompleteTime = factCompleteTime;
	}

	public java.lang.Integer getSubTaskPriority() {
		return this.subTaskPriority;
	}

	public void setSubTaskPriority(java.lang.Integer subTaskPriority) {
		this.subTaskPriority = subTaskPriority;
	}

	public String getDevWorkDay() {
		return this.devWorkDay;
	}

	public void setDevWorkDay(String devWorkDay) {
		this.devWorkDay = devWorkDay;
	}

	public String getTestWorkDay() {
		return this.testWorkDay;
	}

	public void setTestWorkDay(String testWorkDay) {
		this.testWorkDay = testWorkDay;
	}

	public java.lang.Integer getPossibleProduct() {
		return this.possibleProduct;
	}

	public void setPossibleProduct(java.lang.Integer possibleProduct) {
		this.possibleProduct = possibleProduct;
	}

	public java.lang.Integer getPossibleBack() {
		return this.possibleBack;
	}

	public void setPossibleBack(java.lang.Integer possibleBack) {
		this.possibleBack = possibleBack;
	}

	public java.lang.Integer getPossibleTest() {
		return this.possibleTest;
	}

	public void setPossibleTest(java.lang.Integer possibleTest) {
		this.possibleTest = possibleTest;
	}

	public java.lang.Integer getIsPerformance() {
		return this.isPerformance;
	}

	public void setIsPerformance(java.lang.Integer isPerformance) {
		this.isPerformance = isPerformance;
	}

	public java.lang.Integer getTaskId() {
		return this.taskId;
	}

	public void setTaskId(java.lang.Integer taskId) {
		this.taskId = taskId;
	}

	public Integer getSubTaskType() {
		return this.subTaskType;
	}

	public void setSubTaskType(Integer subTaskType) {
		this.subTaskType = subTaskType;
	}

	public String getCreatorStaff() {
		return this.creatorStaff;
	}

	public void setCreatorStaff(String creatorStaff) {
		this.creatorStaff = creatorStaff;
	}

	public java.lang.Integer getCurPhase() {
		return this.curPhase;
	}

	public void setCurPhase(java.lang.Integer curPhase) {
		this.curPhase = curPhase;
	}

	public java.lang.Integer getTestorId() {
		return this.testorId;
	}

	public void setTestorId(java.lang.Integer testorId) {
		this.testorId = testorId;
	}

	public String getTestorName() {
		return this.testorName;
	}

	public void setTestorName(String testorName) {
		this.testorName = testorName;
	}

	public String getPossibleProductReason() {
		return this.possibleProductReason;
	}

	public void setPossibleProductReason(String possibleProductReason) {
		this.possibleProductReason = possibleProductReason;
	}

	public String getPossibleBackReason() {
		return this.possibleBackReason;
	}

	public void setPossibleBackReason(String possibleBackReason) {
		this.possibleBackReason = possibleBackReason;
	}

	public String getPossibleTestReason() {
		return this.possibleTestReason;
	}

	public void setPossibleTestReason(String possibleTestReason) {
		this.possibleTestReason = possibleTestReason;
	}

	public java.lang.Integer getIsJointDebug() {
		return isJointDebug;
	}

	public void setIsJointDebug(java.lang.Integer isJointDebug) {
		this.isJointDebug = isJointDebug;
	}

	public java.lang.Integer getJointEnvironment() {
		return jointEnvironment;
	}

	public void setJointEnvironment(java.lang.Integer jointEnvironment) {
		jointEnvironment = jointEnvironment;
	}

	public java.lang.Integer getSubmitStaffId() {
		return submitStaffId;
	}

	public void setSubmitStaffId(java.lang.Integer submitStaffId) {
		this.submitStaffId = submitStaffId;
	}

	public String getSubmitStaffName() {
		return submitStaffName;
	}

	public void setSubmitStaffName(String submitStaffName) {
		this.submitStaffName = submitStaffName;
	}

	public Integer getReviewResult() {
		return reviewResult;
	}

	public void setReviewResult(Integer reviewResult) {
		this.reviewResult = reviewResult;
	}

	public Long getOperId() {
		return operId;
	}

	public void setOperId(Long operId) {
		this.operId = operId;
	}

	public String getOperName() {
		return operName;
	}

	public void setOperName(String operName) {
		this.operName = operName;
	}

	public Date getReviewTime() {
		return reviewTime;
	}

	public void setReviewTime(Date reviewTime) {
		this.reviewTime = reviewTime;
	}

	public String getJoinDebugValsOther() {
		return joinDebugValsOther;
	}

	public void setJoinDebugValsOther(String joinDebugValsOther) {
		this.joinDebugValsOther = joinDebugValsOther;
	}

}