package com.asiainfo.aiga.r_case_comp.bo.extend;

import com.asiainfo.aiga.r_case_comp.bo.AigaRCaseComp;

public class AigaInstRCaseComp extends AigaRCaseComp{

	private Integer baseRefId;

	public AigaInstRCaseComp(Integer caseId, int parseInt, int i, String inVal,
			String outVal, String expectVal, String string, String expectVal2,String arguName,Integer manualTaskId) {
		// TODO Auto-generated constructor stub
		super(caseId,parseInt,i,inVal,outVal,expectVal,string,expectVal2,arguName,manualTaskId);
	}
	
	public AigaInstRCaseComp(){}

	public Integer getBaseRefId() {
		return baseRefId;
	}

	public void setBaseRefId(Integer baseRefId) {
		this.baseRefId = baseRefId;
	}
	
}
