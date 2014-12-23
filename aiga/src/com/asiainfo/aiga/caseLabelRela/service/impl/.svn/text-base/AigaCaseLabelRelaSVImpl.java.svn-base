package com.asiainfo.aiga.caseLabelRela.service.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.caseLabelRela.bo.AigaCaseLabelRela;
import com.asiainfo.aiga.caseLabelRela.dao.IAigaCaseLabelRelaDAO;
import com.asiainfo.aiga.caseLabelRela.service.IAigaCaseLabelRelaSV;
import com.asiainfo.aiga.label.bo.AigaLabel;
import com.asiainfo.aiga.label.dao.IAigaLabelDAO;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.dao.IAigaCaseDAO;

public class AigaCaseLabelRelaSVImpl implements IAigaCaseLabelRelaSV {

	private IAigaCaseLabelRelaDAO labelRelaDAO;
	
	private IAigaCaseDAO aigaCaseDAO;
	
	private IAigaLabelDAO aigaLabelDAO;
	
	
	public void setLabelRelaDAO(IAigaCaseLabelRelaDAO labelRelaDAO) {
		this.labelRelaDAO = labelRelaDAO;
	}

	public void setAigaCaseDAO(IAigaCaseDAO aigaCaseDAO) {
		this.aigaCaseDAO = aigaCaseDAO;
	}


	public void setAigaLabelDAO(IAigaLabelDAO aigaLabelDAO) {
		this.aigaLabelDAO = aigaLabelDAO;
	}


	public void deleteAigaCaseLabelRela(AigaCaseLabelRela value)
			throws Exception {
		// TODO Auto-generated method stub
		labelRelaDAO.delete(value);
	}

	public AigaCaseLabelRela[] getAigaCaseLabelRelaByLabelId(Integer labelId)
			throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaCaseLabelRela.class);
		criteria.add(Restrictions.eq("labelId", labelId));
		return labelRelaDAO.getAigaCaseLabelRelaByCriteria(criteria);
	}

	public void saveAigaCaseLabelRela(AigaCaseLabelRela value) throws Exception {
		// TODO Auto-generated method stub
		labelRelaDAO.saveOrUpdate(value);
	}

	public void saveAigaCaseLabelRelaByCaseIds(String labelId,String caseIds) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaLabel.class);
		criteria.add(Restrictions.eq("labelId", Integer.valueOf(labelId)));
		AigaLabel[] aigaLabels = aigaLabelDAO.getAigaLabelByCriteria(criteria);
		if(aigaLabels.length==1){
			DetachedCriteria caseCriteria = DetachedCriteria.forClass(AigaCase.class);
			String[] cases = caseIds.split(",");
			Integer[] casesInt = new Integer[cases.length];
			for(int i=0;i<cases.length;i++){
				casesInt[i]=Integer.valueOf(cases[i]);
			}
			caseCriteria.add(Restrictions.in("caseId", casesInt));
			AigaCase[] aigaCases = aigaCaseDAO.getAigaCaseByCriteria(caseCriteria);
			for(AigaCase aigaCase : aigaCases){
				AigaCaseLabelRela aigaCaseLabelRela = new AigaCaseLabelRela();
				aigaCaseLabelRela.setCaseId(aigaCase.getCaseId());
				aigaCaseLabelRela.setLabelId(aigaLabels[0].getLabelId());
				labelRelaDAO.saveOrUpdate(aigaCaseLabelRela);
			}
		}
	}

	public void deleteAigaCaseLabelRela(String caseIds, String labelId)
			throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaCaseLabelRela.class);
		criteria.add(Restrictions.eq("labelId", Integer.valueOf(labelId)));
		String[] cases = caseIds.split(",");
		Integer[] casesInt = new Integer[cases.length];
		for(int i=0;i<cases.length;i++){
			casesInt[i]=Integer.valueOf(cases[i]);
		}
		criteria.add(Restrictions.in("caseId", casesInt));
		AigaCaseLabelRela[] aigaCaseLabelRelas = labelRelaDAO.getAigaCaseLabelRelaByCriteria(criteria);
		for(AigaCaseLabelRela aigaCaseLabelRela : aigaCaseLabelRelas){
			labelRelaDAO.delete(aigaCaseLabelRela);
		}
	}

	
}
