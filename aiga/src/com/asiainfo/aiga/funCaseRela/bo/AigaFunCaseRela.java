package com.asiainfo.aiga.funCaseRela.bo;

import java.sql.Timestamp;

/**
 * AigaFunCaseRela entity. @author MyEclipse Persistence Tools
 */

public class AigaFunCaseRela implements java.io.Serializable {

	// Fields

	private Long relaId;
	private Integer folderId;
	private Integer caseId;
	private String relaType;
	private Integer parentFolderId;
	private Timestamp quoteTime;
	private Timestamp updateTime;
	private String latestOperator;
	private Integer regressionTest;
	private Integer efficiencyTest;
	private Integer efficiencyTestType;
	private Integer teminalTest;
	private Integer hasTest;
	private Integer isAvailAuto;
	private Integer isFinishAuto;
	private String testType;
	// Constructors

	/** default constructor */
	public AigaFunCaseRela() {
	}

	/** minimal constructor */
	public AigaFunCaseRela(Long relaId, Integer folderId,
			Integer caseId) {
		this.relaId = relaId;
		this.folderId = folderId;
		this.caseId = caseId;
	}

	/** full constructor */
	public AigaFunCaseRela(Long relaId, Integer folderId,
			Integer caseId, String relaType, Integer parentFolderId,
			Timestamp quoteTime, Timestamp updateTime, String latestOperator,
			Integer regressionTest, Integer efficiencyTest, Integer efficiencyTestType,
			Integer teminalTest, Integer hasTest, Integer isAvailAuto, Integer isFinishAuto) {
		this.relaId = relaId;
		this.folderId = folderId;
		this.caseId = caseId;
		this.relaType = relaType;
		this.parentFolderId = parentFolderId;
		this.quoteTime = quoteTime;
		this.updateTime = updateTime;
		this.latestOperator = latestOperator;
		this.regressionTest = regressionTest;
		this.efficiencyTest = efficiencyTest;
		this.efficiencyTestType = efficiencyTestType;
		this.teminalTest = teminalTest;
		this.hasTest = hasTest;
		this.isAvailAuto = isAvailAuto;
		this.isFinishAuto = isFinishAuto;
	}

	// Property accessors

	public Long getRelaId() {
		return this.relaId;
	}

	public void setRelaId(Long relaId) {
		this.relaId = relaId;
	}

	public Integer getFolderId() {
		return this.folderId;
	}

	public void setFolderId(Integer folderId) {
		this.folderId = folderId;
	}

	public Integer getCaseId() {
		return this.caseId;
	}

	public void setCaseId(Integer caseId) {
		this.caseId = caseId;
	}

	public String getRelaType() {
		return this.relaType;
	}

	public void setRelaType(String relaType) {
		this.relaType = relaType;
	}

	public Integer getParentFolderId() {
		return this.parentFolderId;
	}

	public void setParentFolderId(Integer parentFolderId) {
		this.parentFolderId = parentFolderId;
	}

	public Timestamp getQuoteTime() {
		return this.quoteTime;
	}

	public void setQuoteTime(Timestamp quoteTime) {
		this.quoteTime = quoteTime;
	}

	public Timestamp getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(Timestamp updateTime) {
		this.updateTime = updateTime;
	}

	public String getLatestOperator() {
		return this.latestOperator;
	}

	public void setLatestOperator(String latestOperator) {
		this.latestOperator = latestOperator;
	}

	public Integer getRegressionTest() {
		return this.regressionTest;
	}

	public void setRegressionTest(Integer regressionTest) {
		this.regressionTest = regressionTest;
	}

	public Integer getEfficiencyTest() {
		return this.efficiencyTest;
	}

	public void setEfficiencyTest(Integer efficiencyTest) {
		this.efficiencyTest = efficiencyTest;
	}

	public Integer getEfficiencyTestType() {
		return this.efficiencyTestType;
	}

	public void setEfficiencyTestType(Integer efficiencyTestType) {
		this.efficiencyTestType = efficiencyTestType;
	}

	public Integer getTeminalTest() {
		return this.teminalTest;
	}

	public void setTeminalTest(Integer teminalTest) {
		this.teminalTest = teminalTest;
	}

	public Integer getHasTest() {
		return this.hasTest;
	}

	public void setHasTest(Integer hasTest) {
		this.hasTest = hasTest;
	}

	public Integer getIsAvailAuto() {
		return this.isAvailAuto;
	}

	public void setIsAvailAuto(Integer isAvailAuto) {
		this.isAvailAuto = isAvailAuto;
	}

	public Integer getIsFinishAuto() {
		return this.isFinishAuto;
	}

	public void setIsFinishAuto(Integer isFinishAuto) {
		this.isFinishAuto = isFinishAuto;
	}

	public String getTestType() {
		return testType;
	}

	public void setTestType(String testType) {
		this.testType = testType;
	}

}