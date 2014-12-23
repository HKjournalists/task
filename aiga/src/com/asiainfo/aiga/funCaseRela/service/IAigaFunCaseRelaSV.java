package com.asiainfo.aiga.funCaseRela.service;

import java.util.List;

import com.asiainfo.aiga.funCaseRela.bo.AigaFunCaseRela;
import com.asiainfo.aiga.funCaseRela.bo.AigaHisFunCaseRela;


public interface IAigaFunCaseRelaSV {

	public List getObjectBySQL(String querySql) throws Exception;

	public void saveNewFunCaseRela(Integer valueOf, String caseIds) throws Exception;

	public void deleteFunCaseRela(Integer valueOf, String caseIds) throws Exception;

	public AigaFunCaseRela[] getAigaFunCaseRelaBySql(String querySql)throws Exception;

	public AigaHisFunCaseRela[] convert(AigaFunCaseRela[] newAigaFunCaseRelas,String operateType) throws Exception;

	public AigaHisFunCaseRela[] getHisAigaFunCaseRelaBySql(String string)throws Exception;

}
