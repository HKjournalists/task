package com.asiainfo.aiga.userCase.bo;

/**
 * AigaTestSubElem entity. @author MyEclipse Persistence Tools
 */

public class AigaTestSubElem implements java.io.Serializable {

	// Fields

	private Integer subElemId;
	private Integer elemId;
	private String elemValue;
	private String elemTestLogic;
	private String takeValueMethod;
	private String valueRemark;
	private Integer isDelete;

	// Constructors

	/** default constructor */
	public AigaTestSubElem() {
	}

	/** minimal constructor */
	public AigaTestSubElem(Integer subElemId) {
		this.subElemId = subElemId;
	}

	/** full constructor */
	public AigaTestSubElem(Integer subElemId, Integer elemId,
			String elemValue, String elemTestLogic, String takeValueMethod) {
		this.subElemId = subElemId;
		this.elemId = elemId;
		this.elemValue = elemValue;
		this.elemTestLogic = elemTestLogic;
		this.takeValueMethod = takeValueMethod;
	}

	// Property accessors

	public Integer getSubElemId() {
		return this.subElemId;
	}

	public void setSubElemId(Integer subElemId) {
		this.subElemId = subElemId;
	}

	public Integer getElemId() {
		return this.elemId;
	}

	public void setElemId(Integer elemId) {
		this.elemId = elemId;
	}

	public String getElemValue() {
		return this.elemValue;
	}

	public void setElemValue(String elemValue) {
		this.elemValue = elemValue;
	}

	public String getElemTestLogic() {
		return this.elemTestLogic;
	}

	public void setElemTestLogic(String elemTestLogic) {
		this.elemTestLogic = elemTestLogic;
	}

	public String getTakeValueMethod() {
		return this.takeValueMethod;
	}

	public void setTakeValueMethod(String takeValueMethod) {
		this.takeValueMethod = takeValueMethod;
	}

	public String getValueRemark() {
		return valueRemark;
	}

	public void setValueRemark(String valueRemark) {
		this.valueRemark = valueRemark;
	}

	public Integer getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}

}