package com.asiainfo.csc.matrix.service.interfaces;

import java.util.Map;

import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowDrivingValue;

public interface IAlmWorkflowDrivingSV {
	public IBOAlmWorkflowDrivingValue[] getAlmWorkflowDrivingByCondition(String condition,Map paramter) throws Exception;
}
