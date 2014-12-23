package com.asiainfo.aiga.p2pTest.bo;

import java.sql.Timestamp;

/**
 * AigaP2pBusiOneLevel entity. @author MyEclipse Persistence Tools
 */

public class AigaP2pBusiOneLevel implements java.io.Serializable {

	// Fields

	private Integer p2pBusiId;
	private String busiName;
	private Integer busiType;
	private String busiDesc;
	private Integer importantClass;
	private String remarks;
	private Integer isInvalid;
	private Timestamp createTime;
	private Integer creatorId;
	private String creatorName;

	// Constructors

	/** default constructor */
	public AigaP2pBusiOneLevel() {
	}

	/** minimal constructor */
	public AigaP2pBusiOneLevel(Integer p2pBusiId) {
		this.p2pBusiId = p2pBusiId;
	}

	/** full constructor */
	public AigaP2pBusiOneLevel(Integer p2pBusiId, String busiName,
			Integer busiType, String busiDesc, Integer importantClass,
			String remarks, Integer isInvalid, Timestamp createTime,
			Integer creatorId, String creatorName) {
		this.p2pBusiId = p2pBusiId;
		this.busiName = busiName;
		this.busiType = busiType;
		this.busiDesc = busiDesc;
		this.importantClass = importantClass;
		this.remarks = remarks;
		this.isInvalid = isInvalid;
		this.createTime = createTime;
		this.creatorId = creatorId;
		this.creatorName = creatorName;
	}

	// Property accessors

	public Integer getP2pBusiId() {
		return this.p2pBusiId;
	}

	public void setP2pBusiId(Integer p2pBusiId) {
		this.p2pBusiId = p2pBusiId;
	}

	public String getBusiName() {
		return this.busiName;
	}

	public void setBusiName(String busiName) {
		this.busiName = busiName;
	}

	public Integer getBusiType() {
		return this.busiType;
	}

	public void setBusiType(Integer busiType) {
		this.busiType = busiType;
	}

	public String getBusiDesc() {
		return this.busiDesc;
	}

	public void setBusiDesc(String busiDesc) {
		this.busiDesc = busiDesc;
	}

	public Integer getImportantClass() {
		return this.importantClass;
	}

	public void setImportantClass(Integer importantClass) {
		this.importantClass = importantClass;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Integer getIsInvalid() {
		return this.isInvalid;
	}

	public void setIsInvalid(Integer isInvalid) {
		this.isInvalid = isInvalid;
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