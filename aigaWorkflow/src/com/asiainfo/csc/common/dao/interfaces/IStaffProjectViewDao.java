package com.asiainfo.csc.common.dao.interfaces;

import java.util.List;
import java.util.Map;

import com.ai.secframe.ivalues.orgmodel.ISysOrganizeValue;
import com.asiainfo.csc.common.ivalues.IBOStaffProjectViewValue;

public interface IStaffProjectViewDao {
	
	/**
	 * 根据条件查询的方法
	 * @param condition
	 * @return
	 * @throws Exception
	 */
	public IBOStaffProjectViewValue[] getBeansByCond(String condition)throws Exception;
	
	/**
	 * 根据组织Id查询组织
	 * @param orgIds
	 * @return
	 * @throws Exception
	 */
	public ISysOrganizeValue[] queryOrgsByOrgIds(List orgIds)throws Exception;
	
	/**
	 * 通过员工编号获取项目编号
	 * @param cond
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public long[] getGroupIdByStaffId(String cond,Map param)throws Exception;
	/**
	 * 通过员工编号获取项目名称
	 * @param cond
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String[] getGroupNameByStaffId(String cond,Map param)throws Exception;
	
}
