package com.asiainfo.csc.matrix.dao.impl;

import com.asiainfo.csc.matrix.bo.BOAlmHisWorkflowCaseEngine;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmHisWorkflowCaseDao;
import com.asiainfo.csc.matrix.ivalues.IBOAlmHisWorkflowCaseValue;

public class AlmHisWorkflowCaseDaoImpl implements IAlmHisWorkflowCaseDao{

	
	public void saveHisWorkflowCase(IBOAlmHisWorkflowCaseValue[] value)
			throws Exception {
		// TODO Auto-generated method stub
		BOAlmHisWorkflowCaseEngine.save(value);
	}

}
