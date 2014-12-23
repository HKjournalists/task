package com.asiainfo.aiga.component.bo.extend;

import com.asiainfo.aiga.component.bo.AigaComponent;

public class AigaInstComponent extends AigaComponent {
	private Integer baseCompId;
	private String approvalName;
	private String approvalPsn;

	public String getApprovalName() {
		return approvalName;
	}

	public void setApprovalName(String approvalName) {
		this.approvalName = approvalName;
	}
	
	public String getApprovalPsn() {
		return approvalPsn;
	}

	public void setApprovalPsn(String approvalPsn) {
		this.approvalPsn = approvalPsn;
	}
	
	public Integer getBaseCompId() {
		return baseCompId;
	}

	public void setBaseCompId(Integer baseCompId) {
		this.baseCompId = baseCompId;
	}
	
}
