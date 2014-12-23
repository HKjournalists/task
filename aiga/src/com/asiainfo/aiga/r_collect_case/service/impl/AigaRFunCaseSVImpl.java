package com.asiainfo.aiga.r_collect_case.service.impl;

import java.util.Arrays;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.r_collect_case.bo.AigaRFunCase;
import com.asiainfo.aiga.r_collect_case.dao.IAigaRFunCaseDAO;
import com.asiainfo.aiga.r_collect_case.service.IAigaRFunCaseSV;

public class AigaRFunCaseSVImpl implements IAigaRFunCaseSV {

	private IAigaRFunCaseDAO aigaRFunCaseDAO;
	
	public void setAigaRFunCaseDAO(IAigaRFunCaseDAO aigaRFunCaseDAO) {
		this.aigaRFunCaseDAO = aigaRFunCaseDAO;
	}
	@Override
	public void saveRAigaFunCase(String caseIds,String funId) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria  = DetachedCriteria.forClass(AigaRFunCase.class);
		criteria.add(Restrictions.eq("funId", Integer.valueOf(funId)));
		AigaRFunCase[] aigaRFunCases = aigaRFunCaseDAO.getRFunCaseByCriteria(criteria);
		for(AigaRFunCase aigaRFunCase : aigaRFunCases){
			aigaRFunCaseDAO.delete(aigaRFunCase);
		}
		if(caseIds!=null&&caseIds.length()>0){
			String[] caseId = caseIds.split(",");
			for(String id:caseId){
				AigaRFunCase aigaRFunCase = new AigaRFunCase();
				aigaRFunCase.setCaseId(Integer.valueOf(id));
				aigaRFunCase.setFunId(Integer.valueOf(funId));
				aigaRFunCaseDAO.saveOrUpdate(aigaRFunCase);
			}
		}
	}
	@Override
	public void saveRAigaFunCase(AigaRFunCase[] aigaRFunCases) throws Exception {
		aigaRFunCaseDAO.saveOrUpdateList(Arrays.asList(aigaRFunCases));
		
	}

}
