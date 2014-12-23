package com.asiainfo.aiga.runTask.bo;

import java.sql.Timestamp;

/**
 * AigaRunTask entity. @author MyEclipse Persistence Tools
 */

public class AigaRunTask implements java.io.Serializable {

	// Fields

	private String taskId;
	private String taskStatus;
	private java.lang.Integer taskFlag;
	private String taskResult;
	private String taskTag;
	private String taskName;
	private Integer subTaskId;
	private Integer collectType;

	private Timestamp createTime;
	private Timestamp updateTime;
	
	// Constructors

	/** default constructor */
	public AigaRunTask() {
	}

	/** minimal constructor */
	public AigaRunTask(String taskId) {
		this.taskId = taskId;
	}

	/** full constructor */
	public AigaRunTask(String taskId, String taskStatus,
			java.lang.Integer taskFlag, String taskResult) {
		this.taskId = taskId;
		this.taskStatus = taskStatus;
		this.taskFlag = taskFlag;
		this.taskResult = taskResult;
	}

	// Property accessors

	public String getTaskId() {
		return this.taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public String getTaskStatus() {
		return this.taskStatus;
	}

	public void setTaskStatus(String taskStatus) {
		this.taskStatus = taskStatus;
	}

	public Integer getSubTaskId() {
		return subTaskId;
	}

	public void setSubTaskId(Integer subTaskId) {
		this.subTaskId = subTaskId;
	}

	public java.lang.Integer getTaskFlag() {
		return this.taskFlag;
	}

	public void setTaskFlag(java.lang.Integer taskFlag) {
		this.taskFlag = taskFlag;
	}

	public String getTaskResult() {
		return this.taskResult;
	}

	public void setTaskResult(String taskResult) {
		this.taskResult = taskResult;
	}

	public String getTaskTag() {
		return taskTag;
	}

	public void setTaskTag(String taskTag) {
		this.taskTag = taskTag;
	}

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public Integer getCollectType() {
		return collectType;
	}

	public void setCollectType(Integer collectType) {
		this.collectType = collectType;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public Timestamp getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Timestamp updateTime) {
		this.updateTime = updateTime;
	}

}