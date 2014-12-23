package com.asiainfo.aiga.service.interfaces;

import java.util.List;
import java.util.Map;

import com.asiainfo.aiga.ivalues.IBOAigaSolidTaskValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestPlanValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;

public interface IAigaSolidTaskSV {
	public IBOAigaSolidTaskValue getAigaSolidTaskByTaskId(String taskId)throws Exception;
	public IBOAigaSolidTaskValue[] getAigaSolidTasks(String conditions,Map params)throws Exception;
	
	public IBOAigaSolidTaskValue saveAigaSolidTask(IBOAigaSolidTaskValue value) throws Exception;
	
	public IBOAigaSolidTaskValue saveAigaSolidTaskByTaskPlan(IBOAigaSolidTaskValue iAigaSolidTaskValue, 
			IBOAigaTestPlanValue iAigaTestPlanValue) throws Exception;
	
	public void startAigaSolidTaskWorkflow(IBOAigaTestPlanValue iAigaTestPlanValue,IBOAigaSolidTaskValue iAigaSolidTaskValue,
			List<IBOAlmStakeholderValue> stds,IBOAlmWorkorderValue workorderValue)throws Exception;
}
