package com.asiainfo.csc.common.dao.impl;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;

import com.ai.secframe.bo.orgmodel.QSysUserGroupRelateBean;
import com.ai.secframe.bo.orgmodel.QSysUserGroupRelateEngine;
import com.ai.secframe.bo.orgmodel.SysOrganizeEngine;
import com.ai.secframe.ivalues.orgmodel.ISysOrganizeValue;
import com.asiainfo.csc.common.bo.BOStaffProjectViewEngine;
import com.asiainfo.csc.common.dao.interfaces.IStaffProjectViewDao;
import com.asiainfo.csc.common.ivalues.IBOStaffProjectViewValue;


public class StaffProjectViewDaoImpl implements IStaffProjectViewDao{
	
	private  List<ISysOrganizeValue> sysOrgs = new ArrayList<ISysOrganizeValue>();

	public IBOStaffProjectViewValue[] getBeansByCond(String condition)throws Exception
	{
		try{
		return BOStaffProjectViewEngine.getBeans(condition, null);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("查询员工By项目DAO出错");
		}
	}
	
	public ISysOrganizeValue[] queryOrgsByOrgIds(List orgIds)throws Exception
	{
		
		ISysOrganizeValue[] orgValues = null;
		sysOrgs = new ArrayList<ISysOrganizeValue>();
		
		for (Iterator orgId = orgIds.iterator(); orgId.hasNext();) {
			Long sysOrg = (Long) orgId.next();
			ISysOrganizeValue  showValue = this.getOrgById(sysOrg);
			if(!this.hasOrg(sysOrgs, sysOrg)){
				sysOrgs.add(showValue);
			}
			//调用 递归方法， 一直查到根。-1
			this.findOrgToRoot(showValue);
		}
		
		orgValues = sysOrgs.toArray(new ISysOrganizeValue[sysOrgs.size()]);
		return orgValues;
	}
	
	public void  findOrgToRoot(ISysOrganizeValue showValue)throws Exception 
	{
		if(showValue.getParentOrganizeId()==-1){
			return;
		}
		//得到父组织org
		ISysOrganizeValue  orgValue = this.getOrgById(showValue.getParentOrganizeId());
		if(!this.hasOrg(sysOrgs, orgValue.getOrganizeId())){
			sysOrgs.add(orgValue);
		}
		this.findOrgToRoot(orgValue);
	}
	
	//list 中 是否存在？
	public  boolean  hasOrg(List<ISysOrganizeValue> sysOrgs , long orgId )
	{
		for (Iterator iterator = sysOrgs.iterator(); iterator.hasNext();) 
		{
			ISysOrganizeValue org = (ISysOrganizeValue) iterator.next();
			if(org.getOrganizeId()==orgId){
				return true;
			}
		}
		return false;
	}
	
	//根据组织Id 得到组织
	public ISysOrganizeValue getOrgById(Long sysOrg)throws Exception
	{
		return SysOrganizeEngine.getBean(sysOrg);
	}
	
	
		
	public long[] getGroupIdByStaffId(String cond,Map param)throws Exception
	{
		TreeSet<QSysUserGroupRelateBean> set = new TreeSet<QSysUserGroupRelateBean>(new Comparator<QSysUserGroupRelateBean>(){

			
			public int compare(QSysUserGroupRelateBean o1, QSysUserGroupRelateBean o2) {
				
			return (int) (o1.getGroupId()-o2.getGroupId());
				
			}
  			
  		});
		try{
			QSysUserGroupRelateBean[] UGRel = QSysUserGroupRelateEngine.getBeans(cond, param);
			
			for (int i=0;i<UGRel.length;i++){
				set.add(UGRel[i]);
			}
			long[] GroupId = new long[set.size()];
			Iterator<QSysUserGroupRelateBean> iterator = set.iterator();
			int j = 0;
			while(iterator.hasNext()){
				GroupId[j] =iterator.next().getGroupId(); 
				j++;
			}
			return GroupId;
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("由员工编号获取项目编号错误");
		}
	}
	
	public String[] getGroupNameByStaffId(String cond,Map param)throws Exception
	{
		TreeSet<QSysUserGroupRelateBean> set = new TreeSet<QSysUserGroupRelateBean>(new Comparator<QSysUserGroupRelateBean>(){

			
			public int compare(QSysUserGroupRelateBean o1, QSysUserGroupRelateBean o2) {
				
			return (int) (o1.getGroupId()-o2.getGroupId());
				
			}
  			
  		});
		try{
			QSysUserGroupRelateBean[] UGRel = QSysUserGroupRelateEngine.getBeans(cond, param);
			
			for (int i=0;i<UGRel.length;i++){
				set.add(UGRel[i]);
			}
			String[] GroupName = new String[set.size()];
			Iterator<QSysUserGroupRelateBean> iterator = set.iterator();
			int j = 0;
			while(iterator.hasNext()){
				GroupName[j] =iterator.next().getGroupName(); 
				j++;
			}
			return GroupName;
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("由员工编号获取项目编号错误");
		}
	}
}
