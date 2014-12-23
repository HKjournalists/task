package com.asiainfo.aiga.solidTask.bo;


/**
 * AigaStCodescan entity. @author MyEclipse Persistence Tools
 */

public class AigaStCodescan implements java.io.Serializable {

	// Fields

	private Integer csId;
	private Integer stId;
	private String validatyFirstScan;
	private String validatyRegrScan;
	private String validatyRepairScale;
	private String securityFirstScan;
	private String securityRegrScan;
	private String securityRepairScale;
	private String maintenFirstScan;
	private String maintenRegrScan;
	private String maintenRepairScale;
	private String testEnv;
	private String testResult;
	private String testRemark;

	// Constructors

	/** default constructor */
	public AigaStCodescan() {
	}

	/** minimal constructor */
	public AigaStCodescan(Integer csId) {
		this.csId = csId;
	}

	/** full constructor */
	public AigaStCodescan(Integer csId, Integer stId,
			String validatyFirstScan, String validatyRegrScan,
			String validatyRepairScale, String securityFirstScan,
			String securityRegrScan, String securityRepairScale,
			String maintenFirstScan, String maintenRegrScan,
			String maintenRepairScale, String testEnv, String testResult,
			String testRemark) {
		this.csId = csId;
		this.stId = stId;
		this.validatyFirstScan = validatyFirstScan;
		this.validatyRegrScan = validatyRegrScan;
		this.validatyRepairScale = validatyRepairScale;
		this.securityFirstScan = securityFirstScan;
		this.securityRegrScan = securityRegrScan;
		this.securityRepairScale = securityRepairScale;
		this.maintenFirstScan = maintenFirstScan;
		this.maintenRegrScan = maintenRegrScan;
		this.maintenRepairScale = maintenRepairScale;
		this.testEnv = testEnv;
		this.testResult = testResult;
		this.testRemark = testRemark;
	}

	// Property accessors

	public Integer getCsId() {
		return this.csId;
	}

	public void setCsId(Integer csId) {
		this.csId = csId;
	}

	public Integer getStId() {
		return this.stId;
	}

	public void setStId(Integer stId) {
		this.stId = stId;
	}

	public String getValidatyFirstScan() {
		return this.validatyFirstScan;
	}

	public void setValidatyFirstScan(String validatyFirstScan) {
		this.validatyFirstScan = validatyFirstScan;
	}

	public String getValidatyRegrScan() {
		return this.validatyRegrScan;
	}

	public void setValidatyRegrScan(String validatyRegrScan) {
		this.validatyRegrScan = validatyRegrScan;
	}

	public String getValidatyRepairScale() {
		return this.validatyRepairScale;
	}

	public void setValidatyRepairScale(String validatyRepairScale) {
		this.validatyRepairScale = validatyRepairScale;
	}

	public String getSecurityFirstScan() {
		return this.securityFirstScan;
	}

	public void setSecurityFirstScan(String securityFirstScan) {
		this.securityFirstScan = securityFirstScan;
	}

	public String getSecurityRegrScan() {
		return this.securityRegrScan;
	}

	public void setSecurityRegrScan(String securityRegrScan) {
		this.securityRegrScan = securityRegrScan;
	}

	public String getSecurityRepairScale() {
		return this.securityRepairScale;
	}

	public void setSecurityRepairScale(String securityRepairScale) {
		this.securityRepairScale = securityRepairScale;
	}

	public String getMaintenFirstScan() {
		return this.maintenFirstScan;
	}

	public void setMaintenFirstScan(String maintenFirstScan) {
		this.maintenFirstScan = maintenFirstScan;
	}

	public String getMaintenRegrScan() {
		return this.maintenRegrScan;
	}

	public void setMaintenRegrScan(String maintenRegrScan) {
		this.maintenRegrScan = maintenRegrScan;
	}

	public String getMaintenRepairScale() {
		return this.maintenRepairScale;
	}

	public void setMaintenRepairScale(String maintenRepairScale) {
		this.maintenRepairScale = maintenRepairScale;
	}

	public String getTestEnv() {
		return this.testEnv;
	}

	public void setTestEnv(String testEnv) {
		this.testEnv = testEnv;
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