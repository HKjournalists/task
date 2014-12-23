package com.asiainfo.aiga.groupJointDebug.service;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.groupCase.bo.AigaRGroupChangeCase;
import com.asiainfo.aiga.groupJointDebug.bo.AigaJointDebugChange;
import com.asiainfo.aiga.groupJointDebug.bo.AigaJointDebugReqForm;
import com.asiainfo.aiga.groupJointDebug.bo.AigaJointDebugSubTaskForm;
import com.asiainfo.aiga.groupJointDebug.bo.AigaJointDebugTaskForm;

public interface IAigaJointDebugSV {
	
	public void saveAigaJointDebugReqForm(AigaJointDebugReqForm aValue)throws Exception;
	
	public void saveAigaRGroupChangeCase(AigaRGroupChangeCase aValue)throws Exception;
	
	public AigaJointDebugReqForm[] getAigaJointDebugReqForm(DetachedCriteria criteria)throws Exception;
	
	public AigaJointDebugReqForm[] getAigaJointDebugReqForm(String querySql)throws Exception;
	
	public void deleteAigaJointDebugReqForm(AigaJointDebugReqForm aValue)throws Exception;

	public void deleteAigaJointDebugReqForm(String reqIds)throws Exception;
	
	public void saveAigaJointDebugTaskForm(AigaJointDebugTaskForm aValue)throws Exception;
	
	public AigaJointDebugTaskForm[] getAigaJointDebugTaskForm(DetachedCriteria criteria)throws Exception;
	
	public AigaJointDebugTaskForm[] getAigaJointDebugTaskForm(String querySql)throws Exception;
	
	public void deleteAigaJointDebugTaskForm(AigaJointDebugTaskForm aValue)throws Exception;

	public void deleteAigaJointDebugTaskForm(String taskIds)throws Exception;
	
	public void saveAigaJointDebugSubTaskForm(AigaJointDebugSubTaskForm aValue)throws Exception;
	
	public AigaJointDebugSubTaskForm[] getAigaJointDebugSubTaskForm(DetachedCriteria criteria)throws Exception;
	
	public AigaJointDebugSubTaskForm[] getAigaJointDebugSubTaskForm(String querySql)throws Exception;
	
	public void deleteAigaJointDebugSubTaskForm(AigaJointDebugSubTaskForm aValue)throws Exception;

	public void deleteAigaJointDebugSubTaskForm(String subTaskIds)throws Exception;
	
	public void saveAigaJointDebugChange(AigaJointDebugChange aValue)throws Exception;
	
	public AigaJointDebugChange[] getAigaJointDebugChange(DetachedCriteria criteria)throws Exception;
	
	public AigaJointDebugChange[] getAigaJointDebugChange(String querySql)throws Exception;
	
	public void deleteAigaJointDebugChange(AigaJointDebugChange aValue)throws Exception;
}
