package com.asiainfo.aiga.caseLabelRela.service;

import com.asiainfo.aiga.caseLabelRela.bo.AigaCaseLabelRela;

public interface IAigaCaseLabelRelaSV {

	public AigaCaseLabelRela[] getAigaCaseLabelRelaByLabelId(Integer labelId)throws Exception;
	
	public void saveAigaCaseLabelRela(AigaCaseLabelRela aValue)throws Exception;
	
	public void saveAigaCaseLabelRelaByCaseIds(String labelId,String caseIds)throws Exception;
	
	public void deleteAigaCaseLabelRela(AigaCaseLabelRela aValue)throws Exception;
	
	public void deleteAigaCaseLabelRela(String caseIds,String labelId)throws Exception;
}
