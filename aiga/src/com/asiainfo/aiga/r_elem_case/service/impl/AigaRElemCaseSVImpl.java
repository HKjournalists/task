package com.asiainfo.aiga.r_elem_case.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.r_elem_case.bo.AigaRElemCase;
import com.asiainfo.aiga.r_elem_case.dao.IAigaRElemCaseDAO;
import com.asiainfo.aiga.r_elem_case.service.IAigaRElemCaseSV;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.bo.extend.AigaInstCase;
import com.asiainfo.aiga.userCase.dao.IAigaCaseDAO;

public class AigaRElemCaseSVImpl implements IAigaRElemCaseSV {

	private IAigaRElemCaseDAO aigaRElemCaseDAO;
	private IAigaCaseDAO aigaCaseDAO;
	
	public void setAigaRElemCaseDAO(IAigaRElemCaseDAO aigaRElemCaseDAO) {
		this.aigaRElemCaseDAO = aigaRElemCaseDAO;
	}
	
	public void setAigaCaseDAO(IAigaCaseDAO aigaCaseDAO) {
		this.aigaCaseDAO = aigaCaseDAO;
	}
	public void addRElemCase(String caseIds, String elemTag) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRElemCase.class);
		criteria.add(Restrictions.eq("elemTag", elemTag));
		List<Integer> addCaseId = new ArrayList<Integer>();
		List<Integer> delCaseId = new ArrayList<Integer>();
		List<Integer> databaseCaseId = new ArrayList<Integer>();
		AigaRElemCase[] databaseCases = aigaRElemCaseDAO.getRElemCaseByCriteria(criteria);
		for(AigaRElemCase databaseCase : databaseCases){
			databaseCaseId.add(databaseCase.getCaseId());
		}
		
		String[] caseIdArray = caseIds.split(",");
		boolean isEqual = false;
		if(!caseIds.equals(""))
		for(String caseId : caseIdArray){
			isEqual = false;
			for(Integer databaseCase : databaseCaseId){
				if(databaseCase.toString().equals(caseId)){
					isEqual = true;
					break;
				}
			}
			if(isEqual)
				continue;
			addCaseId.add(Integer.valueOf(caseId));
		}
		
		for(Integer databaseCase : databaseCaseId){
			isEqual = false;
			for(String caseId : caseIdArray){
				if(databaseCase.toString().equals(caseId)){
					isEqual = true;
					break;
				}
			}
			if(isEqual)
				continue;
			delCaseId.add(databaseCase);
		}
		
		for(Integer addCase : addCaseId){
			if(addCase.equals(0))
				continue;
			AigaRElemCase aigaRElemCase = new AigaRElemCase();
			aigaRElemCase.setCaseId(addCase);
			DetachedCriteria caseCriteria = DetachedCriteria.forClass(AigaInstCase.class);
			caseCriteria.add(Restrictions.eq("caseId", addCase));
			AigaCase[] cases = aigaCaseDAO.getAigaCaseByCriteria(caseCriteria);
			if(cases.length!=1)
				throw new Exception("未查找到相应的用例信息，caseid="+addCase);
			aigaRElemCase.setElemTag(elemTag);
			aigaRElemCaseDAO.saveOrUpdate(aigaRElemCase);
		}
	}
	public void saveRElemCase(String caseIds, String elemTag) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRElemCase.class);
		criteria.add(Restrictions.eq("elemTag", elemTag));
		List<Integer> addCaseId = new ArrayList<Integer>();
		List<Integer> delCaseId = new ArrayList<Integer>();
		List<Integer> databaseCaseId = new ArrayList<Integer>();
		AigaRElemCase[] databaseCases = aigaRElemCaseDAO.getRElemCaseByCriteria(criteria);
		for(AigaRElemCase databaseCase : databaseCases){
			databaseCaseId.add(databaseCase.getCaseId());
		}
		
		String[] caseIdArray = caseIds.split(",");
		boolean isEqual = false;
		if(!caseIds.equals(""))
		for(String caseId : caseIdArray){
			isEqual = false;
			for(Integer databaseCase : databaseCaseId){
				if(databaseCase.toString().equals(caseId)){
					isEqual = true;
					break;
				}
			}
			if(isEqual)
				continue;
			addCaseId.add(Integer.valueOf(caseId));
		}
		
		for(Integer databaseCase : databaseCaseId){
			isEqual = false;
			for(String caseId : caseIdArray){
				if(databaseCase.toString().equals(caseId)){
					isEqual = true;
					break;
				}
			}
			if(isEqual)
				continue;
			delCaseId.add(databaseCase);
		}
		
		for(Integer addCase : addCaseId){
			if(addCase.equals(0))
				continue;
			AigaRElemCase aigaRElemCase = new AigaRElemCase();
			aigaRElemCase.setCaseId(addCase);
			DetachedCriteria caseCriteria = DetachedCriteria.forClass(AigaInstCase.class);
			caseCriteria.add(Restrictions.eq("caseId", addCase));
			AigaCase[] cases = aigaCaseDAO.getAigaCaseByCriteria(caseCriteria);
			if(cases.length!=1)
				throw new Exception("未查找到相应的用例信息，caseid="+addCase);
			aigaRElemCase.setElemTag(elemTag);
			aigaRElemCaseDAO.saveOrUpdate(aigaRElemCase);
		}
		for(Integer delCase : delCaseId){
			if(delCase.equals(0))
				continue;
			DetachedCriteria caseCriteria = DetachedCriteria.forClass(AigaRElemCase.class);
			caseCriteria.add(Restrictions.eq("elemTag", elemTag));
			caseCriteria.add(Restrictions.eq("caseId", delCase));
			AigaRElemCase[] aigaRElemCases = aigaRElemCaseDAO.getRElemCaseByCriteria(caseCriteria);
			if(aigaRElemCases.length==1)
				aigaRElemCaseDAO.delete(aigaRElemCases[0]);
		}
	}

	public void deleteRElemCase(String caseIds, String elemTag)
			throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRElemCase.class);
		String[] caseIdArray = caseIds.split(",");
		List<Integer> caseIdList = new ArrayList<Integer>();
		for(String caseId : caseIdArray){
			if(!caseId.equals("")){
				caseIdList.add(Integer.valueOf(caseId));
			}
		}
		criteria.add(Restrictions.in("caseId", caseIdList));
		criteria.add(Restrictions.eq("elemTag", elemTag));
		AigaRElemCase[] databaseCases = aigaRElemCaseDAO.getRElemCaseByCriteria(criteria);
		for(AigaRElemCase databaseCase : databaseCases){
			aigaRElemCaseDAO.delete(databaseCase);
		}
	}

	public String getRElemCaseIdByElemTag(String elemTag)
			throws Exception {
		// TODO Auto-generated method stub
		String caseIds = "0";
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRElemCase.class);
		criteria.add(Restrictions.eq("elemTag", elemTag));
		AigaRElemCase[] aigaRElemCases = aigaRElemCaseDAO.getRElemCaseByCriteria(criteria);
		for(int i=0,n=aigaRElemCases.length;i<n;i++){
			caseIds += ","+aigaRElemCases[i].getCaseId();
		}
		return caseIds;
	}
	
	public AigaRElemCase[] getRElemCaseBySql(String querySql) throws Exception {
		return aigaRElemCaseDAO.getRElemCaseBySql(querySql);
	}
	
	public void saveRElemCaseValues(AigaRElemCase[] aigaRElemCases)throws Exception{
		for(AigaRElemCase aigaRElemCase:aigaRElemCases){
			aigaRElemCaseDAO.saveOrUpdate(aigaRElemCase);
		}
	}

}
