package com.asiainfo.csc.matrix.dao.impl;

import java.util.Map;

import com.asiainfo.csc.matrix.bo.BOAlmHisStakeholderBean;
import com.asiainfo.csc.matrix.bo.BOAlmHisStakeholderEngine;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmHisStakeholderDao;
import com.asiainfo.csc.matrix.ivalues.IBOAlmHisStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;

public class AlmHisStakeholderDaoImpl implements IAlmHisStakeholderDao{

	
	public void saveHisStakeholder(IBOAlmHisStakeholderValue[] value)
			throws Exception {
		// TODO Auto-generated method stub
		for(IBOAlmHisStakeholderValue val : value)
			if(val.isNew())
				val.setHisStdholderId(BOAlmHisStakeholderEngine.getNewId().longValue());
		BOAlmHisStakeholderEngine.save(value);
	}
	
	public IBOAlmHisStakeholderValue[] getHisStakeholderByCondition(String condition,Map paramter) throws Exception{
		return BOAlmHisStakeholderEngine.getBeans(condition, paramter);
	}

	
	public IBOAlmHisStakeholderValue copyStakeholderToHisStakeholder(
			IBOAlmStakeholderValue value, long orderId) throws Exception {
		// TODO Auto-generated method stub
		try{
			if(value!=null){
				IBOAlmHisStakeholderValue iHSValue = new BOAlmHisStakeholderBean();
				iHSValue.setObjId(value.getObjId());
				iHSValue.setLinkId(value.getLinkId());
				iHSValue.setHisStdholderId(BOAlmHisStakeholderEngine.getNewId().longValue());
				iHSValue.setStdholderStaffId(value.getStdholderStaffId());
				iHSValue.setStdholderStaffNo(value.getStdholderStaffNo());
				iHSValue.setStdholdeType(value.getStdholdeType());
				iHSValue.setCreateTime(value.getCreateTime());
				iHSValue.setStdholderStaffName(value.getStdholderStaffName());
				iHSValue.setOrderId(orderId);
				iHSValue.setObjId(value.getObjId());
				iHSValue.setObjType(value.getObjType());
				iHSValue.setLinkNo(value.getLinkNo());
				return iHSValue;
			}else{
				return null;
			}
			
		}catch(Exception e){
			throw e;
		}
	}

}
