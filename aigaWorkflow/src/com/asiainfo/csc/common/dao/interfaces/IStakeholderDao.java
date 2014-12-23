package com.asiainfo.csc.common.dao.interfaces;

import java.util.Map;

import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.common.ivalues.IBOCountStkholderValue;
import com.asiainfo.csc.common.ivalues.IBOHisStakeholderValue;
import com.asiainfo.csc.common.ivalues.IBOStakeholderValue;

public interface IStakeholderDao {
	/**
	 * ��ϵ�˲�ѯ����1
	 * @param sql
	 * @return
	 * @throws Exception
	 */
	public IBOStakeholderValue[] getStakeholders(Criteria sql)throws Exception;
	/**
	 * ��ϵ�˲�ѯ����2
	 * @param condition
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public IBOStakeholderValue[] getStakeholders(String condition,Map param)throws Exception;
	/**
	 * ��ѯ��ϵ�˼�����ͼ����
	 * @param cond
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public IBOCountStkholderValue[] getStkholderNum(String cond,Map param)throws Exception;
	/**
	 * ��ϵ�˱��淽��
	 * @param holder
	 * @throws Exception
	 */
	public void saveStakeholder(IBOStakeholderValue holder)throws Exception;
	
	public void saveHisStakeholder(IBOHisStakeholderValue stkholderValue)throws Exception;
	
	public void saveStdholder(IBOStakeholderValue aValue)throws Exception;
}
