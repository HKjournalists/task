package com.asiainfo.aiga.statistics.bo;

import com.asiainfo.aiga.common.helper.CommonHelper;


/**
 * StatGridColumns entity. @author MyEclipse Persistence Tools
 */

public class StatGridColumns implements java.io.Serializable {

	// Fields

	private Integer columnId;
	private String header;
	private String hidden;
	private Integer width;
	private String align;
	private String sortable;
	private String dataIndex;
	private String gridType;
	private Integer parentId;
	private String statClassConstant;
	private Integer columnIndex;
	private Integer gridId;
	private Integer labelWidth;
	private String xtype;
	private String labelAlign;
	private String fieldLabel;
	private String tbarShow;
	private String isEdit;
	private StatGridColumns[] StatGridColumns;

	// Constructors

	/** default constructor */
	public StatGridColumns() {
	}

	/** minimal constructor */
	public StatGridColumns(Integer columnId) {
		this.columnId = columnId;
	}

	public String getDataIndex() {
		return dataIndex;
	}

	public void setDataIndex(String dataIndex) {
		this.dataIndex = dataIndex;
	}

	public Integer getGridId() {
		return gridId;
	}

	public void setGridId(Integer gridId) {
		this.gridId = gridId;
	}

	public String getIsEdit() {
		return isEdit;
	}

	public void setIsEdit(String isEdit) {
		this.isEdit = isEdit;
	}

	/** full constructor */
	public StatGridColumns(Integer columnId, String header, String hidden,
			Integer width, String align, String sortable, String dataIndex,
			String gridType, Integer parentId, String statClassConstant,
			Integer columnIndex) {
		this.columnId = columnId;
		this.header = header;
		this.hidden = hidden;
		this.width = width;
		this.align = align;
		this.sortable = sortable;
		this.dataIndex = dataIndex;
		this.gridType = gridType;
		this.parentId = parentId;
		this.statClassConstant = statClassConstant;
		this.columnIndex = columnIndex;
	}

	// Property accessors

	public Integer getColumnId() {
		return this.columnId;
	}

	public void setColumnId(Integer columnId) {
		this.columnId = columnId;
	}

	public String getHeader() {
		return this.header;
	}

	public void setHeader(String header) {
		this.header = header;
	}

	public String getHidden() {
		return this.hidden;
	}

	public void setHidden(String hidden) {
		this.hidden = hidden;
	}

	public Integer getWidth() {
		return this.width;
	}

	public void setWidth(Integer width) {
		this.width = width;
	}

	public String getAlign() {
		return this.align;
	}

	public void setAlign(String align) {
		this.align = align;
	}

	public String getSortable() {
		return this.sortable;
	}

	public void setSortable(String sortable) {
		this.sortable = sortable;
	}

	public String getGridType() {
		return this.gridType;
	}

	public void setGridType(String gridType) {
		this.gridType = gridType;
	}

	public Integer getParentId() {
		return this.parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getStatClassConstant() {
		return this.statClassConstant;
	}

	public void setStatClassConstant(String statClassConstant) {
		this.statClassConstant = statClassConstant;
	}

	public Integer getColumnIndex() {
		return this.columnIndex;
	}

	public void setColumnIndex(Integer columnIndex) {
		this.columnIndex = columnIndex;
	}
	
	public StatGridColumns[] getStatGridColumns() {
		return StatGridColumns;
	}

	public void setStatGridColumns(StatGridColumns[] statGridColumns) {
		StatGridColumns = statGridColumns;
	}



	public String getXtype() {
		return xtype;
	}

	public void setXtype(String xtype) {
		this.xtype = xtype;
	}

	public String getLabelAlign() {
		return labelAlign;
	}

	public void setLabelAlign(String labelAlign) {
		this.labelAlign = labelAlign;
	}

	public String getFieldLabel() {
		return fieldLabel;
	}

	public void setFieldLabel(String fieldLabel) {
		this.fieldLabel = fieldLabel;
	}

	public Integer getLabelWidth() {
		return labelWidth;
	}

	public void setLabelWidth(Integer labelWidth) {
		this.labelWidth = labelWidth;
	}

	public String getTbarShow() {
		return tbarShow;
	}

	public void setTbarShow(String tbarShow) {
		this.tbarShow = tbarShow;
	}

	@Override
	public String toString(){
		StringBuffer strBuf=new StringBuffer();
		if(this.StatGridColumns==null||this.StatGridColumns.length==0){
			strBuf.append("{");
			if(this.header!=null&&!this.header.equals(""))strBuf.append("header:'"+this.header+"',");
			if(this.hidden!=null&&!this.hidden.equals(""))strBuf.append("hidden:"+this.hidden+",");
			if(this.width!=null&&!this.width.equals(""))strBuf.append("width:"+this.width+",");
			if(this.align!=null&&!this.align.equals(""))strBuf.append("align:'"+this.align+"',");
			if(this.sortable!=null&&!this.sortable.equals(""))strBuf.append("sortable:"+this.sortable+",");
			if(this.dataIndex!=null&&!this.dataIndex.equals(""))strBuf.append("dataIndex:'"+this.dataIndex+"',");
			if(this.isEdit!=null&&this.isEdit.equals("true"))strBuf.append("editor:{xtype:'"+this.xtype+"'},");
			strBuf.append("placeholder:'true'");
			strBuf.append("}");
		}else{
			strBuf.append("{");
			if(this.header!=null&&!this.header.equals(""))strBuf.append("header:'"+this.header+"',");
			if(this.hidden!=null&&!this.hidden.equals(""))strBuf.append("hidden:"+this.hidden+",");
			if(this.width!=null&&!this.width.equals(""))strBuf.append("width:"+this.width+",");
			if(this.align!=null&&!this.align.equals(""))strBuf.append("align:'"+this.align+"',");
			if(this.sortable!=null&&!this.sortable.equals(""))strBuf.append("sortable:"+this.sortable+",");
			if(this.dataIndex!=null&&!this.dataIndex.equals(""))strBuf.append("dataIndex:'"+this.dataIndex+"',");
			strBuf.append("columns:[");
			for(int i=0,n=this.getStatGridColumns().length;i<n;i++){
				strBuf.append(StatGridColumns[i]+((i==n-1)?"":","));
			}
			strBuf.append("],");
			strBuf.append("placeholder:'true'");//Õ¼Î»·û
			strBuf.append("}");
		}
	
		return strBuf.toString();
	}
	public String getTbarHtmlString(){
		if(this.getTbarShow()!=null &&!this.getTbarShow().equals("true")&&(this.getStatGridColumns()==null||this.getStatGridColumns().length==0))return "";
		StringBuffer tempTbarHtmlBuffer=new StringBuffer();
		if(this.StatGridColumns==null||this.StatGridColumns.length==0){
			tempTbarHtmlBuffer.append("{width:");
			tempTbarHtmlBuffer.append((this.getWidth()+this.getLabelWidth()));
			tempTbarHtmlBuffer.append(",labelWidth:");
			tempTbarHtmlBuffer.append(this.getLabelWidth());
			tempTbarHtmlBuffer.append(",xtype:'");
			if(this.getXtype()==null||this.getXtype().equals(""))this.setXtype("textfield");
			tempTbarHtmlBuffer.append(this.getXtype());
			tempTbarHtmlBuffer.append("'");
			tempTbarHtmlBuffer.append(",name:'");
			tempTbarHtmlBuffer.append(this.getDataIndex());
			tempTbarHtmlBuffer.append("'");
			tempTbarHtmlBuffer.append(",labelAlign:'");
			if(this.getLabelAlign()==null||this.getLabelAlign().equals(""))this.setLabelAlign("right");
			tempTbarHtmlBuffer.append(this.getLabelAlign());
			tempTbarHtmlBuffer.append("'");
			tempTbarHtmlBuffer.append(",fieldLabel:'");
			if(this.getFieldLabel()==null||this.getFieldLabel().equals(""))this.setFieldLabel(CommonHelper.removeHTMLTag(this.getHeader()));
			tempTbarHtmlBuffer.append(this.getFieldLabel());
			tempTbarHtmlBuffer.append("'");
			tempTbarHtmlBuffer.append("}");
			tempTbarHtmlBuffer.append(",");
		}else if(this.StatGridColumns.length>0){
			for(int i=0,n=this.getStatGridColumns().length;i<n;i++){
				tempTbarHtmlBuffer.append(StatGridColumns[i].getTbarHtmlString());
			}
		}
		return tempTbarHtmlBuffer.toString();
	}
}