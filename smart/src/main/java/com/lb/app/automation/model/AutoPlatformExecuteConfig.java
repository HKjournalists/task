package com.lb.app.automation.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;


@Entity
@Table(name = "auto_platformexecuteconfig")
public class AutoPlatformExecuteConfig {
	@Id
	@GeneratedValue(generator = "prefixsequence_gen")  
	@GenericGenerator(name = "prefixsequence_gen", strategy = "com.lb.app.common.id.PrefixIDSequence",   
	     parameters = { @Parameter(name = "prefix", value = "pfe"),  
			@Parameter(name = "sequence", value = "AUTO_PLATFORMEXECUTECONFIG$SEQ")}) 
	String configid;
	
	String batchid;
	String execstarttime;
	String execendtime;
	
	String ruleversion;
	String keywordversion;
	String scriptversion;
	String testcaseversion;
	
	String testcaselevel;
	
	public String getTestcaselevel() {
		return testcaselevel;
	}
	public void setTestcaselevel(String testcaselevel) {
		this.testcaselevel = testcaselevel;
	}
	String execmode;
	String loglevel;
	String runstatus;
	String platformid;
	
	public String getConfigid() {
		return configid;
	}
	public void setConfigid(String configid) {
		this.configid = configid;
	}
	public String getBatchid() {
		return batchid;
	}
	public void setBatchid(String batchid) {
		this.batchid = batchid;
	}
	public String getExecstarttime() {
		return execstarttime;
	}
	public void setExecstarttime(String execstarttime) {
		this.execstarttime = execstarttime;
	}
	public String getExecendtime() {
		return execendtime;
	}
	public void setExecendtime(String execendtime) {
		this.execendtime = execendtime;
	}
	public String getRuleversion() {
		return ruleversion;
	}
	public void setRuleversion(String ruleversion) {
		this.ruleversion = ruleversion;
	}
	public String getKeywordversion() {
		return keywordversion;
	}
	public void setKeywordversion(String keywordversion) {
		this.keywordversion = keywordversion;
	}
	public String getScriptversion() {
		return scriptversion;
	}
	public void setScriptversion(String scriptversion) {
		this.scriptversion = scriptversion;
	}
	public String getTestcaseversion() {
		return testcaseversion;
	}
	public void setTestcaseversion(String testcaseversion) {
		this.testcaseversion = testcaseversion;
	}
	public String getExecmode() {
		return execmode;
	}
	public void setExecmode(String execmode) {
		this.execmode = execmode;
	}
	public String getLoglevel() {
		return loglevel;
	}
	public void setLoglevel(String loglevel) {
		this.loglevel = loglevel;
	}
	public String getRunstatus() {
		return runstatus;
	}
	public void setRunstatus(String runstatus) {
		this.runstatus = runstatus;
	}
	public String getPlatformid() {
		return platformid;
	}
	public void setPlatformid(String platformid) {
		this.platformid = platformid;
	}
	
	
	
}
