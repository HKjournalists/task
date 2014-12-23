package com.lb.app.automation.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


@Entity
@Table(name = "auto_batch")
@JsonIgnoreProperties(value={"batchdetails"})
public class AutoBatch {
	@Id
	@GeneratedValue(generator = "prefixsequence_gen")  
	@GenericGenerator(name = "prefixsequence_gen", strategy = "com.lb.app.common.id.PrefixIDSequence",   
	     parameters = { @Parameter(name = "prefix", value = "bat"),  
			@Parameter(name = "sequence", value = "auto_batch$seq")}) 
	String batchid;
	String batchname;
	String comments;
	
	@OneToMany(mappedBy = "batch", cascade = {CascadeType.ALL})
	Set<AutoBatchDetail> batchdetails = new HashSet<AutoBatchDetail>();

	public String getBatchid() {
		return batchid;
	}

	public void setBatchid(String batchid) {
		this.batchid = batchid;
	}

	public String getBatchname() {
		return batchname;
	}

	public void setBatchname(String batchname) {
		this.batchname = batchname;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public Set<AutoBatchDetail> getBatchdetails() {
		return batchdetails;
	}

	public void setBatchdetails(Set<AutoBatchDetail> batchdetails) {
		this.batchdetails = batchdetails;
	}
	
}
