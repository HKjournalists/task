package com.asiainfo.aiga.funCaseRela.bo;

import java.sql.Timestamp;

/**
 * AigaHisFunCaseRela entity. @author MyEclipse Persistence Tools
 */

public class AigaHisFunCaseRela implements java.io.Serializable {

	// Fields

	private Long hisRelaId;
	private Long relaId;
	private Integer folderId;
	private Integer caseId;
	private String relaType;
	private Integer parentFolderId;
	private Timestamp operateTime;
	private String latestOperator;
	private Integer regressionTest;
	private Integer efficiencyTest;
	private Integer efficiencyTestType;
	private Integer teminalTest;
	private Integer hasTest;
	private Integer isAvailAuto;
	private Integer isFinishAuto;
	private String operateType;
	private Integer editType;
	private String subTaskTag;
	private String temporaryTag;
	private String normalMac;
	private String testType;

	/** default constructor */
	public AigaHisFunCaseRela() {
	}

	/** minimal constructor */
	public AigaHisFunCaseRela(Long hisRelaId, Long relaId,
			Integer folderId, Integer caseId) {
		this.hisRelaId = hisRelaId;
		this.relaId = relaId;
		this.folderId = folderId;
		this.caseId = caseId;
	}
	
	// Constructors
	public AigaHisFunCaseRela(Long hisRelaId, Long relaId, Integer folderId,
			Integer caseId, String relaType, Integer parentFolderId,
			Timestamp operateTime, String latestOperator,
			Integer regressionTest, Integer efficiencyTest,
			Integer efficiencyTestType, Integer teminalTest, Integer hasTest,
			Integer isAvailAuto, Integer isFinishAuto, String operateType,
			Integer editType, String subTaskTag, String temporaryTag,
			String normalMac) {
		this.hisRelaId = hisRelaId;
		this.relaId = relaId;
		this.folderId = folderId;
		this.caseId = caseId;
		this.relaType = relaType;
		this.parentFolderId = parentFolderId;
		this.operateTime = operateTime;
		this.latestOperator = latestOperator;
		this.regressionTest = regressionTest;
		this.efficiencyTest = efficiencyTest;
		this.efficiencyTestType = efficiencyTestType;
		this.teminalTest = teminalTest;
		this.hasTest = hasTest;
		this.isAvailAuto = isAvailAuto;
		this.isFinishAuto = isFinishAuto;
		this.operateType = operateType;
		this.editType = editType;
		this.subTaskTag = subTaskTag;
		this.temporaryTag = temporaryTag;
		this.normalMac = normalMac;
	}
	// Property accessors

	public Long getHisRelaId() {
		return this.hisRelaId;
	}

	public void setHisRelaId(Long hisRelaId) {
		this.hisRelaId = hisRelaId;
	}

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

	public String getOperateType() {
		return operateType;
	}

	public void setOperateType(String operateType) {
		this.operateType = operateType;
	}

	public Timestamp getOperateTime() {
		return operateTime;
	}

	public void setOperateTime(Timestamp operateTime) {
		this.operateTime = operateTime;
	}

	public Integer getEditType() {
		return editType;
	}

	public void setEditType(Integer editType) {
		this.editType = editType;
	}

	public String getSubTaskTag() {
		return subTaskTag;
	}

	public void setSubTaskTag(String subTaskTag) {
		this.subTaskTag = subTaskTag;
	}

	public String getTemporaryTag() {
		return temporaryTag;
	}

	public void setTemporaryTag(String temporaryTag) {
		this.temporaryTag = temporaryTag;
	}

	public String getNormalMac() {
		return normalMac;
	}

	public void setNormalMac(String normalMac) {
		this.normalMac = normalMac;
	}

	public String getTestType() {
		return testType;
	}

	public void setTestType(String testType) {
		this.testType = testType;
	}

}