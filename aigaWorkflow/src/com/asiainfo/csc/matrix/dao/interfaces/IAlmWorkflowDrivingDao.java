package com.asiainfo.csc.matrix.dao.interfaces;

import java.util.Map;

import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowDrivingValue;

public interface IAlmWorkflowDrivingDao {
	public IBOAlmWorkflowDrivingValue[] getAlmWorkflowDrivingByCondition(String condition,Map paramter) throws Exception;
}
