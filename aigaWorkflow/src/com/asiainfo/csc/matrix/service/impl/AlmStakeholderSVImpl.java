package com.asiainfo.csc.matrix.service.impl;

import java.util.Map;

import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.matrix.bo.BOAlmStakeholderBean;
import com.asiainfo.csc.matrix.factory.BusiFactory;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;
import com.asiainfo.csc.matrix.service.interfaces.IAlmStakeholderSV;

public class AlmStakeholderSVImpl implements IAlmStakeholderSV {

	
	public IBOAlmStakeholderValue[] getStakeholderByCondition(String condition,
			Map paramter) throws Exception {
		// TODO Auto-generated method stub
		return BusiFactory.getAlmStakeholderDao().getStakeholderByCondition(condition, paramter);
	}

	public IBOAlmStakeholderValue[] getStakeholder(String linkNo,String objId,String objType)throws Exception{
		Criteria sql = new Criteria();
		if(linkNo!=null&&!linkNo.equals(""))
			sql.addEqual(BOAlmStakeholderBean.S_LinkNo, linkNo);
		if(objId!=null&&!objId.equals(""))
			sql.addEqual(BOAlmStakeholderBean.S_ObjId, objId);
		if(objType!=null&&!objType.equals(""))
			sql.addEqual(BOAlmStakeholderBean.S_ObjType, objType);
		return BusiFactory.getAlmStakeholderDao().getStakeholderByCondition(sql.toString(), sql.getParameters());
	}
	
	public void saveStakeholder(IBOAlmStakeholderValue[] schedules) throws Exception {
		// TODO Auto-generated method stub
		BusiFactory.getAlmStakeholderDao().saveStakeholder(schedules);
	}

}
