package com.asiainfo.aiga.label.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.caseLabelRela.bo.AigaCaseLabelRela;
import com.asiainfo.aiga.caseLabelRela.service.IAigaCaseLabelRelaSV;
import com.asiainfo.aiga.label.bo.AigaLabel;
import com.asiainfo.aiga.label.dao.IAigaLabelDAO;
import com.asiainfo.aiga.label.service.IAigaLabelSV;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.dao.IAigaCaseDAO;

public class AigaLabelSVImpl implements IAigaLabelSV {

	private IAigaLabelDAO labelDAO;
	private IAigaCaseDAO caseDao;
	private IAigaCaseLabelRelaSV caseLabelRelaSV;
	
	public void setLabelDAO(IAigaLabelDAO labelDAO) {
		this.labelDAO = labelDAO;
	}

	public void setCaseDao(IAigaCaseDAO caseDao) {
		this.caseDao = caseDao;
	}
	
	public void setCaseLabelRelaSV(IAigaCaseLabelRelaSV caseLabelRelaSV) {
		this.caseLabelRelaSV = caseLabelRelaSV;
	}

	public void deleteAigaLabel(AigaLabel value) throws Exception {
		// TODO Auto-generated method stub
		labelDAO.delete(value);
	}

	public void saveAigaLabel(AigaLabel value) throws Exception {
		// TODO Auto-generated method stub
		labelDAO.saveOrUpdate(value);
	}

	public AigaLabel[] getAigaLabelById(Integer id) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaLabel.class);
		criteria.add(Restrictions.eq("labelId", id));
		return labelDAO.getAigaLabelByCriteria(criteria);
	}
	
	public AigaCase[] getAigaCaseByLabelId(Integer labelId)throws Exception{
		AigaCaseLabelRela[] caseLabelRelas = caseLabelRelaSV.getAigaCaseLabelRelaByLabelId(labelId);
		List<Integer> caseIdList = new ArrayList<Integer>();
		for(AigaCaseLabelRela caseLabelRela : caseLabelRelas){
			caseIdList.add(caseLabelRela.getCaseId());
		}
		if(caseIdList.size()>0){
			DetachedCriteria caseCriteria = DetachedCriteria.forClass(AigaCase.class);
			caseCriteria.add(Restrictions.in("caseId", caseIdList));
			AigaCase[] aigaCase = caseDao.getAigaCaseByCriteria(caseCriteria);
			if(aigaCase!=null){
				if(aigaCase.length>0)
					return aigaCase;
				else
					return null;
			}else
				return null;
		}
		else
			return null;
	}
	
	public AigaLabel[] getAigaLabelByParentId(Integer parentId)throws Exception{
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaLabel.class);
		criteria.add(Restrictions.eq("parentId", parentId));
		return labelDAO.getAigaLabelByCriteria(criteria);
	}
	
	public AigaLabel[] getAigaLabelBySql(String querySql) throws Exception {
		return labelDAO.getAigaLabelBySql(querySql);
	}
	
	public AigaLabel[] getAigaLabelLeafBySql(String querySql) throws Exception {
		return labelDAO.getAigaLabelLeafBySql(querySql);
	}
	
}
