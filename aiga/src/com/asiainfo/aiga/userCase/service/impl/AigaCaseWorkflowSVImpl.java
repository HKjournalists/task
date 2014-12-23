package com.asiainfo.aiga.userCase.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.bo.AigaFunFolder;
import com.asiainfo.aiga.userCase.bo.AigaRElemSec;
import com.asiainfo.aiga.userCase.bo.AigaRFunElem;
import com.asiainfo.aiga.userCase.bo.extend.AigaInstCase;
import com.asiainfo.aiga.userCase.dao.IAigaCaseDAO;
import com.asiainfo.aiga.userCase.dao.IAigaFunFolderDAO;
import com.asiainfo.aiga.userCase.dao.IAigaRFunElemDAO;
import com.asiainfo.aiga.userCase.dao.IAigaSeceneDAO;
import com.asiainfo.aiga.userCase.dao.IAigaTestElemDAO;
import com.asiainfo.aiga.userCase.dao.IAigaTestSubElemDAO;
import com.asiainfo.aiga.userCase.service.IAigaCaseWorkflowSV;

public class AigaCaseWorkflowSVImpl implements IAigaCaseWorkflowSV {

	private IAigaCaseDAO aigaCaseDAO;
	private IAigaFunFolderDAO aigaFunFolderDAO;
	private IAigaRFunElemDAO aigaRFunElemDAO;
	private IAigaSeceneDAO aigaSeceneDAO;
	
	public void setAigaFunFolderDAO(IAigaFunFolderDAO aigaFunFolderDAO) {
		this.aigaFunFolderDAO = aigaFunFolderDAO;
	}

	public void setAigaRFunElemDAO(IAigaRFunElemDAO aigaRFunElemDAO) {
		this.aigaRFunElemDAO = aigaRFunElemDAO;
	}

	public void setAigaSeceneDAO(IAigaSeceneDAO aigaSeceneDAO) {
		this.aigaSeceneDAO = aigaSeceneDAO;
	}

	public void setAigaCaseDAO(IAigaCaseDAO aigaCaseDAO) {
		this.aigaCaseDAO = aigaCaseDAO;
	}

	@Override
	public AigaCase[] getAigaInstCases(String funName,String applicateSys,String important,String caseName,Integer start,Integer limit) throws Exception {
		// TODO Auto-generated method stub
		List<Integer> secIds = new ArrayList<Integer>();
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstCase.class);
		criteria.add(Restrictions.eq("needApproval", "Y"));
		if((funName!=null&&funName.length()>0)||(applicateSys!=null&&applicateSys.length()>0)||(important!=null&&important.length()>0)){
			DetachedCriteria criteria2 = DetachedCriteria.forClass(AigaFunFolder.class);
			if(applicateSys!=null&&applicateSys.length()>0)
				criteria2.add(Restrictions.eq("sysId", Integer.valueOf(applicateSys)));
			if(funName!=null&&funName.length()>0)
				criteria2.add(Restrictions.like("sysName", "%"+funName+"%"));
			if(important!=null&&important.length()>0)
				criteria2.add(Restrictions.eq("importantClass", Short.valueOf(important)));
			AigaFunFolder[] aigaFunFolders = aigaFunFolderDAO.getFunFolders(criteria2);
			
			List<Integer> funIds = new ArrayList<Integer>();
			for(AigaFunFolder aigaFunFolder : aigaFunFolders){
				funIds.add(aigaFunFolder.getFunId());
			}
			if(funIds.size()>0){
				List<Integer> elemIds = new ArrayList<Integer>();
				criteria2 = DetachedCriteria.forClass(AigaRFunElem.class);
				criteria2.add(Restrictions.in("funId", funIds));
				AigaRFunElem[] aigaRFunElems = aigaRFunElemDAO.getRFunElem(criteria2);
				for(AigaRFunElem aigaRFunElem : aigaRFunElems){
					elemIds.add(aigaRFunElem.getElemId());
				}
				
				if(elemIds.size()>0){
					criteria2 = DetachedCriteria.forClass(AigaRElemSec.class);
					criteria2.add(Restrictions.in("elemId", elemIds));
					AigaRElemSec[] aigaRElemSecs = aigaSeceneDAO.getRElemSecene(criteria2);
					for(AigaRElemSec aigaRElemSec : aigaRElemSecs){
						secIds.add(aigaRElemSec.getSecId());
					}
				}
			}
			if(secIds.size()>0)
				criteria.add(Restrictions.in("secId", secIds));
			else{
				secIds.add(0);
				criteria.add(Restrictions.in("secId", secIds));
			}
		}
		if(caseName!=null&&caseName.length()>0)
			criteria.add(Restrictions.like("caseName", "%"+caseName+"%"));
		AigaCase[] aigaCases = aigaCaseDAO.getAigaCaseByCriteria(criteria,start,limit);
		return aigaCases;
	}

	@Override
	public int getAigaInstCasesCount(String funName,String applicateSys,String important,String caseName) throws Exception {
		// TODO Auto-generated method stub
		List<Integer> secIds = new ArrayList<Integer>();
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstCase.class);
		criteria.add(Restrictions.eq("needApproval", "Y"));
		if((funName!=null&&funName.length()>0)||(applicateSys!=null&&applicateSys.length()>0)||(important!=null&&important.length()>0)){
			DetachedCriteria criteria2 = DetachedCriteria.forClass(AigaFunFolder.class);
			if(applicateSys!=null&&applicateSys.length()>0)
				criteria2.add(Restrictions.eq("sysId", Integer.valueOf(applicateSys)));
			if(funName!=null&&funName.length()>0)
				criteria2.add(Restrictions.like("sysName", "%"+funName+"%"));
			if(important!=null&&important.length()>0)
				criteria2.add(Restrictions.eq("importantClass", Short.valueOf(important)));
			AigaFunFolder[] aigaFunFolders = aigaFunFolderDAO.getFunFolders(criteria2);
			
			List<Integer> funIds = new ArrayList<Integer>();
			for(AigaFunFolder aigaFunFolder : aigaFunFolders){
				funIds.add(aigaFunFolder.getFunId());
			}
			if(funIds.size()>0){
				List<Integer> elemIds = new ArrayList<Integer>();
				criteria2 = DetachedCriteria.forClass(AigaRFunElem.class);
				criteria2.add(Restrictions.in("funId", funIds));
				AigaRFunElem[] aigaRFunElems = aigaRFunElemDAO.getRFunElem(criteria2);
				for(AigaRFunElem aigaRFunElem : aigaRFunElems){
					elemIds.add(aigaRFunElem.getElemId());
				}
				
				if(elemIds.size()>0){
					criteria2 = DetachedCriteria.forClass(AigaRElemSec.class);
					criteria2.add(Restrictions.in("elemId", elemIds));
					AigaRElemSec[] aigaRElemSecs = aigaSeceneDAO.getRElemSecene(criteria2);
					for(AigaRElemSec aigaRElemSec : aigaRElemSecs){
						secIds.add(aigaRElemSec.getSecId());
					}
					
				}
			}
		}
		if(caseName!=null&&caseName.length()>0)
			criteria.add(Restrictions.like("caseName", "%"+caseName+"%"));
		if(secIds.size()>0)
			criteria.add(Restrictions.in("secId", secIds));
		Integer count = aigaCaseDAO.getAigaCaseCount(criteria);
		return count;
	}

}
