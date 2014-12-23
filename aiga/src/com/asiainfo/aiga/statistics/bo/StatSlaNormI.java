package com.asiainfo.aiga.statistics.bo;

import java.sql.Timestamp;

/**
 * StatSlaNormI entity. @author MyEclipse Persistence Tools
 */

public class StatSlaNormI implements java.io.Serializable {

	// Fields

	private Integer statId;
	private Integer planId;
	private Timestamp reportTime;
	private Long reqNum;
	private Long testTaskNum;
	private Long devTaskNum;
	private Timestamp createTime;
	private Long bugSum;
	private Long bugUnclosed;
	private Double funcBusiPassPrecent;
	private Double funcProjectPassPrecent;
	private Double performPassPrecent;
	private Double endToEndPassPrecent;
	private Double combinedTestPassPrecent;
	private Double groupInPassPrecent;
	private Double groupOutPassPrecent;
	private Long codeScanProblemNum;
	private Long safeScanProblemNum;
	private Long usableProblemNum;
	private Double publishBusiPassPrecent;
	private Double publishProjectPassPrecent;
	private Double publishFuncPassPrecent;
	private Double publishPerformPassPrecent;
	private Double publishEtePassPrecent;
	private Double publishInterPassPrecent;

	// Constructors

	/** default constructor */
	public StatSlaNormI() {
	}

	/** minimal constructor */
	public StatSlaNormI(Integer statId) {
		this.statId = statId;
	}

	/** full constructor */
	public StatSlaNormI(Integer statId, Integer planId,
			Timestamp reportTime, Long reqNum, Long testTaskNum,
			Long devTaskNum, Timestamp createTime, Long bugSum,
			Long bugUnclosed, Double funcBusiPassPrecent,
			Double funcProjectPassPrecent, Double performPassPrecent,
			Double endToEndPassPrecent, Double combinedTestPassPrecent,
			Double groupInPassPrecent, Double groupOutPassPrecent,
			Long codeScanProblemNum, Long safeScanProblemNum,
			Long usableProblemNum, Double publishBusiPassPrecent,
			Double publishProjectPassPrecent, Double publishFuncPassPrecent,
			Double publishPerformPassPrecent, Double publishEtePassPrecent,
			Double publishInterPassPrecent) {
		this.statId = statId;
		this.planId = planId;
		this.reportTime = reportTime;
		this.reqNum = reqNum;
		this.testTaskNum = testTaskNum;
		this.devTaskNum = devTaskNum;
		this.createTime = createTime;
		this.bugSum = bugSum;
		this.bugUnclosed = bugUnclosed;
		this.funcBusiPassPrecent = funcBusiPassPrecent;
		this.funcProjectPassPrecent = funcProjectPassPrecent;
		this.performPassPrecent = performPassPrecent;
		this.endToEndPassPrecent = endToEndPassPrecent;
		this.combinedTestPassPrecent = combinedTestPassPrecent;
		this.groupInPassPrecent = groupInPassPrecent;
		this.groupOutPassPrecent = groupOutPassPrecent;
		this.codeScanProblemNum = codeScanProblemNum;
		this.safeScanProblemNum = safeScanProblemNum;
		this.usableProblemNum = usableProblemNum;
		this.publishBusiPassPrecent = publishBusiPassPrecent;
		this.publishProjectPassPrecent = publishProjectPassPrecent;
		this.publishFuncPassPrecent = publishFuncPassPrecent;
		this.publishPerformPassPrecent = publishPerformPassPrecent;
		this.publishEtePassPrecent = publishEtePassPrecent;
		this.publishInterPassPrecent = publishInterPassPrecent;
	}

	// Property accessors

	public Integer getStatId() {
		return this.statId;
	}

	public void setStatId(Integer statId) {
		this.statId = statId;
	}

	public Integer getPlanId() {
		return this.planId;
	}

	public void setPlanId(Integer planId) {
		this.planId = planId;
	}

	public Timestamp getReportTime() {
		return this.reportTime;
	}

	public void setReportTime(Timestamp reportTime) {
		this.reportTime = reportTime;
	}

	public Long getReqNum() {
		return this.reqNum;
	}

	public void setReqNum(Long reqNum) {
		this.reqNum = reqNum;
	}

	public Long getTestTaskNum() {
		return this.testTaskNum;
	}

	public void setTestTaskNum(Long testTaskNum) {
		this.testTaskNum = testTaskNum;
	}

	public Long getDevTaskNum() {
		return this.devTaskNum;
	}

	public void setDevTaskNum(Long devTaskNum) {
		this.devTaskNum = devTaskNum;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public Long getBugSum() {
		return this.bugSum;
	}

	public void setBugSum(Long bugSum) {
		this.bugSum = bugSum;
	}

	public Long getBugUnclosed() {
		return this.bugUnclosed;
	}

	public void setBugUnclosed(Long bugUnclosed) {
		this.bugUnclosed = bugUnclosed;
	}

	public Double getFuncBusiPassPrecent() {
		return this.funcBusiPassPrecent;
	}

	public void setFuncBusiPassPrecent(Double funcBusiPassPrecent) {
		this.funcBusiPassPrecent = funcBusiPassPrecent;
	}

	public Double getFuncProjectPassPrecent() {
		return this.funcProjectPassPrecent;
	}

	public void setFuncProjectPassPrecent(Double funcProjectPassPrecent) {
		this.funcProjectPassPrecent = funcProjectPassPrecent;
	}

	public Double getPerformPassPrecent() {
		return this.performPassPrecent;
	}

	public void setPerformPassPrecent(Double performPassPrecent) {
		this.performPassPrecent = performPassPrecent;
	}

	public Double getEndToEndPassPrecent() {
		return this.endToEndPassPrecent;
	}

	public void setEndToEndPassPrecent(Double endToEndPassPrecent) {
		this.endToEndPassPrecent = endToEndPassPrecent;
	}

	public Double getCombinedTestPassPrecent() {
		return this.combinedTestPassPrecent;
	}

	public void setCombinedTestPassPrecent(Double combinedTestPassPrecent) {
		this.combinedTestPassPrecent = combinedTestPassPrecent;
	}

	public Double getGroupInPassPrecent() {
		return this.groupInPassPrecent;
	}

	public void setGroupInPassPrecent(Double groupInPassPrecent) {
		this.groupInPassPrecent = groupInPassPrecent;
	}

	public Double getGroupOutPassPrecent() {
		return this.groupOutPassPrecent;
	}

	public void setGroupOutPassPrecent(Double groupOutPassPrecent) {
		this.groupOutPassPrecent = groupOutPassPrecent;
	}

	public Long getCodeScanProblemNum() {
		return this.codeScanProblemNum;
	}

	public void setCodeScanProblemNum(Long codeScanProblemNum) {
		this.codeScanProblemNum = codeScanProblemNum;
	}

	public Long getSafeScanProblemNum() {
		return this.safeScanProblemNum;
	}

	public void setSafeScanProblemNum(Long safeScanProblemNum) {
		this.safeScanProblemNum = safeScanProblemNum;
	}

	public Long getUsableProblemNum() {
		return this.usableProblemNum;
	}

	public void setUsableProblemNum(Long usableProblemNum) {
		this.usableProblemNum = usableProblemNum;
	}

	public Double getPublishBusiPassPrecent() {
		return this.publishBusiPassPrecent;
	}

	public void setPublishBusiPassPrecent(Double publishBusiPassPrecent) {
		this.publishBusiPassPrecent = publishBusiPassPrecent;
	}

	public Double getPublishProjectPassPrecent() {
		return this.publishProjectPassPrecent;
	}

	public void setPublishProjectPassPrecent(Double publishProjectPassPrecent) {
		this.publishProjectPassPrecent = publishProjectPassPrecent;
	}

	public Double getPublishFuncPassPrecent() {
		return this.publishFuncPassPrecent;
	}

	public void setPublishFuncPassPrecent(Double publishFuncPassPrecent) {
		this.publishFuncPassPrecent = publishFuncPassPrecent;
	}

	public Double getPublishPerformPassPrecent() {
		return this.publishPerformPassPrecent;
	}

	public void setPublishPerformPassPrecent(Double publishPerformPassPrecent) {
		this.publishPerformPassPrecent = publishPerformPassPrecent;
	}

	public Double getPublishEtePassPrecent() {
		return this.publishEtePassPrecent;
	}

	public void setPublishEtePassPrecent(Double publishEtePassPrecent) {
		this.publishEtePassPrecent = publishEtePassPrecent;
	}

	public Double getPublishInterPassPrecent() {
		return this.publishInterPassPrecent;
	}

	public void setPublishInterPassPrecent(Double publishInterPassPrecent) {
		this.publishInterPassPrecent = publishInterPassPrecent;
	}

}