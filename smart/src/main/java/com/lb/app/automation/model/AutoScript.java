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
@Table(name="auto_script")
@JsonIgnoreProperties(value={"scriptdetails", "submodule"})
public class AutoScript {

	
	@Id
	@GeneratedValue(generator = "prefixsequence_gen")  
	@GenericGenerator(name = "prefixsequence_gen", strategy = "com.lb.app.common.id.PrefixIDSequence",   
	     parameters = { @Parameter(name = "prefix", value = "SCR"),  
			@Parameter(name = "sequence", value = "auto_script$seq")}) 
	String scriptid;
	String scriptname;
	
	@Transient
	String submoduleid;
	
	@ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH},fetch = FetchType.LAZY)
    @JoinColumn(name = "submoduleid")
	AutoSubModule submodule;
	
	
	@OneToMany(mappedBy = "script", cascade={CascadeType.ALL})
	Set<AutoScriptDetail> scriptdetails = new HashSet<AutoScriptDetail>();
	

	public Set<AutoScriptDetail> getScriptdetails() {
		return scriptdetails;
	}

	public void setScriptdetails(Set<AutoScriptDetail> scriptdetails) {
		this.scriptdetails = scriptdetails;
	}

	
	public String getScriptid() {
		return scriptid;
	}
	public void setScriptid(String scriptid) {
		this.scriptid = scriptid;
	}
	public String getScriptname() {
		return scriptname;
	}
	public void setScriptname(String scriptname) {
		this.scriptname = scriptname;
	}
	public AutoSubModule getSubmodule() {
		return submodule;
	}
	public void setSubmodule(AutoSubModule submodule) {
		this.submodule = submodule;
	}
	
	
	public String getSubmoduleid() {
		return submoduleid;
	}
	public void setSubmoduleid(String submoduleid) {
		this.submoduleid = submoduleid;
	}

}
