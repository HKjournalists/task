package com.asiainfo.aiga.manualTask.bo;

import java.lang.Integer;
import java.sql.Timestamp;

/**
 * AigaManualTask entity. @author MyEclipse Persistence Tools
 */

public class AigaManualTask implements java.io.Serializable {

	// Fields

	private Integer taskId;
	private String taskName;
	private String taskDesc;
	private Timestamp createTime;
	private Timestamp updateTime;
	private String preResult;
	private String preTestData;
	private Integer caseId;
	private String describe;
	private String actualResult;
	private Integer taskOrder;
	// Constructors

	/** default constructor */
	public AigaManualTask() {
	}

	/** minimal constructor */
	public AigaManualTask(Integer taskId) {
		this.taskId = taskId;
	}

	/** full constructor */
	public AigaManualTask(Integer taskId, String taskName, String taskDesc,
			Timestamp createTime, Timestamp updateTime, String preResult,
			String preTestData, Integer caseId, String describe) {
		this.taskId = taskId;
		this.taskName = taskName;
		this.taskDesc = taskDesc;
		this.createTime = createTime;
		this.updateTime = updateTime;
		this.preResult = preResult;
		this.preTestData = preTestData;
		this.caseId = caseId;
		this.describe = describe;
	}

	// Property accessors

	public Integer getTaskId() {
		return this.taskId;
	}

	public void setTaskId(Integer taskId) {
		this.taskId = taskId;
	}

	public String getTaskName() {
		return this.taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public String getTaskDesc() {
		return this.taskDesc;
	}

	public void setTaskDesc(String taskDesc) {
		this.taskDesc = taskDesc;
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

	public String getPreResult() {
		return this.preResult;
	}

	public void setPreResult(String preResult) {
		this.preResult = preResult;
	}

	public String getPreTestData() {
		return this.preTestData;
	}

	public void setPreTestData(String preTestData) {
		this.preTestData = preTestData;
	}

	public Integer getCaseId() {
		return this.caseId;
	}

	public void setCaseId(Integer caseId) {
		this.caseId = caseId;
	}

	public String getDescribe() {
		return this.describe;
	}

	public void setDescribe(String describe) {
		this.describe = describe;
	}

	public String getActualResult() {
		return actualResult;
	}

	public void setActualResult(String actualResult) {
		this.actualResult = actualResult;
	}

	public Integer getTaskOrder() {
		return taskOrder;
	}

	public void setTaskOrder(Integer taskOrder) {
		this.taskOrder = taskOrder;
	}

}