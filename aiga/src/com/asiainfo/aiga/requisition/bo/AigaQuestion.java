package com.asiainfo.aiga.requisition.bo;

import java.sql.Timestamp;

/**
 * SysStaffOrgRelat entity. @author MyEclipse Persistence Tools
 */

public class AigaQuestion implements java.io.Serializable {

	// Fields

	private Long aqId;
	private String aqReviewTag;
	private Integer aqState;
	private Integer aqInto;
	private Integer aqStpMainClass;
	private Integer aqStpSubClass;
	
	private String aqName;
	private String aqSubmitStaff;
	private Timestamp aqSubTime;
	private String defectDscr;
	private String stpDscr;
	
	// Constructors

	/** default constructor */
	public AigaQuestion() {
	}

	public Long getAqId() {
		return aqId;
	}

	public void setAqId(Long aqId) {
		this.aqId = aqId;
	}


	public Integer getAqState() {
		return aqState;
	}

	public void setAqState(Integer aqState) {
		this.aqState = aqState;
	}

	public Integer getAqInto() {
		return aqInto;
	}

	public void setAqInto(Integer aqInto) {
		this.aqInto = aqInto;
	}

	public Integer getAqStpMainClass() {
		return aqStpMainClass;
	}

	public void setAqStpMainClass(Integer aqStpMainClass) {
		this.aqStpMainClass = aqStpMainClass;
	}

	public Integer getAqStpSubClass() {
		return aqStpSubClass;
	}

	public void setAqStpSubClass(Integer aqStpSubClass) {
		this.aqStpSubClass = aqStpSubClass;
	}

	public String getAqName() {
		return aqName;
	}

	public void setAqName(String aqName) {
		this.aqName = aqName;
	}

	public String getAqSubmitStaff() {
		return aqSubmitStaff;
	}

	public void setAqSubmitStaff(String aqSubmitStaff) {
		this.aqSubmitStaff = aqSubmitStaff;
	}

	public Timestamp getAqSubTime() {
		return aqSubTime;
	}

	public void setAqSubTime(Timestamp aqSubTime) {
		this.aqSubTime = aqSubTime;
	}

	public String getDefectDscr() {
		return defectDscr;
	}

	public void setDefectDscr(String defectDscr) {
		this.defectDscr = defectDscr;
	}

	public String getStpDscr() {
		return stpDscr;
	}

	public void setStpDscr(String stpDscr) {
		this.stpDscr = stpDscr;
	}

	public String getAqReviewTag() {
		return aqReviewTag;
	}

	public void setAqReviewTag(String aqReviewTag) {
		this.aqReviewTag = aqReviewTag;
	}

	
}