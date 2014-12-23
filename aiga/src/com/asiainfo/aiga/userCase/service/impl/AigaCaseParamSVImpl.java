package com.asiainfo.aiga.userCase.service.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.userCase.bo.AigaCaseParams;
import com.asiainfo.aiga.userCase.dao.IAigaCaseParamDAO;
import com.asiainfo.aiga.userCase.service.IAigaCaseParamSV;

public class AigaCaseParamSVImpl implements IAigaCaseParamSV{

	private IAigaCaseParamDAO aigaCaseParamDAO;
	
	public void setAigaCaseParamDAO(IAigaCaseParamDAO aigaCaseParamDAO) {
		this.aigaCaseParamDAO = aigaCaseParamDAO;
	}

	@Override
	public AigaCaseParams[] getAigaCaseParamsById(Integer caseId)
			throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaCaseParams.class);
		criteria.add(Restrictions.eq("caseId", caseId));
		return aigaCaseParamDAO.getAigaCaseParams(criteria);
	}

	@Override
	public void saveAigaCaseParams(AigaCaseParams aValue) throws Exception {
		// TODO Auto-generated method stub
		aigaCaseParamDAO.saveAigaCaseParams(aValue);
	}

	@Override
	public void deleteAigaCaseParams(AigaCaseParams aValue) throws Exception {
		// TODO Auto-generated method stub
		aigaCaseParamDAO.deleteAigaCaseParams(aValue);
	}

	@Override
	public void saveAigaCaseParamss(AigaCaseParams[] values,String caseId) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaCaseParams.class);
		criteria.add(Restrictions.eq("caseId", Integer.valueOf(caseId)));
		AigaCaseParams[] aigaCaseParams = aigaCaseParamDAO.getAigaCaseParams(criteria);
		for(AigaCaseParams aigaCaseParam : aigaCaseParams){
			this.deleteAigaCaseParams(aigaCaseParam);
		}
		for(AigaCaseParams value : values){
			value.setParamId(null);
			this.saveAigaCaseParams(value);
		}
	}

}
