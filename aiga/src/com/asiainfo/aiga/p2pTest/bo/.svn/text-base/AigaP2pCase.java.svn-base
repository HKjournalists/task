package com.asiainfo.aiga.p2pTest.bo;

import java.sql.Timestamp;

/**
 * AigaP2pCaseTemp entity. @author MyEclipse Persistence Tools
 */

public class AigaP2pCase implements java.io.Serializable {

	// Fields

	private Integer caseId;
	private String caseName;
	private String caseDesc;
	private String precondition;
	private String expectation;
	private String operateDesc;
	private String source;
	private String remark;
	private Timestamp createTime;
	private Integer creatorId;
	private String creatorName;
	private String cause;
	private Integer causeType;
	private Integer status;
	private Integer verifyStatus;
	private Integer isDirty;
	private String verifyResult;
	private String caseClass;

	// Constructors

	/** default constructor */
	public AigaP2pCase() {
	}

	/** minimal constructor */
	public AigaP2pCase(Integer caseId) {
		this.caseId = caseId;
	}

	/** full constructor */
	public AigaP2pCase(Integer caseId, String caseName, String caseDesc,
			String precondition, String expectation, String source,
			String remark, Timestamp createTime, Integer creatorId,
			String creatorName, String cause, Integer causeType,
			Integer status, Integer verifyStatus, String verifyResult) {
		this.caseId = caseId;
		this.caseName = caseName;
		this.caseDesc = caseDesc;
		this.precondition = precondition;
		this.expectation = expectation;
		this.source = source;
		this.remark = remark;
		this.createTime = createTime;
		this.creatorId = creatorId;
		this.creatorName = creatorName;
		this.cause = cause;
		this.causeType = causeType;
		this.status = status;
		this.verifyStatus = verifyStatus;
		this.verifyResult = verifyResult;
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

	public String getPrecondition() {
		return this.precondition;
	}

	public void setPrecondition(String precondition) {
		this.precondition = precondition;
	}

	public String getExpectation() {
		return this.expectation;
	}

	public void setExpectation(String expectation) {
		this.expectation = expectation;
	}

	public String getSource() {
		return this.source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public Integer getCreatorId() {
		return this.creatorId;
	}

	public void setCreatorId(Integer creatorId) {
		this.creatorId = creatorId;
	}

	public String getCreatorName() {
		return this.creatorName;
	}

	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}

	public String getCause() {
		return this.cause;
	}

	public void setCause(String cause) {
		this.cause = cause;
	}

	public Integer getCauseType() {
		return this.causeType;
	}

	public void setCauseType(Integer causeType) {
		this.causeType = causeType;
	}

	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getVerifyStatus() {
		return this.verifyStatus;
	}

	public void setVerifyStatus(Integer verifyStatus) {
		this.verifyStatus = verifyStatus;
	}

	public String getVerifyResult() {
		return this.verifyResult;
	}

	public void setVerifyResult(String verifyResult) {
		this.verifyResult = verifyResult;
	}

	public String getOperateDesc() {
		return operateDesc;
	}

	public void setOperateDesc(String operateDesc) {
		this.operateDesc = operateDesc;
	}

	public Integer getIsDirty() {
		return isDirty;
	}

	public void setIsDirty(Integer isDirty) {
		this.isDirty = isDirty;
	}

	public String getCaseClass() {
		return caseClass;
	}

	public void setCaseClass(String caseClass) {
		this.caseClass = caseClass;
	}

	@Override
	public boolean equals(Object other) {
		if (this == other)
			return true;// 先检查是否其自反性，后比较other是否为空。这样效率高
		if (other == null)
			return false;
		if (!(other instanceof AigaP2pCase))
			return false;
		AigaP2pCase o = (AigaP2pCase) other;
		try {
			if (this.caseId == null && o.caseId == null)
				return false;
			if (this.caseId.equals(o.caseId)
					&& this.caseName.equals(o.caseName)
					&& this.caseDesc.equals(o.caseDesc)
					&& this.expectation.equals(o.expectation)
					&& this.operateDesc.equals(o.operateDesc)
					&& this.precondition.equals(o.precondition))
				return true;
		} catch (Exception e) {
			// TODO: handle exception
			return false;
		}
		return false;
	}
}