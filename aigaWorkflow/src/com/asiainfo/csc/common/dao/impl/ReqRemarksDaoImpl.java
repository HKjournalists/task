package com.asiainfo.csc.common.dao.impl;

import java.util.Map;

import com.asiainfo.csc.common.bo.BOReqRemarksEngine;
import com.asiainfo.csc.common.dao.interfaces.IReqRemarksDao;
import com.asiainfo.csc.common.ivalues.IBOReqRemarksValue;

public class ReqRemarksDaoImpl implements IReqRemarksDao {

	
	public IBOReqRemarksValue[] getRemarksByCon(String condition, Map parameter)
			throws Exception {
		return BOReqRemarksEngine.getBeans(condition,parameter);
	}

	
	public void saveRemarks(IBOReqRemarksValue value) throws Exception {
		BOReqRemarksEngine.save(value);
	}

	
	public long getNewId() throws Exception {
		return BOReqRemarksEngine.getNewId().longValue();
	}

}
