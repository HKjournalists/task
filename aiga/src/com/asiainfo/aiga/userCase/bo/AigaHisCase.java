package com.asiainfo.aiga.userCase.bo;

import java.sql.Timestamp;

/**
 * AigaHisCase entity. @author MyEclipse Persistence Tools
 */

public class AigaHisCase implements java.io.Serializable {

	// Fields

	private Integer hisCaseId;
	private String operatorUser;
	private String operatorName;
	private Timestamp operateTime;
	private String operatorType;
	private Integer caseId;
	private String caseName;
	private Integer funFolderId;
	private String caseDesc;
	private Timestamp createTime;
	private Timestamp updateTime;
	private String author;
	private String latestOperator;
	private Integer baseCaseId;
	private String sysLabel;
	private String ownLabel;
	private String url;
	private String approvalPsn;
	private Integer status;
	private String approvalName;
	private String authorNo;
	private Integer important;
	private Integer maintenanceFac;
	private Integer regressionTest;
	private Integer hasTest;
	private String testType;
	private Integer caseType;
	private Integer efficiencyTest;
	private Integer efficiencyTestType;
	private Integer teminalTest;
	private String casePreCond;
	private String caseOperateInst;
	private String preResult;
	private Integer secId;
	private String elemvalue;
	private String subTaskTag;
	private Integer editType;
	private String temporaryTag;
	private String normalMac;
	private Integer isDelete;
	private Integer isFinishAuto;
	private Integer isAvailAuto;

	// Constructors

	/** default constructor */
	public AigaHisCase() {
	}

	/** minimal constructor */
	public AigaHisCase(Integer hisCaseId) {
		this.hisCaseId = hisCaseId;
	}

	/** full constructor */
	public AigaHisCase(Integer hisCaseId, String operatorUser,
			String operatorName, Timestamp operateTime, String operatorType,
			Integer caseId, String caseName, Integer funFolderId,
			String caseDesc, Timestamp createTime, Timestamp updateTime,
			String author, String latestOperator, Integer baseCaseId,
			String sysLabel, String ownLabel, String url, String approvalPsn,
			Integer status, String approvalName, String authorNo, Integer important,
			Integer maintenanceFac, Integer regressionTest, Integer hasTest,
			String testType, Integer caseType, Integer efficiencyTest,
			Integer efficiencyTestType, Integer teminalTest, String casePreCond,
			String caseOperateInst, String preResult, Integer secId,
			String elemvalue, String subTaskTag, Integer editType,
			String temporaryTag, String normalMac) {
		this.hisCaseId = hisCaseId;
		this.operatorUser = operatorUser;
		this.operatorName = operatorName;
		this.operateTime = operateTime;
		this.operatorType = operatorType;
		this.caseId = caseId;
		this.caseName = caseName;
		this.funFolderId = funFolderId;
		this.caseDesc = caseDesc;
		this.createTime = createTime;
		this.updateTime = updateTime;
		this.author = author;
		this.latestOperator = latestOperator;
		this.baseCaseId = baseCaseId;
		this.sysLabel = sysLabel;
		this.ownLabel = ownLabel;
		this.url = url;
		this.approvalPsn = approvalPsn;
		this.status = status;
		this.approvalName = approvalName;
		this.authorNo = authorNo;
		this.important = important;
		this.maintenanceFac = maintenanceFac;
		this.regressionTest = regressionTest;
		this.hasTest = hasTest;
		this.testType = testType;
		this.caseType = caseType;
		this.efficiencyTest = efficiencyTest;
		this.efficiencyTestType = efficiencyTestType;
		this.teminalTest = teminalTest;
		this.casePreCond = casePreCond;
		this.caseOperateInst = caseOperateInst;
		this.preResult = preResult;
		this.secId = secId;
		this.elemvalue = elemvalue;
		this.subTaskTag = subTaskTag;
		this.editType = editType;
		this.temporaryTag = temporaryTag;
		this.normalMac = normalMac;
	}

	// Property accessors

	public Integer getHisCaseId() {
		return this.hisCaseId;
	}

	public void setHisCaseId(Integer hisCaseId) {
		this.hisCaseId = hisCaseId;
	}

	public String getOperatorUser() {
		return this.operatorUser;
	}

	public void setOperatorUser(String operatorUser) {
		this.operatorUser = operatorUser;
	}

	public String getOperatorName() {
		return this.operatorName;
	}

	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}

	public Timestamp getOperateTime() {
		return this.operateTime;
	}

	public void setOperateTime(Timestamp operateTime) {
		this.operateTime = operateTime;
	}

	public String getOperatorType() {
		return this.operatorType;
	}

	public void setOperatorType(String operatorType) {
		this.operatorType = operatorType;
	}

	public Integer getCaseId() {
		return this.caseId;
	}

	public void setCaseId(Integer caseId) {
		this.caseId = caseId;
	}

	public String getCaseName() {
		return this.caseName;
	}

	public void setCaseName(String caseName) {
		this.caseName = caseName;
	}

	public Integer getFunFolderId() {
		return this.funFolderId;
	}

	public void setFunFolderId(Integer funFolderId) {
		this.funFolderId = funFolderId;
	}

	public String getCaseDesc() {
		return this.caseDesc;
	}

	public void setCaseDesc(String caseDesc) {
		this.caseDesc = caseDesc;
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

	public String getAuthor() {
		return this.author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getLatestOperator() {
		return this.latestOperator;
	}

	public void setLatestOperator(String latestOperator) {
		this.latestOperator = latestOperator;
	}

	public Integer getBaseCaseId() {
		return this.baseCaseId;
	}

	public void setBaseCaseId(Integer baseCaseId) {
		this.baseCaseId = baseCaseId;
	}

	public String getSysLabel() {
		return this.sysLabel;
	}

	public void setSysLabel(String sysLabel) {
		this.sysLabel = sysLabel;
	}

	public String getOwnLabel() {
		return this.ownLabel;
	}

	public void setOwnLabel(String ownLabel) {
		this.ownLabel = ownLabel;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getApprovalPsn() {
		return this.approvalPsn;
	}

	public void setApprovalPsn(String approvalPsn) {
		this.approvalPsn = approvalPsn;
	}

	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getApprovalName() {
		return this.approvalName;
	}

	public void setApprovalName(String approvalName) {
		this.approvalName = approvalName;
	}

	public String getAuthorNo() {
		return this.authorNo;
	}

	public void setAuthorNo(String authorNo) {
		this.authorNo = authorNo;
	}

	public Integer getImportant() {
		return this.important;
	}

	public void setImportant(Integer important) {
		this.important = important;
	}

	public Integer getMaintenanceFac() {
		return this.maintenanceFac;
	}

	public void setMaintenanceFac(Integer maintenanceFac) {
		this.maintenanceFac = maintenanceFac;
	}

	public Integer getRegressionTest() {
		return this.regressionTest;
	}

	public void setRegressionTest(Integer regressionTest) {
		this.regressionTest = regressionTest;
	}

	public Integer getHasTest() {
		return this.hasTest;
	}

	public void setHasTest(Integer hasTest) {
		this.hasTest = hasTest;
	}

	public String getTestType() {
		return this.testType;
	}

	public void setTestType(String testType) {
		this.testType = testType;
	}

	public Integer getCaseType() {
		return this.caseType;
	}

	public void setCaseType(Integer caseType) {
		this.caseType = caseType;
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

	public String getCasePreCond() {
		return this.casePreCond;
	}

	public void setCasePreCond(String casePreCond) {
		this.casePreCond = casePreCond;
	}

	public String getCaseOperateInst() {
		return this.caseOperateInst;
	}

	public void setCaseOperateInst(String caseOperateInst) {
		this.caseOperateInst = caseOperateInst;
	}

	public String getPreResult() {
		return this.preResult;
	}

	public void setPreResult(String preResult) {
		this.preResult = preResult;
	}

	public Integer getSecId() {
		return this.secId;
	}

	public void setSecId(Integer secId) {
		this.secId = secId;
	}

	public String getElemvalue() {
		return this.elemvalue;
	}

	public void setElemvalue(String elemvalue) {
		this.elemvalue = elemvalue;
	}

	public String getSubTaskTag() {
		return this.subTaskTag;
	}

	public void setSubTaskTag(String subTaskTag) {
		this.subTaskTag = subTaskTag;
	}

	public Integer getEditType() {
		return this.editType;
	}

	public void setEditType(Integer editType) {
		this.editType = editType;
	}

	public String getTemporaryTag() {
		return this.temporaryTag;
	}

	public void setTemporaryTag(String temporaryTag) {
		this.temporaryTag = temporaryTag;
	}

	public String getNormalMac() {
		return this.normalMac;
	}

	public void setNormalMac(String normalMac) {
		this.normalMac = normalMac;
	}

	public Integer getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}

	public Integer getIsFinishAuto() {
		return isFinishAuto;
	}

	public void setIsFinishAuto(Integer isFinishAuto) {
		this.isFinishAuto = isFinishAuto;
	}

	public Integer getIsAvailAuto() {
		return isAvailAuto;
	}

	public void setIsAvailAuto(Integer isAvailAuto) {
		this.isAvailAuto = isAvailAuto;
	}

}