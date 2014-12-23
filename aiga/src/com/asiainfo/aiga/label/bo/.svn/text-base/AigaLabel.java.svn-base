package com.asiainfo.aiga.label.bo;

import java.util.Date;

/**
 * AigaLabel entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class AigaLabel implements java.io.Serializable {

	// Fields

	private Integer labelId;
	private Integer parentId;
	private String labelName;
	private Short labelType;
	private Short labelLevel;
	private Date createTime;
	private String labelDesc;
	private Integer isLeaf;

	// Constructors

	public Integer getIsLeaf() {
		return isLeaf;
	}

	public void setIsLeaf(Integer isLeaf) {
		this.isLeaf = isLeaf;
	}

	/** default constructor */
	public AigaLabel() {
	}

	/** full constructor */
	public AigaLabel(Integer parentId, String labelName, Short labelType,
			Short labelLevel, Date createTime, String labelDesc) {
		this.parentId = parentId;
		this.labelName = labelName;
		this.labelType = labelType;
		this.labelLevel = labelLevel;
		this.createTime = createTime;
		this.labelDesc = labelDesc;
	}

	// Property accessors

	public Integer getLabelId() {
		return this.labelId;
	}

	public void setLabelId(Integer labelId) {
		this.labelId = labelId;
	}

	public Integer getParentId() {
		return this.parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getLabelName() {
		return this.labelName;
	}

	public void setLabelName(String labelName) {
		this.labelName = labelName;
	}

	public Short getLabelType() {
		return this.labelType;
	}

	public void setLabelType(Short labelType) {
		this.labelType = labelType;
	}

	public Short getLabelLevel() {
		return this.labelLevel;
	}

	public void setLabelLevel(Short labelLevel) {
		this.labelLevel = labelLevel;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getLabelDesc() {
		return this.labelDesc;
	}

	public void setLabelDesc(String labelDesc) {
		this.labelDesc = labelDesc;
	}

}