package com.asiainfo.aiga.caseLabelRela.bo;

/**
 * AigaCaseLabelRela entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class AigaCaseLabelRela implements java.io.Serializable {

	// Fields
  
	private Integer relaId;
	private Integer caseId;
	private Integer labelId;

	// Constructors

	/** default constructor */
	public AigaCaseLabelRela() {
	}

	/** full constructor */
	public AigaCaseLabelRela(Integer caseId, Integer labelId) {
		this.caseId = caseId;
		this.labelId = labelId;
	}

	// Property accessors

	public Integer getRelaId() {
		return this.relaId;
	}

	public void setRelaId(Integer relaId) {
		this.relaId = relaId;
	}

	public Integer getCaseId() {
		return this.caseId;
	}

	public void setCaseId(Integer caseId) {
		this.caseId = caseId;
	}

	public Integer getLabelId() {
		return this.labelId;
	}

	public void setLabelId(Integer labelId) {
		this.labelId = labelId;
	}

}