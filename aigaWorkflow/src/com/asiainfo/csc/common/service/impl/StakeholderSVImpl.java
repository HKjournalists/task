package com.asiainfo.csc.common.service.impl;

import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.common.bo.BOCountStkholderBean;
import com.asiainfo.csc.common.bo.BOStakeholderBean;
import com.asiainfo.csc.common.dao.interfaces.IStakeholderDao;
import com.asiainfo.csc.common.define.IObjectType;
import com.asiainfo.csc.common.define.IStakeholderType;
import com.asiainfo.csc.common.ivalues.IBOCountStkholderValue;
import com.asiainfo.csc.common.ivalues.IBOStakeholderValue;
import com.asiainfo.csc.common.service.interfaces.IStakeholderSV;

public class StakeholderSVImpl implements IStakeholderSV{

	public void saveStkholder(IBOStakeholderValue Stkholder,long objId,String objType)throws Exception
	{
		try{
			Stkholder.setObjId(objId);
			Stkholder.setObjType(objType);
			Stkholder.setCreateTime(ServiceManager.getOpDateTime());
			
			//当流程存在环状结构时，需要确定这个干系人是第x次执行了第y个环节
				//1.查询本环节已经进行了几次
			Criteria sql = new Criteria();
			sql.addEqual(BOCountStkholderBean.S_ObjId, Stkholder.getObjId());
			sql.addEqual(BOCountStkholderBean.S_ObjType, Stkholder.getObjType());			
			if (Stkholder.getLinkNo() != null)
				sql.addEqual(BOCountStkholderBean.S_LinkNo, Stkholder.getLinkNo());
			else if (Stkholder.getLinkId() != 0)
				sql.addEqual(BOCountStkholderBean.S_LinkId, Stkholder.getLinkId());
			else
				throw new Exception("在保存干系人方法中出错，没有发现环节信息，错误在SV层saveStkholder函数！");
			
			IStakeholderDao isd = (IStakeholderDao)ServiceFactory.getService(IStakeholderDao.class);
			IBOCountStkholderValue[] counts = isd.getStkholderNum(sql.toString(), sql.getParameters());
				//2.将获得的次数+1 写入stkholder的计数器字段中
			if (counts==null||counts.length==0||counts[0]==null)
				Stkholder.setCounter(1);
			else
				Stkholder.setCounter(counts[0].getNumOfOrder()+1);
			//保存stkholder
			isd.saveStakeholder(Stkholder);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("在保存干系人方法中出错，错误在SV层saveStkholder函数！");
		}
	}
	
	public IBOStakeholderValue[] getStkholders(long objId,String objType,String linkNo)throws Exception
	{
		try{
			//查新linkNo环节执行人
				//1.考虑到流程的环状结构，先查询linkNo环节已被执行几次
			Criteria sql = new Criteria();
			sql.addEqual(BOCountStkholderBean.S_ObjId, objId);
			sql.addEqual(BOCountStkholderBean.S_ObjType, objType);
			sql.addEqual(BOCountStkholderBean.S_LinkNo, linkNo);
			IStakeholderDao isd = (IStakeholderDao)ServiceFactory.getService(IStakeholderDao.class);
			IBOCountStkholderValue[] counts = isd.getStkholderNum(sql.toString(), sql.getParameters());
				//2.然后查询执行第n+1次对应的执行人
			sql.clear();
			sql.addEqual(IBOStakeholderValue.S_ObjId, objId);
			sql.addEqual(IBOStakeholderValue.S_ObjType, objType);
			sql.addEqual(IBOStakeholderValue.S_LinkNo, linkNo);
			sql.addEqual(IBOStakeholderValue.S_StdholdeType, IStakeholderType.STDHOLDETYPE_APPROVAL);
//			if (counts==null||counts.length==0||counts[0]==null)
//				sql.addEqual(BOStakeholderBean.S_Counter,1);
//			else
//				sql.addEqual(BOStakeholderBean.S_Counter, counts[0].getNumOfOrder()+1);
			return isd.getStakeholders(sql);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("在查询干系人方法中时出错，错误在SV层saveStkholder函数！");
		}
	}
	
	public IBOStakeholderValue[] getStkholders(long objId,String objType,long linkId)throws Exception
	{
		try{
			//查新linkNo环节执行人
				//1.考虑到流程的环状结构，先查询linkNo环节已被执行几次
			Criteria sql = new Criteria();
			sql.addEqual(BOCountStkholderBean.S_ObjId, objId);
			sql.addEqual(BOCountStkholderBean.S_ObjType, objType);
			sql.addEqual(BOCountStkholderBean.S_LinkId, linkId);
			IStakeholderDao isd = (IStakeholderDao)ServiceFactory.getService(IStakeholderDao.class);
			IBOCountStkholderValue[] counts = isd.getStkholderNum(sql.toString(), sql.getParameters());
				//2.然后查询执行第n+1次对应的执行人
			sql.clear();
			sql.addEqual(IBOStakeholderValue.S_ObjId, objId);
			sql.addEqual(IBOStakeholderValue.S_ObjType, objType);
			sql.addEqual(IBOStakeholderValue.S_LinkId, linkId);
			sql.addEqual(IBOStakeholderValue.S_StdholdeType, IStakeholderType.STDHOLDETYPE_APPROVAL);
//			if (counts==null||counts.length==0||counts[0]==null)
//				sql.addEqual(BOStakeholderBean.S_Counter,1);
//			else
//				sql.addEqual(BOStakeholderBean.S_Counter, counts[0].getNumOfOrder()+1);
//			
			return isd.getStakeholders(sql);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("在查询干系人方法中时出错，错误在SV层saveStkholder函数！");
		}
	}
	
	public int getStkCounter(long objId,String objType,String linkNo)throws Exception
	{
		try{
			Criteria sql = new Criteria();
			sql.addEqual(BOCountStkholderBean.S_ObjId, objId);
			sql.addEqual(BOCountStkholderBean.S_ObjType, objType);
			sql.addEqual(BOCountStkholderBean.S_LinkNo, linkNo);
			IStakeholderDao isd = (IStakeholderDao)ServiceFactory.getService(IStakeholderDao.class);
			IBOCountStkholderValue[] counts = isd.getStkholderNum(sql.toString(), sql.getParameters());
			if (counts==null||counts.length==0||counts[0]==null)
				return 1;
			else
				return counts[0].getNumOfOrder()+1;
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("查询当前stkholder的Counter字段时出错，错误在SV层getStkCounter函数");
		}
	}

	
	public IBOStakeholderValue[] getStkholdersByCondition(Criteria sql)
			throws Exception {
		// TODO Auto-generated method stub
		IStakeholderDao isd = (IStakeholderDao)ServiceFactory.getService(IStakeholderDao.class);
		return isd.getStakeholders(sql);
	}
	
	
	public void saveStakeholder(IBOStakeholderValue value) throws Exception {
		// TODO Auto-generated method stub
		IStakeholderDao isd = (IStakeholderDao)ServiceFactory.getService(IStakeholderDao.class);
		isd.saveStdholder(value);
	}
}
