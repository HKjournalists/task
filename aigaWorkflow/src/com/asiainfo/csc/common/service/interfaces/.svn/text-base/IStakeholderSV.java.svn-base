package com.asiainfo.csc.common.service.interfaces;

import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.common.ivalues.IBOStakeholderValue;

public interface IStakeholderSV {
	/**
	 * 保存干系人方法
	 * @param Stkholder
	 * @param objId
	 * @param objType
	 * @throws Exception
	 */
	public void saveStkholder(IBOStakeholderValue Stkholder,long objId,String objType)throws Exception;
	/**
	 * 查询干系人方法
	 * @param objId
	 * @param objType
	 * @param linkNo
	 * @return
	 * @throws Exception
	 */
	public IBOStakeholderValue[] getStkholders(long objId,String objType,String linkNo)throws Exception;
	/**
	 * 查询干系人方法 用LinkId没有No
	 * @param objId
	 * @param objType
	 * @param linkId
	 * @return
	 * @throws Exception
	 */
	public IBOStakeholderValue[] getStkholders(long objId,String objType,long linkId)throws Exception;
	/**
	 * 查询当前干系人Counter字段
	 * @param objId
	 * @param objType
	 * @param linkNo
	 * @return
	 * @throws Exception
	 */
	public int getStkCounter(long objId,String objType,String linkNo)throws Exception;
	
	public IBOStakeholderValue[] getStkholdersByCondition(Criteria sql)throws Exception;
	
	public void saveStakeholder(IBOStakeholderValue aValue)throws Exception;
}
