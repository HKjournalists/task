package com.asiainfo.csc.common.service.interfaces;

import java.rmi.RemoteException;
import java.util.List;

import com.ai.secframe.ivalues.orgmodel.ISysOrganizeValue;
import com.asiainfo.csc.common.ivalues.IBOStaffProjectViewValue;

public interface IStaffProjectViewSV {
	
	/**
	 * 查询staff信息
	 * @param projectId
	 * @param role_code
	 * @return
	 * @throws Exception
	 */
	public IBOStaffProjectViewValue[] getStaffsByProject(long[] projectId,String role_code)throws Exception;
	
	/**
	 * 在指定的组织范围内 根据组织的parentid 得到 组织信息
	 * @param sysOrgValues
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	public ISysOrganizeValue[] getOrgsFromDatasByParentId(ISysOrganizeValue[] sysOrgValues,String parentId)throws Exception;
	
	/**
	 * 根据父组织Id 得到其组织信息
	 * @param orgIds
	 * @return
	 * @throws Exception
	 */
	public ISysOrganizeValue[] queryOrgsByList(List orgIds) throws Exception;
	
	/**
	 * 获取选择员工时需要的项目编号
	 * @param staffId
	 * @return
	 * @throws Exception
	 * @throws RemoteException
	 */
	public long[] getProjectIds (long staffId, String groupName)throws Exception, RemoteException;
	/**
	 * 获取选择员工时需要的项目名称
	 * @param staffId
	 * @return
	 * @throws Exception
	 * @throws RemoteException
	 */
	public String[] getProjectNames (long staffId, String groupName)throws Exception, RemoteException;
	
	
	public boolean getOrgIsParnetChildRel(long parentOrgId,long childOrgId) throws Exception, RemoteException;
}
