package com.asiainfo.aiga.p2pTest.bo;


/**
 * AigaP2pSceneSubTaskRela entity. @author MyEclipse Persistence Tools
 */

public class AigaP2pSceneSubTaskRela implements java.io.Serializable {

	// Fields

	private String relaId;
	private Integer sceneId;
	private Integer subTaskId;
	private String remarks;

	// Constructors

	/** default constructor */
	public AigaP2pSceneSubTaskRela() {
	}

	/** minimal constructor */
	public AigaP2pSceneSubTaskRela(String relaId) {
		this.relaId = relaId;
	}

	/** full constructor */
	public AigaP2pSceneSubTaskRela(String relaId, Integer sceneId,
			Integer subTaskId, String remarks) {
		this.relaId = relaId;
		this.sceneId = sceneId;
		this.subTaskId = subTaskId;
		this.remarks = remarks;
	}

	// Property accessors

	public String getRelaId() {
		return this.relaId;
	}

	public void setRelaId(String relaId) {
		this.relaId = relaId;
	}

	public Integer getSceneId() {
		return this.sceneId;
	}

	public void setSceneId(Integer sceneId) {
		this.sceneId = sceneId;
	}

	public Integer getSubTaskId() {
		return this.subTaskId;
	}

	public void setSubTaskId(Integer subTaskId) {
		this.subTaskId = subTaskId;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

}