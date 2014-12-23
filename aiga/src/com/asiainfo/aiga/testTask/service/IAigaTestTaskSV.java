package com.asiainfo.aiga.testTask.service;

import com.asiainfo.aiga.testTask.bo.AigaTestTask;
import com.asiainfo.aiga.testTask.bo.AigaTestTaskChange;

public interface IAigaTestTaskSV {
	public void saveAigaTestTask(AigaTestTask aValue)throws Exception;
	
	public void deleteAigaTestTask(AigaTestTask aValue)throws Exception;
	
	public AigaTestTask[] getAigaTestTaskByFunPointId(String funPointId)throws Exception;
	
	public AigaTestTask[] getAigaTestTaskBySql(String querySql) throws Exception;
	
	public boolean changeAigaTestTask(AigaTestTask o,String changeStaffid,String changeStaffName)throws Exception;
	
	public void saveAigaTestTaskChange(AigaTestTaskChange o)throws Exception;
}
