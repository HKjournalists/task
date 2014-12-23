package com.asiainfo.csc.common.dao.interfaces;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Map;

import com.asiainfo.csc.common.ivalues.IBOSysParamValue;



public interface ISysParamDao {
	
	public IBOSysParamValue[] queryPars(String condition, HashMap para) throws Exception, RemoteException;
	
	/***
	 * ����ϵͳ������Ϣ(���������������)
	 * @param para
	 * @throws Exception
	 * @throws RemoteException
	 */
	public void saveSystemParam(IBOSysParamValue para) throws Exception, RemoteException;
	
	public IBOSysParamValue[] getSysParamBySql(String sql, Map params) throws Exception;
	
	public IBOSysParamValue[] getSysParamByCon(String condition, Map params) throws Exception;
}
