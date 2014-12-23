package com.asiainfo.csc.matrix.service.impl;

import com.ai.appframe2.common.ServiceManager;
import com.asiainfo.csc.matrix.bo.BOAlmHisWorkorderBean;
import com.asiainfo.csc.matrix.bo.BOAlmWorkorderBean;
import com.asiainfo.csc.matrix.common.ConstDefine;
import com.asiainfo.csc.matrix.factory.BusiFactory;
import com.asiainfo.csc.matrix.ivalues.IBOAlmHisWorkorderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;
import com.asiainfo.csc.matrix.service.interfaces.IAlmHisWorkorderSV;

public class AlmHisWorkorderSVImpl implements IAlmHisWorkorderSV{

	
	public void capyHisWorkorderByWorkorder(
			IBOAlmWorkorderValue almWorkorderValue) throws Exception {
		IBOAlmHisWorkorderValue iBOAlmHisWorkorderValue = new BOAlmHisWorkorderBean();
		iBOAlmHisWorkorderValue.setOrderId(almWorkorderValue.getOrderId());
		iBOAlmHisWorkorderValue.setWorkflowId(almWorkorderValue.getWorkflowId());
		iBOAlmHisWorkorderValue.setParentOrderId(almWorkorderValue.getParentOrderId());
		iBOAlmHisWorkorderValue.setLastOrderId(almWorkorderValue.getLastOrderId());	
		iBOAlmHisWorkorderValue.setVmTaskId(almWorkorderValue.getVmTaskId());
		iBOAlmHisWorkorderValue.setParentVmTaskId(almWorkorderValue.getParentVmTaskId());
		iBOAlmHisWorkorderValue.setLastVmTaskId(almWorkorderValue.getLastVmTaskId());
		iBOAlmHisWorkorderValue.setLinkId(almWorkorderValue.getLinkId());
		iBOAlmHisWorkorderValue.setLinkNo(almWorkorderValue.getLinkNo());
		iBOAlmHisWorkorderValue.setLinkNoType(almWorkorderValue.getLinkNoType());
		iBOAlmHisWorkorderValue.setIsCurrentTask(almWorkorderValue.getIsCurrentTask());
		iBOAlmHisWorkorderValue.setOrderType(almWorkorderValue.getOrderType());
		iBOAlmHisWorkorderValue.setObjId(almWorkorderValue.getObjId());
		iBOAlmHisWorkorderValue.setObjType(almWorkorderValue.getObjType());
		iBOAlmHisWorkorderValue.setIsLock(almWorkorderValue.getIsLock());
		iBOAlmHisWorkorderValue.setFinishPrint(almWorkorderValue.getFinishPrint());
		iBOAlmHisWorkorderValue.setExecRoleId(almWorkorderValue.getExecRoleId());
		iBOAlmHisWorkorderValue.setExecRoleCode(almWorkorderValue.getExecRoleCode());
		iBOAlmHisWorkorderValue.setExecStaffId(almWorkorderValue.getExecStaffId());
		iBOAlmHisWorkorderValue.setExecStaffNo(almWorkorderValue.getExecStaffNo());
		iBOAlmHisWorkorderValue.setLockRoleId(almWorkorderValue.getLockRoleId());
		iBOAlmHisWorkorderValue.setLockRoleCode(almWorkorderValue.getLockRoleCode());
		iBOAlmHisWorkorderValue.setLockStaffId(almWorkorderValue.getLockStaffId());
		iBOAlmHisWorkorderValue.setLockStaffNo(almWorkorderValue.getLockStaffNo());
		iBOAlmHisWorkorderValue.setResult(almWorkorderValue.getResult());
		iBOAlmHisWorkorderValue.setCond(almWorkorderValue.getCond());
		iBOAlmHisWorkorderValue.setStatus(almWorkorderValue.getStatus());
		iBOAlmHisWorkorderValue.setOpinion(almWorkorderValue.getOpinion());
		iBOAlmHisWorkorderValue.setLockOpinion(almWorkorderValue.getLockOpinion());
		iBOAlmHisWorkorderValue.setCreateTime(almWorkorderValue.getCreateTime());
		iBOAlmHisWorkorderValue.setRecvTime(almWorkorderValue.getRecvTime());
		iBOAlmHisWorkorderValue.setLockTime(almWorkorderValue.getLockTime());
		iBOAlmHisWorkorderValue.setRealseLockTime(almWorkorderValue.getRealseLockTime());
		iBOAlmHisWorkorderValue.setExecTime(almWorkorderValue.getExecTime());
		iBOAlmHisWorkorderValue.setFinishTime(almWorkorderValue.getFinishTime());
		iBOAlmHisWorkorderValue.setAdviceCompTime(almWorkorderValue.getAdviceCompTime());
		IBOAlmHisWorkorderValue[] iBOAlmHisWorkorderValues =	{iBOAlmHisWorkorderValue};
		this.saveHisWorkorder(iBOAlmHisWorkorderValues);
	}

	
	public void saveHisWorkorder(IBOAlmHisWorkorderValue[] value)
			throws Exception {
		BusiFactory.getAlmHisWorkorderDao().saveHisWorkorder(value);
		
	}
	
}
