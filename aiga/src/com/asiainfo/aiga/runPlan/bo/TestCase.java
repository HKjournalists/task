package com.asiainfo.aiga.runPlan.bo;

import java.util.List;

public class TestCase {
	private String attr;
	private Base base;
	private List<Step> steps;
	private String log;
	private String err;
	
	
	public String getLog() {
		return log;
	}
	public void setLog(String log) {
		this.log = log;
	}
	public String getErr() {
		return err;
	}
	public void setErr(String err) {
		this.err = err;
	}
	public String getAttr() {
		return attr;
	}
	public void setAttr(String attr) {
		this.attr = attr;
	}
	public Base getBase() {
		return base;
	}
	public void setBase(Base base) {
		this.base = base;
	}
	public List<Step> getSteps() {
		return steps;
	}
	public void setSteps(List<Step> steps) {
		this.steps = steps;
	}
	public class Step{
		private String  result;
		private String stepname;
		private List<Element> elements;
		public String getResult() {
			return result;
		}
		public void setResult(String result) {
			this.result = result;
		}
		public String getStepname() {
			return stepname;
		}
		public void setStepname(String stepname) {
			this.stepname = stepname;
		}
		public List<Element> getElements() {
			return elements;
		}
		public void setElements(List<Element> elements) {
			this.elements = elements;
		}
		
		
	}
	public class Element{
		private String argument;
		private String method;
		private String value;
		public String getArgument() {
			return argument;
		}
		public void setArgument(String argument) {
			this.argument = argument;
		}
		public String getMethod() {
			return method;
		}
		public void setMethod(String method) {
			this.method = method;
		}
		public String getValue() {
			return value;
		}
		public void setValue(String value) {
			this.value = value;
		}
		
	}
	public class Base{
		private String casename;
		private String casetype;
		private String caseid;
		private String url;
		private String collectionid;
		public String getCasename() {
			return casename;
		}
		public void setCasename(String casename) {
			this.casename = casename;
		}
		public String getCasetype() {
			return casetype;
		}
		public void setCasetype(String casetype) {
			this.casetype = casetype;
		}
		public String getCaseid() {
			return caseid;
		}
		public void setCaseid(String caseid) {
			this.caseid = caseid;
		}
		public String getUrl() {
			return url;
		}
		public void setUrl(String url) {
			this.url = url;
		}
		public String getCollectionid() {
			return collectionid;
		}
		public void setCollectionid(String collectionid) {
			this.collectionid = collectionid;
		}
		
	}
}
