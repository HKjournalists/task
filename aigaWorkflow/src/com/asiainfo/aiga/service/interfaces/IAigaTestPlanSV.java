package com.asiainfo.aiga.service.interfaces;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.asiainfo.aiga.ivalues.IBOAigaSolidTaskValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestPlanChangeValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestPlanValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestTaskValue;
import com.asiainfo.csc.matrix.common.interfaces.IAlmVmTask;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;

public interface IAigaTestPlanSV extends IAlmVmTask{

	public void startWorkflow(IBOAigaTestPlanValue aValue,String cond,String option)throws Exception;
	
	public void saveTestPlanAndFirstWorkorder(IBOAigaTestPlanValue value,String cond,String option) throws Exception;
	
	public void saveWorkorder(IBOAlmWorkorderValue woValue,List<IBOAlmStakeholderValue> IShVList, String cond) throws Exception;
	
	public void approveWorkorder(IBOAlmWorkorderValue woValue,List<IBOAlmStakeholderValue> IShVList, String cond) throws Exception;
		
	public void startTestPlanWorkflow(List<IBOAigaTestPlanValue> atps, List<IBOAlmStakeholderValue> stds,
			List<IBOAlmWorkorderValue> orders,List<IBOAigaTestTaskValue> attasks,
			List<IBOAigaSolidTaskValue> astasks)throws Exception;
	
	public void startWorkflow(String templateId,String objId, String objType, String cond)throws Exception;
	
	public IBOAigaTestPlanValue getAigaTestPlanByPlanId(String planId)throws Exception;
	
	public IBOAigaTestPlanValue[] getAigaTestPlan(String conditions,Map params)throws Exception;
	
	public IBOAigaTestPlanValue saveAigaTestPlan(IBOAigaTestPlanValue value) throws Exception;
	
	public void startTestPlanWorkflow(IBOAigaTestPlanValue aValue,List<IBOAlmStakeholderValue> stds,
									IBOAlmWorkorderValue workorderValue)throws Exception;
	
	public void saveTestPlanFirstOrder(List<IBOAigaTestPlanValue> atps,List<IBOAlmStakeholderValue> stds,
			IBOAlmWorkorderValue workorderValue,List<IBOAigaTestTaskValue> attasks)throws Exception;
	
	public void testPlanChange(JSONObject testPlanChange)throws Exception;
	
	public void saveAigaTestPlanChange(IBOAigaTestPlanChangeValue value) throws Exception;

}
