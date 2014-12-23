package com.asiainfo.aiga.funPoint.service.impl;

import java.util.List;

import com.asiainfo.aiga.funPoint.bo.AigaFunPoint;
import com.asiainfo.aiga.funPoint.bo.AigaKnowledge;
import com.asiainfo.aiga.funPoint.dao.IAigaFunPointDAO;
import com.asiainfo.aiga.funPoint.service.IAigaFunPointSV;

public class AigaFunPointSVImpl implements IAigaFunPointSV {

	private IAigaFunPointDAO funPointDAO;
	
	public void setFunPointDAO(IAigaFunPointDAO funPointDAO) {
		this.funPointDAO = funPointDAO;
	}

	public void delete(Object value) throws Exception {
		funPointDAO.delete(value);
	}

	public void saveOrUpdate(Object value) throws Exception {
		funPointDAO.saveOrUpdate(value);
	}
	
	public void saveOrUpdateList(List list) throws Exception {
		funPointDAO.saveOrUpdateList(list);
	}
	
	public AigaFunPoint[] getFunPointBySql(String querySql) throws Exception {
		return funPointDAO.getFunPointBySql(querySql);
	}
	
	public AigaKnowledge[] getKnowledgeBySql(String querySql) throws Exception {
		return funPointDAO.getKnowledgeBySql(querySql);
	}

}
