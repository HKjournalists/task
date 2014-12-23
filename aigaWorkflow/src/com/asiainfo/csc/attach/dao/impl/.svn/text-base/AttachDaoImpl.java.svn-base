package com.asiainfo.csc.attach.dao.impl;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Map;

import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.attach.bo.BOAttachEngine;
import com.asiainfo.csc.attach.bo.BOAttachTypeEngine;
import com.asiainfo.csc.attach.bo.BODocTempTreeBean;
import com.asiainfo.csc.attach.bo.BODocTempTreeEngine;
import com.asiainfo.csc.attach.bo.BODocTemplateBean;
import com.asiainfo.csc.attach.bo.BODocTemplateEngine;
import com.asiainfo.csc.attach.bo.BOPackageEngine;
import com.asiainfo.csc.attach.bo.BOQueryAttPackEngine;
import com.asiainfo.csc.attach.dao.interfaces.IAttachDao;
import com.asiainfo.csc.attach.ivalues.IBOAttachTypeValue;
import com.asiainfo.csc.attach.ivalues.IBOAttachValue;
import com.asiainfo.csc.attach.ivalues.IBODocTemplateValue;
import com.asiainfo.csc.attach.ivalues.IBOPackageValue;
import com.asiainfo.csc.attach.ivalues.IBOQueryAttPackValue;

public class AttachDaoImpl implements IAttachDao {

	public IBOAttachValue newAttach(IBOAttachValue valueAttach) throws Exception,
			RemoteException {
		valueAttach.setAttId(BOAttachEngine.getNewId().longValue());
		BOAttachEngine.save(valueAttach);
		return valueAttach;
	}
	
	public IBOPackageValue[] getAttPackage(String condition, Map params) throws Exception {
		return BOPackageEngine.getBeans(condition, params);
	}

	public void saveAttach(IBOAttachValue valueAttach) throws Exception {
		try {
			BOAttachEngine.save(valueAttach);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public long getAttachNewId() throws Exception, RemoteException {
		return BOAttachEngine.getNewId().longValue();
	}

	public IBOAttachValue[] queryAllAttach() throws Exception {
		return BOAttachEngine.getBeans(null, null);
	}

	public IBOAttachValue[] queryAttach(Criteria sql) throws Exception {
		return BOAttachEngine.getBeans(sql);
	}

	public IBOAttachValue[] queryAttach(Criteria sql, int startIndex,
			int endIndex) throws Exception {
		return BOAttachEngine.getBeans(null, sql.toString(), sql
				.getParameters(), startIndex, endIndex, false);
	}

	public BODocTempTreeBean[] queryDocTempTree(Criteria sql) throws Exception {
		return BODocTempTreeEngine.getBeans(sql);
	}

	// dxp-文档模板 查找 根据
	public IBODocTemplateValue[] queryDocTemp(Criteria sql) throws Exception {
		return BODocTemplateEngine.getBeans(sql);
	}

	// public IBOStaffRoleAuthorValue[] queryStaffRoleAuthorByRoles(String
	// condition, Map param) throws Exception{
	// return BOStaffRoleAuthorEngine.getBeans(condition, param);
	// }

	public void saveNewPackage(IBOPackageValue[] valuesPackage)
			throws Exception {
		for (int i = 0; i < valuesPackage.length; i++) {
			valuesPackage[i].setAttPackId(BOPackageEngine.getNewId()
					.longValue());
			BOPackageEngine.save(valuesPackage[i]);
		}
	}

	public void saveDocTemp(BODocTemplateBean[] valueDocTemps) throws Exception {
		for (int i = 0; i < valueDocTemps.length; i++) {
			if (valueDocTemps[i].getDocTempId() == 0) {
				valueDocTemps[i].setDocTempId(BODocTemplateEngine.getNewId()
						.longValue());
			}
			BODocTemplateEngine.save(valueDocTemps[i]);
		}
	}

	public void saveDocTempTree(BODocTempTreeBean[] valueDocTempTrees)
			throws Exception {
		for (int i = 0; i < valueDocTempTrees.length; i++) {
			BODocTempTreeEngine.save(valueDocTempTrees[i]);
		}
	}

	public IBOQueryAttPackValue[] queryQueryAttPack(String condition)
			throws Exception {

		return BOQueryAttPackEngine.getBeans(condition, null);
	}
	
	public IBOAttachValue[] queryBOAttach(String condition) throws Exception {

		return BOAttachEngine.getBeans(condition, null);
	}

	public void delPackage(IBOPackageValue[] valuePackages) throws Exception {
		long[] pack_id = new long[valuePackages.length];
		for (int i = 0; i < valuePackages.length; i++) {
			pack_id[i] = valuePackages[i].getAttPackId();
		}
		Criteria sql = new Criteria();
		sql.addIn(IBOPackageValue.S_AttPackId, pack_id);
		IBOPackageValue[] valuesToDel = BOPackageEngine.getBeans(sql);
		for (int i = 0; i < valuesToDel.length; i++) {
			valuesToDel[i].delete();
			// valuePackages[i].isDeleted();
			BOPackageEngine.save(valuesToDel[i]);
		}
	}

	public int queryAttachCount(Criteria sql) throws Exception {
		return BOAttachEngine
				.getBeansCount(sql.toString(), sql.getParameters());
	}
	
	public IBOAttachTypeValue[] getAttachType()throws Exception
	{
		return  BOAttachTypeEngine.getBeans(null, null);
	}

	
	public IBOQueryAttPackValue[] queryQueryAttPack(String condition,
			HashMap map) throws Exception {
		return BOQueryAttPackEngine.getBeans(condition, map);
	}

}
