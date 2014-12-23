package com.asiainfo.aiga.testVersion.bo;

import java.sql.Timestamp;

/**
 * AigaTestVersion entity. @author MyEclipse Persistence Tools
 */

public class AigaTestVersion implements java.io.Serializable {

	// Fields

	private Integer versionId;
	private String versionTag;
	private Timestamp plOnlineTime;
	private Timestamp factOnlineTime;
	private Timestamp versionCreateTime;
	private String plWorkDay;
	private String factWorkDay;

	// Constructors

	/** default constructor */
	public AigaTestVersion() {
	}

	/** minimal constructor */
	public AigaTestVersion(Integer versionId) {
		this.versionId = versionId;
	}

	/** full constructor */
	public AigaTestVersion(Integer versionId, String versionTag,
			Timestamp plOnlineTime, Timestamp factOnlineTime,
			Timestamp versionCreateTime, String plWorkDay, String factWorkDay) {
		this.versionId = versionId;
		this.versionTag = versionTag;
		this.plOnlineTime = plOnlineTime;
		this.factOnlineTime = factOnlineTime;
		this.versionCreateTime = versionCreateTime;
		this.plWorkDay = plWorkDay;
		this.factWorkDay = factWorkDay;
	}

	// Property accessors

	public Integer getVersionId() {
		return this.versionId;
	}

	public void setVersionId(Integer versionId) {
		this.versionId = versionId;
	}

	public String getVersionTag() {
		return this.versionTag;
	}

	public void setVersionTag(String versionTag) {
		this.versionTag = versionTag;
	}

	public Timestamp getPlOnlineTime() {
		return this.plOnlineTime;
	}

	public void setPlOnlineTime(Timestamp plOnlineTime) {
		this.plOnlineTime = plOnlineTime;
	}

	public Timestamp getFactOnlineTime() {
		return this.factOnlineTime;
	}

	public void setFactOnlineTime(Timestamp factOnlineTime) {
		this.factOnlineTime = factOnlineTime;
	}



	public Timestamp getVersionCreateTime() {
		return versionCreateTime;
	}

	public void setVersionCreateTime(Timestamp versionCreateTime) {
		this.versionCreateTime = versionCreateTime;
	}

	public String getPlWorkDay() {
		return this.plWorkDay;
	}

	public void setPlWorkDay(String plWorkDay) {
		this.plWorkDay = plWorkDay;
	}

	public String getFactWorkDay() {
		return this.factWorkDay;
	}

	public void setFactWorkDay(String factWorkDay) {
		this.factWorkDay = factWorkDay;
	}

}