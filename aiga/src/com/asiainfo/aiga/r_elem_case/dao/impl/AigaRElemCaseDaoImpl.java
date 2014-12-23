package com.asiainfo.aiga.r_elem_case.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.r_elem_case.bo.AigaRElemCase;
import com.asiainfo.aiga.r_elem_case.dao.IAigaRElemCaseDAO;
import com.asiainfo.aiga.userCase.bo.AigaCase;

public class AigaRElemCaseDaoImpl extends HibernateDaoSupport implements IAigaRElemCaseDAO{

	public AigaRElemCase[] getRElemCaseBySql(String querySql)
			throws Exception {
		List<AigaRElemCase> rCaseCompList = this.getHibernateTemplate().find(querySql);
		return rCaseCompList.toArray(new AigaRElemCase[0]);
	}

	public AigaRElemCase[] getRElemCaseByCriteria(
			DetachedCriteria criteria) throws Exception {
		List<AigaRElemCase> aigaCases = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaCases.toArray(new AigaRElemCase[0]);
	}

	public AigaRElemCase[] getUpdateByCriteria(DetachedCriteria criteria)
			throws Exception {
		
		return null;
	}

	public void saveOrUpdate(AigaRElemCase aValue) throws Exception {
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

	public void delete(AigaRElemCase aValue) throws Exception {
		this.getHibernateTemplate().delete(aValue);
	}

}
