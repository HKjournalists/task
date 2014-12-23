package com.asiainfo.csc.common.dao.impl;

import java.util.Map;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.ai.secframe.common.Constants;
import com.ai.secframe.ivalues.orgmodel.IStaffValue;
import com.ai.secframe.service.pubapi.interfaces.ISecframe;
import com.asiainfo.csc.common.bo.BOCountStkholderEngine;
import com.asiainfo.csc.common.bo.BOHisStakeholderEngine;
import com.asiainfo.csc.common.bo.BOStakeholderEngine;
import com.asiainfo.csc.common.dao.interfaces.IStakeholderDao;
import com.asiainfo.csc.common.ivalues.IBOCountStkholderValue;
import com.asiainfo.csc.common.ivalues.IBOHisStakeholderValue;
import com.asiainfo.csc.common.ivalues.IBOStakeholderValue;

public class StakeholderDaoImpl implements IStakeholderDao{

	public IBOStakeholderValue[] getStakeholders(Criteria sql)throws Exception
	{
		try{
			return BOStakeholderEngine.getBeans(sql);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("在查询干系人方法1中出错，错误在Dao层getStakeholders函数");
		}
	}
	
	public IBOStakeholderValue[] getStakeholders(String condition,Map param)throws Exception
	{
		try{
			return BOStakeholderEngine.getBeans(condition, param);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("在查询干系人方法2中出错，错误在Dao层getStakeholders函数");
		}
	}
	
	public IBOCountStkholderValue[] getStkholderNum(String cond,Map param)throws Exception
	{
		try{
			return BOCountStkholderEngine.getBeans(cond, param);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("查询某流程中，某一环节被流经X次出错，错误在Dao层，getStkholderNum函数");
		}
	}
	
	public void saveStakeholder(IBOStakeholderValue holder)throws Exception
	{
		try{
			//判空
			if (holder == null)
				throw new Exception("保存干系人方法中传入参数为空，错误在Dao层，saveStakeholder函数");
			
			//获取新主键值
			if (holder.isNew())
			{
				long newId = BOStakeholderEngine.getNewId().longValue();
				holder.setStdholderId(newId);
			}
			
			//干系人不能为空
			if (holder.getStdholderStaffId() == 0 && holder.getStdholderStaffNo()== null)
				throw new Exception("在保存干系人方法中发现干系人信息为空，错误在Dao层saveStakeholder函数");
			
			//根据干系人Id填写执行人No
			ISecframe secframe = (ISecframe) ServiceFactory.getService(Constants.SERVICE_SECFRAME);
			if (holder.getStdholderStaffNo()==null||holder.getStdholderStaffNo().equals(""))
			{
				IStaffValue staff = secframe.getStaffByStaffId(holder.getStdholderStaffId());
				holder.setStdholderStaffNo(staff.getCode());
				holder.setStdholderStaffName(staff.getName());
			}
			
			//根据No填Id
			if (holder.getStdholderStaffId() == 0)
			{
				IStaffValue staff = secframe.getStaffByCode(holder.getStdholderStaffNo());
				holder.setStdholderStaffId(staff.getStaffId());
				holder.setStdholderStaffName(staff.getName());
			}
			
			//保存
			BOStakeholderEngine.save(holder);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("保存干系人方法出错，错误在Dao层，saveStakeholder函数");
		}
	}
	
	public void saveHisStakeholder(IBOHisStakeholderValue stkholderValue)throws Exception
	{
		try{
			//判空
			if (stkholderValue == null)
				throw new Exception("在保存干系人历史表时发现传入数据为空，错误在Dao层，saveHisStakeholder函数");
			
			//获得新主键值
			if (stkholderValue.isNew())
			{
				long newId = BOHisStakeholderEngine.getNewId().longValue();
				stkholderValue.setHisStdholderId(newId);
			}
			
			BOHisStakeholderEngine.save(stkholderValue);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("在保存干系人历史表时出错，错误在Dao层，saveHisStakeholder函数");
		}
	}

	
	public void saveStdholder(IBOStakeholderValue value) throws Exception {
		// TODO Auto-generated method stub
		try{
			if (value == null)
				throw new Exception("在保存干系人发现传入数据为空，错误在Dao层，saveStdholder函数");
			BOStakeholderEngine.save(value);
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception("在保存干系人时出错，错误在Dao层，saveStdholder函数");
		}
	}
}
