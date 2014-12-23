package com.asiainfo.csc.common.service.impl;

import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.common.dao.interfaces.IReqRemarksDao;
import com.asiainfo.csc.common.ivalues.IBOReqRemarksValue;
import com.asiainfo.csc.common.service.interfaces.IReqRemarksSV;

public class ReqRemarksSVImpl implements IReqRemarksSV {

	IReqRemarksDao iReDao=(IReqRemarksDao)ServiceFactory.getService(IReqRemarksDao.class);
	
	public int countReqRemarks(String objTag, String objType) throws Exception {
		Criteria criteria=new Criteria();
		criteria.addEqual(IBOReqRemarksValue.S_ObjTag, objTag);
		criteria.addEqual(IBOReqRemarksValue.S_ObjType, objType);
		return iReDao.getRemarksByCon(criteria.toString(), criteria.getParameters()).length;
	}

	
	public IBOReqRemarksValue[] queryReqRemarks(String objTag, String objType,
			int startindex, int endindex) throws Exception {
		Criteria criteria=new Criteria();
		criteria.addEqual(IBOReqRemarksValue.S_ObjTag, objTag);
		criteria.addEqual(IBOReqRemarksValue.S_ObjType, objType);
		return iReDao.getRemarksByCon(criteria.toString(), criteria.getParameters());
	}

	
	public void saveReqRemarks(IBOReqRemarksValue value) throws Exception {
		if(value.isNew()){
			value.setRemarkId(iReDao.getNewId());
			value.setCreateTime(ServiceManager.getOpDateTime());
		}else{
			value.setChangeTime(ServiceManager.getOpDateTime());
		}
		iReDao.saveRemarks(value);
	}

	
	public void delReqRemarks(String remarkId) throws Exception {
		Criteria criteria=new Criteria();
		criteria.addEqual(IBOReqRemarksValue.S_RemarkId, remarkId);
		IBOReqRemarksValue[] values=iReDao.getRemarksByCon(criteria.toString(), criteria.getParameters());
		values[0].delete();
		iReDao.saveRemarks(values[0]);
	}
}
