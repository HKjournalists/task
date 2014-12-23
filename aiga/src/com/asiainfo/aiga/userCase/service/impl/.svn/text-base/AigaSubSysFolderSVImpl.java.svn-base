package com.asiainfo.aiga.userCase.service.impl;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.userCase.bo.AigaSubSysFolder;
import com.asiainfo.aiga.userCase.dao.IAigaSubSysFolderDAO;
import com.asiainfo.aiga.userCase.service.IAigaSubSysFolderSV;

public class AigaSubSysFolderSVImpl implements IAigaSubSysFolderSV{

	private IAigaSubSysFolderDAO aigaSubSysFolderDAO;
	
	public void setAigaSubSysFolderDAO(IAigaSubSysFolderDAO aigaSubSysFolderDAO) {
		this.aigaSubSysFolderDAO = aigaSubSysFolderDAO;
	}
	
	@Override
	public AigaSubSysFolder[] getSubSysFolder(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		return aigaSubSysFolderDAO.getSubSysFolder(criteria);
	}
	
	public AigaSubSysFolder[] getSubSysFolder(String querySql) throws Exception {
		return aigaSubSysFolderDAO.getSubSysFolder(querySql);
	}

	@Override
	public void deleteAigaSubSysFolder(AigaSubSysFolder aValue)
			throws Exception {
		aigaSubSysFolderDAO.deleteSubSysFolder(aValue);
		
	}

	@Override
	public void saveAigaSubSysFolder(AigaSubSysFolder aValue) throws Exception {
		aigaSubSysFolderDAO.saveSubSysFolder(aValue);
	}

	
}
