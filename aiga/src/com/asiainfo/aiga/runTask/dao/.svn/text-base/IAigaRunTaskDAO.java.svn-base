package com.asiainfo.aiga.runTask.dao;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.runTask.bo.AigaHisRunTaskResult;
import com.asiainfo.aiga.runTask.bo.AigaRunTask;

public interface IAigaRunTaskDAO {
	public AigaRunTask[] getAigaRunTaskBySql(String querySql) throws Exception;

	public AigaRunTask[] getRunTaskByCriteria(DetachedCriteria criteria) throws Exception;

	public AigaRunTask[] getUpdateByCriteria(DetachedCriteria criteria) throws Exception;

	public void saveOrUpdate(AigaRunTask aValue) throws Exception;

	public void delete(AigaRunTask aValue) throws Exception;
	
	public void saveAigaHisRunTaskResult(AigaHisRunTaskResult[] hisValues) throws Exception;
}
