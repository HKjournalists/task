package com.asiainfo.aiga.userCase.dao;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.userCase.bo.AigaHisSecene;
import com.asiainfo.aiga.userCase.bo.AigaRElemSec;
import com.asiainfo.aiga.userCase.bo.AigaSecene;

public interface IAigaSeceneDAO {
	
	public AigaSecene[] getSecene(DetachedCriteria criteria)throws Exception;
	
	public void saveSecene(AigaSecene aValue)throws Exception;
	
	public void deleteSecene(AigaSecene aValue)throws Exception;
	
	public AigaRElemSec[] getRElemSecene(DetachedCriteria criteria)throws Exception;
	
	public void deleteRElemSec(AigaRElemSec aigaRElemSec)throws Exception;
	
	public void saveRElemSec(AigaRElemSec aigaRElemSec)throws Exception;
	
	public AigaHisSecene[] getHisSeceneBySql(String querySql) throws Exception;

	public AigaSecene[] getSeceneBySql(String querySql) throws Exception;
	
}
