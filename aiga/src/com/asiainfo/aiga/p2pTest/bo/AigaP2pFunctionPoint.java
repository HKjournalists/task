package com.asiainfo.aiga.p2pTest.bo;

import java.sql.Timestamp;

/**
 * AigaP2pFunctionPoint entity. @author MyEclipse Persistence Tools
 */

public class AigaP2pFunctionPoint implements java.io.Serializable {

	// Fields

	private Integer funId;
	private String sysName;
	private Timestamp createTime;
	private Timestamp updateTime;
	private String cause;
	private Integer causeType;
	private Integer operatorId;
	private String operatorName;
	private Integer creatorId;
	private String creatorName;
	private Integer status;
	private Integer verifyStatus;
	private String verifyResult;
	// Constructors

	/** default constructor */
	public AigaP2pFunctionPoint() {
	}

	/** minimal constructor */
	public AigaP2pFunctionPoint(Integer funId) {
		this.funId = funId;
	}

	/** full constructor */
	public AigaP2pFunctionPoint(Integer funId, String sysName,
			Timestamp createTime, Timestamp updateTime, String cause,
			Integer causeType, Integer operatorId, String operatorName,
			Integer creatorId, String creatorName) {
		this.funId = funId;
		this.sysName = sysName;
		this.createTime = createTime;
		this.updateTime = updateTime;
		this.cause = cause;
		this.causeType = causeType;
		this.operatorId = operatorId;
		this.operatorName = operatorName;
		this.creatorId = creatorId;
		this.creatorName = creatorName;
	}

	// Property accessors

	public Integer getFunId() {
		return this.funId;
	}

	public void setFunId(Integer funId) {
		this.funId = funId;
	}

	public String getSysName() {
		return this.sysName;
	}

	public void setSysName(String sysName) {
		this.sysName = sysName;
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

	public Integer getOperatorId() {
		return this.operatorId;
	}

	public void setOperatorId(Integer operatorId) {
		this.operatorId = operatorId;
	}

	public String getOperatorName() {
		return this.operatorName;
	}

	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
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

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getVerifyStatus() {
		return verifyStatus;
	}

	public void setVerifyStatus(Integer verifyStatus) {
		this.verifyStatus = verifyStatus;
	}

	public String getVerifyResult() {
		return verifyResult;
	}

	public void setVerifyResult(String verifyResult) {
		this.verifyResult = verifyResult;
	}

}