package com.asiainfo.aiga.dao.interfaces;

import java.util.Map;

import com.asiainfo.aiga.ivalues.IBOAigaSolidTaskValue;

public interface IAigaSolidTaskDao {
	public IBOAigaSolidTaskValue getAigaSolidTaskByTaskId(String taskId)throws Exception;
	public IBOAigaSolidTaskValue[] getAigaSolidTasks(String conditions,Map params)throws Exception;
	
	public IBOAigaSolidTaskValue saveAigaSolidTask(IBOAigaSolidTaskValue o)throws Exception;
}
