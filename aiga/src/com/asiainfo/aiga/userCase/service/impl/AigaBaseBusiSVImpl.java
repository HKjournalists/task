package com.asiainfo.aiga.userCase.service.impl;


import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.userCase.bo.AigaBaseBusi;
import com.asiainfo.aiga.userCase.dao.IAigaBaseBusiDAO;
import com.asiainfo.aiga.userCase.service.IAigaBaseBusiSV;

public class AigaBaseBusiSVImpl implements IAigaBaseBusiSV{

	private IAigaBaseBusiDAO aigaBaseBusiDAO;
	
	public void setAigaBaseBusiDAO(IAigaBaseBusiDAO aigaBaseBusiDAO) {
		this.aigaBaseBusiDAO = aigaBaseBusiDAO;
	}

	@Override
	public AigaBaseBusi[] getAigaBaseBusi(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		return aigaBaseBusiDAO.getAigaBaseBusis(criteria);
	}

	@Override
	public void saveAigaBaseBusi(AigaBaseBusi aValue) throws Exception {
		// TODO Auto-generated method stub
		aigaBaseBusiDAO.saveAigaBaseBusi(aValue);
	}

	@Override
	public void deleteAigaBaseBusi(AigaBaseBusi aValue) throws Exception {
		// TODO Auto-generated method stub
		aigaBaseBusiDAO.deleteAigaBaseBusi(aValue);
	}

	@Override
	public AigaBaseBusi[] getAigaBaseBusi(String querySql) throws Exception {
		// TODO Auto-generated method stub
		return aigaBaseBusiDAO.getAigaBaseBusiBySql(querySql);
	}

}
