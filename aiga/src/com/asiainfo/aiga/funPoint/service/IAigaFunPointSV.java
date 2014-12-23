package com.asiainfo.aiga.funPoint.service;

import java.util.List;

import com.asiainfo.aiga.funPoint.bo.AigaFunPoint;
import com.asiainfo.aiga.funPoint.bo.AigaKnowledge;

public interface IAigaFunPointSV {

	public void saveOrUpdate(Object aValue)throws Exception;
	
	public void saveOrUpdateList(List list) throws Exception;
	
	public void delete(Object aValue)throws Exception;
	
	public AigaFunPoint[] getFunPointBySql(String querySql) throws Exception;
	
	public AigaKnowledge[] getKnowledgeBySql(String querySql) throws Exception;
	
}
