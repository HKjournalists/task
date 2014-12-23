package com.asiainfo.csc.matrix.service.interfaces;

import java.util.Map;

import com.asiainfo.csc.matrix.ivalues.IBOAlmHisStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;

public interface IAlmHisStakeholderSV {
	public IBOAlmHisStakeholderValue[] getHisStakeholderByCondition(String condition,Map paramter) throws Exception;
	public void saveHisStakeholder(IBOAlmHisStakeholderValue[] schedules) throws Exception;
	public void copyHisStakeholderByStakeholder(IBOAlmWorkorderValue iWorkOrderValue, IBOAlmStakeholderValue iBOStakeholder)
	throws Exception;
}
