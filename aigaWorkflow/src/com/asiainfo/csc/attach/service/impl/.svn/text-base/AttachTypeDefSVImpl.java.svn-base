package com.asiainfo.csc.attach.service.impl;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.attach.bo.BOAttachTypeDefBean;
import com.asiainfo.csc.attach.dao.interfaces.IAttachTypeDefDao;
import com.asiainfo.csc.attach.ivalues.IBOAttachTypeDefValue;
import com.asiainfo.csc.attach.service.interfaces.IAttachTypeDefSV;

public class AttachTypeDefSVImpl implements IAttachTypeDefSV {

	private static IAttachTypeDefDao defDao = (IAttachTypeDefDao)ServiceFactory.getService(IAttachTypeDefDao.class);
	
	public IBOAttachTypeDefValue[] getAttachTypeDef(String attTypeDefIds)
			throws Exception {
		// TODO Auto-generated method stub
		if(attTypeDefIds==null||attTypeDefIds.equals(""))
			throw new Exception("attTypeDefIdsÎª¿Õ¡¾com.asiainfo.csc.attach.service.impl.AttachTypeDefSVImpl.getAttachTypeDef()¡¿");
		String condition = "ATT_TYPE_ID in("+attTypeDefIds+")";
		IBOAttachTypeDefValue[] attachTypeValues = defDao.getAttachTypeDef(condition,null);
		return attachTypeValues;
	}
	
	public IBOAttachTypeDefValue getAttachTypeDefById(String attTypeDefId)
			throws Exception {
		// TODO Auto-generated method stub
		if(attTypeDefId==null||attTypeDefId.equals(""))
			throw new Exception("attTypeDefIdÎª¿Õ¡¾com.asiainfo.csc.attach.service.impl.AttachTypeDefSVImpl.getAttachTypeDefById()¡¿");
		Criteria sql = new Criteria();
		sql.addEqual(BOAttachTypeDefBean.S_AttTypeId, attTypeDefId);
		IBOAttachTypeDefValue[] attachTypeValues = defDao.getAttachTypeDef(sql.toString(),sql.getParameters());
		if(attachTypeValues.length==1)
			return attachTypeValues[0];
		else
			return null;
	}

}
