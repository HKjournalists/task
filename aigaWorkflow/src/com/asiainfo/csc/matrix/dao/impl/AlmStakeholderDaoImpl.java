package com.asiainfo.csc.matrix.dao.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.common.define.IObjectType;
import com.asiainfo.csc.common.define.IStakeholderType;
import com.asiainfo.csc.common.define.WorkFlowParam;
import com.asiainfo.csc.matrix.bo.BOAlmStakeholderBean;
import com.asiainfo.csc.matrix.bo.BOAlmStakeholderEngine;
import com.asiainfo.csc.matrix.common.ConstDefine;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmStakeholderDao;
import com.asiainfo.csc.matrix.dao.interfaces.IAlmWorkorderDao;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkflowSV;

public class AlmStakeholderDaoImpl implements IAlmStakeholderDao {
	WorkFlowParam workflowParam = WorkFlowParam.getInstance();
	
	public IBOAlmStakeholderValue[] getStakeholderByCondition(String condition,
			Map paramter) throws Exception {
		// TODO Auto-generated method stub
		return BOAlmStakeholderEngine.getBeans(condition,paramter);
	}

	
	public void saveStakeholder(IBOAlmStakeholderValue[] schedules) throws Exception {
		// TODO Auto-generated method stub
		for(IBOAlmStakeholderValue schedule : schedules){
			if(schedule.isNew())
				schedule.setStdholderId(BOAlmStakeholderEngine.getNewId().longValue());
			BOAlmStakeholderEngine.save(schedule);
		}
	}

	

	public IBOAlmStakeholderValue[] getStakeholders(String cond, Map param) throws Exception
	{
		// TODO Auto-generated method stub
		try{
			return BOAlmStakeholderEngine.getBeans(cond, param);
		}catch(Exception e)
		{
			e.printStackTrace();
			throw new Exception("获取Stakeholder数据时出错，错误在IStakeholderDao层，getStakeholders函数");
		}
	}
	public IBOAlmStakeholderValue[] getStakeholders(Criteria sql)
	{
		// TODO Auto-generated method stub
		try
		{
			return BOAlmStakeholderEngine.getBeans(sql);
		} catch (Exception e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}

	
	public void saveStakeholder(IBOAlmStakeholderValue schedule)
			throws Exception {
		// TODO Auto-generated method stub
		if(schedule.isNew())
			schedule.setStdholderId(BOAlmStakeholderEngine.getNewId().longValue());
		BOAlmStakeholderEngine.save(schedule);
	}

	
	public IBOAlmStakeholderValue saveStakeholderByConds(String linkId, String linkNo,
			String staffId, String staffName, String stdType,String objId,String objType) throws Exception {
		// TODO Auto-generated method stub
		IBOAlmStakeholderValue newstd = new BOAlmStakeholderBean();
		newstd.setLinkId(Long.parseLong(linkId));
		newstd.setLinkNo(linkNo);
		newstd.setStdholderStaffId(Long.parseLong(staffId));
		newstd.setStdholderStaffName(staffName);
		newstd.setStdholdeType(stdType);
		List<IBOAlmStakeholderValue> list = new ArrayList<IBOAlmStakeholderValue>();
		list.add(newstd);
		List<IBOAlmStakeholderValue> listReturns = saveStakeholderReturn(list,Long.parseLong(objId),objType);
		return listReturns.get(0);
	}
	
	public IBOAlmStakeholderValue searchStakeholder(String linkNo, String stakeholderType, long objId,String StaffId)
	{
		Criteria sql = new Criteria();
		sql.addEqual("LINK_NO", linkNo);
		sql.addEqual("OBJ_ID", objId);
		sql.addEqual(IBOAlmStakeholderValue.S_StdholdeType, ConstDefine.STAKEHOLDERTYPE_WF);
		sql.addEqual(IBOAlmStakeholderValue.S_StdholderStaffId, StaffId);
		IBOAlmStakeholderValue[] iBOStakeholder = getStakeholders(sql);
		if(iBOStakeholder!=null&&iBOStakeholder.length>0)
		{
			return iBOStakeholder[0];
		}
		else {
			return null;
		}
	}
	public IBOAlmStakeholderValue[] searchStakeholder(String linkNo, String stakeholderType, long objId)throws Exception
	{
		Criteria sql = new Criteria();
		sql.addEqual("LINK_NO", linkNo);
		sql.addEqual("OBJ_ID", objId);
		sql.addEqual(IBOAlmStakeholderValue.S_StdholdeType, ConstDefine.STAKEHOLDERTYPE_WF);
		IBOAlmStakeholderValue[] iBOStakeholder = getStakeholders(sql);
		return iBOStakeholder;
	}
	
	public List saveStakeholderReturn(List<IBOAlmStakeholderValue> o, long objId,String objType) throws Exception {
		// TODO Auto-generated method stub
		List<IBOAlmStakeholderValue> returnList = new ArrayList<IBOAlmStakeholderValue>();
		boolean temp = true;
		for(IBOAlmStakeholderValue value:o)
		{
			if(!value.isNew())
			{
				BOAlmStakeholderEngine.save(value);
				continue;
			}
			if(temp)
			{
				IBOAlmStakeholderValue[] iBOStakeholder = searchStakeholder(value.getLinkNo(),value.getStdholdeType(),objId);
				if(iBOStakeholder!=null&&iBOStakeholder.length>0)
				{
					//查询已经有干系人，如果此环节不是会签则更新以前的干系人，如果是会签节点则删除所有干系人，重新插入
					if(!(value.getLinkNo().equals("requestFeasibilityAnalysis")))//如果此环节不是会签的话
					{
						value.setStdholderId(iBOStakeholder[0].getStdholderId());
						value.setStsToOld();
					}
					else //如果此环节是会签的话
					{
						for(IBOAlmStakeholderValue s:iBOStakeholder)
						{
							s.delete();
							BOAlmStakeholderEngine.save(s);
						}
						temp = false;
						value.setStdholderId(BOAlmStakeholderEngine.getNewId().longValue());
						value.setObjId(objId);
						value.setObjType(objType);
						value.setCreateTime(ServiceManager.getOpDateTime());
					}
				}
				else 
				{
					temp = false;
					value.setStdholderId(BOAlmStakeholderEngine.getNewId().longValue());
					value.setObjId(objId);
					value.setObjType(objType);
					value.setCreateTime(ServiceManager.getOpDateTime());
				}
			}
			else 
			{
				if(value.isNew())
				{
					value.setStdholderId(BOAlmStakeholderEngine.getNewId().longValue());
					value.setObjId(objId);
					value.setObjType(objType);
					value.setCreateTime(ServiceManager.getOpDateTime());
				}
			}
			BOAlmStakeholderEngine.save(value);
			returnList.add(value);
		}
		return returnList;
	}
	
	public void saveStakeholder(List<IBOAlmStakeholderValue> o,long objId,String objType) throws Exception {
		// TODO Auto-generated method stub
		boolean temp = true;
		IBOAlmStakeholderValue sid = null;
		for(IBOAlmStakeholderValue value:o)
		{
			if(!value.isNew())
			{	
				if(!(queryIsSignByLinkNo(value.getLinkNo())))//如果此环节不是会签的话
				{
						
					IBOAlmStakeholderValue[] iBOStakeholder = searchStakeholder(value.getLinkNo(),value.getStdholdeType(),objId);
					if(iBOStakeholder!=null&&iBOStakeholder.length>0)
					{
						iBOStakeholder[0].setObjId(objId);
						iBOStakeholder[0].setCreateTime(value.getCreateTime());
						iBOStakeholder[0].setLinkNo(value.getLinkNo());
						iBOStakeholder[0].setStdholderStaffName(value.getStdholderStaffName());
						if(value.getRoleId()!=0)
							iBOStakeholder[0].setRoleId(value.getRoleId());
						iBOStakeholder[0].setStdholderStaffId(value.getStdholderStaffId());
						iBOStakeholder[0].setStdholdeType(value.getStdholdeType());
						iBOStakeholder[0].setObjType(objType);
						iBOStakeholder[0].setLinkId(value.getLinkId());
						value = iBOStakeholder[0];
					}
				}
				BOAlmStakeholderEngine.save(value);
				continue;
			}
			if(temp)
			{
				IBOAlmStakeholderValue[] iBOStakeholder = searchStakeholder(value.getLinkNo(),value.getStdholdeType(),objId);
				if(iBOStakeholder!=null&&iBOStakeholder.length>0)
				{
					//查询已经有干系人，如果此环节不是会签则更新以前的干系人，如果是会签节点则删除所有干系人，重新插入
					if(!(queryIsSignByLinkNo(value.getLinkNo())))//如果此环节不是会签的话
					{
						iBOStakeholder[0].setObjId(objId);
						iBOStakeholder[0].setCreateTime(value.getCreateTime());
						iBOStakeholder[0].setLinkNo(value.getLinkNo());
						iBOStakeholder[0].setStdholderStaffName(value.getStdholderStaffName());
						if(value.getRoleId()!=0)
							iBOStakeholder[0].setRoleId(value.getRoleId());
						iBOStakeholder[0].setStdholderStaffId(value.getStdholderStaffId());
						iBOStakeholder[0].setStdholdeType(value.getStdholdeType());
						iBOStakeholder[0].setObjType(objType);
						iBOStakeholder[0].setLinkId(value.getLinkId());
						value = iBOStakeholder[0];
					}
					else //如果此环节是会签的话
					{
						for(IBOAlmStakeholderValue s:iBOStakeholder)
						{
							s.delete();
							BOAlmStakeholderEngine.save(s);
						}
						temp = false;
						value.setStdholderId(BOAlmStakeholderEngine.getNewId().longValue());
						value.setObjId(objId);
						value.setObjType(objType);
						value.setCreateTime(ServiceManager.getOpDateTime());
					}
				}
				else 
				{
					temp = false;
					value.setStdholderId(BOAlmStakeholderEngine.getNewId().longValue());
					value.setObjId(objId);
					value.setObjType(objType);
					value.setCreateTime(ServiceManager.getOpDateTime());
				}
			}
			else 
			{
				if(value.isNew())
				{
					if(!(queryIsSignByLinkNo(value.getLinkNo())))//如果此环节不是会签的话
					{
						IBOAlmStakeholderValue[] iBOStakeholderx = searchStakeholder(value.getLinkNo(),value.getStdholdeType(),objId);
						if(iBOStakeholderx!=null&&iBOStakeholderx.length>0)
						{
							iBOStakeholderx[0].setObjId(objId);
							iBOStakeholderx[0].setCreateTime(value.getCreateTime());
							iBOStakeholderx[0].setLinkNo(value.getLinkNo());
							iBOStakeholderx[0].setStdholderStaffName(value.getStdholderStaffName());
							if(value.getRoleId()!=0)
								iBOStakeholderx[0].setRoleId(value.getRoleId());
							iBOStakeholderx[0].setStdholderStaffId(value.getStdholderStaffId());
							iBOStakeholderx[0].setStdholdeType(value.getStdholdeType());
							iBOStakeholderx[0].setObjType(objType);
							iBOStakeholderx[0].setLinkId(value.getLinkId());
							value = iBOStakeholderx[0];
						}
						else {
							value.setStdholderId(BOAlmStakeholderEngine.getNewId().longValue());
							value.setObjId(objId);
							value.setObjType(objType);
							value.setCreateTime(ServiceManager.getOpDateTime());
						}
					}
					else {
						value.setStdholderId(BOAlmStakeholderEngine.getNewId().longValue());
						value.setObjId(objId);
						value.setObjType(objType);
						value.setCreateTime(ServiceManager.getOpDateTime());
					}	
				}
			}
			sid = searchStakeholder(value.getLinkNo(),value.getStdholdeType(),value.getObjId(),String.valueOf(value.getStdholderStaffId()));
			if(sid!=null)
			{
				value = sid;
			}
			BOAlmStakeholderEngine.save(value);
		}
	}
	
	public void saveStakeholder(IBOAlmStakeholderValue value,long objId,String objType) throws Exception {
		// TODO Auto-generated method stub
		boolean temp = true;
		IBOAlmStakeholderValue sid = null;
			if (!value.isNew()) {
			if (!(queryIsSignByLinkNo(value.getLinkNo())))// 如果此环节不是会签的话
			{
				IBOAlmStakeholderValue[] iBOStakeholder = searchStakeholder(value.getLinkNo(), value.getStdholdeType(), objId);
				if (iBOStakeholder != null && iBOStakeholder.length > 0) {
					iBOStakeholder[0].setObjId(objId);
					iBOStakeholder[0].setCreateTime(value.getCreateTime());
					iBOStakeholder[0].setLinkNo(value.getLinkNo());
					iBOStakeholder[0].setStdholderStaffName(value.getStdholderStaffName());
					if (value.getRoleId() != 0)iBOStakeholder[0].setRoleId(value.getRoleId());
					iBOStakeholder[0].setStdholderStaffId(value.getStdholderStaffId());
					iBOStakeholder[0].setStdholdeType(value.getStdholdeType());
					iBOStakeholder[0].setObjType(objType);
					iBOStakeholder[0].setLinkId(value.getLinkId());
					value = iBOStakeholder[0];
				}
			}
			BOAlmStakeholderEngine.save(value);
		}
		if (temp) {
			IBOAlmStakeholderValue[] iBOStakeholder = searchStakeholder(value.getLinkNo(), value.getStdholdeType(), objId);
			if (iBOStakeholder != null && iBOStakeholder.length > 0) {
				// 查询已经有干系人，如果此环节不是会签则更新以前的干系人，如果是会签节点则删除所有干系人，重新插入
				if (!(queryIsSignByLinkNo(value.getLinkNo())))// 如果此环节不是会签的话
				{
					iBOStakeholder[0].setObjId(objId);
					iBOStakeholder[0].setCreateTime(value.getCreateTime());
					iBOStakeholder[0].setLinkNo(value.getLinkNo());
					iBOStakeholder[0].setStdholderStaffName(value.getStdholderStaffName());
					if (value.getRoleId() != 0)iBOStakeholder[0].setRoleId(value.getRoleId());
					iBOStakeholder[0].setStdholderStaffId(value.getStdholderStaffId());
					iBOStakeholder[0].setStdholdeType(value.getStdholdeType());
					iBOStakeholder[0].setObjType(objType);
					iBOStakeholder[0].setLinkId(value.getLinkId());
					value = iBOStakeholder[0];
				} else // 如果此环节是会签的话
				{
					for (IBOAlmStakeholderValue s : iBOStakeholder) {
						s.delete();
						BOAlmStakeholderEngine.save(s);
					}
					temp = false;
					value.setStdholderId(BOAlmStakeholderEngine.getNewId()
							.longValue());
					value.setObjId(objId);
					value.setObjType(objType);
					value.setCreateTime(ServiceManager.getOpDateTime());
				}
			} else {
				temp = false;
				value.setStdholderId(BOAlmStakeholderEngine.getNewId().longValue());
				value.setObjId(objId);
				value.setObjType(objType);
				value.setCreateTime(ServiceManager.getOpDateTime());
			}
		} else {
			if (value.isNew()) {
				if (!(queryIsSignByLinkNo(value.getLinkNo())))// 如果此环节不是会签的话
				{
					IBOAlmStakeholderValue[] iBOStakeholderx = searchStakeholder(
							value.getLinkNo(), value.getStdholdeType(), objId);
					if (iBOStakeholderx != null && iBOStakeholderx.length > 0) {
						iBOStakeholderx[0].setObjId(objId);
						iBOStakeholderx[0].setCreateTime(value.getCreateTime());
						iBOStakeholderx[0].setLinkNo(value.getLinkNo());
						iBOStakeholderx[0].setStdholderStaffName(value
								.getStdholderStaffName());
						if (value.getRoleId() != 0)
							iBOStakeholderx[0].setRoleId(value.getRoleId());
						iBOStakeholderx[0].setStdholderStaffId(value
								.getStdholderStaffId());
						iBOStakeholderx[0].setStdholdeType(value
								.getStdholdeType());
						iBOStakeholderx[0].setObjType(objType);
						iBOStakeholderx[0].setLinkId(value.getLinkId());
						value = iBOStakeholderx[0];
					} else {
						value.setStdholderId(BOAlmStakeholderEngine.getNewId()
								.longValue());
						value.setObjId(objId);
						value.setObjType(objType);
						value.setCreateTime(ServiceManager.getOpDateTime());
					}
				} else {
					value.setStdholderId(BOAlmStakeholderEngine.getNewId()
							.longValue());
					value.setObjId(objId);
					value.setObjType(objType);
					value.setCreateTime(ServiceManager.getOpDateTime());
				}
			}
		}
		sid = searchStakeholder(value.getLinkNo(), value.getStdholdeType(),
				value.getObjId(), String.valueOf(value.getStdholderStaffId()));
		if (sid != null) {
			value = sid;
		}
		BOAlmStakeholderEngine.save(value);
	}
	
	public IBOAlmStakeholderValue[] getStakeholderBySql(String sql, Map paramter)
			throws Exception {
		// TODO Auto-generated method stub
		return BOAlmStakeholderEngine.getBeansFromSql(sql, paramter);
	}
	
	//获取是否是会签
	public boolean queryIsSignByLinkNo(String linkNo) throws Exception{
		IAlmWorkflowSV ws = (IAlmWorkflowSV) ServiceFactory
		.getService(IAlmWorkflowSV.class);
		String condition = " LINK_NO=:LINK_NO";
		HashMap parameter = new HashMap();
		parameter.put("LINK_NO", linkNo);

		IBOAlmWorkflowValue[] wv = ws.getAlmWorkflowByCondition(condition,
				parameter);
		if("sign".equals(wv[0].getLinkNoType())){
			return true;
		}else {
			return false;
		}
	}
}
