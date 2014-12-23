package com.asiainfo.aiga.userCase.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.userCase.bo.AigaFunFolder;

public interface IAigaFunFolderSV {
	public AigaFunFolder[] getAigaFunFolder(DetachedCriteria criteria)throws Exception;
	
	public AigaFunFolder[] getAigaFunFolderBySql(String querySql)throws Exception;
	
	public void saveAigaFunFolder(AigaFunFolder aValue)throws Exception;
	
	public void deleteAigaFunFolder(String funIds)throws Exception;
	
	public String caseCoverageCountChart() throws Exception;
	
	public List getSubSysCoverage() throws Exception;
	
}
