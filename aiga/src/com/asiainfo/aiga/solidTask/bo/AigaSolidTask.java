package com.asiainfo.aiga.solidTask.bo;

import java.sql.Timestamp;

/**
 * AigaSolidTask entity. @author MyEclipse Persistence Tools
 */

public class AigaSolidTask implements java.io.Serializable {

	// Fields

	private Integer taskId;
	private String taskType;
	private String planTag;
	private Timestamp plCompleteTime;
	private Timestamp factCompleteTime;
	private Timestamp createTime;
	private Timestamp beginTime;
	private Integer isSecurityTest;
	private Integer isCodeScan;
	private Integer isPerformanceTest;
	private Integer isRegressionTest;
	private Integer versionContent;
	private Integer taskStatus;
	private Timestamp reqTime;
	private Timestamp codeCommitDate;
	private Integer onLineType;
	private Integer bigType;
	private String changeReason;
	private Integer planId;
	private String planName;
	private Integer submitStaffId;
	private String submitStaffName;
	private String planDscr;
	private Integer taskPhase;

	// Constructors

	/** default constructor */
	public AigaSolidTask() {
	}

	/** minimal constructor */
	public AigaSolidTask(Integer taskId) {
		this.taskId = taskId;
	}

	/** full constructor */
	public AigaSolidTask(Integer taskId, String taskType, String planTag,
			Timestamp plCompleteTime, Timestamp factCompleteTime,
			Timestamp createTime, Timestamp beginTime, Integer isSecurityTest,
			Integer isCodeScan, Integer isPerformanceTest, Integer isRegressionTest,
			Integer versionContent, Integer taskStatus,
			Timestamp reqTime, Timestamp codeCommitDate, Integer onLineType,
			Integer bigType, String changeReason, Integer planId,
			String planName, Integer submitStaffId, String submitStaffName,
			String planDscr, Integer taskPhase) {
		this.taskId = taskId;
		this.taskType = taskType;
		this.planTag = planTag;
		this.plCompleteTime = plCompleteTime;
		this.factCompleteTime = factCompleteTime;
		this.createTime = createTime;
		this.beginTime = beginTime;
		this.isSecurityTest = isSecurityTest;
		this.isCodeScan = isCodeScan;
		this.isPerformanceTest = isPerformanceTest;
		this.isRegressionTest = isRegressionTest;
		this.versionContent = versionContent;
		this.taskStatus = taskStatus;
		this.reqTime = reqTime;
		this.codeCommitDate = codeCommitDate;
		this.onLineType = onLineType;
		this.bigType = bigType;
		this.changeReason = changeReason;
		this.planId = planId;
		this.planName = planName;
		this.submitStaffId = submitStaffId;
		this.submitStaffName = submitStaffName;
		this.planDscr = planDscr;
		this.taskPhase = taskPhase;
	}

	// Property accessors

	public Integer getTaskId() {
		return this.taskId;
	}

	public void setTaskId(Integer taskId) {
		this.taskId = taskId;
	}

	public String getTaskType() {
		return this.taskType;
	}

	public void setTaskType(String taskType) {
		this.taskType = taskType;
	}

	public String getPlanTag() {
		return this.planTag;
	}

	public void setPlanTag(String planTag) {
		this.planTag = planTag;
	}

	public Timestamp getPlCompleteTime() {
		return this.plCompleteTime;
	}

	public void setPlCompleteTime(Timestamp plCompleteTime) {
		this.plCompleteTime = plCompleteTime;
	}

	public Timestamp getFactCompleteTime() {
		return this.factCompleteTime;
	}

	public void setFactCompleteTime(Timestamp factCompleteTime) {
		this.factCompleteTime = factCompleteTime;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public Timestamp getBeginTime() {
		return this.beginTime;
	}

	public void setBeginTime(Timestamp beginTime) {
		this.beginTime = beginTime;
	}

	public Integer getIsSecurityTest() {
		return this.isSecurityTest;
	}

	public void setIsSecurityTest(Integer isSecurityTest) {
		this.isSecurityTest = isSecurityTest;
	}

	public Integer getIsCodeScan() {
		return this.isCodeScan;
	}

	public void setIsCodeScan(Integer isCodeScan) {
		this.isCodeScan = isCodeScan;
	}

	public Integer getIsPerformanceTest() {
		return this.isPerformanceTest;
	}

	public void setIsPerformanceTest(Integer isPerformanceTest) {
		this.isPerformanceTest = isPerformanceTest;
	}

	public Integer getIsRegressionTest() {
		return this.isRegressionTest;
	}

	public void setIsRegressionTest(Integer isRegressionTest) {
		this.isRegressionTest = isRegressionTest;
	}

	public Integer getVersionContent() {
		return this.versionContent;
	}

	public void setVersionContent(Integer versionContent) {
		this.versionContent = versionContent;
	}

	public Integer getTaskStatus() {
		return this.taskStatus;
	}

	public void setTaskStatus(Integer taskStatus) {
		this.taskStatus = taskStatus;
	}

	public Timestamp getReqTime() {
		return this.reqTime;
	}

	public void setReqTime(Timestamp reqTime) {
		this.reqTime = reqTime;
	}

	public Timestamp getCodeCommitDate() {
		return this.codeCommitDate;
	}

	public void setCodeCommitDate(Timestamp codeCommitDate) {
		this.codeCommitDate = codeCommitDate;
	}

	public Integer getOnLineType() {
		return this.onLineType;
	}

	public void setOnLineType(Integer onLineType) {
		this.onLineType = onLineType;
	}

	public Integer getBigType() {
		return this.bigType;
	}

	public void setBigType(Integer bigType) {
		this.bigType = bigType;
	}

	public String getChangeReason() {
		return this.changeReason;
	}

	public void setChangeReason(String changeReason) {
		this.changeReason = changeReason;
	}

	public Integer getPlanId() {
		return this.planId;
	}

	public void setPlanId(Integer planId) {
		this.planId = planId;
	}

	public String getPlanName() {
		return this.planName;
	}

	public void setPlanName(String planName) {
		this.planName = planName;
	}

	public Integer getSubmitStaffId() {
		return this.submitStaffId;
	}

	public void setSubmitStaffId(Integer submitStaffId) {
		this.submitStaffId = submitStaffId;
	}

	public String getSubmitStaffName() {
		return this.submitStaffName;
	}

	public void setSubmitStaffName(String submitStaffName) {
		this.submitStaffName = submitStaffName;
	}

	public String getPlanDscr() {
		return this.planDscr;
	}

	public void setPlanDscr(String planDscr) {
		this.planDscr = planDscr;
	}

	public Integer getTaskPhase() {
		return this.taskPhase;
	}

	public void setTaskPhase(Integer taskPhase) {
		this.taskPhase = taskPhase;
	}

}