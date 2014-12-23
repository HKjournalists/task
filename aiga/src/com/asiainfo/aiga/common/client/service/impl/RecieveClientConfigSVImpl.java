package com.asiainfo.aiga.common.client.service.impl;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.common.client.bo.AigaClientConfig;
import com.asiainfo.aiga.common.client.dao.IRecieveClientConfigDAO;
import com.asiainfo.aiga.common.client.service.IRecieveClientConfigSV;

public class RecieveClientConfigSVImpl implements IRecieveClientConfigSV{

	private IRecieveClientConfigDAO clientConfigDAO;
	
	public void setClientConfigDAO(IRecieveClientConfigDAO clientConfigDAO) {
		this.clientConfigDAO = clientConfigDAO;
	}

	@Override
	public void saveRecieveClientConfig(String ip, String port, String pathMap,
			String nickName,String uuid) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaClientConfig.class);
		criteria.add(Restrictions.eq("nickName", nickName));
		criteria.add(Restrictions.eq("port", port));
		criteria.add(Restrictions.eq("ip", ip));
		AigaClientConfig[] clientConfig = clientConfigDAO.getRecieveClientConfig(criteria);
		AigaClientConfig config = null;
		if(clientConfig.length==0)
			config = new AigaClientConfig();
		else if(clientConfig.length==1)
			config = clientConfig[0];
		else
			throw new Exception("≤È—ØµΩµƒ÷’∂À≈‰÷√¥Û”⁄1,÷’∂À√˚≥∆:"+nickName+"÷’∂ÀIP:"+ip+"÷’∂ÀPORT:"+port);
		
		config.setIp(ip);
		config.setNickName(nickName);
		config.setPathMap(pathMap);
		config.setPort(port);
		config.setUuid(uuid);
		config.setStatus(1);
		
		clientConfigDAO.saveRecieveClientConfig(config);
	}

}
