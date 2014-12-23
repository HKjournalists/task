package com.asiainfo.aiga.r_collect_case.bo;

/**
 * AigaRCollectCase entity. @author MyEclipse Persistence Tools
 */

public class AigaRCollectCase implements java.io.Serializable
{

	// Fields    

	private Integer refId;

	private Integer collectId;

	private Integer caseId;

	private Integer ROrder;

	// Constructors

	/** default constructor */
	public AigaRCollectCase()
	{
	}

	/** full constructor */
	public AigaRCollectCase(Integer collectId, Integer caseId, Integer ROrder)
	{
		this.collectId = collectId;
		this.caseId = caseId;
		this.ROrder = ROrder;
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

	public Integer getCollectId()
	{
		return this.collectId;
	}

	public void setCollectId(Integer collectId)
	{
		this.collectId = collectId;
	}

	public Integer getCaseId()
	{
		return this.caseId;
	}

	public void setCaseId(Integer caseId)
	{
		this.caseId = caseId;
	}

	public Integer getROrder()
	{
		return this.ROrder;
	}

	public void setROrder(Integer ROrder)
	{
		this.ROrder = ROrder;
	}

}