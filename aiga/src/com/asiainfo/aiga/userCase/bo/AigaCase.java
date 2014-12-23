package com.asiainfo.aiga.userCase.bo;

import java.util.Date;

/**
 * AigaCase entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class AigaCase implements java.io.Serializable {
	// Fields

	private Integer caseId;
	private String caseName;
	private Integer funFolderId;
	private String caseDesc;
	private Date createTime;
	private Date updateTime;
	private String author;
	private String latestOperator;
	private String sysLabel;
	private String ownLabel;
	private String url;
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
	private Integer isDelete;
	private Integer isFinishAuto;
	private Integer isAvailAuto;
	private String needApproval;

	// Constructors

	/** default constructor */
	public AigaCase() {
	}

	/** full constructor */
	public AigaCase(String caseName, Integer funFolderId,String caseDesc, Date createTime, Date updateTime,
			String author, String latestOperator) {
		this.caseName = caseName;
		this.funFolderId = funFolderId;
		this.caseDesc = caseDesc;
		this.createTime = createTime;
		this.updateTime = updateTime;
		this.author = author;
		this.latestOperator = latestOperator;
	}

	// Property accessors

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

	public String getCaseDesc() {
		return this.caseDesc;
	}

	public void setCaseDesc(String caseDesc) {
		this.caseDesc = caseDesc;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(Date updateTime) {
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

	public String getSysLabel() {
		return sysLabel;
	}

	public void setSysLabel(String sysLabel) {
		this.sysLabel = sysLabel;
	}

	public String getOwnLabel() {
		return ownLabel;
	}

	public void setOwnLabel(String ownLabel) {
		this.ownLabel = ownLabel;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getAuthorNo() {
		return authorNo;
	}

	public void setAuthorNo(String authorNo) {
		this.authorNo = authorNo;
	}

	public Integer getFunFolderId() {
		return funFolderId;
	}

	public void setFunFolderId(Integer funFolderId) {
		this.funFolderId = funFolderId;
	}

	public Integer getImportant() {
		return important;
	}

	public void setImportant(Integer important) {
		this.important = important;
	}

	public Integer getMaintenanceFac() {
		return maintenanceFac;
	}

	public void setMaintenanceFac(Integer maintenanceFac) {
		this.maintenanceFac = maintenanceFac;
	}

	public Integer getRegressionTest() {
		return regressionTest;
	}

	public void setRegressionTest(Integer regressionTest) {
		this.regressionTest = regressionTest;
	}

	public Integer getHasTest() {
		return hasTest;
	}

	public void setHasTest(Integer hasTest) {
		this.hasTest = hasTest;
	}

	public String getTestType() {
		return testType;
	}

	public void setTestType(String testType) {
		this.testType = testType;
	}

	public Integer getCaseType() {
		return caseType;
	}

	public void setCaseType(Integer caseType) {
		this.caseType = caseType;
	}

	public Integer getEfficiencyTest() {
		return efficiencyTest;
	}

	public void setEfficiencyTest(Integer efficiencyTest) {
		this.efficiencyTest = efficiencyTest;
	}

	public Integer getEfficiencyTestType() {
		return efficiencyTestType;
	}

	public void setEfficiencyTestType(Integer efficiencyTestType) {
		this.efficiencyTestType = efficiencyTestType;
	}

	public Integer getTeminalTest() {
		return teminalTest;
	}

	public void setTeminalTest(Integer teminalTest) {
		this.teminalTest = teminalTest;
	}

	public String getCasePreCond() {
		return casePreCond;
	}

	public void setCasePreCond(String casePreCond) {
		this.casePreCond = casePreCond;
	}

	public String getCaseOperateInst() {
		return caseOperateInst;
	}

	public void setCaseOperateInst(String caseOperateInst) {
		this.caseOperateInst = caseOperateInst;
	}

	public String getPreResult() {
		return preResult;
	}

	public void setPreResult(String preResult) {
		this.preResult = preResult;
	}

	public Integer getSecId() {
		return secId;
	}

	public void setSecId(Integer secId) {
		this.secId = secId;
	}

	public String getElemvalue() {
		return elemvalue;
	}

	public void setElemvalue(String elemvalue) {
		this.elemvalue = elemvalue;
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

	public String getNeedApproval() {
		return needApproval;
	}

	public void setNeedApproval(String needApproval) {
		this.needApproval = needApproval;
	}

}