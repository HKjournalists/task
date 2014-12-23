package com.asiainfo.csc.common.service.interfaces;

import java.rmi.RemoteException;
import java.util.List;

import com.ai.secframe.ivalues.orgmodel.ISysOrganizeValue;
import com.asiainfo.csc.common.ivalues.IBOStaffProjectViewValue;

public interface IStaffProjectViewSV {
	
	/**
	 * ��ѯstaff��Ϣ
	 * @param projectId
	 * @param role_code
	 * @return
	 * @throws Exception
	 */
	public IBOStaffProjectViewValue[] getStaffsByProject(long[] projectId,String role_code)throws Exception;
	
	/**
	 * ��ָ������֯��Χ�� ������֯��parentid �õ� ��֯��Ϣ
	 * @param sysOrgValues
	 * @param parentId
	 * @return
	 * @throws Exception
	 */
	public ISysOrganizeValue[] getOrgsFromDatasByParentId(ISysOrganizeValue[] sysOrgValues,String parentId)throws Exception;
	
	/**
	 * ���ݸ���֯Id �õ�����֯��Ϣ
	 * @param orgIds
	 * @return
	 * @throws Exception
	 */
	public ISysOrganizeValue[] queryOrgsByList(List orgIds) throws Exception;
	
	/**
	 * ��ȡѡ��Ա��ʱ��Ҫ����Ŀ���
	 * @param staffId
	 * @return
	 * @throws Exception
	 * @throws RemoteException
	 */
	public long[] getProjectIds (long staffId, String groupName)throws Exception, RemoteException;
	/**
	 * ��ȡѡ��Ա��ʱ��Ҫ����Ŀ����
	 * @param staffId
	 * @return
	 * @throws Exception
	 * @throws RemoteException
	 */
	public String[] getProjectNames (long staffId, String groupName)throws Exception, RemoteException;
	
	
	public boolean getOrgIsParnetChildRel(long parentOrgId,long childOrgId) throws Exception, RemoteException;
}
