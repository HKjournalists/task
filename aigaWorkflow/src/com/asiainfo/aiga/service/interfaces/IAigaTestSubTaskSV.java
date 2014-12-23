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
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;

public interface IAigaTestSubTaskSV {
	public IBOAigaTestSubTaskValue getAigaTestSubTaskBySubTaskId(String taskId)throws Exception;
	public IBOAigaTestSubTaskValue[] getAigaTestSubTasks(String conditions,Map params)throws Exception;
	
	public IBOAigaTestSubTaskValue saveAigaTestSubTask(IBOAigaTestSubTaskValue value) throws Exception;
	
	public IBOAigaTestSubTaskValue saveAigaTestSubTaskByTestTask(IBOAigaTestSubTaskValue iAigaTestSubTaskValue, 
			IBOAigaTestTaskValue iAigaTestTaskValue) throws Exception;
	
	public void startAigaTestSubTaskWorkflow(IBOAigaTestTaskValue iAigaTestTaskValue,
			IBOAigaTestSubTaskValue iAigaTestSubTaskValue)throws Exception;
	
	public void startAigaPerfSubTaskWorkflow(IBOAigaTestSubTaskValue iAigaTestSubTaskValue,
			List<IBOAlmStakeholderValue> stds,
			List<IBOAlmWorkorderValue> orders)throws Exception;
	
	public void batchSubTaskReview(JSONArray subTasks,String StaffId, String StaffName)throws Exception;
	
	public void startProblemWF(IBOAigaSubTaskProblemValue aigaSubTaskProblemValue,String subTask,String problemTag,String StaffId, String StaffName)throws Exception;
	
	public IBOAigaSubTaskProblemValue[] getAigaSubTaskProblems(String conditions,Map params)throws Exception;
	
	public IBOAigaSubTaskProblemValue saveAigaSubTaskProblem(IBOAigaSubTaskProblemValue value) throws Exception;
	
	public IBOAigaSubTaskProblemValue getAigaSubTaskProblemById(String id)throws Exception;
}
