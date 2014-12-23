package com.asiainfo.aiga.userCase.bo;
/**
 * 导出测试报告时,第六个用例的具体信息.
 * @author peng
 *
 */
public class AigaForTestReport {
	private String caseName;//用例名称
	private String funName;//所属功能点
	private int refValue;//测试环境(1:测试, 2:准发布, 3:生产)
	
	private String taskName;//任务名称
	private String doResult;//执行结果
	private String doTime;//执行时间
	private String doEnv;//执行环境
	
	private String testPassPer;//测试通过率
	private String testPassCount;//通过数
	private String testUnpassCount;//未通过数
	private String testResult;//测试结果
	private String testCaseCount;//用例总数
	private String testDefectCount;//缺陷数量
	private String testDefectPass;//缺陷通过数量
	private String testDefectUnPass;//缺陷未通过数
	
	
	public String getTestPassPer() {
		return testPassPer;
	}
	public void setTestPassPer(String testPassPer) {
		this.testPassPer = testPassPer;
	}
	public String getTestPassCount() {
		return testPassCount;
	}
	public void setTestPassCount(String testPassCount) {
		this.testPassCount = testPassCount;
	}
	public String getTestUnpassCount() {
		return testUnpassCount;
	}
	public void setTestUnpassCount(String testUnpassCount) {
		this.testUnpassCount = testUnpassCount;
	}
	public String getTestResult() {
		return testResult;
	}
	public void setTestResult(String testResult) {
		this.testResult = testResult;
	}
	public String getTestCaseCount() {
		return testCaseCount;
	}
	public void setTestCaseCount(String testCaseCount) {
		this.testCaseCount = testCaseCount;
	}
	public String getTestDefectCount() {
		return testDefectCount;
	}
	public void setTestDefectCount(String testDefectCount) {
		this.testDefectCount = testDefectCount;
	}
	public String getTestDefectPass() {
		return testDefectPass;
	}
	public void setTestDefectPass(String testDefectPass) {
		this.testDefectPass = testDefectPass;
	}
	public String getTestDefectUnPass() {
		return testDefectUnPass;
	}
	public void setTestDefectUnPass(String testDefectUnPass) {
		this.testDefectUnPass = testDefectUnPass;
	}
	public String getTaskName() {
		return taskName;
	}
	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}
	public String getDoResult() {
		return doResult;
	}
	public void setDoResult(String doResult) {
		this.doResult = doResult;
	}
	public String getDoTime() {
		return doTime;
	}
	public void setDoTime(String doTime) {
		this.doTime = doTime;
	}
	public String getDoEnv() {
		return doEnv;
	}
	public void setDoEnv(String doEnv) {
		this.doEnv = doEnv;
	}
	public String getCaseName() {
		return caseName;
	}
	public void setCaseName(String caseName) {
		this.caseName = caseName;
	}
	public String getFunName() {
		return funName;
	}
	public void setFunName(String funName) {
		this.funName = funName;
	}
	public int getRefValue() {
		return refValue;
	}
	public void setRefValue(int refValue) {
		this.refValue = refValue;
	}
	
}
