package com.asiainfo.csc.common.service.impl;

import java.util.HashMap;
import java.util.Map;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.secframe.common.Constants;
import com.ai.secframe.ivalues.orgmodel.ISysEmployeeValue;
import com.ai.secframe.ivalues.orgmodel.ISysOrganizeValue;
import com.ai.secframe.ivalues.orgmodel.ISysStaffOrgRelatValue;
import com.ai.secframe.service.pubapi.interfaces.ISecframe;
import com.asiainfo.csc.common.dao.interfaces.IPermissionDao;
import com.asiainfo.csc.common.define.OrgRole;
import com.asiainfo.csc.common.service.interfaces.IPermissionSV;

public class PermissionSVImpl implements IPermissionSV
{

	ISecframe secframe = (ISecframe) ServiceFactory.getService(Constants.SERVICE_SECFRAME);

	public String getOrgName(long orgId) throws Exception
	{
		try
		{

			String orgName = null;

			if (orgId != -1)
			{
				String condition = " 1=1 start with organize_id =" + orgId + " connect by prior parent_organize_id =organize_id  order by organize_id asc";
				Map parameter = new HashMap();
				ISysOrganizeValue[] orgInfo = null;
				try
				{
					orgInfo = secframe.getSysOrganize(condition, parameter);
				} catch (Exception e)
				{

					e.printStackTrace();
				}
				orgName = orgInfo[0].getOrganizeName();
				for (int i = 1; i < orgInfo.length; i++)
				{
					if (orgName != null)
					{
						orgName = orgName + "/" + orgInfo[i].getOrganizeName();
					}
				}
			}
			return orgName;

		} catch (Exception e)
		{
			e.printStackTrace();
			throw new Exception("获取组织字符串出错，错误在SV层，getOrgName函数");
		}
	}

	public String[] getProjectId(long staffId) throws Exception
	{
		try
		{
			IPermissionDao iPermissionDao = (IPermissionDao)ServiceFactory.getService(IPermissionDao.class);
			return iPermissionDao.getProjectId(staffId);
		} catch (Exception e)
		{
			throw e;
		}
	}

	public long getReqSource(long userId)
	{
		long orgid = 0;
		long reqSource = -1;

		// 获取组织id
		try
		{
			ISysStaffOrgRelatValue stafforg = secframe.getSysStaffOrgBaseRelatByStaffId(userId);

			orgid = secframe.getSysStaffOrgBaseRelatByStaffId(userId).getOrganizeId();
			ISysOrganizeValue orginfo = secframe.getSysOrganizeById(orgid);
			String orgname = orginfo.getOrganizeName();
			int index = orgname.indexOf("员工");
			if (index != -1)
			{
				String orgcode = orginfo.getOldParentCode();
				orgid = secframe.getSysOrgByOrgCode(orgcode).getOrganizeId();
			}
			reqSource = secframe.getSysOrganizeById(orgid).getOrgRoleTypeId();
		}catch (Exception e)
		{
			e.printStackTrace();
		}
		return reqSource;

	}

	//返回组织id 编号、名称、员工编号、员工名称及员工级别
	public OrgRole getOrgRole(long userId) throws Exception {
		long orgid = 0;
		String orgname = null;
		String orgcode = null;
		boolean ismgr = false;
		long  empId=-1;
		String  empName=null;
		String staffno=null;
		ISysEmployeeValue iEmployeeInfo;
		// 获取组织id
		try {
			staffno=secframe.getSysStaffByStaffId(userId).getCode();
			empId= secframe.getSysStaffByStaffId(userId).getEmployeeId();
			iEmployeeInfo = secframe.getSysEmployeeById(empId);
			empName=iEmployeeInfo.getEmployeeName();
					
			@SuppressWarnings("unused")
			ISysStaffOrgRelatValue stafforg = secframe
					.getSysStaffOrgBaseRelatByStaffId(userId);

			orgid = ((Long) secframe.getSysStaffOrgBaseRelatByStaffId(userId)
					.getOrganizeId()).intValue();
			ISysOrganizeValue orginfo = secframe.getSysOrganizeById(orgid);
			orgname = orginfo.getOrganizeName();
			orgcode=orginfo.getCode();
			long stafflvl = secframe.getSysStaffByStaffId(userId).getOpLvl();
			//在 sys_static_data 定义员工操作级别 为9是 是管理员
			if (stafflvl == 2) {
				ismgr = true;
			}

			/*int index = orgname.indexOf("员工"); if (index != -1) {
				porgid =orginfo.getParentOrganizeId(); 
				orginfo= secframe.getSysOrganizeById(porgid);
				orgid =orginfo.getOrganizeId(); orgname = orginfo.getOrganizeName();
				ismgr = false; 
			 } 
			else{
				 orgcode=orginfo.getCode();
				 orgid = ((Long)secframe.getSysOrgByOrgCode(orgcode).getOrgId()) .intValue();
				 orgname = orginfo.getOrganizeName(); 
				 ismgr = false; 
				 }*/
		} catch (Exception e) {
			e.printStackTrace();
		}
		OrgRole orgrole = new OrgRole();
		orgrole.setIsmgr(ismgr);
		orgrole.setOrgid(orgid);
		orgrole.setOrgcode(orgcode);
		orgrole.setOrgname(orgname);
		orgrole.setStaffname(empName);
		orgrole.setStaffno(staffno);
		return orgrole;
	}
	
	public String getOrgType(long userId) throws Exception {//获取组织类型名称
		long orgid = 0;
		long orgtypeid = 0;
		String orgTypeNme = null;
		try {
			orgid = secframe.getSysStaffOrgBaseRelatByStaffId(userId)
					.getOrganizeId();
			orgtypeid = secframe.getSysOrganizeById(orgid).getOrgRoleTypeId();
			orgTypeNme = secframe.getOrgRoleTypeByTypeId(orgtypeid)
					.getOrgRoleTypeName();
		} catch (Exception e) {

			e.printStackTrace();
		}
		return orgTypeNme;
	}
}
