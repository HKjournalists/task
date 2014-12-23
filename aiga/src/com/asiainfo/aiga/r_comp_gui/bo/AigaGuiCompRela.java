package com.asiainfo.aiga.r_comp_gui.bo;


/**
 * AigaGuiCompRela entity. @author MyEclipse Persistence Tools
 */

public class AigaGuiCompRela implements java.io.Serializable {

	// Fields

	private Integer relaId;
	private Integer compId;
	private Integer guiId;
	private Integer guiOrder;

	// Constructors

	/** default constructor */
	public AigaGuiCompRela() {
	}

	/** minimal constructor */
	public AigaGuiCompRela(Integer relaId) {
		this.relaId = relaId;
	}

	/** full constructor */
	public AigaGuiCompRela(Integer relaId, Integer compId,
			Integer guiId, Integer guiOrder) {
		this.relaId = relaId;
		this.compId = compId;
		this.guiId = guiId;
		this.guiOrder = guiOrder;
	}

	// Property accessors

	public Integer getRelaId() {
		return this.relaId;
	}

	public void setRelaId(Integer relaId) {
		this.relaId = relaId;
	}

	public Integer getCompId() {
		return this.compId;
	}

	public void setCompId(Integer compId) {
		this.compId = compId;
	}

	public Integer getGuiId() {
		return this.guiId;
	}

	public void setGuiId(Integer guiId) {
		this.guiId = guiId;
	}

	public Integer getGuiOrder() {
		return this.guiOrder;
	}

	public void setGuiOrder(Integer guiOrder) {
		this.guiOrder = guiOrder;
	}

}