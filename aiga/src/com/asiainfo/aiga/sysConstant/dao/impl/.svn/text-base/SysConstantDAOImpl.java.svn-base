package com.asiainfo.aiga.sysConstant.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.sysConstant.bo.SysConstant;
import com.asiainfo.aiga.sysConstant.dao.ISysConstantDAO;

public class SysConstantDAOImpl extends HibernateDaoSupport implements ISysConstantDAO {
	
	public SysConstant[] getSysConstantBySql(String querySql) throws Exception {
		List<SysConstant> constants = this.getHibernateTemplate().find(querySql);
		return constants.toArray(new SysConstant[0]);
	}

	public List getCategoryByCriteria(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		return this.getHibernateTemplate().findByCriteria(criteria);
	}

	public SysConstant[] getSysConstantByCriteria(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<SysConstant> constants = this.getHibernateTemplate().findByCriteria(criteria);
		return constants.toArray(new SysConstant[0]);
	}

}
