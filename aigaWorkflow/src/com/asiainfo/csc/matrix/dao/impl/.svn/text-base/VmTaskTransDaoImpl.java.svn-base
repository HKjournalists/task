package com.asiainfo.csc.matrix.dao.impl;

import java.util.Map;

import com.asiainfo.csc.matrix.bo.BOVmTaskTransEngine;
import com.asiainfo.csc.matrix.dao.interfaces.IVmTaskTransDao;
import com.asiainfo.csc.matrix.ivalues.IBOVmTaskTransValue;

public class VmTaskTransDaoImpl implements IVmTaskTransDao{

	
	public IBOVmTaskTransValue[] getValueByCondition(String condition,
			Map paramter) throws Exception {
		// TODO Auto-generated method stub
		return BOVmTaskTransEngine.getBeans(condition, paramter);
	}

	
	public void saveVmTaskTrans(IBOVmTaskTransValue o) throws Exception {
		// TODO Auto-generated method stub
		if(o.isNew())
			o.setTaskId(BOVmTaskTransEngine.getNewId().longValue());
		BOVmTaskTransEngine.save(o);
	}

}
