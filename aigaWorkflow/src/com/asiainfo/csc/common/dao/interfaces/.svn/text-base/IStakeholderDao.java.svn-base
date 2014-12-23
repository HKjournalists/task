package com.asiainfo.csc.common.dao.interfaces;

import java.util.Map;

import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.common.ivalues.IBOCountStkholderValue;
import com.asiainfo.csc.common.ivalues.IBOHisStakeholderValue;
import com.asiainfo.csc.common.ivalues.IBOStakeholderValue;

public interface IStakeholderDao {
	/**
	 * 干系人查询方法1
	 * @param sql
	 * @return
	 * @throws Exception
	 */
	public IBOStakeholderValue[] getStakeholders(Criteria sql)throws Exception;
	/**
	 * 干系人查询方法2
	 * @param condition
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public IBOStakeholderValue[] getStakeholders(String condition,Map param)throws Exception;
	/**
	 * 查询干系人计数视图方法
	 * @param cond
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public IBOCountStkholderValue[] getStkholderNum(String cond,Map param)throws Exception;
	/**
	 * 干系人保存方法
	 * @param holder
	 * @throws Exception
	 */
	public void saveStakeholder(IBOStakeholderValue holder)throws Exception;
	
	public void saveHisStakeholder(IBOHisStakeholderValue stkholderValue)throws Exception;
	
	public void saveStdholder(IBOStakeholderValue aValue)throws Exception;
}
