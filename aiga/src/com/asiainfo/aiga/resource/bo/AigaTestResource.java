package com.asiainfo.aiga.resource.bo;

/**
 * AigaTestResource entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class AigaTestResource implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer subTaskId;
	private Integer resourceType;
	private String resourceDesc;
	private String resourceTypeShow;

	// Constructors

	/** default constructor */
	public AigaTestResource() {
	}

	/** full constructor */
	public AigaTestResource(Integer subTaskId, String resourceDesc) {
		this.subTaskId = subTaskId;
		this.resourceDesc = resourceDesc;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public String getResourceTypeShow() {
		return resourceTypeShow;
	}

	public void setResourceTypeShow(String resourceTypeShow) {
		this.resourceTypeShow = resourceTypeShow;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getSubTaskId() {
		return this.subTaskId;
	}

	public void setSubTaskId(Integer subTaskId) {
		this.subTaskId = subTaskId;
	}

	public String getResourceDesc() {
		return this.resourceDesc;
	}

	public void setResourceDesc(String resourceDesc) {
		this.resourceDesc = resourceDesc;
	}

	public Integer getResourceType() {
		return resourceType;
	}

	public void setResourceType(Integer resourceType) {
		this.resourceType = resourceType;
	}

}