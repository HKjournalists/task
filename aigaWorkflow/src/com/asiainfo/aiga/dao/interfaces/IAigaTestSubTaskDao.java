package com.asiainfo.aiga.dao.interfaces;

import java.util.Map;

import com.asiainfo.aiga.ivalues.IBOAigaSubTaskProblemValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestSubTaskValue;

public interface IAigaTestSubTaskDao {
	public IBOAigaTestSubTaskValue getAigaTestSubTaskBySubTaskId(String taskId)throws Exception;
	public IBOAigaTestSubTaskValue[] getAigaTestSubTasks(String conditions,Map params)throws Exception;
	
	public IBOAigaTestSubTaskValue saveAigaTestSubTask(IBOAigaTestSubTaskValue o)throws Exception;
	
	public IBOAigaSubTaskProblemValue[] getAigaSubTaskProblems(String conditions,Map params)throws Exception;
	
	public IBOAigaSubTaskProblemValue saveAigaSubTaskProblem(IBOAigaSubTaskProblemValue value) throws Exception;
	
	public IBOAigaSubTaskProblemValue getAigaSubTaskProblemById(String id)throws Exception;
}
