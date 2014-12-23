package com.asiainfo.aiga.userCase.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.userCase.bo.AigaBusiRuleLabel;

public interface IAigaBusiRuleLabelSV {

	public List getAigaBusiRuleLabelByCriteria(DetachedCriteria criteria)throws Exception;
	
	public void saveAigaBusiRuleLabel(AigaBusiRuleLabel aValue)throws Exception;
	
	public void deleteAigaBusiRuleLabel(AigaBusiRuleLabel aValue)throws Exception;
	
	public void saveAigaBusiRuleLabel(AigaBusiRuleLabel[] aValue)throws Exception;
}
