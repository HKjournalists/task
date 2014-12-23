package com.asiainfo.aiga.p2pTest.bo;


/**
 * AigaP2pSceneCollectRela entity. @author MyEclipse Persistence Tools
 */

public class AigaP2pSceneCollectRela implements java.io.Serializable {

	// Fields

	private String relaId;
	private Integer sceneId;
	private Integer collectId;
	private Integer collectIndex;

	// Constructors

	/** default constructor */
	public AigaP2pSceneCollectRela() {
	}

	/** minimal constructor */
	public AigaP2pSceneCollectRela(String relaId) {
		this.relaId = relaId;
	}

	/** full constructor */
	public AigaP2pSceneCollectRela(String relaId, Integer sceneId,
			Integer collectId, Integer collectIndex) {
		this.relaId = relaId;
		this.sceneId = sceneId;
		this.collectId = collectId;
		this.collectIndex = collectIndex;
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

	public Integer getCollectId() {
		return this.collectId;
	}

	public void setCollectId(Integer collectId) {
		this.collectId = collectId;
	}

	public Integer getCollectIndex() {
		return this.collectIndex;
	}

	public void setCollectIndex(Integer collectIndex) {
		this.collectIndex = collectIndex;
	}

}