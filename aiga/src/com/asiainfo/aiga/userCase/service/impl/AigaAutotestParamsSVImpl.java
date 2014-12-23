package com.asiainfo.aiga.userCase.service.impl;

import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.userCase.bo.AigaAutotestParams;
import com.asiainfo.aiga.userCase.dao.IAigaAutotestParamsDAO;
import com.asiainfo.aiga.userCase.service.IAigaAutotestParamsSV;

public class AigaAutotestParamsSVImpl implements IAigaAutotestParamsSV {

	private IAigaAutotestParamsDAO aigaAutotestParamsDAO;
	
	public void setAigaAutotestParamsDAO(
			IAigaAutotestParamsDAO aigaAutotestParamsDAO) {
		this.aigaAutotestParamsDAO = aigaAutotestParamsDAO;
	}

	@Override
	public JSONArray getAigaAutotestParamsByCaseId(Integer caseId,Integer parentId)
			throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaAutotestParams.class);
		criteria.add(Restrictions.eq("caseId", caseId));
		criteria.add(Restrictions.eq("parentId", parentId));
		AigaAutotestParams[] paramTitles = aigaAutotestParamsDAO.getAigaAutotestParams(criteria);
		JSONArray titleArray = new JSONArray();
		for(int i=0,n=paramTitles.length;i<n;i++){
			JSONObject titleObjcet = new JSONObject();
			titleObjcet.put("id", paramTitles[i].getParamId());
			titleObjcet.put("text", paramTitles[i].getParamName());
			if(paramTitles[i].getIsleaf().equals("Y"))
				titleObjcet.put("leaf", true);
			else if(paramTitles[i].getIsleaf().equals("N")){
				titleObjcet.put("leaf", false);
				titleObjcet.put("expanded", false);
			}
			titleObjcet.put("paramId", paramTitles[i].getParamId());
			titleObjcet.put("parentId", paramTitles[i].getParentId());
			titleObjcet.put("paramName", paramTitles[i].getParamName());
			titleObjcet.put("paramValue", paramTitles[i].getParamValue());
			titleObjcet.put("isleaf", paramTitles[i].getIsleaf());
			titleObjcet.put("caseId", paramTitles[i].getCaseId());
			titleObjcet.put("paramDesc", paramTitles[i].getParamDesc());
			titleObjcet.put("exeSql", paramTitles[i].getExeSql());
			
			titleArray.add(titleObjcet);
		}
		return titleArray;
	}

	@Override
	public void saveAigaAutotestParams(AigaAutotestParams aValue)
			throws Exception {
		// TODO Auto-generated method stub
		aigaAutotestParamsDAO.saveAigaAutotestParams(aValue);
	}

	@Override
	public void deleteAigaAutotestParams(AigaAutotestParams aValue)
			throws Exception {
		// TODO Auto-generated method stub
		aigaAutotestParamsDAO.deleteAigaAutotestParams(aValue);
	}

	@Override
	public List getAigaAutotestParamsByCriteria(
			DetachedCriteria criteria) throws Exception {
		// TODO Auto-generated method stub
		return aigaAutotestParamsDAO.getAigaAutotestParamsList(criteria);
	}

	@Override
	public void saveAigaAutotestParamss(AigaAutotestParams[] aValue)
			throws Exception {
		// TODO Auto-generated method stub
		for(AigaAutotestParams value:aValue){
			this.deleteAigaAutotestParams(value);
		}
		for(AigaAutotestParams value:aValue){
			value.setParamId(null);
			this.saveAigaAutotestParams(value);
		}
	}

}
