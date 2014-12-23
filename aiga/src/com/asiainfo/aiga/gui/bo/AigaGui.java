package com.asiainfo.aiga.gui.bo;

import java.lang.Integer;
import java.sql.Timestamp;

/**
 * AigaGui entity. @author MyEclipse Persistence Tools
 */

public class AigaGui implements java.io.Serializable {

	// Fields

	private Integer guiId;
	private String guiSelector;
	private String guiUrl;
	private String guiThumbUrl;
	private String guiTag;
	private Integer parentId;
	private String guiName;
	private Short guiPermission;
	private String guiPath;
	private String guiExtra;
	private String guiDesc;
	private String guiHtml;
	private Timestamp guiCreateTime;
	private Timestamp guiUpdateTime;
	private String guiAuthor;
	private String guiBounds;
	private String guiHashcode;
	private String guiLatestOperator;

	// Constructors

	/** default constructor */
	public AigaGui() {
	}

	/** minimal constructor */
	public AigaGui(Integer guiId) {
		this.guiId = guiId;
	}

	/** full constructor */
	public AigaGui(Integer guiId, String guiSelector, String guiUrl,
			String guiThumbUrl, String guiTag, Integer parentId,
			String guiName, Short guiPermission, String guiPath,
			String guiExtra, String guiDesc, String guiHtml,
			Timestamp guiCreateTime, Timestamp guiUpdateTime, String guiAuthor,
			String guiBounds, String guiHashcode, String guiLatestOperator) {
		this.guiId = guiId;
		this.guiSelector = guiSelector;
		this.guiUrl = guiUrl;
		this.guiThumbUrl = guiThumbUrl;
		this.guiTag = guiTag;
		this.parentId = parentId;
		this.guiName = guiName;
		this.guiPermission = guiPermission;
		this.guiPath = guiPath;
		this.guiExtra = guiExtra;
		this.guiDesc = guiDesc;
		this.guiHtml = guiHtml;
		this.guiCreateTime = guiCreateTime;
		this.guiUpdateTime = guiUpdateTime;
		this.guiAuthor = guiAuthor;
		this.guiBounds = guiBounds;
		this.guiHashcode = guiHashcode;
		this.guiLatestOperator = guiLatestOperator;
	}

	// Property accessors

	public Integer getGuiId() {
		return this.guiId;
	}

	public void setGuiId(Integer guiId) {
		this.guiId = guiId;
	}

	public String getGuiSelector() {
		return this.guiSelector;
	}

	public void setGuiSelector(String guiSelector) {
		this.guiSelector = guiSelector;
	}

	public String getGuiUrl() {
		return this.guiUrl;
	}

	public void setGuiUrl(String guiUrl) {
		this.guiUrl = guiUrl;
	}

	public String getguiThumbUrl() {
		return this.guiThumbUrl;
	}

	public void setguiThumbUrl(String guiThumbUrl) {
		this.guiThumbUrl = guiThumbUrl;
	}

	public String getGuiTag() {
		return this.guiTag;
	}

	public void setGuiTag(String guiTag) {
		this.guiTag = guiTag;
	}

	public Integer getParentId() {
		return this.parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getGuiName() {
		return this.guiName;
	}

	public void setGuiName(String guiName) {
		this.guiName = guiName;
	}

	public Short getGuiPermission() {
		return this.guiPermission;
	}

	public void setGuiPermission(Short guiPermission) {
		this.guiPermission = guiPermission;
	}

	public String getGuiPath() {
		return this.guiPath;
	}

	public void setGuiPath(String guiPath) {
		this.guiPath = guiPath;
	}

	public String getGuiExtra() {
		return this.guiExtra;
	}

	public void setGuiExtra(String guiExtra) {
		this.guiExtra = guiExtra;
	}

	public String getGuiDesc() {
		return this.guiDesc;
	}

	public void setGuiDesc(String guiDesc) {
		this.guiDesc = guiDesc;
	}

	public String getGuiHtml() {
		return this.guiHtml;
	}

	public void setGuiHtml(String guiHtml) {
		this.guiHtml = guiHtml;
	}

	public Timestamp getGuiCreateTime() {
		return this.guiCreateTime;
	}

	public void setGuiCreateTime(Timestamp guiCreateTime) {
		this.guiCreateTime = guiCreateTime;
	}

	public Timestamp getGuiUpdateTime() {
		return this.guiUpdateTime;
	}

	public void setGuiUpdateTime(Timestamp guiUpdateTime) {
		this.guiUpdateTime = guiUpdateTime;
	}

	public String getGuiAuthor() {
		return this.guiAuthor;
	}

	public void setGuiAuthor(String guiAuthor) {
		this.guiAuthor = guiAuthor;
	}

	public String getGuiBounds() {
		return this.guiBounds;
	}

	public void setGuiBounds(String guiBounds) {
		this.guiBounds = guiBounds;
	}

	public String getGuiHashcode() {
		return this.guiHashcode;
	}

	public void setGuiHashcode(String guiHashcode) {
		this.guiHashcode = guiHashcode;
	}

	public String getGuiLatestOperator() {
		return this.guiLatestOperator;
	}

	public void setGuiLatestOperator(String guiLatestOperator) {
		this.guiLatestOperator = guiLatestOperator;
	}

}