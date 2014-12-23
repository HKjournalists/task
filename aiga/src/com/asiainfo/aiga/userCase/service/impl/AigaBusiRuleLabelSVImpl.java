package com.asiainfo.aiga.userCase.service.impl;

import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.userCase.bo.AigaAutotestParams;
import com.asiainfo.aiga.userCase.bo.AigaBusiRuleLabel;
import com.asiainfo.aiga.userCase.dao.IAigaAutotestParamsDAO;
import com.asiainfo.aiga.userCase.dao.IAigaBusiRuleLabelDAO;
import com.asiainfo.aiga.userCase.service.IAigaAutotestParamsSV;
import com.asiainfo.aiga.userCase.service.IAigaBusiRuleLabelSV;

public class AigaBusiRuleLabelSVImpl implements IAigaBusiRuleLabelSV {

	private IAigaBusiRuleLabelDAO aigaBusiRuleLabelDAO;
	
	public void setAigaBusiRuleLabelDAO(
			IAigaBusiRuleLabelDAO aigaBusiRuleLabelDAO) {
		this.aigaBusiRuleLabelDAO = aigaBusiRuleLabelDAO;
	}

	@Override
	public void deleteAigaBusiRuleLabel(AigaBusiRuleLabel aValue)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List getAigaBusiRuleLabelByCriteria(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void saveAigaBusiRuleLabel(AigaBusiRuleLabel aValue)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void saveAigaBusiRuleLabel(AigaBusiRuleLabel[] aValue)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

}
