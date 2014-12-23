package com.asiainfo.csc.matrix.dao.impl;

import com.asiainfo.csc.matrix.bo.BOAlmHisWorkorderBean;
import com.asiainfo.csc.matrix.bo.BOAlmHisWorkorderEngine;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmHisWorkorderDao;
import com.asiainfo.csc.matrix.ivalues.IBOAlmHisWorkorderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;

public class AlmHisWorkorderDaoImpl implements IAlmHisWorkorderDao{

	
	public void saveHisWorkorder(IBOAlmHisWorkorderValue[] value) throws Exception {
		// TODO Auto-generated method stub
		for(IBOAlmHisWorkorderValue val : value)
			if(val.isNew())
				val.setHisOrderId(BOAlmHisWorkorderEngine.getNewId().longValue());
		BOAlmHisWorkorderEngine.save(value);
	}

	
	public IBOAlmHisWorkorderValue copyWorkOrderToHisWorkOrder(
			IBOAlmWorkorderValue o) throws Exception {
		// TODO Auto-generated method stub
		try{
			if(o!=null){
				IBOAlmHisWorkorderValue iBOHisWorkOrderValue = new BOAlmHisWorkorderBean();
				iBOHisWorkOrderValue.setOrderId(o.getOrderId());
				iBOHisWorkOrderValue.setWorkflowId(o.getWorkflowId());
				iBOHisWorkOrderValue.setParentOrderId(o.getParentOrderId());
				iBOHisWorkOrderValue.setLastOrderId(o.getLastOrderId());
				iBOHisWorkOrderValue.setVmTaskId(o.getVmTaskId());
				iBOHisWorkOrderValue.setParentVmTaskId(o.getParentVmTaskId());
				iBOHisWorkOrderValue.setLastVmTaskId(o.getLastVmTaskId());
				iBOHisWorkOrderValue.setLinkId(o.getLinkId());
				iBOHisWorkOrderValue.setLinkNo(o.getLinkNo());
				iBOHisWorkOrderValue.setLinkNoType(o.getLinkNoType());
				iBOHisWorkOrderValue.setIsCurrentTask(o.getIsCurrentTask());
				iBOHisWorkOrderValue.setOrderType(o.getOrderType());
				iBOHisWorkOrderValue.setObjId(o.getObjId());
				iBOHisWorkOrderValue.setObjType(o.getObjType());
				iBOHisWorkOrderValue.setDealType(o.getDealType());
				iBOHisWorkOrderValue.setIsLock(o.getIsLock());
				iBOHisWorkOrderValue.setFinishPrint(o.getFinishPrint());
				iBOHisWorkOrderValue.setExecRoleId(o.getExecRoleId());
				iBOHisWorkOrderValue.setExecRoleCode(o.getExecRoleCode());
				iBOHisWorkOrderValue.setExecStaffId(o.getExecStaffId());
				iBOHisWorkOrderValue.setExecStaffNo(o.getExecStaffNo());
				iBOHisWorkOrderValue.setLockRoleId(o.getLockRoleId());
				iBOHisWorkOrderValue.setLockRoleCode(o.getLockRoleCode());
				iBOHisWorkOrderValue.setLockStaffId(o.getLockStaffId());
				iBOHisWorkOrderValue.setLockStaffNo(o.getLockStaffNo());
				iBOHisWorkOrderValue.setResult(o.getResult());
				iBOHisWorkOrderValue.setCond(o.getCond());
				iBOHisWorkOrderValue.setStatus(o.getStatus());
				iBOHisWorkOrderValue.setOpinion(o.getOpinion());
				iBOHisWorkOrderValue.setLockOpinion(o.getLockOpinion());
				iBOHisWorkOrderValue.setCreateTime(o.getCreateTime());
				iBOHisWorkOrderValue.setRecvTime(o.getRecvTime());
				iBOHisWorkOrderValue.setLockTime(o.getLockTime());
				iBOHisWorkOrderValue.setRealseLockTime(o.getRealseLockTime());
				iBOHisWorkOrderValue.setExecTime(o.getExecTime());
				iBOHisWorkOrderValue.setFinishTime(o.getFinishTime());
				iBOHisWorkOrderValue.setAdviceCompTime(o.getAdviceCompTime());
				return iBOHisWorkOrderValue;
			}else{
				return null;
			}
		}catch(Exception e){
			throw e;
		}
	}

	
	public void saveHisWorkorder(IBOAlmHisWorkorderValue value)
			throws Exception {
		// TODO Auto-generated method stub
		if(value.isNew())
			value.setHisOrderId(BOAlmHisWorkorderEngine.getNewId().longValue());
		BOAlmHisWorkorderEngine.save(value);
	}
}
