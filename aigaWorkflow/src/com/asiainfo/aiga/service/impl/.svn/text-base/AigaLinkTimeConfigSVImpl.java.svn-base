package com.asiainfo.aiga.service.impl;

import java.util.Map;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.aiga.dao.interfaces.IAigaLinkTimeConfigDao;
import com.asiainfo.aiga.ivalues.IBOAigaLinkTimeConfigValue;
import com.asiainfo.aiga.service.interfaces.IAigaLinkTimeConfigSV;

public class AigaLinkTimeConfigSVImpl implements IAigaLinkTimeConfigSV{

	@Override
	public IBOAigaLinkTimeConfigValue[] getLinkTimeConfigByCondition(
			String condition, Map param) throws Exception {
		// TODO Auto-generated method stub
		IAigaLinkTimeConfigDao iAigaLinkTimeConfigDao = (IAigaLinkTimeConfigDao)ServiceFactory.getService(IAigaLinkTimeConfigDao.class);
		return iAigaLinkTimeConfigDao.getLinkTimeConfigByCondition(condition, param);
	}

	@Override
	public IBOAigaLinkTimeConfigValue[] getLinkTimeConfigByLinkMark(
			String linkNo, String mark)  throws Exception{
		// TODO Auto-generated method stub
		Criteria sql = new Criteria();
		sql.addEqual(IBOAigaLinkTimeConfigValue.S_LinkNo, linkNo);
		sql.addEqual(IBOAigaLinkTimeConfigValue.S_Mark, mark);
		return getLinkTimeConfigByCondition(sql.toString(),sql.getParameters());
	}

}
