package com.asiainfo.aiga.statistics.bo;


/**
 * StatAutoCover entity. @author MyEclipse Persistence Tools
 */

public class StatAutoCover implements java.io.Serializable {

	// Fields

	private Integer statId;
	private String reportMonth;
	private String systemName;
	private String functionPoint;
	private String manualCase;
	private String autoFunctionPoint;
	private String autoCase;
	private String unrealizableAutoCase;
	private String unrealizedAutoCase;
	private String kernalFunctionPoint;
	private String kernalRegressCase;
	private String kernalAutoCase;
	private String kernalUnrealizableCase;
	private String kernalUnrealizedCase;
	private String kernalFunctionCover;
	private String kernalAutoFunctionCover;
	private String kernalRegressAutoCover;
	private String autoFunctionCover;
	private String autoCaseCover;
	private String kernalAutoFunction;

	// Constructors

	/** default constructor */
	public StatAutoCover() {
	}

	/** minimal constructor */
	public StatAutoCover(Integer statId) {
		this.statId = statId;
	}

	/** full constructor */
	public StatAutoCover(Integer statId, String reportMonth,
			String systemName, String functionPoint, String manualCase,
			String autoFunctionPoint, String autoCase,
			String unrealizableAutoCase, String unrealizedAutoCase,
			String kernalFunctionPoint, String kernalRegressCase,
			String kernalAutoCase, String kernalUnrealizableCase,
			String kernalUnrealizedCase, String kernalFunctionCover,
			String kernalAutoFunctionCover, String kernalRegressAutoCover,
			String autoFunctionCover, String autoCaseCover,
			String kernalAutoFunction) {
		this.statId = statId;
		this.reportMonth = reportMonth;
		this.systemName = systemName;
		this.functionPoint = functionPoint;
		this.manualCase = manualCase;
		this.autoFunctionPoint = autoFunctionPoint;
		this.autoCase = autoCase;
		this.unrealizableAutoCase = unrealizableAutoCase;
		this.unrealizedAutoCase = unrealizedAutoCase;
		this.kernalFunctionPoint = kernalFunctionPoint;
		this.kernalRegressCase = kernalRegressCase;
		this.kernalAutoCase = kernalAutoCase;
		this.kernalUnrealizableCase = kernalUnrealizableCase;
		this.kernalUnrealizedCase = kernalUnrealizedCase;
		this.kernalFunctionCover = kernalFunctionCover;
		this.kernalAutoFunctionCover = kernalAutoFunctionCover;
		this.kernalRegressAutoCover = kernalRegressAutoCover;
		this.autoFunctionCover = autoFunctionCover;
		this.autoCaseCover = autoCaseCover;
		this.kernalAutoFunction = kernalAutoFunction;
	}

	// Property accessors

	public Integer getStatId() {
		return this.statId;
	}

	public void setStatId(Integer statId) {
		this.statId = statId;
	}

	public String getReportMonth() {
		return this.reportMonth;
	}

	public void setReportMonth(String reportMonth) {
		this.reportMonth = reportMonth;
	}

	public String getSystemName() {
		return this.systemName;
	}

	public void setSystemName(String systemName) {
		this.systemName = systemName;
	}

	public String getFunctionPoint() {
		return this.functionPoint;
	}

	public void setFunctionPoint(String functionPoint) {
		this.functionPoint = functionPoint;
	}

	public String getManualCase() {
		return this.manualCase;
	}

	public void setManualCase(String manualCase) {
		this.manualCase = manualCase;
	}

	public String getAutoFunctionPoint() {
		return this.autoFunctionPoint;
	}

	public void setAutoFunctionPoint(String autoFunctionPoint) {
		this.autoFunctionPoint = autoFunctionPoint;
	}

	public String getAutoCase() {
		return this.autoCase;
	}

	public void setAutoCase(String autoCase) {
		this.autoCase = autoCase;
	}

	public String getUnrealizableAutoCase() {
		return this.unrealizableAutoCase;
	}

	public void setUnrealizableAutoCase(String unrealizableAutoCase) {
		this.unrealizableAutoCase = unrealizableAutoCase;
	}

	public String getUnrealizedAutoCase() {
		return this.unrealizedAutoCase;
	}

	public void setUnrealizedAutoCase(String unrealizedAutoCase) {
		this.unrealizedAutoCase = unrealizedAutoCase;
	}

	public String getKernalFunctionPoint() {
		return this.kernalFunctionPoint;
	}

	public void setKernalFunctionPoint(String kernalFunctionPoint) {
		this.kernalFunctionPoint = kernalFunctionPoint;
	}

	public String getKernalRegressCase() {
		return this.kernalRegressCase;
	}

	public void setKernalRegressCase(String kernalRegressCase) {
		this.kernalRegressCase = kernalRegressCase;
	}

	public String getKernalAutoCase() {
		return this.kernalAutoCase;
	}

	public void setKernalAutoCase(String kernalAutoCase) {
		this.kernalAutoCase = kernalAutoCase;
	}

	public String getKernalUnrealizableCase() {
		return this.kernalUnrealizableCase;
	}

	public void setKernalUnrealizableCase(String kernalUnrealizableCase) {
		this.kernalUnrealizableCase = kernalUnrealizableCase;
	}

	public String getKernalUnrealizedCase() {
		return this.kernalUnrealizedCase;
	}

	public void setKernalUnrealizedCase(String kernalUnrealizedCase) {
		this.kernalUnrealizedCase = kernalUnrealizedCase;
	}

	public String getKernalFunctionCover() {
		return this.kernalFunctionCover;
	}

	public void setKernalFunctionCover(String kernalFunctionCover) {
		this.kernalFunctionCover = kernalFunctionCover;
	}

	public String getKernalAutoFunctionCover() {
		return this.kernalAutoFunctionCover;
	}

	public void setKernalAutoFunctionCover(String kernalAutoFunctionCover) {
		this.kernalAutoFunctionCover = kernalAutoFunctionCover;
	}

	public String getKernalRegressAutoCover() {
		return this.kernalRegressAutoCover;
	}

	public void setKernalRegressAutoCover(String kernalRegressAutoCover) {
		this.kernalRegressAutoCover = kernalRegressAutoCover;
	}

	public String getAutoFunctionCover() {
		return this.autoFunctionCover;
	}

	public void setAutoFunctionCover(String autoFunctionCover) {
		this.autoFunctionCover = autoFunctionCover;
	}

	public String getAutoCaseCover() {
		return this.autoCaseCover;
	}

	public void setAutoCaseCover(String autoCaseCover) {
		this.autoCaseCover = autoCaseCover;
	}

	public String getKernalAutoFunction() {
		return this.kernalAutoFunction;
	}

	public void setKernalAutoFunction(String kernalAutoFunction) {
		this.kernalAutoFunction = kernalAutoFunction;
	}

}