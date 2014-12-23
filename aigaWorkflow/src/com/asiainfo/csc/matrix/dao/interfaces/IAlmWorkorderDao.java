package com.asiainfo.csc.matrix.dao.interfaces;

import java.util.HashMap;
import java.util.Map;

import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;

public interface IAlmWorkorderDao {
	public IBOAlmWorkorderValue[] getAlmWorkorderByCondition(String condition,Map paramter) throws Exception;
	public void saveAlmWorkorder(IBOAlmWorkorderValue[] workorders) throws Exception;
	public void saveAlmWorkorder(IBOAlmWorkorderValue workorder) throws Exception;
	public IBOAlmWorkorderValue[] getBeans(Criteria sql)throws Exception;
	public IBOAlmWorkorderValue queryWorkOrderById(String workOrderID) throws NumberFormatException, Exception;
	public IBOAlmWorkorderValue[] queryWorkOrders(String string,
			HashMap parameters, int $startrowindex, int $endrowindex) throws Exception;
	public int queryWorkOrdersCount(String string, HashMap parameters) throws Exception;
}
