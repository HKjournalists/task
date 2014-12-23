package com.asiainfo.aiga.common.service.impl;

import java.util.List;

import com.asiainfo.aiga.common.dao.ICommonPageinationDAO;
import com.asiainfo.aiga.common.service.ICommonPageinationSV;
/**
 * ��Ҫ�޸�Ŀ������ָ������ʱ, �����Լ���Action�����в���!
 * @author peng
 *
 */
public class CommonPageinationSVImpl implements ICommonPageinationSV {

	private ICommonPageinationDAO commonPageinationDAO;
	
	public ICommonPageinationDAO getCommonPageinationDAO() {
		return commonPageinationDAO;
	}

	public void setCommonPageinationDAO(ICommonPageinationDAO commonPageinationDAO) {
		this.commonPageinationDAO = commonPageinationDAO;
	}

	@Override
	public List getObjectList(int pageNo, int pageSize, String HQL)
			throws Exception {
		// TODO Auto-generated method stub
		return commonPageinationDAO.getObjectList(pageNo, pageSize, HQL);
	}

	@Override
	public int getTotal(String HQL) throws Exception {
		
		return commonPageinationDAO.getTotal(HQL);
	}
}
