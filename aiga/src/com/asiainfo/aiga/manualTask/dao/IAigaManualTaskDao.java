package com.asiainfo.aiga.manualTask.dao;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.manualTask.bo.AigaManualTask;

public interface IAigaManualTaskDao {

	public AigaManualTask[] getManualTask(DetachedCriteria criteria)throws Exception;
	
	public void saveManualTask(AigaManualTask aValue)throws Exception;
	
	public void deleteManualTask(AigaManualTask aValue)throws Exception;
}
