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

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


@Entity
@Table(name="auto_keyword")
@JsonIgnoreProperties(value={"keyworddetails", "scripts", "submodule"})
public class AutoKeyword {

	@Id
	@GeneratedValue(generator = "prefixsequence_gen")  
	@GenericGenerator(name = "prefixsequence_gen", strategy = "com.lb.app.common.id.PrefixIDSequence",   
	     parameters = { @Parameter(name = "prefix", value = "KEY"),  
			@Parameter(name = "sequence", value = "auto_keyword$seq")}) 
	String keywordid;
	
	String keywordname;
	String version;
	
	@Transient
	String submodule_id;
	
	@ManyToOne(cascade={CascadeType.ALL}, fetch=FetchType.LAZY)
    @JoinColumn(name = "submoduleid")
	AutoSubModule submodule;
	
	@OneToMany(mappedBy = "keyword")
	Set<AutoKeywordDetail> keyworddetails = new HashSet<AutoKeywordDetail>();
	
	@OneToMany(mappedBy = "keyword")
	Set<AutoScriptDetail> scripts = new HashSet<AutoScriptDetail>();


	public Set<AutoKeywordDetail> getKeyworddetails() {
		return keyworddetails;
	}

	public void setKeyworddetails(Set<AutoKeywordDetail> keyworddetails) {
		this.keyworddetails = keyworddetails;
	}

	public String getKeywordid() {
		return keywordid;
	}

	public void setKeywordid(String keywordid) {
		this.keywordid = keywordid;
	}

	public String getKeywordname() {
		return keywordname;
	}

	public void setKeywordname(String keywordname) {
		this.keywordname = keywordname;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public AutoSubModule getSubmodule() {
		return submodule;
	}

	public void setSubmodule(AutoSubModule submodule) {
		this.submodule = submodule;
	}
	
	
	public String getSubmodule_id() {
		return submodule_id;
	}

	public void setSubmodule_id(String submoduleid) {
		this.submodule_id = submoduleid;
	}

	public Set<AutoScriptDetail> getScripts() {
		return scripts;
	}

	public void setScripts(Set<AutoScriptDetail> scripts) {
		this.scripts = scripts;
	}
}
