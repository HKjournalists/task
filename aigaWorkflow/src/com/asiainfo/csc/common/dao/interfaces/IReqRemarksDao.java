package com.asiainfo.csc.common.dao.interfaces;

import java.util.Map;

import com.asiainfo.csc.common.ivalues.IBOReqRemarksValue;

public interface IReqRemarksDao {

	public void saveRemarks(IBOReqRemarksValue value)throws Exception;
	
	public IBOReqRemarksValue[] getRemarksByCon(String condition,Map parameter)throws Exception;
	
	public long getNewId()throws Exception;
}
