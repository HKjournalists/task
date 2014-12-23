package com.asiainfo.aiga.userCase.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.userCase.bo.AigaSystemFolder;

public interface IAigaSystemFolderSV {

	public AigaSystemFolder[] getSystemFolder(DetachedCriteria criteria)throws Exception;
	
	public AigaSystemFolder[] getSystemFolder(String querySql) throws Exception;
	
	public void saveAigaSystemFolder(AigaSystemFolder aValue)throws Exception;
	
	List getSysIdsBySubFunIds(String[] funIds) throws Exception;
	
	public void deleteAigaSystemFolder(AigaSystemFolder aValue)throws Exception;
}
