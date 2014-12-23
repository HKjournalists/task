package com.asiainfo.csc.attach.util;

import com.ai.appframe2.service.ServiceFactory;
import com.asiainfo.csc.attach.ivalues.IBOAttachTypeValue;
import com.asiainfo.csc.attach.service.interfaces.IAttachService;

public class AttachParam1 {
	
	public static IBOAttachTypeValue[] getAllAttackType()
	{
		IBOAttachTypeValue[] values=null;
		try{
			IAttachService iAttachService = (IAttachService)ServiceFactory.getService(IAttachService.class);
			 values = iAttachService.getAttType();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return values;
	}

}
