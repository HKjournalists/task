package com.asiainfo.csc.common.service.interfaces;

import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.common.ivalues.IBOStakeholderValue;

public interface IStakeholderSV {
	/**
	 * �����ϵ�˷���
	 * @param Stkholder
	 * @param objId
	 * @param objType
	 * @throws Exception
	 */
	public void saveStkholder(IBOStakeholderValue Stkholder,long objId,String objType)throws Exception;
	/**
	 * ��ѯ��ϵ�˷���
	 * @param objId
	 * @param objType
	 * @param linkNo
	 * @return
	 * @throws Exception
	 */
	public IBOStakeholderValue[] getStkholders(long objId,String objType,String linkNo)throws Exception;
	/**
	 * ��ѯ��ϵ�˷��� ��LinkIdû��No
	 * @param objId
	 * @param objType
	 * @param linkId
	 * @return
	 * @throws Exception
	 */
	public IBOStakeholderValue[] getStkholders(long objId,String objType,long linkId)throws Exception;
	/**
	 * ��ѯ��ǰ��ϵ��Counter�ֶ�
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
