package com.asiainfo.aiga.common.client.bo;

import java.lang.Integer;

/**
 * AigaClientConfig entity. @author MyEclipse Persistence Tools
 */

public class AigaClientConfig implements java.io.Serializable {

	// Fields

	private Integer confId;
	private String nickName;
	private String ip;
	private String pathMap;
	private Integer status;
	private String uuid;
	private String port;

	// Constructors

	/** default constructor */
	public AigaClientConfig() {
	}

	/** minimal constructor */
	public AigaClientConfig(Integer confId) {
		this.confId = confId;
	}

	/** full constructor */
	public AigaClientConfig(Integer confId, String nickName, String ip,
			String pathMap, Integer status, String uuid) {
		this.confId = confId;
		this.nickName = nickName;
		this.ip = ip;
		this.pathMap = pathMap;
		this.status = status;
		this.uuid = uuid;
	}

	// Property accessors

	public Integer getConfId() {
		return this.confId;
	}

	public void setConfId(Integer confId) {
		this.confId = confId;
	}

	public String getNickName() {
		return this.nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getIp() {
		return this.ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getPathMap() {
		return this.pathMap;
	}

	public void setPathMap(String pathMap) {
		this.pathMap = pathMap;
	}

	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getUuid() {
		return this.uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}

}