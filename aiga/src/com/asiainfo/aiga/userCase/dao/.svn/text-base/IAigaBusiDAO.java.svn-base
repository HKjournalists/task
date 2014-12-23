package com.asiainfo.aiga.userCase.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.collection.bo.AigaCaseCollection;
import com.asiainfo.aiga.userCase.bo.AigaBusi;

public interface IAigaBusiDAO {

	public AigaBusi[] getAigaBusis(DetachedCriteria criteria)throws Exception;
	

	public AigaBusi[] getAigaBusiBySql(String querySql)throws Exception;
	
	public List getBusiIdByCriteria(DetachedCriteria criteria)throws Exception;
	
	public AigaBusi[] getAigaBusiByCriteria(DetachedCriteria criteria)throws Exception;
	
	public void saveAigaBusi(AigaBusi aValue)throws Exception;
	
	public void deleteAigaBusi(AigaBusi aValue)throws Exception;
}
