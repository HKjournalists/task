package com.asiainfo.csc.common.dao.interfaces;

import java.util.Map;

import com.asiainfo.csc.common.ivalues.IBOWorkflowValue;

public interface IWorkflowDao {
	/**
	 * workflow���ñ��ѯ����
	 * @param cond
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public IBOWorkflowValue[] getWorkflows(String cond,Map param)throws Exception;
}
