package com.asiainfo.aiga.label.service;

import com.asiainfo.aiga.label.bo.AigaLabel;
import com.asiainfo.aiga.userCase.bo.AigaCase;

public interface IAigaLabelSV {

	public void saveAigaLabel(AigaLabel aValue)throws Exception;
	
	public void deleteAigaLabel(AigaLabel aValue)throws Exception;
	
	public AigaLabel[] getAigaLabelById(Integer id)throws Exception;
	
	public AigaCase[] getAigaCaseByLabelId(Integer labelId)throws Exception;
	
	public AigaLabel[] getAigaLabelByParentId(Integer parentId)throws Exception;
	
	public AigaLabel[] getAigaLabelBySql(String querySql) throws Exception;
	
	public AigaLabel[] getAigaLabelLeafBySql(String querySql) throws Exception;
	
}
