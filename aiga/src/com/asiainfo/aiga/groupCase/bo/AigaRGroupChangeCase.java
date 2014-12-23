package com.asiainfo.aiga.groupCase.bo;
// default package

import java.math.BigDecimal;


/**
 * AigaRGroupChangeCase entity. @author MyEclipse Persistence Tools
 */

public class AigaRGroupChangeCase  implements java.io.Serializable {


    // Fields    

     private Integer relaId;
     private Integer caseId;
     private Integer changeId;


    // Constructors

    /** default constructor */
    public AigaRGroupChangeCase() {
    }

    
    /** full constructor */
    public AigaRGroupChangeCase(Integer caseId, Integer changeId) {
        this.caseId = caseId;
        this.changeId = changeId;
    }

   
    // Property accessors

    public Integer getRelaId() {
        return this.relaId;
    }
    
    public void setRelaId(Integer relaId) {
        this.relaId = relaId;
    }

    public Integer getCaseId() {
        return this.caseId;
    }
    
    public void setCaseId(Integer caseId) {
        this.caseId = caseId;
    }

    public Integer getChangeId() {
        return this.changeId;
    }
    
    public void setChangeId(Integer changeId) {
        this.changeId = changeId;
    }
   








}