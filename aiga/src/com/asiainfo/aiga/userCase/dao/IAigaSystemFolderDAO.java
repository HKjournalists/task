package com.asiainfo.aiga.userCase.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.userCase.bo.AigaSystemFolder;

public interface IAigaSystemFolderDAO {

	public AigaSystemFolder[] getSystemFolders(DetachedCriteria criteria)throws Exception;
	
	public AigaSystemFolder[] getSystemFolders(String querySql) throws Exception;
	
	public void saveSystemFolders(AigaSystemFolder aValue)throws Exception;
	
	public void deleteSystemFolders(AigaSystemFolder aValue)throws Exception;

	List getObjectBySQL(String SQL) throws Exception;
}
