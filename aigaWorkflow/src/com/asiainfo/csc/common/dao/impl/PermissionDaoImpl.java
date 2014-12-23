package com.asiainfo.csc.common.dao.impl;

import java.util.HashMap;
import java.util.Map;

import com.asiainfo.csc.common.bo.projectIdEngine;
import com.asiainfo.csc.common.dao.interfaces.IPermissionDao;
import com.asiainfo.csc.common.ivalues.IprojectIdValue;

public class PermissionDaoImpl implements IPermissionDao
{
	public String[] getProjectId(long staffId) throws Exception {
		try{
			String[] ar = null;
			String condition  = "staff_id=:1";
			Map parameter  = new HashMap();
			parameter.put("1", staffId);
			IprojectIdValue[] array = projectIdEngine.getBeans(condition, parameter);
			ar = new String[array.length];
			int i = 0;
			for(IprojectIdValue o : array){
				ar[i] = o.getKindName();
				i++;
			}
			return ar;
		}catch(Exception e){
			throw e;
		}
	}
}
