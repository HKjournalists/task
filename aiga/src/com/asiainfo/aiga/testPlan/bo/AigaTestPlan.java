package com.asiainfo.aiga.testPlan.bo;

import java.sql.Timestamp;

/**
 * AigaTestPlan entity. @author MyEclipse Persistence Tools
 */

public class AigaTestPlan implements java.io.Serializable {

	// Fields

	private java.lang.Integer planId;
	private String planTag;
	private Timestamp plCompleteTime;
	private Timestamp factCompleteTime;
	private Timestamp createTime;
	private Timestamp beginTime;
	private java.lang.Integer isSecurityTest;
	private java.lang.Integer isCodeScan;
	private java.lang.Integer isPerformanceTest;
	private java.lang.Integer isRegressionTest;
	private java.lang.Integer isHwergressionTest;
	private java.lang.Integer versionContent;
	private java.lang.Integer planStatus;
	private Timestamp reqTime;
	private Timestamp codeCommitDate;
	private java.lang.Integer onLineType;
	private java.lang.Integer bigType;
	private String changeReason;
	private String planName;
	private java.lang.Integer submitStaffId;
	private String submitStaffName;
	private String planDscr;
	private java.lang.Integer planPhase;
	private java.lang.Integer startMark;
	
	// Constructors

	/** default constructor */
	public AigaTestPlan() {
	}

	/** minimal constructor */
	public AigaTestPlan(java.lang.Integer planId) {
		this.planId = planId;
	}

	/** full constructor */
	public AigaTestPlan(java.lang.Integer planId, String planTag,
			Timestamp plCompleteTime, Timestamp factCompleteTime,
			Timestamp createTime, Timestamp beginTime, java.lang.Integer isSecurityTest,
			java.lang.Integer isCodeScan, java.lang.Integer isPerformanceTest, java.lang.Integer isRegressionTest,
			java.lang.Integer versionContent, java.lang.Integer planStatus,
			Timestamp reqTime, Timestamp codeCommitDate, java.lang.Integer onLineType,
			java.lang.Integer bigType, String changeReason, String planName,
			java.lang.Integer submitStaffId, String submitStaffName, String planDscr,
			java.lang.Integer planPhase) {
		this.planId = planId;
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
		this.planStatus = planStatus;
		this.reqTime = reqTime;
		this.codeCommitDate = codeCommitDate;
		this.onLineType = onLineType;
		this.bigType = bigType;
		this.changeReason = changeReason;
		this.planName = planName;
		this.submitStaffId = submitStaffId;
		this.submitStaffName = submitStaffName;
		this.planDscr = planDscr;
		this.planPhase = planPhase;
	}

	// Property accessors

	public java.lang.Integer getPlanId() {
		return this.planId;
	}

	public void setPlanId(java.lang.Integer planId) {
		this.planId = planId;
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

	public java.lang.Integer getIsSecurityTest() {
		return this.isSecurityTest;
	}

	public void setIsSecurityTest(java.lang.Integer isSecurityTest) {
		this.isSecurityTest = isSecurityTest;
	}

	public java.lang.Integer getIsCodeScan() {
		return this.isCodeScan;
	}

	public void setIsCodeScan(java.lang.Integer isCodeScan) {
		this.isCodeScan = isCodeScan;
	}

	public java.lang.Integer getIsPerformanceTest() {
		return this.isPerformanceTest;
	}

	public void setIsPerformanceTest(java.lang.Integer isPerformanceTest) {
		this.isPerformanceTest = isPerformanceTest;
	}

	public java.lang.Integer getIsRegressionTest() {
		return this.isRegressionTest;
	}

	public void setIsRegressionTest(java.lang.Integer isRegressionTest) {
		this.isRegressionTest = isRegressionTest;
	}

	public java.lang.Integer getVersionContent() {
		return this.versionContent;
	}

	public void setVersionContent(java.lang.Integer versionContent) {
		this.versionContent = versionContent;
	}

	public java.lang.Integer getPlanStatus() {
		return this.planStatus;
	}

	public void setPlanStatus(java.lang.Integer planStatus) {
		this.planStatus = planStatus;
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

	public java.lang.Integer getOnLineType() {
		return this.onLineType;
	}

	public void setOnLineType(java.lang.Integer onLineType) {
		this.onLineType = onLineType;
	}

	public java.lang.Integer getBigType() {
		return this.bigType;
	}

	public void setBigType(java.lang.Integer bigType) {
		this.bigType = bigType;
	}

	public String getChangeReason() {
		return this.changeReason;
	}

	public void setChangeReason(String changeReason) {
		this.changeReason = changeReason;
	}

	public String getPlanName() {
		return this.planName;
	}

	public void setPlanName(String planName) {
		this.planName = planName;
	}

	public java.lang.Integer getSubmitStaffId() {
		return this.submitStaffId;
	}

	public void setSubmitStaffId(java.lang.Integer submitStaffId) {
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

	public java.lang.Integer getPlanPhase() {
		return this.planPhase;
	}

	public void setPlanPhase(java.lang.Integer planPhase) {
		this.planPhase = planPhase;
	}

	public java.lang.Integer getIsHwergressionTest() {
		return isHwergressionTest;
	}

	public void setIsHwergressionTest(java.lang.Integer isHwergressionTest) {
		this.isHwergressionTest = isHwergressionTest;
	}

	public java.lang.Integer getStartMark() {
		return startMark;
	}

	public void setStartMark(java.lang.Integer startMark) {
		this.startMark = startMark;
	}

}