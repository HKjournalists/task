package com.lb.app.automation.model;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


@Entity
@Table(name = "auto_batchdetail")
@JsonIgnoreProperties(value={"script", "batch"})
public class AutoBatchDetail {

	@Id
	@GeneratedValue(generator = "prefixsequence_gen")  
	@GenericGenerator(name = "prefixsequence_gen", strategy = "com.lb.app.common.id.PrefixIDSequence",   
	     parameters = { @Parameter(name = "prefix", value = "bad"),  
			@Parameter(name = "sequence", value = "auto_batchdetail$seq")}) 
	String batchdetailid;
	
	@Transient
	String scriptid;
	
	@Transient
	String batchid;
	

	@ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE},fetch=FetchType.LAZY)
    @JoinColumn(name = "scriptid")
	AutoScript script;
	
	@ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE},fetch=FetchType.LAZY)
	@JoinColumn(name = "batchid")
	AutoBatch batch;
	
	String submodulename;
	
	String scriptname;
	
	String modulename;

	public String getBatchdetailid() {
		return batchdetailid;
	}

	public void setBatchdetailid(String batchdetailid) {
		this.batchdetailid = batchdetailid;
	}

	public String getScriptid() {
		return scriptid;
	}

	public void setScriptid(String scriptid) {
		this.scriptid = scriptid;
	}

	public String getBatchid() {
		return batchid;
	}

	public void setBatchid(String batchid) {
		this.batchid = batchid;
	}

	public AutoScript getScript() {
		return script;
	}

	public void setScript(AutoScript script) {
		this.script = script;
	}

	public AutoBatch getBatch() {
		return batch;
	}

	public void setBatch(AutoBatch batch) {
		this.batch = batch;
	}

	public String getSubmodulename() {
		return submodulename;
	}

	public void setSubmodulename(String submodulename) {
		this.submodulename = submodulename;
	}

	public String getScriptname() {
		return scriptname;
	}

	public void setScriptname(String scriptname) {
		this.scriptname = scriptname;
	}

	public String getModulename() {
		return modulename;
	}

	public void setModulename(String modulename) {
		this.modulename = modulename;
	}
	
	
	
	
	
	
}