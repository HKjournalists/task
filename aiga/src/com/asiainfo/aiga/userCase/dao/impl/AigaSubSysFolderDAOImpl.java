package com.asiainfo.aiga.userCase.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.userCase.bo.AigaSubSysFolder;
import com.asiainfo.aiga.userCase.dao.IAigaSubSysFolderDAO;

public class AigaSubSysFolderDAOImpl extends HibernateDaoSupport implements IAigaSubSysFolderDAO{

	@Override
	public AigaSubSysFolder[] getSubSysFolder(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaSubSysFolder> aigaSubSysFolders = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaSubSysFolders.toArray(new AigaSubSysFolder[0]);
	}
	
	public AigaSubSysFolder[] getSubSysFolder(String querySql) throws Exception {
		List<AigaSubSysFolder> aigaSubSysFolders = this.getHibernateTemplate().find(querySql);
		return aigaSubSysFolders.toArray(new AigaSubSysFolder[0]);
	}

	@Override
	public void saveSubSysFolder(AigaSubSysFolder aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

	@Override
	public void deleteSubSysFolder(AigaSubSysFolder aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(aValue);
	}

}
