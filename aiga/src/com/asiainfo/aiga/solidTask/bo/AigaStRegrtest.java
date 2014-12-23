package com.asiainfo.aiga.solidTask.bo;


/**
 * AigaStRegrtest entity. @author MyEclipse Persistence Tools
 */

public class AigaStRegrtest implements java.io.Serializable {

	// Fields

	private Integer rtId;
	private Integer stId;
	private String testEnv;
	private Long testcaseNum;
	private Long testPassNum;
	private Long testNotpassNum;
	private String testResult;
	private String testRemark;

	// Constructors

	/** default constructor */
	public AigaStRegrtest() {
	}

	/** minimal constructor */
	public AigaStRegrtest(Integer rtId) {
		this.rtId = rtId;
	}

	/** full constructor */
	public AigaStRegrtest(Integer rtId, Integer stId, String testEnv,
			Long testcaseNum, Long testPassNum, Long testNotpassNum,
			String testResult, String testRemark) {
		this.rtId = rtId;
		this.stId = stId;
		this.testEnv = testEnv;
		this.testcaseNum = testcaseNum;
		this.testPassNum = testPassNum;
		this.testNotpassNum = testNotpassNum;
		this.testResult = testResult;
		this.testRemark = testRemark;
	}

	// Property accessors

	public Integer getRtId() {
		return this.rtId;
	}

	public void setRtId(Integer rtId) {
		this.rtId = rtId;
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

	public Long getTestcaseNum() {
		return this.testcaseNum;
	}

	public void setTestcaseNum(Long testcaseNum) {
		this.testcaseNum = testcaseNum;
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