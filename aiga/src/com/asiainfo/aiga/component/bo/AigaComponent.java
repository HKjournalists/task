package com.asiainfo.aiga.component.bo;

import java.sql.Timestamp;

/**
 * AigaComponent entity. @author MyEclipse Persistence Tools
 */

public class AigaComponent implements java.io.Serializable {

	// Fields

	private Integer compId;
	private Integer parentId;
	private String compName;
	private Integer permission;
	private String path;
	private String defaultVal;
	private String compDesc;
	private Timestamp createTime;
	private Timestamp updateTime;
	private String author;
	private String latestOperator;
	private String hashcode;
	private String url;
	private String extra;
	private String isLeaf;
	private String authorNo;

	// Constructors

	/** default constructor */
	public AigaComponent() {
	}

	/** minimal constructor */
	public AigaComponent(Integer compId) {
		this.compId = compId;
	}

	/** full constructor */
	public AigaComponent(Integer compId, Integer parentId,
			String compName, Integer permission, String path, String defaultVal,
			String compDesc, Timestamp createTime, Timestamp updateTime,
			String author, String latestOperator, String hashcode, String url,
			String extra) {
		this.compId = compId;
		this.parentId = parentId;
		this.compName = compName;
		this.permission = permission;
		this.path = path;
		this.defaultVal = defaultVal;
		this.compDesc = compDesc;
		this.createTime = createTime;
		this.updateTime = updateTime;
		this.author = author;
		this.latestOperator = latestOperator;
		this.hashcode = hashcode;
		this.url = url;
		this.extra = extra;
	}

	// Property accessors

	public Integer getCompId() {
		return this.compId;
	}

	public void setCompId(Integer compId) {
		this.compId = compId;
	}

	public Integer getParentId() {
		return this.parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getCompName() {
		return this.compName;
	}

	public void setCompName(String compName) {
		this.compName = compName;
	}

	public Integer getPermission() {
		return this.permission;
	}

	public void setPermission(Integer permission) {
		this.permission = permission;
	}

	public String getPath() {
		return this.path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getDefaultVal() {
		return this.defaultVal;
	}

	public void setDefaultVal(String defaultVal) {
		this.defaultVal = defaultVal;
	}

	public String getCompDesc() {
		return this.compDesc;
	}

	public void setCompDesc(String compDesc) {
		this.compDesc = compDesc;
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

	public String getHashcode() {
		return this.hashcode;
	}

	public void setHashcode(String hashcode) {
		this.hashcode = hashcode;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getExtra() {
		return this.extra;
	}

	public void setExtra(String extra) {
		this.extra = extra;
	}

	public String getIsLeaf() {
		return isLeaf;
	}

	public void setIsLeaf(String isLeaf) {
		this.isLeaf = isLeaf;
	}

	public String getAuthorNo() {
		return authorNo;
	}

	public void setAuthorNo(String authorNo) {
		this.authorNo = authorNo;
	}
}