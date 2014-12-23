package com.asiainfo.aiga.requisition.bo;

public class AigaAudit {
	
	private Integer auditId;
	
	private Integer auditType;
	
	private String auditCount;
	
	private String auditRate;
	
	private Integer subTaskId;
	
	private Integer checkStatus;

	public Integer getcheckStatus() {
		return checkStatus;
	}

	public void setcheckStatus(Integer checkStatus) {
		this.checkStatus = checkStatus;
	}

	public Integer getSubTaskId() {
		return subTaskId;
	}

	public void setSubTaskId(Integer subTaskId) {
		this.subTaskId = subTaskId;
	}

	public Integer getAuditId() {
		return auditId;
	}

	public void setAuditId(Integer auditId) {
		this.auditId = auditId;
	}

	public Integer getAuditType() {
		return auditType;
	}

	public void setAuditType(Integer auditType) {
		this.auditType = auditType;
	}

	public String getAuditCount() {
		return auditCount;
	}

	public void setAuditCount(String auditCount) {
		this.auditCount = auditCount;
	}

	public String getAuditRate() {
		return auditRate;
	}

	public void setAuditRate(String auditRate) {
		this.auditRate = auditRate;
	}

}
