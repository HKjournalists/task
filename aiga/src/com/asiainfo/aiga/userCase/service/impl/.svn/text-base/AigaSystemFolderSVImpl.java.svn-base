package com.asiainfo.aiga.userCase.service.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.common.helper.CommonHelper;
import com.asiainfo.aiga.userCase.bo.AigaSystemFolder;
import com.asiainfo.aiga.userCase.dao.IAigaSystemFolderDAO;
import com.asiainfo.aiga.userCase.service.IAigaSystemFolderSV;

public class AigaSystemFolderSVImpl implements IAigaSystemFolderSV{

	private IAigaSystemFolderDAO aigaSystemFolderDAO;
	
	public void setAigaSystemFolderDAO(IAigaSystemFolderDAO aigaSystemFolderDAO) {
		this.aigaSystemFolderDAO = aigaSystemFolderDAO;
	}

	@Override
	public AigaSystemFolder[] getSystemFolder(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		return aigaSystemFolderDAO.getSystemFolders(criteria);
	}
	
	public AigaSystemFolder[] getSystemFolder(String querySql) throws Exception {
		return aigaSystemFolderDAO.getSystemFolders(querySql);
	}

	@Override
	public void saveAigaSystemFolder(AigaSystemFolder aValue) throws Exception {
		// TODO Auto-generated method stub
		aigaSystemFolderDAO.saveSystemFolders(aValue);
	}

	@Override
	public List getSysIdsBySubFunIds(String[] funIds) throws Exception {
		// TODO Auto-generated method stub
		String SQL="SELECT asf.sys_id FROM aiga_system_folder asf ,AIGA_SUB_SYS_FOLDER ASSF WHERE asf.sys_id=ASSF.sys_id AND ASSF.SUBSYS_ID in("+CommonHelper.array2String(funIds)+") GROUP BY asf.sys_id";
		return aigaSystemFolderDAO.getObjectBySQL(SQL);
	}

	@Override
	public void deleteAigaSystemFolder(AigaSystemFolder aValue)
			throws Exception {
		aigaSystemFolderDAO.deleteSystemFolders(aValue);
	}

}
