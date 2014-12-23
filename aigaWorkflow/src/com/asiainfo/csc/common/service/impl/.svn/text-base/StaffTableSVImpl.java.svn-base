package com.asiainfo.csc.common.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.common.dao.interfaces.IStaffTableDao;
import com.asiainfo.csc.common.ivalues.IBOStaffTableValue;
import com.asiainfo.csc.common.service.interfaces.IStaffTableSV;

public class StaffTableSVImpl implements IStaffTableSV{
	
	private IStaffTableDao istd = (IStaffTableDao)ServiceFactory.getService(IStaffTableDao.class);

	public IBOStaffTableValue[] queryStaffsByIdAndRole(String staffIds ,String roleCode)throws Exception
	{
		try{
			if(staffIds==null || staffIds.equals(""))
			{
				throw new Exception("在根据员工Id和角色查询员工信息时接收到空数据，错误在SV层queryStaffsByIdAndRole函数");
			}
		
			String condition="";
			if (roleCode==null||roleCode.equals(""))
				condition = " staff_id in ("+staffIds+")";
			else
				condition = " staff_id in ("+staffIds+") and role_code in ('"+roleCode+"')";
			
			return istd.getStaffs(condition, null);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("在根据员工Id和角色查询员工信息时出错，错误在SV层queryStaffsByIdAndRole函数");
		}
	}
	
	
	public IBOStaffTableValue[] queryStaffsByIds(String staffIds ,String roleCode)throws Exception
	{
		try{
			if(staffIds==null || staffIds.equals(""))
			{
				throw new Exception("在根据员工Id和角色查询员工信息时接收到空数据，错误在SV层queryStaffsByIdAndRole函数");
			}
		
			String condition="";
			if (roleCode==null||roleCode.equals(""))
				condition = " staff_id in ("+staffIds+")";
			else
				condition = " staff_id in ("+staffIds+") and role_code in ('"+roleCode+"')";
			IBOStaffTableValue[] stValue=istd.getStaffs(condition, null);
			Map<Long,IBOStaffTableValue> map=new HashMap<Long,IBOStaffTableValue>();
			for(IBOStaffTableValue value:stValue){
				if(map.get(value.getStaffId())==null){
					map.put(value.getStaffId(),value);
				}
			}
			return map.values().toArray(new IBOStaffTableValue[map.size()]);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("在根据员工Id和角色查询员工信息时出错，错误在SV层queryStaffsByIdAndRole函数");
		}
	}
	
	public IBOStaffTableValue[] queryBranchStaffs(long branchRoot)throws Exception
	{
		try{
			String condition = "organize_id in(select organize_id from sys_organize start with organize_id ="+branchRoot+" connect by prior organize_id = parent_organize_id)";
			return istd.getStaffs(condition, null);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("在根据父节点ID查询子组织时出错，错误在SV层queryOrgsByPid函数");
		}
	}

	
	public IBOStaffTableValue[] queryStaffsByName(String staffIds,
			String roleCode, String name) throws Exception {
		// TODO Auto-generated method stub
		try{
//			if(staffIds==null || staffIds.equals(""))
//			{
//				throw new Exception("在根据员工Id和角色查询员工信息时接收到空数据，错误在SV层queryStaffsByIdAndRole函数");
//			}
//		
			String condition="";
			boolean a = false;
			boolean b = false;
			boolean c = false;
			if (!StringUtils.isBlank(staffIds)) {
				condition = condition + "staff_id in ("+staffIds+")";
				a = true;
			}
			if (!StringUtils.isBlank(roleCode)) {
				if(a) 
					condition = condition + " and ";
				condition = condition + "role_code in ('"+roleCode+"')";
				b = true;
			}
			
			if (!StringUtils.isBlank(name)) {
				if(a||b) 
					condition = condition + " and ";
				condition = condition + "employee_name like '%"+name+"%'";
				c = true;
			}
			System.out.println(condition);
			return istd.getStaffs(condition, null);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("在根据员工Id和角色查询员工信息时出错，错误在SV层queryStaffsByIdAndRole函数");
		}
	}
	
	public IBOStaffTableValue[] queryStaffInfoByCode(String staffCode)throws Exception{
		Criteria sql = new Criteria();
		sql.addEqual(IBOStaffTableValue.S_StaffCode, staffCode);
		return istd.getStaffs(sql.toString(), sql.getParameters());
	}
}
