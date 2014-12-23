package com.asiainfo.aiga.service.interfaces;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.asiainfo.aiga.ivalues.IBOAigaSolidTaskValue;
import com.asiainfo.aiga.ivalues.IBOAigaSubTaskProblemValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestPlanValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestSubTaskValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestTaskValue;
import com.asiainfo.csc.matrix.common.interfaces.IAlmVmTask;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;

public interface IAigaTestTaskSV extends IAlmVmTask{

	public void startWorkflow(IBOAigaTestTaskValue aValue,String cond,String option)throws Exception;
	
	public void saveWorkorder(IBOAlmWorkorderValue woValue,List<IBOAlmStakeholderValue> IShVList, String cond) throws Exception;
	
	public void approveWorkorder(IBOAlmWorkorderValue woValue,List<IBOAlmStakeholderValue> IShVList, String cond) throws Exception;
	
	public void saveTestTaskAndFirstWorkorder(IBOAigaTestTaskValue value,String cond,String option) throws Exception;
	
	public IBOAigaTestTaskValue getAigaTestTaskByTaskId(String taskId)throws Exception;
	public IBOAigaTestTaskValue[] getAigaTestTask(String conditions,Map params)throws Exception;
	
	public IBOAigaTestTaskValue saveAigaTestTask(IBOAigaTestTaskValue value) throws Exception;
	public void startAigaTestTaskWorkflow(IBOAigaTestTaskValue iAigaTestTaskValue, 
			IBOAigaTestPlanValue iAigaTestPlanValue)throws Exception;
	
	public void startAigaTestTaskListWorkflowWithoutTestPlan(List<IBOAigaTestTaskValue> iBOAigaTestTaskList)throws Exception;
	
	public void startAigaUETTaskListWorkflow(List<IBOAigaTestTaskValue> iBOAigaTestTaskList,List<IBOAlmStakeholderValue> iBOAlmStakeholderList,String taskId)throws Exception;
	
	public void startAigaTestTaskWorkflowWithoutTestPlan(IBOAigaTestTaskValue iAigaTestTaskValue)throws Exception;
	
	public void splitAigaTestTask(List<IBOAlmStakeholderValue> iBOAlmStakeholderList, List<IBOAlmWorkorderValue> iBOAlmWorkorderList,
			List<IBOAigaTestTaskValue> iBOAigaTestTaskList,JSONArray subTaskStaffs)throws Exception;
	
	public void batchAllotTestTaskToSubTask(JSONArray subTaskStaffs)throws Exception;
	public void batchSubTaskTestorChange(JSONArray subTaskChangeStaffs)throws Exception;
	
	public void startPerfTestTaskWorkflow(IBOAigaTestTaskValue aigaTestTaskValue,List<IBOAlmStakeholderValue> iBOAlmStakeholderList,
			IBOAlmWorkorderValue workorderValue,String taskId)throws Exception;

	public void savePerfTestTaskWorkflow(IBOAigaTestTaskValue aigaTestTaskValue)throws Exception;
	
	public void saveTestTaskChange(IBOAigaTestTaskValue aigaTestTaskValue)throws Exception;
		
	public void subTaskRegn(List<IBOAlmStakeholderValue> iBOAlmStakeholderList,
			List<IBOAlmWorkorderValue> iBOAlmWorkorderList,List<IBOAigaTestPlanValue> iBOAigaTestPlanList,
			List<IBOAigaTestTaskValue> iBOAigaTestTaskList,List<IBOAigaSolidTaskValue> iBOAigaSolidTaskList,
			List<IBOAigaTestSubTaskValue> iBOAigaTestSubTaskValue,
			List<IBOAigaSubTaskProblemValue> iBOAigaSubTaskProblemValue,
			String objType,JSONObject subTaskRegnInfo)throws Exception;
}
