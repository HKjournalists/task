package com.asiainfo.aiga.userCase.bo;

/**
 * AigaRElemSec entity. @author MyEclipse Persistence Tools
 */

public class AigaRElemSec implements java.io.Serializable {

	// Fields

	private Integer relaId;
	private Integer elemId;
	private Integer secId;
	private String subElemIds;
	private Integer elemOrder;
	private Integer funId;

	// Constructors

	/** default constructor */
	public AigaRElemSec() {
	}

	/** minimal constructor */
	public AigaRElemSec(Integer relaId) {
		this.relaId = relaId;
	}

	/** full constructor */
	public AigaRElemSec(Integer relaId, Integer elemId, Integer secId, Integer funId) {
		this.relaId = relaId;
		this.elemId = elemId;
		this.secId = secId;
		this.funId = funId;
	}

	// Property accessors

	public Integer getFunId() {
		return funId;
	}

	public void setFunId(Integer funId) {
		this.funId = funId;
	}

	public Integer getRelaId() {
		return this.relaId;
	}

	public void setRelaId(Integer relaId) {
		this.relaId = relaId;
	}

	public Integer getElemId() {
		return this.elemId;
	}

	public void setElemId(Integer elemId) {
		this.elemId = elemId;
	}

	public Integer getSecId() {
		return this.secId;
	}

	public void setSecId(Integer secId) {
		this.secId = secId;
	}

	public String getSubElemIds() {
		return subElemIds;
	}

	public void setSubElemIds(String subElemIds) {
		this.subElemIds = subElemIds;
	}

	public Integer getElemOrder() {
		return elemOrder;
	}

	public void setElemOrder(Integer elemOrder) {
		this.elemOrder = elemOrder;
	}

}