package com.asiainfo.aiga.userCase.bo;

import java.lang.Integer;
import java.sql.Timestamp;

/**
 * AigaSubSysFolder entity. @author MyEclipse Persistence Tools
 */

public class AigaSubSysFolder implements java.io.Serializable {

	// Fields

	private Integer subsysId;
	private String sysName;
	private Timestamp createTime;
	private Timestamp updateTime;
	private Integer sysId;

	// Constructors

	/** default constructor */
	public AigaSubSysFolder() {
	}

	/** minimal constructor */
	public AigaSubSysFolder(Integer subsysId) {
		this.subsysId = subsysId;
	}

	/** full constructor */
	public AigaSubSysFolder(Integer subsysId, String sysName,
			Timestamp createTime, Timestamp updateTime, Integer sysId) {
		this.subsysId = subsysId;
		this.sysName = sysName;
		this.createTime = createTime;
		this.updateTime = updateTime;
		this.sysId = sysId;
	}

	// Property accessors

	public Integer getSubsysId() {
		return this.subsysId;
	}

	public void setSubsysId(Integer subsysId) {
		this.subsysId = subsysId;
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

	public Integer getSysId() {
		return this.sysId;
	}

	public void setSysId(Integer sysId) {
		this.sysId = sysId;
	}

}