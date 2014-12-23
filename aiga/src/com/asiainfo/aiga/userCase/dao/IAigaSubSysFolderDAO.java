package com.asiainfo.aiga.userCase.dao;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.userCase.bo.AigaSubSysFolder;

public interface IAigaSubSysFolderDAO {

	public AigaSubSysFolder[] getSubSysFolder(DetachedCriteria criteria)throws Exception;
	
	public AigaSubSysFolder[] getSubSysFolder(String querySql) throws Exception;
	
	public void saveSubSysFolder(AigaSubSysFolder aValue)throws Exception;
	
	public void deleteSubSysFolder(AigaSubSysFolder aValue)throws Exception;
}
