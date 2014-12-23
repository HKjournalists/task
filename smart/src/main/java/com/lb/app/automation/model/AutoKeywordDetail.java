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
@Table(name="auto_keyworddetail")
@JsonIgnoreProperties(value={"keyword"})
public class AutoKeywordDetail {

	
	@Id
	@GeneratedValue(generator = "prefixsequence_gen")  
	@GenericGenerator(name = "prefixsequence_gen", strategy = "com.lb.app.common.id.PrefixIDSequence",   
	     parameters = { @Parameter(name = "prefix", value = "KED"),  
			@Parameter(name = "sequence", value = "auto_keyworddetail$seq")}) 
	String keyworddetailid;
	
	@Transient
	String keywordid;


	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "keywordid")
	AutoKeyword keyword;
	
	String object;
	String operation;
	String parameter;
	String actioniffail;
	
	public String getKeyworddetailid() {
		return keyworddetailid;
	}
	public void setKeyworddetailid(String keyworddetailid) {
		this.keyworddetailid = keyworddetailid;
	}
	public AutoKeyword getKeyword() {
		return keyword;
	}
	public void setKeyword(AutoKeyword keyword) {
		this.keyword = keyword;
	}
	public String getObject() {
		return object;
	}
	public void setObject(String object) {
		this.object = object;
	}
	public String getOperation() {
		return operation;
	}
	public void setOperation(String operation) {
		this.operation = operation;
	}
	public String getParameter() {
		return parameter;
	}
	public void setParameter(String parameter) {
		this.parameter = parameter;
	}
	public String getActioniffail() {
		return actioniffail;
	}
	public void setActioniffail(String actioniffail) {
		this.actioniffail = actioniffail;
	}
	public String getKeywordid() {
		return keywordid;
	}
	public void setKeywordid(String keywordid) {
		this.keywordid = keywordid;
	}
}
