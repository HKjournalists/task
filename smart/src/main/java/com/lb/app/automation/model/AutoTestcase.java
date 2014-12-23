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
@Table(name="auto_testcase")
@JsonIgnoreProperties(value={"script", "testcasedetails"})
public class AutoTestcase {
	@Id
	@GeneratedValue(generator = "prefixsequence_gen")  
	@GenericGenerator(name = "prefixsequence_gen", strategy = "com.lb.app.common.id.PrefixIDSequence",   
	     parameters = {@Parameter(name = "prefix", value = "CAE"),  
			@Parameter(name = "sequence", value = "auto_testcase$seq")}) 
	String testcaseid;

	
	@Transient
	String scriptid;
	
	String testcasename;
	String testcaselevel;
	String expectedresult;
	

	@ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH},fetch = FetchType.LAZY)
    @JoinColumn(name = "scriptid")
	AutoScript script;
	
	
	@OneToMany(mappedBy = "testcase", cascade = {CascadeType.ALL})
	Set<AutoTestcaseDetail> testcasedetails = new HashSet<AutoTestcaseDetail>();


	public Set<AutoTestcaseDetail> getTestcasedetails() {
		return testcasedetails;
	}


	public void setTestcasedetails(Set<AutoTestcaseDetail> testcasedetails) {
		this.testcasedetails = testcasedetails;
	}


	public String getTestcaseid() {
		return testcaseid;
	}


	public void setTestcaseid(String testcaseid) {
		this.testcaseid = testcaseid;
	}


	public String getScriptid() {
		return scriptid;
	}


	public void setScriptid(String scriptid) {
		this.scriptid = scriptid;
	}


	public String getTestcasename() {
		return testcasename;
	}


	public void setTestcasename(String testcasename) {
		this.testcasename = testcasename;
	}


	public String getTestcaselevel() {
		return testcaselevel;
	}


	public void setTestcaselevel(String testcaselevel) {
		this.testcaselevel = testcaselevel;
	}


	public String getExpectedresult() {
		return expectedresult;
	}


	public void setExpectedresult(String expectedresult) {
		this.expectedresult = expectedresult;
	}


	public AutoScript getScript() {
		return script;
	}


	public void setScript(AutoScript script) {
		this.script = script;
	}
	
	
}