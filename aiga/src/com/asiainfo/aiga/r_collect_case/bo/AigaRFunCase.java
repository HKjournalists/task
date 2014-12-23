package com.asiainfo.aiga.r_collect_case.bo;

/**
 * AigaRFunCase entity. @author MyEclipse Persistence Tools
 */

public class AigaRFunCase implements java.io.Serializable {

	// Fields

	private Integer relaId;
	private Integer funId;
	private Integer caseId;

	private String refValue;
	// Constructors

	/** default constructor */
	public AigaRFunCase() {
	}

	/** minimal constructor */
	public AigaRFunCase(Integer relaId) {
		this.relaId = relaId;
	}

	/** full constructor */
	public AigaRFunCase(Integer relaId, Integer funId, Integer caseId) {
		this.relaId = relaId;
		this.funId = funId;
		this.caseId = caseId;
	}

	// Property accessors

	public Integer getRelaId() {
		return this.relaId;
	}

	public void setRelaId(Integer relaId) {
		this.relaId = relaId;
	}

	public Integer getFunId() {
		return this.funId;
	}

	public void setFunId(Integer funId) {
		this.funId = funId;
	}

	public Integer getCaseId() {
		return this.caseId;
	}

	public void setCaseId(Integer caseId) {
		this.caseId = caseId;
	}

	public String getRefValue() {
		return refValue;
	}

	public void setRefValue(String refValue) {
		this.refValue = refValue;
	}

}