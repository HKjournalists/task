package com.lb.app.automation.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name="auto_scriptdetail")
@JsonIgnoreProperties(value = {"keyword"})
public class AutoScriptDetail {

	@Id
	@GeneratedValue(generator = "prefixsequence_gen")  
	@GenericGenerator(name = "prefixsequence_gen", strategy = "com.lb.app.common.id.PrefixIDSequence",   
	     parameters = {@Parameter(name = "prefix", value = "SCD"),  
			@Parameter(name = "sequence", value = "auto_scriptdetail$seq")}) 
	String scriptdetailid;
	
	@Transient
	String scriptid;
	
	String keywordsubmoduleid;
	
	@Transient
	String keywordid;
	
	String version;
	
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "keywordid")
	AutoKeyword keyword;
	
	@ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH},fetch = FetchType.LAZY)
    @JoinColumn(name = "scriptid")
	AutoScript script;

	public String getScriptdetailid() {
		return scriptdetailid;
	}

	public void setScriptdetailid(String scriptdetailid) {
		this.scriptdetailid = scriptdetailid;
	}

	public String getScriptid() {
		return scriptid;
	}

	public void setScriptid(String scriptid) {
		this.scriptid = scriptid;
	}

	public String getKeywordsubmoduleid() {
		return keywordsubmoduleid;
	}

	public void setKeywordsubmoduleid(String keywordsubmoduleid) {
		this.keywordsubmoduleid = keywordsubmoduleid;
	}

	public String getKeywordid() {
		return keywordid;
	}

	public void setKeywordid(String keywordid) {
		this.keywordid = keywordid;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public AutoKeyword getKeyword() {
		return keyword;
	}

	public void setKeyword(AutoKeyword keyword) {
		this.keyword = keyword;
	}

	public AutoScript getScript() {
		return script;
	}

	public void setScript(AutoScript script) {
		this.script = script;
	}
	
	

}