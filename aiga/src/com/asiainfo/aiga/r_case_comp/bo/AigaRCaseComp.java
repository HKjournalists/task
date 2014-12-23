package com.asiainfo.aiga.r_case_comp.bo;

/**
 * AigaRCaseComp entity. @author MyEclipse Persistence Tools
 */

public class AigaRCaseComp implements java.io.Serializable
{

	// Fields    

	private Integer refId;

	private Integer caseId;

	private Integer compId;

	private Integer ROrder;

	private String inVal;

	private String outVal;

	private String expectVal;

	private String hinge;

	private String remark;
	
	private String refDesc;
	
	private String arguName;
	
	private Integer manualTaskId;

	// Constructors

	/** default constructor */
	public AigaRCaseComp()
	{
	}

	/** minimal constructor */
	public AigaRCaseComp(Integer caseId, Integer compId, Integer ROrder)
	{
		this.caseId = caseId;
		this.compId = compId;
		this.ROrder = ROrder;
	}

	/** full constructor */
	public AigaRCaseComp(Integer caseId, Integer compId, Integer ROrder, String inVal, String outVal, String expectVal, String hinge, String remark,String arguName,Integer manualTaskId)
	{
		this.caseId = caseId;
		this.compId = compId;
		this.ROrder = ROrder;
		this.inVal = inVal;
		this.outVal = outVal;
		this.expectVal = expectVal;
		this.hinge = hinge;
		this.remark = remark;
		this.arguName=arguName;
		this.manualTaskId = manualTaskId;
	}

	// Property accessors

	public Integer getRefId()
	{
		return this.refId;
	}

	public void setRefId(Integer refId)
	{
		this.refId = refId;
	}

	public Integer getCaseId()
	{
		return this.caseId;
	}

	public void setCaseId(Integer caseId)
	{
		this.caseId = caseId;
	}

	public Integer getCompId()
	{
		return this.compId;
	}

	public void setCompId(Integer compId)
	{
		this.compId = compId;
	}

	public Integer getROrder()
	{
		return this.ROrder;
	}

	public void setROrder(Integer ROrder)
	{
		this.ROrder = ROrder;
	}

	public String getInVal()
	{
		return this.inVal;
	}

	public void setInVal(String inVal)
	{
		this.inVal = inVal;
	}

	public String getOutVal()
	{
		return this.outVal;
	}

	public void setOutVal(String outVal)
	{
		this.outVal = outVal;
	}

	public String getExpectVal()
	{
		return this.expectVal;
	}

	public void setExpectVal(String expectVal)
	{
		this.expectVal = expectVal;
	}

	public String getHinge()
	{
		return this.hinge;
	}

	public void setHinge(String hinge)
	{
		this.hinge = hinge;
	}

	public String getRemark()
	{
		return this.remark;
	}

	public void setRemark(String remark)
	{
		this.remark = remark;
	}

	public String getRefDesc() {
		return refDesc;
	}

	public void setRefDesc(String refDesc) {
		this.refDesc = refDesc;
	}

	public String getArguName() {
		return arguName;
	}

	public void setArguName(String arguName) {
		this.arguName = arguName;
	}

	public Integer getManualTaskId() {
		return manualTaskId;
	}

	public void setManualTaskId(Integer manualTaskId) {
		this.manualTaskId = manualTaskId;
	}

}