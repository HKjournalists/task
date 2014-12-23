package com.asiainfo.aiga.log.bo;


/**
 * AigaLogElement entity. @author MyEclipse Persistence Tools
 */

public class AigaLogElement implements java.io.Serializable {

	// Fields

	private Integer elementId;
	private String elementArgument;
	private String elementMethod;
	private String elementValue;
	private Integer stepId;
	private String expectValue;
	private String actualValue;

	// Constructors

	/** default constructor */
	public AigaLogElement() {
	}

	/** minimal constructor */
	public AigaLogElement(Integer elementId) {
		this.elementId = elementId;
	}

	/** full constructor */
	public AigaLogElement(Integer elementId, String elementArgument,
			String elementMethod, String elementValue) {
		this.elementId = elementId;
		this.elementArgument = elementArgument;
		this.elementMethod = elementMethod;
		this.elementValue = elementValue;
	}

	// Property accessors

	public Integer getElementId() {
		return this.elementId;
	}

	public void setElementId(Integer elementId) {
		this.elementId = elementId;
	}

	public String getElementArgument() {
		return this.elementArgument;
	}

	public void setElementArgument(String elementArgument) {
		this.elementArgument = elementArgument;
	}

	public String getElementMethod() {
		return this.elementMethod;
	}

	public void setElementMethod(String elementMethod) {
		this.elementMethod = elementMethod;
	}

	public String getElementValue() {
		return this.elementValue;
	}

	public void setElementValue(String elementValue) {
		this.elementValue = elementValue;
	}

	public Integer getStepId() {
		return stepId;
	}

	public void setStepId(Integer stepId) {
		this.stepId = stepId;
	}

	public String getExpectValue() {
		return expectValue;
	}

	public void setExpectValue(String expectValue) {
		this.expectValue = expectValue;
	}

	public String getActualValue() {
		return actualValue;
	}

	public void setActualValue(String actualValue) {
		this.actualValue = actualValue;
	}



}