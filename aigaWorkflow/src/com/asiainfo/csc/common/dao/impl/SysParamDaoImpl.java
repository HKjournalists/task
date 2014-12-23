package com.asiainfo.csc.common.dao.impl;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.asiainfo.csc.common.bo.BOSysParamEngine;
import com.asiainfo.csc.common.dao.interfaces.ISysParamDao;
import com.asiainfo.csc.common.ivalues.IBOSysParamValue;

public class SysParamDaoImpl implements ISysParamDao {
	//��־
	private final static transient Log log = LogFactory.getLog(SysParamDaoImpl.class);
	
	public IBOSysParamValue[] queryPars(String condition, HashMap para) throws Exception{
		if(log.isDebugEnabled()){
			  StringBuffer sb = new StringBuffer();
			  sb.append("��ѯϵͳ�����ؼ�����:��");
			  sb.append("sql:").append(condition);
			  sb.append("��param:��").append(para).append("��");
			  log.debug(sb);
		 }
		try {
			return BOSysParamEngine.getBeans(condition, para);
		} catch (Exception e) {
			StringBuffer sb = new StringBuffer();
			sb.append("��ѯϵͳ����ʧ��,�ؼ�����:��");
			sb.append("sql:").append(condition);
			 sb.append("��param:��").append(para).append("��");
			log.error(sb);
			e.printStackTrace();
			throw new Exception("��ѯϵͳ����ʧ�ܣ�\n\n����ԭ��:"+ (e.getCause() == null ? e.getMessage() : e.getCause().getMessage()));
		}
	}

	public void saveSystemParam(IBOSysParamValue para) throws Exception, RemoteException {
		BOSysParamEngine.save(para);
	}
	
	public IBOSysParamValue[] getSysParamBySql(String sql, Map params) throws Exception {
		return BOSysParamEngine.getBeansFromSql(sql, params);
	}
	
	public IBOSysParamValue[] getSysParamByCon(String condition, Map params) throws Exception {
		return BOSysParamEngine.getBeans(condition, params);
	}
	
}
