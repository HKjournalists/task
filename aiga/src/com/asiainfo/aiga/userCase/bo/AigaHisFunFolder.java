package com.asiainfo.aiga.userCase.bo;
// default package

import java.sql.Timestamp;


/**
 * AigaFunFolder entity. @author MyEclipse Persistence Tools
 */

public class AigaHisFunFolder implements java.io.Serializable {


    // Fields    
	 private java.lang.Integer hisFunId;
     private java.lang.Integer funId;
     private String sysName;
     private Timestamp createTime;
     private Timestamp updateTime;
     private Integer sysId;
     private String busiLabel;
     private String baseFunLabel;
     private String dataCheckScript;
     private Short importantClass;
     private String menuPath;
     private Short funType;
     private String funDesc;
     private Short isInvalid;
     private Short efficiencyTestType;
     private Short isEfficiencyTest;
     private Short devFirm;
     private String sysIdTemp;
     private String subSysIdTemp;
     private Integer subSysId;
     private Integer operatorId;
     private String operatorName;


    // Constructors

    /** default constructor */
    public AigaHisFunFolder() {
    }

    
    /** full constructor */
    public AigaHisFunFolder(Integer funId,String sysName, Timestamp createTime, Timestamp updateTime, Integer sysId, String busiLabel, String baseFunLabel, String dataCheckScript, Short importantClass, String menuPath, Short funType, String funDesc, Short isInvalid,Short efficiencyTestType,Short isEfficiencyTest,Short devFirm) {
        this.funId = funId;
    	this.sysName = sysName;
        this.createTime = createTime;
        this.updateTime = updateTime;
        this.sysId = sysId;
        this.busiLabel = busiLabel;
        this.baseFunLabel = baseFunLabel;
        this.dataCheckScript = dataCheckScript;
        this.importantClass = importantClass;
        this.menuPath = menuPath;
        this.funType = funType;
        this.funDesc = funDesc;
        this.isInvalid = isInvalid;
        this.efficiencyTestType = efficiencyTestType;
        this.isEfficiencyTest = isEfficiencyTest;
        this.devFirm = devFirm;
    }

   
    // Property accessors

    public java.lang.Integer getFunId() {
        return this.funId;
    }
    
    
    public java.lang.Integer getHisFunId() {
		return hisFunId;
	}


	public void setHisFunId(java.lang.Integer hisFunId) {
		this.hisFunId = hisFunId;
	}


	public String getSubSysIdTemp() {
		return subSysIdTemp;
	}


	public void setSubSysIdTemp(String subSysIdTemp) {
		this.subSysIdTemp = subSysIdTemp;
	}


	public String getSysIdTemp() {
		return sysIdTemp;
	}


	public void setSysIdTemp(String sysIdTemp) {
		this.sysIdTemp = sysIdTemp;
	}


	public void setFunId(java.lang.Integer funId) {
        this.funId = funId;
    }

    public String getSysName() {
        return this.sysName;
    }
    
    public void setSysName(String sysName) {
        this.sysName = sysName;
    }

    public Timestamp getCreateTime() {
        return this.createTime;
    }
    
    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public Timestamp getUpdateTime() {
        return this.updateTime;
    }
    
    public void setUpdateTime(Timestamp updateTime) {
        this.updateTime = updateTime;
    }

    public Integer getSysId() {
        return this.sysId;
    }
    
    public void setSysId(Integer sysId) {
        this.sysId = sysId;
    }

    public String getBusiLabel() {
        return this.busiLabel;
    }
    
    public void setBusiLabel(String busiLabel) {
        this.busiLabel = busiLabel;
    }

    public String getBaseFunLabel() {
        return this.baseFunLabel;
    }
    
    public void setBaseFunLabel(String baseFunLabel) {
        this.baseFunLabel = baseFunLabel;
    }

    public String getDataCheckScript() {
        return this.dataCheckScript;
    }
    
    public void setDataCheckScript(String dataCheckScript) {
        this.dataCheckScript = dataCheckScript;
    }

    public Short getImportantClass() {
        return this.importantClass;
    }
    
    public void setImportantClass(Short importantClass) {
        this.importantClass = importantClass;
    }

    public String getMenuPath() {
        return this.menuPath;
    }
    
    public void setMenuPath(String menuPath) {
        this.menuPath = menuPath;
    }

    public Short getFunType() {
        return this.funType;
    }
    
    public void setFunType(Short funType) {
        this.funType = funType;
    }

    public String getFunDesc() {
        return this.funDesc;
    }
    
    public void setFunDesc(String funDesc) {
        this.funDesc = funDesc;
    }

    public Short getIsInvalid() {
        return this.isInvalid;
    }
    
    public void setIsInvalid(Short isInvalid) {
        this.isInvalid = isInvalid;
    }


	public Short getEfficiencyTestType() {
		return efficiencyTestType;
	}


	public void setEfficiencyTestType(Short efficiencyTestType) {
		this.efficiencyTestType = efficiencyTestType;
	}


	public Short getIsEfficiencyTest() {
		return isEfficiencyTest;
	}


	public void setIsEfficiencyTest(Short isEfficiencyTest) {
		this.isEfficiencyTest = isEfficiencyTest;
	}


	public Short getDevFirm() {
		return devFirm;
	}


	public void setDevFirm(Short devFirm) {
		this.devFirm = devFirm;
	}


	public Integer getSubSysId() {
		return subSysId;
	}


	public void setSubSysId(Integer subSysId) {
		this.subSysId = subSysId;
	}


	public Integer getOperatorId() {
		return operatorId;
	}


	public void setOperatorId(Integer operatorId) {
		this.operatorId = operatorId;
	}


	public String getOperatorName() {
		return operatorName;
	}


	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}
   
	







}