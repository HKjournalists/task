package com.asiainfo.csc.matrix.dao.impl;

import java.util.HashMap;
import java.util.Map;

import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.matrix.bo.BOAlmWorkorderEngine;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmWorkorderDao;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;

public class AlmWorkorderDaoImpl implements IAlmWorkorderDao {

	
	public IBOAlmWorkorderValue[] getAlmWorkorderByCondition(String condition,
			Map paramter) throws Exception {
		// TODO Auto-generated method stub
		return BOAlmWorkorderEngine.getBeans(condition,paramter);
	}

	
	public void saveAlmWorkorder(IBOAlmWorkorderValue[] workorders) throws Exception {
		// TODO Auto-generated method stub
		for(IBOAlmWorkorderValue workorder : workorders){
			if(workorder.isNew())
				workorder.setOrderId(BOAlmWorkorderEngine.getNewId().longValue());
			BOAlmWorkorderEngine.save(workorder);
		}
	}

	
	public void saveAlmWorkorder(IBOAlmWorkorderValue workorder)
			throws Exception {
		// TODO Auto-generated method stub
		if(workorder.isNew())
			workorder.setOrderId(BOAlmWorkorderEngine.getNewId().longValue());
		BOAlmWorkorderEngine.save(workorder);
	}

	
	public IBOAlmWorkorderValue[] getBeans(Criteria sql) throws Exception {
		// TODO Auto-generated method stub
		return BOAlmWorkorderEngine.getBeans(sql);
	}

	
	public IBOAlmWorkorderValue queryWorkOrderById(String workOrderID) throws NumberFormatException, Exception {
		// TODO Auto-generated method stub
		return BOAlmWorkorderEngine.getBean(Long.parseLong(workOrderID));
	}

	
	public IBOAlmWorkorderValue[] queryWorkOrders(String condition,
			HashMap parameters, int $startrowindex, int $endrowindex) throws Exception {
		// TODO Auto-generated method stub
		return BOAlmWorkorderEngine.getBeans(null, condition, parameters, $startrowindex, $endrowindex, false);
	}

	
	public int queryWorkOrdersCount(String condition, HashMap parameters) throws Exception {
		// TODO Auto-generated method stub
		return BOAlmWorkorderEngine.getBeansCount(condition, parameters);
	}

}
