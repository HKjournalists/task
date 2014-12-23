package com.asiainfo.aiga.dao.impl;

import java.util.Map;

import com.asiainfo.aiga.bo.BOAigaTestPlanBean;
import com.asiainfo.aiga.bo.BOAigaTestPlanChangeEngine;
import com.asiainfo.aiga.bo.BOAigaTestPlanEngine;
import com.asiainfo.aiga.dao.interfaces.IAigaTestPlanDao;
import com.asiainfo.aiga.ivalues.IBOAigaTestPlanChangeValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestPlanValue;

public class AigaTestPlanDaoImpl implements IAigaTestPlanDao{

	@Override
	public IBOAigaTestPlanValue saveAigaTestPlan(IBOAigaTestPlanValue aValue) throws Exception {
		// TODO Auto-generated method stub
		if(aValue.getPlanId() == 0)
			aValue.setPlanId(BOAigaTestPlanEngine.getNewId().longValue());
		BOAigaTestPlanEngine.save(aValue);
		return aValue;
	}

	@Override
	public IBOAigaTestPlanValue[] getAigaTestPlan(String condition, Map param)
			throws Exception {
		// TODO Auto-generated method stub
		return BOAigaTestPlanEngine.getBeans(condition, param);
	}

	@Override
	public IBOAigaTestPlanValue getAigaTestPlanByPlanId(String planId)
			throws Exception {
		// TODO Auto-generated method stub
		return BOAigaTestPlanEngine.getBean(Long.valueOf(planId));
	}

	@Override
	public void saveAigaTestPlanChange(IBOAigaTestPlanChangeValue value)
			throws Exception {
		// TODO Auto-generated method stub
		if(value.getAcId() == 0)
			value.setAcId(BOAigaTestPlanChangeEngine.getNewId().longValue());
		BOAigaTestPlanChangeEngine.save(value);
	}

}
