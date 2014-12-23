package com.asiainfo.aiga.solidTask.bo;


/**
 * AigaStPerftest entity. @author MyEclipse Persistence Tools
 */

public class AigaStPerftest implements java.io.Serializable {

	// Fields

	private Integer pfId;
	private Integer stId;
	private String testEnv;
	private Long testSceneNum;
	private Long testPassNum;
	private Long testNotpassNum;
	private String testResult;
	private String testRemark;

	// Constructors

	/** default constructor */
	public AigaStPerftest() {
	}

	/** minimal constructor */
	public AigaStPerftest(Integer pfId) {
		this.pfId = pfId;
	}

	/** full constructor */
	public AigaStPerftest(Integer pfId, Integer stId, String testEnv,
			Long testSceneNum, Long testPassNum, Long testNotpassNum,
			String testResult, String testRemark) {
		this.pfId = pfId;
		this.stId = stId;
		this.testEnv = testEnv;
		this.testSceneNum = testSceneNum;
		this.testPassNum = testPassNum;
		this.testNotpassNum = testNotpassNum;
		this.testResult = testResult;
		this.testRemark = testRemark;
	}

	// Property accessors

	public Integer getPfId() {
		return this.pfId;
	}

	public void setPfId(Integer pfId) {
		this.pfId = pfId;
	}

	public Integer getStId() {
		return this.stId;
	}

	public void setStId(Integer stId) {
		this.stId = stId;
	}

	public String getTestEnv() {
		return this.testEnv;
	}

	public void setTestEnv(String testEnv) {
		this.testEnv = testEnv;
	}

	public Long getTestSceneNum() {
		return this.testSceneNum;
	}

	public void setTestSceneNum(Long testSceneNum) {
		this.testSceneNum = testSceneNum;
	}

	public Long getTestPassNum() {
		return this.testPassNum;
	}

	public void setTestPassNum(Long testPassNum) {
		this.testPassNum = testPassNum;
	}

	public Long getTestNotpassNum() {
		return this.testNotpassNum;
	}

	public void setTestNotpassNum(Long testNotpassNum) {
		this.testNotpassNum = testNotpassNum;
	}

	public String getTestResult() {
		return this.testResult;
	}

	public void setTestResult(String testResult) {
		this.testResult = testResult;
	}

	public String getTestRemark() {
		return this.testRemark;
	}

	public void setTestRemark(String testRemark) {
		this.testRemark = testRemark;
	}

}