package com.asiainfo.csc.common.service.interfaces;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.asiainfo.csc.common.ivalues.IBOSysParamValue;


public interface ISysParamSV {
	//初始化关联系统参数
	public IBOSysParamValue[] initSysPars(String id) throws Exception, RemoteException;
	
	//初始化系统参数
	public IBOSysParamValue[] getSysPars(String type) throws Exception, RemoteException;
	public IBOSysParamValue[] getReqTypeByLevel(Long level) throws Exception,
	RemoteException;
	//根据类型和编号初始化关联系统参数
	public IBOSysParamValue[] getSysParam(String type,String no) throws Exception,RemoteException;
	
	public HashMap getAttachTypePars() throws Exception, RemoteException;

	/***
	 * 特殊方法获取子系统
	 * @param no 副系统no
	 * @return
	 * @throws Exception
	 */
	public IBOSysParamValue[] getSubCacheParam(String no) throws Exception ;
	
	/***
	 * 保存系统参数信息(需求及需求点编号生成)
	 * @param para
	 * @throws Exception
	 * @throws RemoteException
	 */
	public void saveSystemParam(IBOSysParamValue para) throws Exception, RemoteException;
	
	/***
	 * 获取所系统参数
	 * @return
	 * @throws Exception
	 */
	public IBOSysParamValue[] getAllSysParam() throws Exception ;
	
	public IBOSysParamValue[] getSysParam(String type,String[] values) throws Exception,
	RemoteException;
	
	public HashMap getSysParamToMap(String type) throws Exception;
	
	public IBOSysParamValue[] getSysParamByRelaId(String type,String realId) throws Exception ;
	
	public IBOSysParamValue[] getSysParamForDS(String value, String text, String tables, String condition) throws Exception;
	
	public IBOSysParamValue[] getSysParamByCon(String condition, Map params) throws Exception;
	
	public void delSysParam(IBOSysParamValue delVal) throws Exception;
	
	public void saveSysParam(IBOSysParamValue saveVal) throws Exception;
	
	public List<IBOSysParamValue> getBusiType() throws Exception;
}
