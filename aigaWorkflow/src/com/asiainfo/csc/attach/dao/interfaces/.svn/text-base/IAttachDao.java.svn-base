package com.asiainfo.csc.attach.dao.interfaces;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Map;

import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.attach.bo.BODocTempTreeBean;
import com.asiainfo.csc.attach.bo.BODocTemplateBean;
import com.asiainfo.csc.attach.ivalues.IBOAttachTypeValue;
import com.asiainfo.csc.attach.ivalues.IBOAttachValue;
import com.asiainfo.csc.attach.ivalues.IBODocTemplateValue;
import com.asiainfo.csc.attach.ivalues.IBOPackageValue;
import com.asiainfo.csc.attach.ivalues.IBOQueryAttPackValue;


public interface IAttachDao {

	public IBOAttachValue newAttach(IBOAttachValue valueAttach) throws Exception, RemoteException;
	
	public IBOPackageValue[] getAttPackage(String condition, Map params) throws Exception;
	
	public void saveAttach(IBOAttachValue valueAttach) throws Exception;

	public long getAttachNewId() throws Exception, RemoteException;
	
	public IBOAttachValue[] queryAllAttach() throws Exception;
	
	public int queryAttachCount(Criteria sql) throws Exception;
	
	public IBOAttachValue[] queryAttach(Criteria sql) throws Exception;
	
	public IBOAttachValue[] queryAttach(Criteria sql, int startIndex, int endIndex) throws Exception;
	
	public void saveNewPackage(IBOPackageValue[] valuesPackage) throws Exception;
	//dxp-保存 文档模板表 信息 
	public void saveDocTemp(BODocTemplateBean[] valueDocTemps) throws Exception;
	//dxp-保存 模板树 信息 
	public void saveDocTempTree(BODocTempTreeBean[] valueDocTempTrees) throws Exception;
	
	public IBOQueryAttPackValue[] queryQueryAttPack(String condition) throws Exception;
	
	public void delPackage(IBOPackageValue[] valuePackages) throws Exception;
	
	//dxp-文档模板 树的 查找
	public BODocTempTreeBean[] queryDocTempTree(Criteria sql) throws Exception;
	//dxp-文档模板  查找 根据
	public IBODocTemplateValue[] queryDocTemp(Criteria sql) throws Exception;

	IBOAttachValue[] queryBOAttach(String condition) throws Exception;
	
	public IBOAttachTypeValue[] getAttachType()throws Exception;

	public IBOQueryAttPackValue[] queryQueryAttPack(String condition,HashMap map)throws Exception;
	
	//dxp-根据角色Id 获得相应的 staff信息
//	public IBOStaffRoleAuthorValue[] queryStaffRoleAuthorByRoles(String condition, Map param) throws Exception;
}
