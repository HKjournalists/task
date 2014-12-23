package com.lb.app.automation.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name="auto_module")
@JsonIgnoreProperties(value={"submodules"})
public class AutoModule {
	@Id
	@GeneratedValue(generator = "prefixsequence_gen")  
	@GenericGenerator(name = "prefixsequence_gen", strategy = "com.lb.app.common.id.PrefixIDSequence",   
	     parameters = { @Parameter(name = "prefix", value = "MOD"),  
			@Parameter(name = "sequence", value = "auto_module$seq")}) 
	String moduleid;

	String modulename;
	
	//@OneToMany(cascade={CascadeType.REFRESH,CascadeType.PERSIST,CascadeType.REMOVE,CascadeType.MERGE},fetch=FetchType.LAZY)
	//@OneToMany(mappedBy = "module")
	@OneToMany(mappedBy = "module")
	Set<AutoSubModule> submodules = new HashSet<AutoSubModule>();
	
	public String getModuleid() {
		return moduleid;
	}
	public void setModuleid(String moduleid) {
		this.moduleid = moduleid;
	}
	public String getModulename() {
		return modulename;
	}
	public void setModulename(String modulename) {
		this.modulename = modulename;
	}
	public Set<AutoSubModule> getSubmodules() {
		return submodules;
	}
	public void setSubmodules(Set<AutoSubModule> submodules) {
		this.submodules = submodules;
	}
}
