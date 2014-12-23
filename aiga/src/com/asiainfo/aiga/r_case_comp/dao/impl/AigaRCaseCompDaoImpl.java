package com.asiainfo.aiga.r_case_comp.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.r_case_comp.bo.AigaRCaseComp;
import com.asiainfo.aiga.r_case_comp.dao.IAigaRCaseCompDAO;

/**
 * Created on 2014-6-25
 * <p>
 * Description: [��������Ҫ���ܽ���]
 * </p>
 */
public class AigaRCaseCompDaoImpl extends HibernateDaoSupport implements
		IAigaRCaseCompDAO {

	public AigaRCaseComp[] getAigaRCaseCompBySql(String querySql)
			throws Exception {
		List<AigaRCaseComp> rCaseCompList = this.getHibernateTemplate().find(
				querySql);
		return rCaseCompList.toArray(new AigaRCaseComp[0]);
	}

	public AigaRCaseComp[] getAigaRCaseCompByCriteria(DetachedCriteria criteria)
			throws Exception {
		List<AigaRCaseComp> aigaRCaseComp = this.getHibernateTemplate()
				.findByCriteria(criteria);
		return aigaRCaseComp.toArray(new AigaRCaseComp[0]);
	}

	public AigaRCaseComp[] getUpdateByCriteria(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	public void saveOrUpdate(AigaRCaseComp aValue) throws Exception {
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

	public void delete(AigaRCaseComp aValue) throws Exception {
		this.getHibernateTemplate().delete(aValue);
	}

	@Override
	public List getAigaRCaseByHql(String hql) throws Exception {
		// TODO Auto-generated method stub
		return this.getHibernateTemplate().find(hql);
	}

}
