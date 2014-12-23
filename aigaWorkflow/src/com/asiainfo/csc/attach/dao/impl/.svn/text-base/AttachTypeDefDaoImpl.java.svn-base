package com.asiainfo.csc.attach.dao.impl;

import java.util.Map;

import com.asiainfo.csc.attach.bo.BOAttachTypeDefEngine;
import com.asiainfo.csc.attach.dao.interfaces.IAttachTypeDefDao;
import com.asiainfo.csc.attach.ivalues.IBOAttachTypeDefValue;

public class AttachTypeDefDaoImpl implements IAttachTypeDefDao {

	
	public IBOAttachTypeDefValue[] getAttachTypeDef(String condition, Map param)
			throws Exception {
		// TODO Auto-generated method stub
		return BOAttachTypeDefEngine.getBeans(condition,param);
	}

	
	public void saveAttachTypeDef(IBOAttachTypeDefValue value) throws Exception {
		// TODO Auto-generated method stub
		if(value.isNew())
			value.setAttTypeId(BOAttachTypeDefEngine.getNewId().longValue());
		BOAttachTypeDefEngine.save(value);
	}

}
