package com.asiainfo.aiga.common.client.dao;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.common.client.bo.AigaClientConfig;

public interface IRecieveClientConfigDAO {

	public void saveRecieveClientConfig(AigaClientConfig aValue)throws Exception;
	
	public AigaClientConfig[] getRecieveClientConfig(DetachedCriteria criteria)throws Exception;
	
	public void deleteRecieveClientConfig(AigaClientConfig aValue)throws Exception;
}
