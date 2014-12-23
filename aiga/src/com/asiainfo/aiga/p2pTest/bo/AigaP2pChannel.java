package com.asiainfo.aiga.p2pTest.bo;

import java.sql.Timestamp;

/**
 * AigaP2pChannel entity. @author MyEclipse Persistence Tools
 */

public class AigaP2pChannel implements java.io.Serializable {

	// Fields

	private java.lang.Integer channelId;
	private String channelName;
	private java.lang.Integer isP2pChannel;
	private java.lang.Integer importanceLevel;
	private java.lang.Integer buidFirm;
	private String remork;
	private String cause;
	private java.lang.Integer causeType;
	private java.lang.Integer status;
	private Timestamp createTime;
	private String creatorId;
	private String creatorName;

	// Constructors

	/** default constructor */
	public AigaP2pChannel() {
	}

	/** minimal constructor */
	public AigaP2pChannel(java.lang.Integer channelId) {
		this.channelId = channelId;
	}

	/** full constructor */
	public AigaP2pChannel(java.lang.Integer channelId, String channelName,
			java.lang.Integer isP2pChannel, java.lang.Integer importanceLevel, java.lang.Integer buidFirm,
			String remork, String cause, java.lang.Integer causeType, java.lang.Integer status,
			Timestamp createTime, String creatorId, String creatorName) {
		this.channelId = channelId;
		this.channelName = channelName;
		this.isP2pChannel = isP2pChannel;
		this.importanceLevel = importanceLevel;
		this.buidFirm = buidFirm;
		this.remork = remork;
		this.cause = cause;
		this.causeType = causeType;
		this.status = status;
		this.createTime = createTime;
		this.creatorId = creatorId;
		this.creatorName = creatorName;
	}

	// Property accessors

	public java.lang.Integer getChannelId() {
		return this.channelId;
	}

	public void setChannelId(java.lang.Integer channelId) {
		this.channelId = channelId;
	}

	public String getChannelName() {
		return this.channelName;
	}

	public void setChannelName(String channelName) {
		this.channelName = channelName;
	}

	public java.lang.Integer getIsP2pChannel() {
		return this.isP2pChannel;
	}

	public void setIsP2pChannel(java.lang.Integer isP2pChannel) {
		this.isP2pChannel = isP2pChannel;
	}

	public java.lang.Integer getImportanceLevel() {
		return this.importanceLevel;
	}

	public void setImportanceLevel(java.lang.Integer importanceLevel) {
		this.importanceLevel = importanceLevel;
	}

	public java.lang.Integer getBuidFirm() {
		return this.buidFirm;
	}

	public void setBuidFirm(java.lang.Integer buidFirm) {
		this.buidFirm = buidFirm;
	}

	public String getRemork() {
		return this.remork;
	}

	public void setRemork(String remork) {
		this.remork = remork;
	}

	public String getCause() {
		return this.cause;
	}

	public void setCause(String cause) {
		this.cause = cause;
	}

	public java.lang.Integer getCauseType() {
		return this.causeType;
	}

	public void setCauseType(java.lang.Integer causeType) {
		this.causeType = causeType;
	}

	public java.lang.Integer getStatus() {
		return this.status;
	}

	public void setStatus(java.lang.Integer status) {
		this.status = status;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getCreatorId() {
		return this.creatorId;
	}

	public void setCreatorId(String creatorId) {
		this.creatorId = creatorId;
	}

	public String getCreatorName() {
		return this.creatorName;
	}

	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}

}