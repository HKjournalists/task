package com.asiainfo.csc.common.dao.interfaces;

import java.util.HashMap;
import java.util.Map;

import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.common.ivalues.IBOHisWorkorderValue;
import com.asiainfo.csc.common.ivalues.IBOWorkorderExtendValue;
import com.asiainfo.csc.common.ivalues.IBOWorkorderListValue;
import com.asiainfo.csc.common.ivalues.IBOWorkorderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;

public interface IWorkorderDao {
	/**
	 * 保存工单的方法
	 * 
	 * @param order
	 * @throws Exception
	 */
	public void saveWorkorder(IBOWorkorderValue order) throws Exception;

	/**
	 * 查询工单的方法
	 * 
	 * @param sql
	 * @return
	 * @throws Exception
	 */
	public IBOWorkorderValue[] getWorkorders(Criteria sql) throws Exception;
	
	public IBOWorkorderValue getWorkorderById(long orderId)throws Exception;

	/**
	 * 查询工单列表方法
	 * 
	 * @param cond
	 * @param param
	 * @param startIndex
	 * @param endIndex
	 * @return
	 * @throws Exception
	 */
	public IBOWorkorderListValue[] queryWorkorderList(String cond, Map param,
			int startIndex, int endIndex) throws Exception;

	/**
	 * 计数工单列表方法
	 * 
	 * @param cond
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int countWorkorderList(String cond, Map param) throws Exception;
	
	
	
	public void saveHisWorkorder(IBOHisWorkorderValue hisOrder)throws Exception;
	
	public void saveWorkorderExtend(IBOWorkorderExtendValue orderExtend)throws Exception;
	
	public IBOWorkorderExtendValue getWorkorderExtendById(long orderId)throws Exception;
	
	public IBOWorkorderValue[] getDiscussRelaOrder(String condition, Map params) throws Exception;
	
	public IBOWorkorderValue[] getDiscussingOrder(String condition, Map params) throws Exception;
	
	public int queryWorkorderListCount(String string, Map parameters) throws Exception;

	public IBOWorkorderListValue[] queryWorkorderList(String string,HashMap parameters, int $startrowindex, int $endrowindex)throws Exception;
	
	public IBOWorkorderValue[] getWorkorder(String condition, Map params) throws Exception;

	public IBOWorkorderListValue[] queryReqFunctionPointSetTree(String objId,String objType) throws Exception;

	public IBOWorkorderListValue[] FunctionPointSetByReqIdAndLinkId(long objId,
			long linkId) throws Exception;
	
	public IBOWorkorderListValue[] queryDoWorkorderList(Criteria sql)throws Exception;
	
	public IBOWorkorderListValue[] FunctionPointSetByReqIdForTree(long objId) throws Exception;
	
	public IBOWorkorderListValue[] FunctionPointSetByFunpIdForTree(long funpId) throws Exception;
	
	public IBOWorkorderListValue[] queryAlmVerTree(String objId,String objType) throws Exception;
	
	//浙江查询工单列表
	public IBOWorkorderListValue[] queryWorkorderListById(String cond, Map param)throws Exception;
	
	public IBOWorkorderListValue[] queryWorklistBySql(String objId,String objType) throws Exception;
}
