package com.asiainfo.aiga.runTask.bo;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

/**
 * AigaHisRunTaskResult entity. @author MyEclipse Persistence Tools
 */
@Entity
@SequenceGenerator(name="SEQ_STORE",sequenceName="AIGA_HIS_RUN_TASK_RESULT$SEQ")
public class AigaHisRunTaskResult implements java.io.Serializable {

	// Fields
	
	private Long id;
	private Integer runId;
	private Integer caseId;
	private String runName;
	private String runResult;
	private Timestamp runTime;
	private String taskId;
	private String relaResult;
	private String taskStatus;
	private Integer subTaskId;
	private String taskTag;
	private String taskName;
	private Integer collectType;
	private Timestamp createTime;
	// Constructors

	/** default constructor */
	public AigaHisRunTaskResult() {
	}

	/** minimal constructor */
	public AigaHisRunTaskResult(Long id, Integer runId) {
		this.id = id;
		this.runId = runId;
	}

	/** full constructor */
	public AigaHisRunTaskResult(Long id, Integer runId,
			Integer caseId, String runName, String runResult,
			Timestamp runTime, String taskId, String relaResult,
			String taskStatus, Integer subTaskId, String taskTag,
			String taskName, Integer collectType) {
		this.id = id;
		this.runId = runId;
		this.caseId = caseId;
		this.runName = runName;
		this.runResult = runResult;
		this.runTime = runTime;
		this.taskId = taskId;
		this.relaResult = relaResult;
		this.taskStatus = taskStatus;
		this.subTaskId = subTaskId;
		this.taskTag = taskTag;
		this.taskName = taskName;
		this.collectType = collectType;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="sequence")  
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getRunId() {
		return this.runId;
	}

	public void setRunId(Integer runId) {
		this.runId = runId;
	}

	public Integer getCaseId() {
		return this.caseId;
	}

	public void setCaseId(Integer caseId) {
		this.caseId = caseId;
	}

	public String getRunName() {
		return this.runName;
	}

	public void setRunName(String runName) {
		this.runName = runName;
	}

	public String getRunResult() {
		return this.runResult;
	}

	public void setRunResult(String runResult) {
		this.runResult = runResult;
	}

	public Timestamp getRunTime() {
		return this.runTime;
	}

	public void setRunTime(Timestamp runTime) {
		this.runTime = runTime;
	}

	public String getTaskId() {
		return this.taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public String getRelaResult() {
		return this.relaResult;
	}

	public void setRelaResult(String relaResult) {
		this.relaResult = relaResult;
	}

	public String getTaskStatus() {
		return this.taskStatus;
	}

	public void setTaskStatus(String taskStatus) {
		this.taskStatus = taskStatus;
	}

	public Integer getSubTaskId() {
		return this.subTaskId;
	}

	public void setSubTaskId(Integer subTaskId) {
		this.subTaskId = subTaskId;
	}

	public String getTaskTag() {
		return this.taskTag;
	}

	public void setTaskTag(String taskTag) {
		this.taskTag = taskTag;
	}

	public String getTaskName() {
		return this.taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public Integer getCollectType() {
		return this.collectType;
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

}