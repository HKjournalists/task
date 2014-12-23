package com.asiainfo.aiga.userCase.dao;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.userCase.bo.AigaFunFolder;

public interface IAigaFunFolderDAO {

	public AigaFunFolder[] getFunFolders(DetachedCriteria criteria)throws Exception;
	
	public void saveFunFolders(AigaFunFolder aValue)throws Exception;
	
	public void deleteFunFolders(AigaFunFolder aValue)throws Exception;
	
	public AigaFunFolder[] getAigaFunFolderBySql(String querySql)throws Exception;
	
}
