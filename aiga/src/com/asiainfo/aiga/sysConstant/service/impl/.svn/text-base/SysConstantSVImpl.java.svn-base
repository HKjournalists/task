package com.asiainfo.aiga.sysConstant.service.impl;

import com.asiainfo.aiga.sysConstant.bo.SysConstant;
import com.asiainfo.aiga.sysConstant.dao.ISysConstantDAO;
import com.asiainfo.aiga.sysConstant.service.ISysConstantSV;

public class SysConstantSVImpl implements ISysConstantSV {
	
	private ISysConstantDAO sysContantDao;
	
	
	
	public ISysConstantDAO getSysContantDao() {
		return sysContantDao;
	}



	public void setSysContantDao(ISysConstantDAO sysContantDao) {
		this.sysContantDao = sysContantDao;
	}



	public SysConstant[] getSysConstantBySql(String querySql) throws Exception {
		return sysContantDao.getSysConstantBySql(querySql);
	}

}
