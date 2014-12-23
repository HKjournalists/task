package com.asiainfo.csc.common.service.interfaces;

import java.util.Map;

import com.ai.appframe2.bo.DataContainer;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.common.bo.BOTreeReqFunctionPointsBean;
import com.asiainfo.csc.common.ivalues.IBOWorkorderListValue;
import com.asiainfo.csc.common.ivalues.IBOWorkorderValue;

public interface IWorkorderSV {
	
	/**
	 * 待办工单列表查询方法
	 * @param staffId
	 * @param status
	 * @param start
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public IBOWorkorderListValue[] queryDoWorkorderList(long staffId, String status, int start, int end)throws Exception;
	
	/**
	 * 待办工单列表计数方法
	 * @param staffId
	 * @param status
	 * @return
	 * @throws Exception
	 */
	public int countDoWorkorderList(long staffId, String status)throws Exception;
	/**
	 * 已办工单列表查询方法
	 * @param staffId
	 * @param status
	 * @param start
	 * @param end
	 * @return
	 * @throws Exception
	 */
	public IBOWorkorderListValue[] queryWorkorderList(long staffId, String status, int start, int end,String property,String direction)throws Exception;
	
	/**
	 * 已办工单列表计数方法
	 * @param staffId
	 * @param status
	 * @return
	 * @throws Exception
	 */
	public int countWorkorderList(String staffId, String status)throws Exception;
	
	
	public IBOWorkorderListValue[] queryHisWorkorderList(String objId,String objType,int start, int end) throws Exception;
	
	public int countHisWorkorderList(String objId,String objType) throws Exception;
	
	public IBOWorkorderListValue getWorkOrderListByOrderId(Long orderId) throws Exception;
	
	public IBOWorkorderValue[] queryWorkorder(Criteria sql )throws Exception;
	
	public void saveWorkorder(IBOWorkorderValue aValue)throws Exception;
	
	public IBOWorkorderListValue[] getDiscussRelaOrder() throws Exception;
	
	public IBOWorkorderValue[] getWorkorder(String condition, Map params) throws Exception;
	
	public IBOWorkorderListValue[] queryWorkorderList(String orderType,String submitter,String objName,String phaseId,String linkId,String beginctime,String endctime,String staffId,int $STARTROWINDEX,int $ENDROWINDEX) throws Exception;

	public int queryWorkorderListCount(String orderType,String submitter,String objName,String phaseId,String linkId,String beginctime,String endctime,String staffId) throws Exception;
	
	public IBOWorkorderListValue[] queryWaitDiscussOrder(int start, int end)throws Exception;
	
	public int countWaitDiscussOrder()throws Exception;
	
	
	public BOTreeReqFunctionPointsBean[] queryReqFunctionPointSetTree(String objId,String objType,int $STARTROWINDEX,int $ENDROWINDEX) throws Exception;
	
	int queryReqFunctionPointSetTreeCount(String objId,String objType);
	
	public IBOWorkorderListValue[] getDoWorkorderListTree (String userGroup,long staffId, String status, int start, int end) throws Exception;
	
	public BOTreeReqFunctionPointsBean[] queryAlmVerTree(
			String objId, String objType, int $startrowindex, int $endrowindex)
			throws Exception;
	
	public IBOWorkorderListValue[] queryWorkOrder(String phaseName,
			String linkNo, String type, String status, String objName,
			int startindex, int endindex) throws Exception;
	
	public int getWorkOrderCount(String phaseName, String linkNo, String type,
			String status, String objName) throws Exception;
	
	//浙江查询工单方法
	
	//针对工单拼装criteria
	public Criteria getCriteria(String objType,String staffId,String objName,
			String phaseId,String linkId,String beginctime,String endctime) throws Exception;
	
	//获取工单
	public IBOWorkorderListValue[] getWorkOrderListByCon(String condition, Map params,int start,int end) throws Exception;
	
	public int getWorkOrderListByConCount(String condition, Map params) throws Exception;
	
	//获取待办工单列表
	public IBOWorkorderListValue[] queryWorkorderList(long staffId,
			String status) throws Exception;
	
	//获取历史轨迹
	public IBOWorkorderListValue[] getHisToryTrack(String objId, String objType)
			throws Exception;
}
