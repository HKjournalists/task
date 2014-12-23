package com.asiainfo.aiga.p2pTest.bo;

import java.sql.Timestamp;

/**
 * AigaP2pBaseFunction entity. @author MyEclipse Persistence Tools
 */

public class AigaP2pBaseFunction implements java.io.Serializable {

	// Fields

	private Integer baseFunId;
	private String baseFunName;
	private String busiScopeIllustration;
	private Integer isInvalid;
	private String remark;
	private String cause;
	private Integer causeType;
	private Integer status;
	private Timestamp createTime;
	private Integer creatorId;
	private String creatorName;

	// Constructors

	/** default constructor */
	public AigaP2pBaseFunction() {
	}

	/** minimal constructor */
	public AigaP2pBaseFunction(Integer baseFunId) {
		this.baseFunId = baseFunId;
	}

	/** full constructor */
	public AigaP2pBaseFunction(Integer baseFunId, String baseFunName,
			String busiScopeIllustration, Integer isInvalid, String remark,
			String cause, Integer causeType, Integer status, Timestamp createTime,
			Integer creatorId, String creatorName) {
		this.baseFunId = baseFunId;
		this.baseFunName = baseFunName;
		this.busiScopeIllustration = busiScopeIllustration;
		this.isInvalid = isInvalid;
		this.remark = remark;
		this.cause = cause;
		this.causeType = causeType;
		this.status = status;
		this.createTime = createTime;
		this.creatorId = creatorId;
		this.creatorName = creatorName;
	}

	// Property accessors

	public Integer getBaseFunId() {
		return this.baseFunId;
	}

	public void setBaseFunId(Integer baseFunId) {
		this.baseFunId = baseFunId;
	}

	public String getBaseFunName() {
		return this.baseFunName;
	}

	public void setBaseFunName(String baseFunName) {
		this.baseFunName = baseFunName;
	}

	public String getBusiScopeIllustration() {
		return this.busiScopeIllustration;
	}

	public void setBusiScopeIllustration(String busiScopeIllustration) {
		this.busiScopeIllustration = busiScopeIllustration;
	}

	public Integer getIsInvalid() {
		return this.isInvalid;
	}

	public void setIsInvalid(Integer isInvalid) {
		this.isInvalid = isInvalid;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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

}