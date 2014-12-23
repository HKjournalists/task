package com.asiainfo.aiga.common.xls;

import java.lang.reflect.Field;

public class ExcelBean {
	private Integer classIndex;
	private Field classField;
	private String cellColumnName;
	public Integer getClassIndex() {
		return classIndex;
	} 
	public void setClassIndex(Integer classIndex) {
		this.classIndex = classIndex;
	}
	public Field getClassField() {
		return classField;
	}
	public void setClassField(Field classField) {
		this.classField = classField;
	}
	public String getCellColumnName() {
		return cellColumnName;
	}
	public void setCellColumnName(String cellColumnName) {
		this.cellColumnName = cellColumnName;
	}

}
