package com.asiainfo.aiga.log.bo;

import java.util.List;
import java.util.Set;

/**
 * AigaLogStep entity. @author MyEclipse Persistence Tools
 */

public class AigaLogStep implements java.io.Serializable {

	// Fields

	private Integer stepId;
	private String stepName;
	private String result;
	private Integer testId;
	private Integer manualTaskId;
	
	public Integer getTestId() {
		return testId;
	}

	public void setTestId(Integer testId) {
		this.testId = testId;
	}

	private List<AigaLogElement> aigaLogElements;

	// Constructors

	/** default constructor */
	public AigaLogStep() {
	}

	/** minimal constructor */
	public AigaLogStep(Integer stepId) {
		this.stepId = stepId;
	}

	/** full constructor */
	public AigaLogStep(Integer stepId, String stepName, String result) {
		this.stepId = stepId;
		this.stepName = stepName;
		this.result = result;
	}

	// Property accessors

	public Integer getStepId() {
		return this.stepId;
	}

	public void setStepId(Integer stepId) {
		this.stepId = stepId;
	}

	public String getStepName() {
		return this.stepName;
	}

	public void setStepName(String stepName) {
		this.stepName = stepName;
	}

	public String getResult() {
		return this.result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public List<AigaLogElement> getAigaLogElements() {
		return aigaLogElements;
	}

	public void setAigaLogElements(List<AigaLogElement> aigaLogElements) {
		this.aigaLogElements = aigaLogElements;
	}

	public Integer getManualTaskId() {
		return manualTaskId;
	}

	public void setManualTaskId(Integer manualTaskId) {
		this.manualTaskId = manualTaskId;
	}

}