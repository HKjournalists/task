package com.asiainfo.aiga.service.impl;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.aiga.dao.interfaces.IAigaSpecialDayConfigDao;
import com.asiainfo.aiga.ivalues.IBOAigaSpecialDayConfigValue;
import com.asiainfo.aiga.service.interfaces.IAigaSpecialDayConfigSV;

public class AigaSpecialDayConfigSVImpl implements IAigaSpecialDayConfigSV{

	@Override
	public IBOAigaSpecialDayConfigValue[] specialDayByCondition(String condition, Map param)
			throws Exception {
		// TODO Auto-generated method stub
		IAigaSpecialDayConfigDao iAigaSpecialDayConfigDao = (IAigaSpecialDayConfigDao)ServiceFactory.getService(IAigaSpecialDayConfigDao.class);
		return iAigaSpecialDayConfigDao.specialDayByCondition(condition, param);
	}

	@Override
	public IBOAigaSpecialDayConfigValue[] getSpecialDayByDayTimeMark(
			String dayTime, String mark) throws Exception {
		// TODO Auto-generated method stub
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); 
		//DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
		String bngtimestamp = " 00:00:00";
		String endtimestamp = " 23:59:59";
		Date begindate = formatter.parse(dayTime+bngtimestamp); 
		Date enddate = formatter.parse(dayTime+endtimestamp); 

		Criteria sqlCriteria = new Criteria();
		sqlCriteria.addGREATEREqual(IBOAigaSpecialDayConfigValue.S_SpecialDay, new Timestamp(begindate.getTime()));
		sqlCriteria.addLESSEqual(IBOAigaSpecialDayConfigValue.S_SpecialDay, new Timestamp(enddate.getTime()));
		
		sqlCriteria.addEqual(IBOAigaSpecialDayConfigValue.S_Mark, mark);
		return specialDayByCondition(sqlCriteria.toString(),sqlCriteria.getParameters());
	}

}
