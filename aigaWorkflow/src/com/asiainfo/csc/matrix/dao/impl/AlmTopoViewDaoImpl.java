package com.asiainfo.csc.matrix.dao.impl;

import java.util.Map;

import com.asiainfo.csc.matrix.bo.BOTopoViewEngine;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmTopoViewDao;
import com.asiainfo.csc.matrix.ivalues.IBOTopoViewValue;

public class AlmTopoViewDaoImpl implements IAlmTopoViewDao {

	
	public IBOTopoViewValue[] getTopoByCondition(String condition, Map paramter) throws Exception {
		// TODO Auto-generated method stub
		return BOTopoViewEngine.getBeans(condition,paramter);
	}

}
