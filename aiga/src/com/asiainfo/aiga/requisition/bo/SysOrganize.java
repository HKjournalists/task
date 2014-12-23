package com.asiainfo.aiga.requisition.bo;

import java.sql.Timestamp;

/**
 * SysOrganize entity. @author MyEclipse Persistence Tools
 */

public class SysOrganize implements java.io.Serializable {

	// Fields

	private Long organizeId;
	private Long parentOrganizeId;
	private String organizeName;
	private String code;
	private Integer orgRoleTypeId;
	private String districtId;
	private String shortName;
	private String englishName;
	private Integer memberNum;
	private String managerName;
	private String email;
	private String phoneId;
	private String faxId;
	private String orgAddress;
	private String contactName;
	private Byte contactCardType;
	private String contactCardId;
	private String contactBillId;
	private Integer postcode;
	private Long postProvince;
	private Long postCity;
	private String postAddress;
	private Integer postPostcod;
	private String notes;
	private Byte state;
	private Long doneCode;
	private Timestamp createDate;
	private Timestamp doneDate;
	private Timestamp validDate;
	private Timestamp expireDate;
	private Long opId;
	private Long orgId;
	private String oldCode;
	private String oldParentCode;
	private Long countyId;
	private String ext1;
	private String ext2;
	private String ext3;
	private String isLeaf;

	// Constructors

	/** default constructor */
	public SysOrganize() {
	}

	/** minimal constructor */
	public SysOrganize(Long organizeId, String organizeName) {
		this.organizeId = organizeId;
		this.organizeName = organizeName;
	}

	/** full constructor */
	public SysOrganize(Long organizeId, Long parentOrganizeId,
			String organizeName, String code, Integer orgRoleTypeId,
			String districtId, String shortName, String englishName,
			Integer memberNum, String managerName, String email,
			String phoneId, String faxId, String orgAddress,
			String contactName, Byte contactCardType, String contactCardId,
			String contactBillId, Integer postcode, Long postProvince,
			Long postCity, String postAddress, Integer postPostcod,
			String notes, Byte state, Long doneCode, Timestamp createDate,
			Timestamp doneDate, Timestamp validDate, Timestamp expireDate,
			Long opId, Long orgId, String oldCode, String oldParentCode,
			Long countyId, String ext1, String ext2, String ext3, String isLeaf) {
		this.organizeId = organizeId;
		this.parentOrganizeId = parentOrganizeId;
		this.organizeName = organizeName;
		this.code = code;
		this.orgRoleTypeId = orgRoleTypeId;
		this.districtId = districtId;
		this.shortName = shortName;
		this.englishName = englishName;
		this.memberNum = memberNum;
		this.managerName = managerName;
		this.email = email;
		this.phoneId = phoneId;
		this.faxId = faxId;
		this.orgAddress = orgAddress;
		this.contactName = contactName;
		this.contactCardType = contactCardType;
		this.contactCardId = contactCardId;
		this.contactBillId = contactBillId;
		this.postcode = postcode;
		this.postProvince = postProvince;
		this.postCity = postCity;
		this.postAddress = postAddress;
		this.postPostcod = postPostcod;
		this.notes = notes;
		this.state = state;
		this.doneCode = doneCode;
		this.createDate = createDate;
		this.doneDate = doneDate;
		this.validDate = validDate;
		this.expireDate = expireDate;
		this.opId = opId;
		this.orgId = orgId;
		this.oldCode = oldCode;
		this.oldParentCode = oldParentCode;
		this.countyId = countyId;
		this.ext1 = ext1;
		this.ext2 = ext2;
		this.ext3 = ext3;
		this.isLeaf = isLeaf;
	}

	// Property accessors

	public Long getOrganizeId() {
		return this.organizeId;
	}

	public void setOrganizeId(Long organizeId) {
		this.organizeId = organizeId;
	}

	public Long getParentOrganizeId() {
		return this.parentOrganizeId;
	}

	public void setParentOrganizeId(Long parentOrganizeId) {
		this.parentOrganizeId = parentOrganizeId;
	}

	public String getOrganizeName() {
		return this.organizeName;
	}

	public void setOrganizeName(String organizeName) {
		this.organizeName = organizeName;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Integer getOrgRoleTypeId() {
		return this.orgRoleTypeId;
	}

	public void setOrgRoleTypeId(Integer orgRoleTypeId) {
		this.orgRoleTypeId = orgRoleTypeId;
	}

	public String getDistrictId() {
		return this.districtId;
	}

	public void setDistrictId(String districtId) {
		this.districtId = districtId;
	}

	public String getShortName() {
		return this.shortName;
	}

	public void setShortName(String shortName) {
		this.shortName = shortName;
	}

	public String getEnglishName() {
		return this.englishName;
	}

	public void setEnglishName(String englishName) {
		this.englishName = englishName;
	}

	public Integer getMemberNum() {
		return this.memberNum;
	}

	public void setMemberNum(Integer memberNum) {
		this.memberNum = memberNum;
	}

	public String getManagerName() {
		return this.managerName;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoneId() {
		return this.phoneId;
	}

	public void setPhoneId(String phoneId) {
		this.phoneId = phoneId;
	}

	public String getFaxId() {
		return this.faxId;
	}

	public void setFaxId(String faxId) {
		this.faxId = faxId;
	}

	public String getOrgAddress() {
		return this.orgAddress;
	}

	public void setOrgAddress(String orgAddress) {
		this.orgAddress = orgAddress;
	}

	public String getContactName() {
		return this.contactName;
	}

	public void setContactName(String contactName) {
		this.contactName = contactName;
	}

	public Byte getContactCardType() {
		return this.contactCardType;
	}

	public void setContactCardType(Byte contactCardType) {
		this.contactCardType = contactCardType;
	}

	public String getContactCardId() {
		return this.contactCardId;
	}

	public void setContactCardId(String contactCardId) {
		this.contactCardId = contactCardId;
	}

	public String getContactBillId() {
		return this.contactBillId;
	}

	public void setContactBillId(String contactBillId) {
		this.contactBillId = contactBillId;
	}

	public Integer getPostcode() {
		return this.postcode;
	}

	public void setPostcode(Integer postcode) {
		this.postcode = postcode;
	}

	public Long getPostProvince() {
		return this.postProvince;
	}

	public void setPostProvince(Long postProvince) {
		this.postProvince = postProvince;
	}

	public Long getPostCity() {
		return this.postCity;
	}

	public void setPostCity(Long postCity) {
		this.postCity = postCity;
	}

	public String getPostAddress() {
		return this.postAddress;
	}

	public void setPostAddress(String postAddress) {
		this.postAddress = postAddress;
	}

	public Integer getPostPostcod() {
		return this.postPostcod;
	}

	public void setPostPostcod(Integer postPostcod) {
		this.postPostcod = postPostcod;
	}

	public String getNotes() {
		return this.notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public Byte getState() {
		return this.state;
	}

	public void setState(Byte state) {
		this.state = state;
	}

	public Long getDoneCode() {
		return this.doneCode;
	}

	public void setDoneCode(Long doneCode) {
		this.doneCode = doneCode;
	}

	public Timestamp getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}

	public Timestamp getDoneDate() {
		return this.doneDate;
	}

	public void setDoneDate(Timestamp doneDate) {
		this.doneDate = doneDate;
	}

	public Timestamp getValidDate() {
		return this.validDate;
	}

	public void setValidDate(Timestamp validDate) {
		this.validDate = validDate;
	}

	public Timestamp getExpireDate() {
		return this.expireDate;
	}

	public void setExpireDate(Timestamp expireDate) {
		this.expireDate = expireDate;
	}

	public Long getOpId() {
		return this.opId;
	}

	public void setOpId(Long opId) {
		this.opId = opId;
	}

	public Long getOrgId() {
		return this.orgId;
	}

	public void setOrgId(Long orgId) {
		this.orgId = orgId;
	}

	public String getOldCode() {
		return this.oldCode;
	}

	public void setOldCode(String oldCode) {
		this.oldCode = oldCode;
	}

	public String getOldParentCode() {
		return this.oldParentCode;
	}

	public void setOldParentCode(String oldParentCode) {
		this.oldParentCode = oldParentCode;
	}

	public Long getCountyId() {
		return this.countyId;
	}

	public void setCountyId(Long countyId) {
		this.countyId = countyId;
	}

	public String getExt1() {
		return this.ext1;
	}

	public void setExt1(String ext1) {
		this.ext1 = ext1;
	}

	public String getExt2() {
		return this.ext2;
	}

	public void setExt2(String ext2) {
		this.ext2 = ext2;
	}

	public String getExt3() {
		return this.ext3;
	}

	public void setExt3(String ext3) {
		this.ext3 = ext3;
	}

	public String getIsLeaf() {
		return this.isLeaf;
	}

	public void setIsLeaf(String isLeaf) {
		this.isLeaf = isLeaf;
	}

}