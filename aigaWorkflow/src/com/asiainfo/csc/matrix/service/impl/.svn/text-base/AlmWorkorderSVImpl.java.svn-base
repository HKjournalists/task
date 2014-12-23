package com.asiainfo.csc.matrix.service.impl;

import java.util.Map;


import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.matrix.bo.BOAlmWorkorderBean;
import com.asiainfo.csc.matrix.common.ConstDefine;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmWorkorderDao;
import com.asiainfo.csc.matrix.factory.BusiFactory;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkorderSV;


public class AlmWorkorderSVImpl implements IAlmWorkorderSV {
    private IAlmWorkorderDao wod = (IAlmWorkorderDao)ServiceFactory.getService(IAlmWorkorderDao.class);

	
	public IBOAlmWorkorderValue[] getAlmWorkorderByCondition(String condition,
			Map paramter) throws Exception {
		// TODO Auto-generated method stub
		return BusiFactory.getAlmWorkorderDao().getAlmWorkorderByCondition(condition, paramter);
	}

	
	public void saveAlmWorkorder(IBOAlmWorkorderValue[] workorders) throws Exception {
		// TODO Auto-generated method stub
		BusiFactory.getAlmWorkorderDao().saveAlmWorkorder(workorders);
	}
	
	public IBOAlmWorkorderValue getLastWorkorderByObjIdAndObjType(String objId,
			String objType) throws Exception {
		try{
			Criteria sql = new Criteria();
			sql.addEqual(IBOAlmWorkorderValue.S_ObjId, objId);
			sql.addEqual(IBOAlmWorkorderValue.S_ObjType, objType);
			sql.addEqual(IBOAlmWorkorderValue.S_ParentOrderId,ConstDefine.WO_NO_PARENT);
			sql.addDescendingOrderByColumn(IBOAlmWorkorderValue.S_OrderId);
			IBOAlmWorkorderValue[] wos = BusiFactory.getAlmWorkorderDao().getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
			if(wos!=null && wos.length>0)
				return wos[0];
			else{
				return null;
			}
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("查询流程实例最后完成工单时出错 查询条件OBJID:"+objId);
		}
	}

	public IBOAlmWorkorderValue getFristWorkorderByObjIdAndObjTypeAndLinkNo(String objId,String objType,String linkNo) throws Exception{
		try{
			Criteria sql = new Criteria();
			sql.addEqual(IBOAlmWorkorderValue.S_ObjId, objId);
			sql.addEqual(IBOAlmWorkorderValue.S_ObjType, objType);
			//sql.addEqual(IBOWorkorderValue.S_OrderType, IObjectType.REQUISITION);
			sql.addEqual(IBOAlmWorkorderValue.S_LinkNo,linkNo);
			sql.addEqual(IBOAlmWorkorderValue.S_ParentOrderId,ConstDefine.WO_NO_PARENT);
			sql.addDescendingOrderByColumn(IBOAlmWorkorderValue.S_OrderId);
			IBOAlmWorkorderValue[] wos = BusiFactory.getAlmWorkorderDao().getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
			if(wos!=null && wos.length>0)
				return wos[0];
			else{
				return null;
			}
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("根据LINKNO查询流程实例第一个完成工单时出错 查询条件OBJID:"+objId+"",e);
		}
	}
	
	public IBOAlmWorkorderValue capyWorkorderByWorkorder(
			IBOAlmWorkorderValue almWorkorderValue) throws Exception {
		IBOAlmWorkorderValue iBOAlmWorkorderValue = new BOAlmWorkorderBean();
		iBOAlmWorkorderValue.setWorkflowId(almWorkorderValue.getWorkflowId());
		iBOAlmWorkorderValue.setParentOrderId(almWorkorderValue.getParentOrderId());
		iBOAlmWorkorderValue.setLastOrderId(almWorkorderValue.getLastOrderId());	
		iBOAlmWorkorderValue.setVmTaskId(almWorkorderValue.getVmTaskId());
		iBOAlmWorkorderValue.setParentVmTaskId(almWorkorderValue.getParentVmTaskId());
		iBOAlmWorkorderValue.setLastVmTaskId(almWorkorderValue.getLastVmTaskId());
		iBOAlmWorkorderValue.setLinkId(almWorkorderValue.getLinkId());
		iBOAlmWorkorderValue.setLinkNo(almWorkorderValue.getLinkNo());
		iBOAlmWorkorderValue.setLinkNoType(almWorkorderValue.getLinkNoType());
		iBOAlmWorkorderValue.setIsCurrentTask(almWorkorderValue.getIsCurrentTask());
		iBOAlmWorkorderValue.setOrderType(almWorkorderValue.getOrderType());
		iBOAlmWorkorderValue.setObjId(almWorkorderValue.getObjId());
		iBOAlmWorkorderValue.setObjType(almWorkorderValue.getObjType());
		iBOAlmWorkorderValue.setDealType(almWorkorderValue.getDealType());
		iBOAlmWorkorderValue.setIsLock(almWorkorderValue.getIsLock());
		iBOAlmWorkorderValue.setFinishPrint(almWorkorderValue.getFinishPrint());
		iBOAlmWorkorderValue.setExecRoleId(almWorkorderValue.getExecRoleId());
		iBOAlmWorkorderValue.setExecRoleCode(almWorkorderValue.getExecRoleCode());
		iBOAlmWorkorderValue.setExecStaffId(almWorkorderValue.getExecStaffId());
		iBOAlmWorkorderValue.setExecStaffNo(almWorkorderValue.getExecStaffNo());
		iBOAlmWorkorderValue.setLockRoleId(almWorkorderValue.getLockRoleId());
		iBOAlmWorkorderValue.setLockRoleCode(almWorkorderValue.getLockRoleCode());
		iBOAlmWorkorderValue.setLockStaffId(almWorkorderValue.getLockStaffId());
		iBOAlmWorkorderValue.setLockStaffNo(almWorkorderValue.getLockStaffNo());
		iBOAlmWorkorderValue.setResult(almWorkorderValue.getResult());
		iBOAlmWorkorderValue.setCond(almWorkorderValue.getCond());
		iBOAlmWorkorderValue.setStatus(almWorkorderValue.getStatus());
		iBOAlmWorkorderValue.setOpinion(almWorkorderValue.getOpinion());
		iBOAlmWorkorderValue.setLockOpinion(almWorkorderValue.getLockOpinion());
		iBOAlmWorkorderValue.setCreateTime(almWorkorderValue.getCreateTime());
		iBOAlmWorkorderValue.setRecvTime(almWorkorderValue.getRecvTime());
		iBOAlmWorkorderValue.setLockTime(almWorkorderValue.getLockTime());
		iBOAlmWorkorderValue.setRealseLockTime(almWorkorderValue.getRealseLockTime());
		iBOAlmWorkorderValue.setExecTime(almWorkorderValue.getExecTime());
		iBOAlmWorkorderValue.setFinishTime(almWorkorderValue.getFinishTime());
		iBOAlmWorkorderValue.setAdviceCompTime(almWorkorderValue.getAdviceCompTime());
		IBOAlmWorkorderValue[] iBOAlmWorkorderValues =	{iBOAlmWorkorderValue};
		this.saveAlmWorkorder(iBOAlmWorkorderValues);
		return iBOAlmWorkorderValue;
	}
	
	public IBOAlmWorkorderValue capyWorkorderByWorkorderNoSave(
			IBOAlmWorkorderValue almWorkorderValue) throws Exception {
		IBOAlmWorkorderValue iBOAlmWorkorderValue = new BOAlmWorkorderBean();
		iBOAlmWorkorderValue.setWorkflowId(almWorkorderValue.getWorkflowId());
		iBOAlmWorkorderValue.setParentOrderId(almWorkorderValue.getParentOrderId());
		iBOAlmWorkorderValue.setLastOrderId(almWorkorderValue.getLastOrderId());	
		iBOAlmWorkorderValue.setVmTaskId(almWorkorderValue.getVmTaskId());
		iBOAlmWorkorderValue.setParentVmTaskId(almWorkorderValue.getParentVmTaskId());
		iBOAlmWorkorderValue.setLastVmTaskId(almWorkorderValue.getLastVmTaskId());
		iBOAlmWorkorderValue.setLinkId(almWorkorderValue.getLinkId());
		iBOAlmWorkorderValue.setLinkNo(almWorkorderValue.getLinkNo());
		iBOAlmWorkorderValue.setLinkNoType(almWorkorderValue.getLinkNoType());
		iBOAlmWorkorderValue.setIsCurrentTask(almWorkorderValue.getIsCurrentTask());
		iBOAlmWorkorderValue.setOrderType(almWorkorderValue.getOrderType());
		iBOAlmWorkorderValue.setObjId(almWorkorderValue.getObjId());
		iBOAlmWorkorderValue.setObjType(almWorkorderValue.getObjType());
		iBOAlmWorkorderValue.setDealType(almWorkorderValue.getDealType());
		iBOAlmWorkorderValue.setIsLock(almWorkorderValue.getIsLock());
		iBOAlmWorkorderValue.setFinishPrint(almWorkorderValue.getFinishPrint());
		iBOAlmWorkorderValue.setExecRoleId(almWorkorderValue.getExecRoleId());
		iBOAlmWorkorderValue.setExecRoleCode(almWorkorderValue.getExecRoleCode());
		iBOAlmWorkorderValue.setExecStaffId(almWorkorderValue.getExecStaffId());
		iBOAlmWorkorderValue.setExecStaffNo(almWorkorderValue.getExecStaffNo());
		iBOAlmWorkorderValue.setLockRoleId(almWorkorderValue.getLockRoleId());
		iBOAlmWorkorderValue.setLockRoleCode(almWorkorderValue.getLockRoleCode());
		iBOAlmWorkorderValue.setLockStaffId(almWorkorderValue.getLockStaffId());
		iBOAlmWorkorderValue.setLockStaffNo(almWorkorderValue.getLockStaffNo());
		iBOAlmWorkorderValue.setResult(almWorkorderValue.getResult());
		iBOAlmWorkorderValue.setCond(almWorkorderValue.getCond());
		iBOAlmWorkorderValue.setStatus(almWorkorderValue.getStatus());
		iBOAlmWorkorderValue.setOpinion(almWorkorderValue.getOpinion());
		iBOAlmWorkorderValue.setLockOpinion(almWorkorderValue.getLockOpinion());
		iBOAlmWorkorderValue.setCreateTime(almWorkorderValue.getCreateTime());
		iBOAlmWorkorderValue.setRecvTime(almWorkorderValue.getRecvTime());
		iBOAlmWorkorderValue.setLockTime(almWorkorderValue.getLockTime());
		iBOAlmWorkorderValue.setRealseLockTime(almWorkorderValue.getRealseLockTime());
		iBOAlmWorkorderValue.setExecTime(almWorkorderValue.getExecTime());
		iBOAlmWorkorderValue.setFinishTime(almWorkorderValue.getFinishTime());
		iBOAlmWorkorderValue.setLockTimes(almWorkorderValue.getLockTimes());
		iBOAlmWorkorderValue.setExecTimes(almWorkorderValue.getExecTimes());
		iBOAlmWorkorderValue.setAdviceCompTime(almWorkorderValue.getAdviceCompTime());
		return iBOAlmWorkorderValue;
	}

	
	public void saveAlmWorkorder(IBOAlmWorkorderValue workorder)
			throws Exception {
		// TODO Auto-generated method stub
		BusiFactory.getAlmWorkorderDao().saveAlmWorkorder(workorder);
	}

	
	public IBOAlmWorkorderValue queryWorkOrderById(String workOrderID) throws NumberFormatException, Exception {
		// TODO Auto-generated method stub
		return wod.queryWorkOrderById(workOrderID);
	}

	public IBOAlmWorkorderValue queryUpperOrder(String objId,String objType) throws Exception {
		// TODO Auto-generated method stub
		try{
			Criteria sql = new Criteria();
			sql.addEqual(IBOAlmWorkorderValue.S_ObjId, objId);
			sql.addEqual(IBOAlmWorkorderValue.S_ObjType, objType);
			//sql.addEqual(IBOWorkorderValue.S_OrderType, IObjectType.REQUISITION);
			sql.addEqual(IBOAlmWorkorderValue.S_Status,ConstDefine.WO_STATUS_COMPLETE);
			sql.addDescendingOrderByColumn(IBOAlmWorkorderValue.S_OrderId);
			IBOAlmWorkorderValue[] wos = BusiFactory.getAlmWorkorderDao().getAlmWorkorderByCondition(sql.toString(), sql.getParameters());
			if(wos!=null && wos.length>0)
				return wos[0];
			else{
				return null;
			}
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("根据objId查询上一个完成工单时出错 查询条件OBJID:"+objId+"",e);
		}
	}

}
