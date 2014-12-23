package com.asiainfo.csc.matrix.dao.interfaces;

import java.util.Map;

import com.asiainfo.csc.matrix.ivalues.IBOWorkflowComponentConfigValue;

public interface IWorkflowComponentConfigDao {

	public IBOWorkflowComponentConfigValue[] getWorkflowComponentConfig(String condition,Map param)throws Exception;
}
