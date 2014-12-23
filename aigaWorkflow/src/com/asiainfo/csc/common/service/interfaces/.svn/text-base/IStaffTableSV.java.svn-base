package com.asiainfo.csc.common.service.interfaces;

import com.asiainfo.csc.common.ivalues.IBOStaffTableValue;


public interface IStaffTableSV {
	/**
	 * 在选择干系人时，用于刷新弹出窗口右边表格
	 * @param staffIds
	 * @param roleCode
	 * @return
	 * @throws Exception
	 */
	public IBOStaffTableValue[] queryStaffsByIdAndRole(String staffIds ,String roleCode)throws Exception;
	
	public IBOStaffTableValue[] queryStaffsByIds(String staffIds ,String roleCode)throws Exception;
	/**
	 * 用于查询在特定组织分之上的员工信息
	 * @param branchRoot
	 * @return
	 * @throws Exception
	 */
	public IBOStaffTableValue[] queryBranchStaffs(long branchRoot)throws Exception;
	
	public IBOStaffTableValue[] queryStaffsByName(String staffIds ,String roleCode,String name)throws Exception;
	
	/**
	 * 用于查询员工信息
	 * @param staffCode
	 * @return
	 * @throws Exception
	 */
	public IBOStaffTableValue[] queryStaffInfoByCode(String staffCode)throws Exception;
}
