package com.asiainfo.aiga.log.bo;

import java.util.List;
import java.util.Set;

/**
 * AigaLogTestCase entity. @author MyEclipse Persistence Tools
 */

public class AigaLogTestCase implements java.io.Serializable {

	// Fields

	private Integer testId;
	private Integer caseId;
	private Integer runId;
	private String logInfo;
	private String errInfo;
	private Integer caseType;
	
	private List<AigaLogStep> aigaLogSteps;
	// Constructors

	/** default constructor */
	public AigaLogTestCase() {
	}

	/** minimal constructor */
	public AigaLogTestCase(Integer testId) {
		this.testId = testId;
	}

	/** full constructor */
	public AigaLogTestCase(Integer testId, Integer caseId,
			Integer runId, String logInfo, String errInfo) {
		this.testId = testId;
		this.caseId = caseId;
		this.runId = runId;
		this.logInfo = logInfo;
		this.errInfo = errInfo;
	}

	// Property accessors

	public Integer getTestId() {
		return this.testId;
	}

	public void setTestId(Integer testId) {
		this.testId = testId;
	}

	public Integer getCaseId() {
		return this.caseId;
	}

	public void setCaseId(Integer caseId) {
		this.caseId = caseId;
	}

	public Integer getRunId() {
		return this.runId;
	}

	public void setRunId(Integer runId) {
		this.runId = runId;
	}

	public String getLogInfo() {
		return this.logInfo;
	}

	public void setLogInfo(String logInfo) {
		this.logInfo = logInfo;
	}

	public String getErrInfo() {
		return this.errInfo;
	}

	public void setErrInfo(String errInfo) {
		this.errInfo = errInfo;
	}

	public List<AigaLogStep> getAigaLogSteps() {
		return aigaLogSteps;
	}

	public void setAigaLogSteps(List<AigaLogStep> aigaLogSteps) {
		this.aigaLogSteps = aigaLogSteps;
	}

	public Integer getCaseType() {
		return caseType;
	}

	public void setCaseType(Integer caseType) {
		this.caseType = caseType;
	}

}