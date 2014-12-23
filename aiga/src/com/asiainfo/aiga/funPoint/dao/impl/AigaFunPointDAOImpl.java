package com.asiainfo.aiga.funPoint.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.funPoint.bo.AigaFunPoint;
import com.asiainfo.aiga.funPoint.bo.AigaKnowledge;
import com.asiainfo.aiga.funPoint.dao.IAigaFunPointDAO;

public class AigaFunPointDAOImpl extends HibernateDaoSupport implements IAigaFunPointDAO {

	public void delete(Object value) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(value);
	}

	public AigaFunPoint[] getFunPointByCriteria(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaFunPoint> aigaFunPoints = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaFunPoints.toArray(new AigaFunPoint[0]);
	}

	public AigaFunPoint[] getFunPointBySql(String querySql) throws Exception {
		// TODO Auto-generated method stub
		List<AigaFunPoint> aigaFunPoints = this.getHibernateTemplate().find(querySql);
		return aigaFunPoints.toArray(new AigaFunPoint[0]);
	}
	
	public void saveOrUpdate(Object value) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(value);
	}
	
	public void saveOrUpdateList(List list) throws Exception {
		this.getHibernateTemplate().saveOrUpdateAll(list);
	}
	
	public AigaKnowledge[] getKnowledgeBySql(String querySql) throws Exception {
		// TODO Auto-generated method stub
		List<AigaKnowledge> knowledges = this.getHibernateTemplate().find(querySql);
		return knowledges.toArray(new AigaKnowledge[0]);
	}

}
