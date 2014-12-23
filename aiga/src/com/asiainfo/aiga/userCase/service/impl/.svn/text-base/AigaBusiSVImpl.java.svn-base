package com.asiainfo.aiga.userCase.service.impl;


import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.userCase.bo.AigaBusi;
import com.asiainfo.aiga.userCase.dao.IAigaBusiDAO;
import com.asiainfo.aiga.userCase.service.IAigaBusiSV;

public class AigaBusiSVImpl implements IAigaBusiSV{

	private IAigaBusiDAO aigaBusiDAO;
	
	public void setAigaBusiDAO(IAigaBusiDAO aigaBusiDAO) {
		this.aigaBusiDAO = aigaBusiDAO;
	}

	@Override
	public AigaBusi[] getAigaBusi(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		return aigaBusiDAO.getAigaBusis(criteria);
	}

	@Override
	public void saveAigaBusi(AigaBusi aValue) throws Exception {
		// TODO Auto-generated method stub
		aigaBusiDAO.saveAigaBusi(aValue);
	}

	@Override
	public void deleteAigaBusi(AigaBusi aValue) throws Exception {
		// TODO Auto-generated method stub
		aigaBusiDAO.deleteAigaBusi(aValue);
	}

	@Override
	public AigaBusi[] getAigaBusi(String querySql) throws Exception {
		// TODO Auto-generated method stub
		return aigaBusiDAO.getAigaBusiBySql(querySql);
	}

}
