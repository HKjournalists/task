package com.asiainfo.aiga.testTask.bo;

import java.sql.Timestamp;

/**
 * AigaTestTask entity. @author MyEclipse Persistence Tools
 */

public class AigaTestTaskChange implements java.io.Serializable {

	// Fields

	private java.lang.Integer atcId;
	private Timestamp createTime;
	private java.lang.Integer changeStaffId;
	private String changeStaffName;
	private java.lang.Integer changeTaskId;
	private String changeTaskTag;
	private String changeReson;
	private java.lang.Integer planIdo;
	private java.lang.Integer planIdn;
	private Timestamp onlineTimeo;
	private Timestamp onlineTimen;
	
	
	/** default constructor */
	public AigaTestTaskChange() {
	}



	public java.lang.Integer getAtcId() {
		return atcId;
	}



	public void setAtcId(java.lang.Integer atcId) {
		this.atcId = atcId;
	}



	public Timestamp getCreateTime() {
		return createTime;
	}



	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}



	public java.lang.Integer getChangeStaffId() {
		return changeStaffId;
	}



	public void setChangeStaffId(java.lang.Integer changeStaffId) {
		this.changeStaffId = changeStaffId;
	}



	public String getChangeStaffName() {
		return changeStaffName;
	}



	public void setChangeStaffName(String changeStaffName) {
		this.changeStaffName = changeStaffName;
	}



	public java.lang.Integer getChangeTaskId() {
		return changeTaskId;
	}



	public void setChangeTaskId(java.lang.Integer changeTaskId) {
		this.changeTaskId = changeTaskId;
	}



	public String getChangeTaskTag() {
		return changeTaskTag;
	}



	public void setChangeTaskTag(String changeTaskTag) {
		this.changeTaskTag = changeTaskTag;
	}



	public String getChangeReson() {
		return changeReson;
	}



	public void setChangeReson(String changeReson) {
		this.changeReson = changeReson;
	}



	public java.lang.Integer getPlanIdo() {
		return planIdo;
	}



	public void setPlanIdo(java.lang.Integer planIdo) {
		this.planIdo = planIdo;
	}



	public java.lang.Integer getPlanIdn() {
		return planIdn;
	}



	public void setPlanIdn(java.lang.Integer planIdn) {
		this.planIdn = planIdn;
	}



	public Timestamp getOnlineTimeo() {
		return onlineTimeo;
	}



	public void setOnlineTimeo(Timestamp onlineTimeo) {
		this.onlineTimeo = onlineTimeo;
	}



	public Timestamp getOnlineTimen() {
		return onlineTimen;
	}



	public void setOnlineTimen(Timestamp onlineTimen) {
		this.onlineTimen = onlineTimen;
	}

	
}