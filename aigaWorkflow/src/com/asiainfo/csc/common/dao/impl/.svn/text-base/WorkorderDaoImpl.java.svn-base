package com.asiainfo.csc.common.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.ai.secframe.common.Constants;
import com.ai.secframe.ivalues.orgmodel.IStaffValue;
import com.ai.secframe.service.pubapi.interfaces.ISecframe;
import com.asiainfo.csc.common.bo.BOHisWorkorderEngine;
import com.asiainfo.csc.common.bo.BOWorkorderEngine;
import com.asiainfo.csc.common.bo.BOWorkorderExtendEngine;
import com.asiainfo.csc.common.bo.BOWorkorderListBean;
import com.asiainfo.csc.common.bo.BOWorkorderListEngine;
import com.asiainfo.csc.common.dao.interfaces.IWorkorderDao;
import com.asiainfo.csc.common.ivalues.IBOHisWorkorderValue;
import com.asiainfo.csc.common.ivalues.IBOWorkorderExtendValue;
import com.asiainfo.csc.common.ivalues.IBOWorkorderListValue;
import com.asiainfo.csc.common.ivalues.IBOWorkorderValue;

public class WorkorderDaoImpl implements IWorkorderDao{
	public void saveWorkorder(IBOWorkorderValue order)throws Exception
	{
		// TODO Auto-generated method stub
		
		try{
			//判空
			if (order == null)
				throw new Exception("在保存工单方法中发现传入数据为空，错误在Dao层saveWorkorder函数");
			
			//获得新主键值
			if (order.isNew())
			{
				long newId = BOWorkorderEngine.getNewId().longValue();
				order.setOrderId(newId);
			}
			
			//执行人不能为空
			if (order.getExecStaffId() == 0 && order.getExecStaffNo().equals(""))
				throw new Exception("在保存工单方法中发现执行人信息为空，错误在Dao层saveWorkorder函数");
			
			//根据执行人Id填写执行人No
			ISecframe secframe = (ISecframe) ServiceFactory.getService(Constants.SERVICE_SECFRAME);
			if (order.getExecStaffNo()==null||order.getExecStaffNo().equals(""))
			{
				IStaffValue staff = secframe.getStaffByStaffId(order.getExecStaffId());
				order.setExecStaffNo(staff.getCode());
			}
			
			//根据No填Id
			if (order.getExecStaffId() == 0)
			{
				IStaffValue staff = secframe.getStaffByCode(order.getExecStaffNo());
				order.setExecStaffId(staff.getStaffId());
			}
			
			BOWorkorderEngine.save(order);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("在保存工单方法中出错，错误在Dao层saveWorkorder函数");
		}
	}
	
	public IBOWorkorderValue[] getWorkorders(Criteria sql)throws Exception
	{
		try{
			return BOWorkorderEngine.getBeans(sql);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("在查询工单方法中出错，错误在Dao层getWorkorders函数");
		}
	}
	
	public IBOWorkorderValue getWorkorderById(long orderId)throws Exception
	{
		try{
			return BOWorkorderEngine.getBean(orderId);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("在根据orderId查询工单方法中出错，错误在Dao层getWorkorderById函数");
		}
	}
	
	public IBOWorkorderListValue[] queryWorkorderList(String cond, Map param, int startIndex, int endIndex)throws Exception
	{
		try{ 
			return BOWorkorderListEngine.getBeans(null, cond, param, startIndex, endIndex, false);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("在查询工单列表方法中出错，错误在Dao层queryWorkorderList函数");
		}
	}
	
	public int countWorkorderList(String cond, Map param)throws Exception
	{
		try{ 
			return BOWorkorderListEngine.getBeansCount(cond, param);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("在计数工单列表方法中出错，错误在Dao层countWorkorderList函数");
		}
	}
	
	
	
	public void saveHisWorkorder(IBOHisWorkorderValue hisOrder)throws Exception
	{
		try{
			//判空
			if (hisOrder == null)
				throw new Exception("在保存干系人历史表时发现传入数据为空，错误在Dao层，saveHisStakeholder函数");
			
			//获得新主键值
			if (hisOrder.isNew())
			{
				long newId = BOHisWorkorderEngine.getNewId().longValue();
				hisOrder.setHisOrderId(newId);
			}
			
			BOHisWorkorderEngine.save(hisOrder);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("在保存工单历史表时出错，错误在Dao层，saveHisWorkorder函数");
		}
	}
	
	public void saveWorkorderExtend(IBOWorkorderExtendValue orderExtend)throws Exception
	{
		BOWorkorderExtendEngine.save(orderExtend);
	}
	
	public IBOWorkorderExtendValue getWorkorderExtendById(long orderId)throws Exception
	{
		return BOWorkorderExtendEngine.getBean(orderId);
	}
	
	public IBOWorkorderValue[] getDiscussRelaOrder(String condition, Map params) throws Exception {
		return BOWorkorderEngine.getBeans(condition, params);
	}
	
	public IBOWorkorderValue[] getDiscussingOrder(String condition, Map params) throws Exception {
		return BOWorkorderEngine.getBeans(condition, params);
	}
	
	public IBOWorkorderValue[] getWorkorder(String condition, Map params) throws Exception {
		return BOWorkorderEngine.getBeans(condition, params);
	}
	
	
	public IBOWorkorderListValue[] queryWorkorderList(String condition,
			HashMap parameters, int $startrowindex, int $endrowindex) throws Exception {
		// TODO Auto-generated method stub
		return BOWorkorderListEngine.getBeans(null, condition, parameters, $startrowindex, $endrowindex, false);
	}
	
	
	public int queryWorkorderListCount(String condition, Map parameters) throws Exception{
		// TODO Auto-generated method stub
		return BOWorkorderListEngine.getBeansCount(condition, parameters);
	}

	
	public IBOWorkorderListValue[] queryDoWorkorderList(Criteria sql)
			throws Exception {
		// TODO Auto-generated method stub
		return BOWorkorderListEngine.getBeans(sql);
	}

	
	public IBOWorkorderListValue[] queryReqFunctionPointSetTree(String objId,String objType) throws Exception {
		String condition = "select * from alm_workorder_list alwl where alwl.obj_id = "+objId+"  and alwl.order_type!='1' and not(alwl.link_no_type='sign' and alwl.parent_vm_task_id is null)  and alwl.obj_type = 1 order by alwl.create_time desc";
		
		return BOWorkorderListEngine.getBeansFromSql(condition,null);
	}
	
	public IBOWorkorderListValue[] queryAlmVerTree(String objId,String objType) throws Exception {
		String condition = "select * from alm_workorder_list alwl where alwl.obj_id = "+objId+"  and alwl.order_type!='1' and not(alwl.link_no_type='sign' and (alwl.parent_vm_task_id is null or alwl.parent_vm_task_id=0))  and alwl.obj_type = "+objType+" order by alwl.finish_time desc";
		
		return BOWorkorderListEngine.getBeansFromSql(condition,null);
	}

	
	public IBOWorkorderListValue[] FunctionPointSetByReqIdAndLinkId(long objId,
			long linkId) throws Exception {
		String condition = "select * from alm_workorder_list awl where awl.obj_id in (select v.ver_id from alm_ver_req_rela v where v.req_id ="+objId+" ) order by awl.finish_time desc";
//		 and awl.connect_point = "+linkId+
		IBOWorkorderListValue[] origin = BOWorkorderListEngine.getBeansFromSql(condition,null);
		List<IBOWorkorderListValue> retList = new ArrayList<IBOWorkorderListValue>();
		for(IBOWorkorderListValue originVal : origin) {
			String connectPoint = originVal.getConnectPoint();
			if(connectPoint == null) {
				continue;
			}
			String[] conLinks = connectPoint.split(",");
			boolean isNeed = false;
			for(String conLink : conLinks) {
				if(Long.valueOf(conLink) == linkId) {
					isNeed = true;
				}
			}
			if(isNeed) {
				retList.add(originVal);
			}
		}
		IBOWorkorderListValue[] retVal = new BOWorkorderListBean[retList.size()];
		return retList.toArray(retVal);
	}
	
	public IBOWorkorderListValue[] FunctionPointSetByReqIdForTree(long objId) throws Exception {
		String condition = "select * from alm_workorder_list awl" +
				" where awl.obj_id in (select v.fun_point_id from req_func_view v where v.req_id = "+objId+") and status=2 order by awl.finish_time desc";
//		 and awl.connect_point = "+linkId+
		IBOWorkorderListValue[] origin = BOWorkorderListEngine.getBeansFromSql(condition,null);
		return origin;
	}
	
	public IBOWorkorderListValue[] FunctionPointSetByFunpIdForTree(long funpId) throws Exception {
		String condition = "select * from alm_workorder_list awl" +
		" where awl.obj_id in (select req_id from  req_func_view where fun_point_id="+funpId+") and status=2 order by awl.finish_time desc";
//		 and awl.connect_point = "+linkId+
		IBOWorkorderListValue[] origin = BOWorkorderListEngine.getBeansFromSql(condition,null);
		return origin;
	}
	
	//浙江查询工单列表
	
	public IBOWorkorderListValue[] queryWorkorderListById(String cond, Map param)throws Exception
	{
		try{ 
			return BOWorkorderListEngine.getBeans(cond, param);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("在计数工单列表方法中出错，错误在Dao层queryWorkorderListById函数");
		}
	}
	
	public IBOWorkorderListValue[] queryWorklistBySql(String objId,String objType) throws Exception {
		String condition = "select * from alm_workorder_list alwl where alwl.obj_id = "+objId+"  and alwl.order_type!='1' and not(alwl.link_no_type='sign' and alwl.parent_vm_task_id is null)  and alwl.obj_type = '" + objType + "' order by alwl.create_time desc";
		
		return BOWorkorderListEngine.getBeansFromSql(condition,null);
	}
}
