package com.asiainfo.csc.matrix.service.impl;

import java.util.Map;

import com.ai.appframe2.common.ServiceManager;
import com.asiainfo.csc.matrix.bo.BOAlmHisStakeholderBean;
import com.asiainfo.csc.matrix.factory.BusiFactory;
import com.asiainfo.csc.matrix.ivalues.IBOAlmHisStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;
import com.asiainfo.csc.matrix.service.interfaces.IAlmHisStakeholderSV;

public class AlmHisStakeholderSVImpl implements IAlmHisStakeholderSV {

	
	public IBOAlmHisStakeholderValue[] getHisStakeholderByCondition(
			String condition, Map paramter) throws Exception {
		BusiFactory.getAlmHisStakeholderDao().getHisStakeholderByCondition(condition, paramter);
		return null;
	}

	
	public void saveHisStakeholder(IBOAlmHisStakeholderValue[] stakeholderValues)
			throws Exception {
		BusiFactory.getAlmHisStakeholderDao().saveHisStakeholder(stakeholderValues);
		
	}
	
	
	public void copyHisStakeholderByStakeholder(IBOAlmWorkorderValue iWorkOrderValue, IBOAlmStakeholderValue iBOStakeholder)
	throws Exception {
			IBOAlmHisStakeholderValue iBOAlmHisStakeholderValue = new BOAlmHisStakeholderBean();
			iBOAlmHisStakeholderValue.setOrderId(iWorkOrderValue.getOrderId());
			iBOAlmHisStakeholderValue.setStdholderId(iBOStakeholder.getStdholderId());
			iBOAlmHisStakeholderValue.setTemplateId(iBOStakeholder.getTemplateId());
			iBOAlmHisStakeholderValue.setLinkId(iBOStakeholder.getLinkId());
			iBOAlmHisStakeholderValue.setLinkNo(iBOStakeholder.getLinkNo());
			iBOAlmHisStakeholderValue.setObjId(iBOStakeholder.getObjId());
			iBOAlmHisStakeholderValue.setObjType(iBOStakeholder.getObjType());
			iBOAlmHisStakeholderValue.setRoleId(iBOStakeholder.getRoleId());
			iBOAlmHisStakeholderValue.setRoleCode(iBOStakeholder.getRoleCode());
			iBOAlmHisStakeholderValue.setStdholderStaffOrgId(iBOStakeholder.getStdholderStaffOrgId());
			iBOAlmHisStakeholderValue.setStdholderStaffId(iBOStakeholder.getStdholderStaffId());
			iBOAlmHisStakeholderValue.setStdholderStaffNo(iBOStakeholder.getStdholderStaffNo());
			iBOAlmHisStakeholderValue.setStdholderStaffName(iBOStakeholder.getStdholderStaffName());
			iBOAlmHisStakeholderValue.setStdholdeType(iBOStakeholder.getStdholdeType());
			iBOAlmHisStakeholderValue.setCreateTime(ServiceManager.getOpDateTime());
			IBOAlmHisStakeholderValue[] iBOAlmHisStakeholderValues = {iBOAlmHisStakeholderValue};
			BusiFactory.getAlmHisStakeholderDao().saveHisStakeholder(iBOAlmHisStakeholderValues);

	}
	

}
