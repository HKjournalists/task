package com.asiainfo.csc.matrix.dao.interfaces;

import java.util.List;
import java.util.Map;

import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;



public interface IAlmStakeholderDao {
	public IBOAlmStakeholderValue[] getStakeholderByCondition(String condition,Map paramter) throws Exception;
	public void saveStakeholder(IBOAlmStakeholderValue[] schedules) throws Exception;
	public void saveStakeholder(IBOAlmStakeholderValue schedule) throws Exception;
	public IBOAlmStakeholderValue saveStakeholderByConds(String linkId,String linkNo,String staffId,String staffName,String stdType,String objId,String objType) throws Exception;
	public IBOAlmStakeholderValue[] getStakeholders(String cond, Map param) throws Exception;
	public IBOAlmStakeholderValue[] getStakeholders(Criteria sql);
	public IBOAlmStakeholderValue[] getStakeholderBySql(String sql,Map paramter) throws Exception;
	
	//���ܱ����ϵ�˷���
	public void saveStakeholder(List<IBOAlmStakeholderValue> o,long objId,String objType) throws Exception;
	public void saveStakeholder(IBOAlmStakeholderValue value,long objId,String objType) throws Exception;
	//��ȡ�Ƿ��ǻ�ǩ
	public boolean queryIsSignByLinkNo(String linkNo) throws Exception;
}
