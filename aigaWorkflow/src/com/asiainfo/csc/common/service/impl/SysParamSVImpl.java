package com.asiainfo.csc.common.service.impl;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.ai.appframe2.common.SessionManager;
import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.common.bo.BOSysParamEngine;
import com.asiainfo.csc.common.dao.interfaces.ISysParamDao;
import com.asiainfo.csc.common.ivalues.IBOOrganizeValue;
import com.asiainfo.csc.common.ivalues.IBOSysParamValue;
import com.asiainfo.csc.common.service.interfaces.IStaffRoleOrgDistSV;
import com.asiainfo.csc.common.service.interfaces.ISysParamSV;



public class SysParamSVImpl implements ISysParamSV {
	ISysParamDao iSysParamDao=(ISysParamDao) ServiceFactory.getService(com.asiainfo.csc.common.dao.interfaces.ISysParamDao.class);
	/***
	 * 保存系统参数信息(需求及需求点编号生成)
	 * @param para
	 * @throws Exception
	 * @throws RemoteException
	 */
	public void saveSystemParam(IBOSysParamValue para) throws Exception, RemoteException{
		iSysParamDao.saveSystemParam(para);
	}
	
	public IBOSysParamValue[] initSysPars(String id) throws Exception,
			RemoteException {

		Criteria criteria = new Criteria();
		IBOSysParamValue[] temp = null;
		if (StringUtils.isNotBlank(id)) {
			criteria.addEqual(IBOSysParamValue.S_ParamRelaId, id);
			temp = iSysParamDao.queryPars(
					criteria.toString(), criteria.getParameters());
			return temp;
		} else {

			return new IBOSysParamValue[] {};

		}

	}
	public IBOSysParamValue[] getSubCacheParam(String no) throws Exception {
		Criteria criteria = new Criteria();
		IBOSysParamValue[] temp = null;
		if (StringUtils.isNotBlank(no)) {
			criteria.addEqual(IBOSysParamValue.S_ParamRelaId, no);
			criteria.addEqual(IBOSysParamValue.S_ParamType, "SUBSYS_TAG");
			temp = iSysParamDao.queryPars(criteria.toString(), criteria.getParameters());
			return temp;
		} else {
			return new IBOSysParamValue[] {};
		}
	}

	public IBOSysParamValue[] getSysPars(String type) throws Exception,
			RemoteException {
		Criteria criteria = new Criteria();
		IBOSysParamValue[] value = null;
		if (StringUtils.isNotBlank(type)) {
			criteria.addEqual(IBOSysParamValue.S_ParamType, type);
		}
			value = iSysParamDao.queryPars(
					criteria.toString()+" order by "+IBOSysParamValue.S_ParamNo, criteria.getParameters());
			return value;
	
	}
	public IBOSysParamValue[] getReqTypeByLevel(Long level) throws Exception,RemoteException {
		String condition  = "PARAM_TYPE='REQ_TYPE' and PARAM_VALUE <= :val";
		HashMap<String,Long> params = new HashMap<String,Long>();
		params.put("val", level);
		IBOSysParamValue[] value = null;
		value =iSysParamDao.queryPars(condition, params);
		return value;
	}
	
   public IBOSysParamValue[] getSysParam(String type,String no) throws Exception,
		RemoteException {
		Criteria criteria = new Criteria();
		IBOSysParamValue[] value = null;
		if (StringUtils.isNotBlank(type)) {
			criteria.addEqual(IBOSysParamValue.S_ParamType, type);
		}
		if (StringUtils.isNotBlank(no)) {
			criteria.addEqual(IBOSysParamValue.S_ParamNo, no);
		}
		value = iSysParamDao.queryPars(
					criteria.toString()+" order by " + IBOSysParamValue.S_ParamNo, criteria.getParameters());
		return value;

    }
   
   public IBOSysParamValue[] getSysParam(String type,String[] values) throws Exception,
	RemoteException {
	List<String> valueList = new ArrayList<String>();
	if(values!=null){
		for(String value : values){
			valueList.add(value);
		}
	}else{
		valueList.add("");
	}
	Criteria criteria = new Criteria();
	IBOSysParamValue[] value = null;
	if (StringUtils.isNotBlank(type)) {
		criteria.addEqual(IBOSysParamValue.S_ParamType, type);
	}
	criteria.addIn(IBOSysParamValue.S_ParamName, valueList);
	value = iSysParamDao.queryPars(
				criteria.toString()+" order by " + IBOSysParamValue.S_ParamNo, criteria.getParameters());
	return value;

   }

	public HashMap getAttachTypePars() throws Exception, RemoteException {
		// TODO Auto-generated method stub
		IBOSysParamValue[] values = getSysPars("ATTACH_TYPE");
		HashMap map = new HashMap();
		
		for(int i = 0; i < values.length; i++){
			map.put(values[i].getParamNo(), values[i].getParamName());
		}
		
		return map;
	}

	public IBOSysParamValue[] getAllSysParam() throws Exception {
		Criteria criteria = new Criteria();
		IBOSysParamValue[] temp = null;
		temp = iSysParamDao.queryPars(criteria.toString(), criteria.getParameters());
		return temp;
	}


	public HashMap getSysParamToMap(String type) throws Exception {
		IBOSysParamValue[] values = getSysPars(type);
		HashMap map = new HashMap();
		
		for(int i = 0; i < values.length; i++){
			map.put(values[i].getParamNo(), values[i]);
		}
		
		return map;
	}


	public IBOSysParamValue[] getSysParamByRelaId(String type, String realId)
			throws Exception {
		Criteria criteria = new Criteria();
		if(StringUtils.isNotBlank(type))
			criteria.addEqual(IBOSysParamValue.S_ParamType, type);
		if(StringUtils.isNotBlank(realId))
			criteria.addEqual(IBOSysParamValue.S_ParamRelaId, realId);
		return iSysParamDao.queryPars(criteria.toString(), criteria.getParameters());
	}

	public IBOSysParamValue[] getSysParamForDS(String value, String text, String tables, String condition) throws Exception {
		String sql = "select " + value + " param_no, " + text + " param_name from " + tables + "where " + condition; 
		return iSysParamDao.getSysParamBySql(sql, null);
	}

	public IBOSysParamValue[] getSysParamByCon(String condition, Map params) throws Exception {
		return iSysParamDao.getSysParamByCon(condition, params);
	}
	
	public void saveSysParam(IBOSysParamValue saveVal) throws Exception {
		if(saveVal.getParamId() == 0) {
			saveVal.setStsToNew();
			long newId = BOSysParamEngine.getNewId().longValue();
			saveVal.setParamId(newId);
		}
		iSysParamDao.saveSystemParam(saveVal);
	}
	
	public void delSysParam(IBOSysParamValue delVal) throws Exception {
		delVal.delete();
		iSysParamDao.saveSystemParam(delVal);
	}
	
	public List<IBOSysParamValue> getBusiType() throws Exception {
		String orgId = SessionManager.getUser().getOrgId() + "";
		List<IBOSysParamValue> resultList=new ArrayList<IBOSysParamValue>();
		List<String> idList=new ArrayList<String>();
		idList.add(orgId);
		IStaffRoleOrgDistSV iStaffRoleOrgDistSV=(IStaffRoleOrgDistSV)ServiceFactory.getService(IStaffRoleOrgDistSV.class);
		Criteria sql=new Criteria();
		sql.addEqual(IBOOrganizeValue.S_OrganizeId,orgId);
		IBOOrganizeValue[] orgValue=iStaffRoleOrgDistSV.queryOrganizeVlaueByCondition(sql.toString(), sql.getParameters());
		while(orgValue!=null&&orgValue.length>0&&orgValue[0].getParentOrganizeId()!=2){
			idList.add(String.valueOf(orgValue[0].getParentOrganizeId()));
			sql.clear();
			sql.addEqual(IBOOrganizeValue.S_OrganizeId,orgValue[0].getParentOrganizeId());
			orgValue=iStaffRoleOrgDistSV.queryOrganizeVlaueByCondition(sql.toString(), sql.getParameters());
		}
		idList.add("2");
		ISysParamSV sysParamSV= (ISysParamSV)ServiceFactory.getService(ISysParamSV.class);
		IBOSysParamValue[] paramValues= sysParamSV.getSysPars("BUSI_TYPE");
		for(IBOSysParamValue value:paramValues){
			List<String> list2=new ArrayList<String>();
			if(value.getParamDisc()!=null&&(!"".equals(value.getParamDisc()))){
				Collections.addAll(list2,value.getParamDisc().split(";"));
				list2.retainAll(idList);
				if(list2.size()>0){
					resultList.add(value); 
				}
			}
		}
		return resultList;
	}
}
