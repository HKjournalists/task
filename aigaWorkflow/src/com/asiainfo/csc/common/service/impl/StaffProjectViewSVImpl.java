package com.asiainfo.csc.common.service.impl;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.ai.secframe.bo.orgmodel.QSysUserGroupRelateBean;
import com.ai.secframe.common.Constants;
import com.ai.secframe.ivalues.orgmodel.ISysOrganizeValue;
import com.ai.secframe.service.pubapi.interfaces.ISecframe;
import com.asiainfo.csc.common.dao.interfaces.IStaffProjectViewDao;
import com.asiainfo.csc.common.ivalues.IBOStaffProjectViewValue;
import com.asiainfo.csc.common.service.interfaces.IStaffProjectViewSV;

public class StaffProjectViewSVImpl implements IStaffProjectViewSV{

	private IStaffProjectViewDao spvd = (IStaffProjectViewDao)ServiceFactory.getService(IStaffProjectViewDao.class);
	
	public IBOStaffProjectViewValue[] getStaffsByProject(long[] projectId,String role_code)throws Exception
	{
		try{
			String condition ="";
			if(projectId.length>0){
				condition = "group_id in (";
				for (int i=1;i<=projectId.length;i++)
				{
					if (i==projectId.length)
						condition += projectId[i-1]+"";
					else
						condition += projectId[i-1]+",";
				}
				condition += ")";				
			}else{
				condition= " 1=1 ";
			}
			if (role_code==null)
			{
				condition += " and STAFF_ID in " +
				"(select a.staff_id from sys_staff a, sys_staff_role_author b, sys_role c " +
				"where a.staff_id = b.staff_id and b.role_id = c.role_id )";
			}else{
				condition += " and STAFF_ID in " +
				"(select a.staff_id from sys_staff a, sys_staff_role_author b, sys_role c " +
				"where a.staff_id = b.staff_id and b.role_id = c.role_id and c.code = '"+ role_code +"')";
			}
			return spvd.getBeansByCond(condition);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("查询员工By项目SV出错");
		}
	}
	
	public ISysOrganizeValue[] getOrgsFromDatasByParentId(ISysOrganizeValue[] sysOrgValues,String parentId)throws Exception
	{
	    List<ISysOrganizeValue> sysOrgs = new ArrayList<ISysOrganizeValue>();
	    ISysOrganizeValue[] orgValues = null;
		for (int i = 0; i < sysOrgValues.length; i++) {
			if(sysOrgValues[i].getParentOrganizeId()==Long.valueOf(parentId)){
				sysOrgs.add(sysOrgValues[i]);
			}
		}
		orgValues = sysOrgs.toArray(new ISysOrganizeValue[sysOrgs.size()]);
		return orgValues;
	}
	
	public ISysOrganizeValue[] queryOrgsByList(List orgIds) throws Exception 
	{
		return spvd.queryOrgsByOrgIds(orgIds);
	}
	
	public long[] getProjectIds (long staffId, String groupName)throws Exception, RemoteException
	{
		try{
			Criteria sql = new Criteria();
			if(staffId != -1)
				sql.addEqual(QSysUserGroupRelateBean.S_StaffId, staffId);
			if(groupName != null && !"".equals(groupName))
				sql.addEqual(QSysUserGroupRelateBean.S_GroupName, groupName);
			return spvd.getGroupIdByStaffId(sql.toString(), sql.getParameters());
		}catch (Exception e)
		{
			e.printStackTrace();
			throw new Exception("获取当前员工所属项目编号失败！\n\n错误原因："+ (e.getCause() == null ? e.getMessage() : e.getCause().getMessage()),e);
		}
	}
	
	public String[] getProjectNames (long staffId, String groupName)throws Exception, RemoteException
	{
		try{
			Criteria sql = new Criteria();
			if(staffId != -1)
				sql.addEqual(QSysUserGroupRelateBean.S_StaffId, staffId);
			if(groupName != null && !"".equals(groupName))
				sql.addEqual(QSysUserGroupRelateBean.S_GroupName, groupName);
			return spvd.getGroupNameByStaffId(sql.toString(), sql.getParameters());
		}catch (Exception e)
		{
			e.printStackTrace();
			throw new Exception("获取当前员工所属项目编号失败！\n\n错误原因："+ (e.getCause() == null ? e.getMessage() : e.getCause().getMessage()),e);
		}
	}
	public boolean getOrgIsParnetChildRel(long parentOrgId,long childOrgId) throws Exception, RemoteException
	{
		ISecframe secframe = (ISecframe) ServiceFactory.getService(Constants.SERVICE_SECFRAME);
		String sql = "m.organize_id = :parentOrgId and m.organize_id in(select a.organize_id from sys_organize a start with a.organize_id=:childOrgId connect by prior a.parent_organize_id=a.organize_id)";
		Map param = new HashMap();
		param.put("parentOrgId", parentOrgId);
		param.put("childOrgId", childOrgId);
		ISysOrganizeValue[] sv = secframe.getSysOrganize(sql, param);
		if(sv != null && sv.length>0){
			return true;
		}
		return true;
	}
	
}
