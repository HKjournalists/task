package com.asiainfo.aiga.gui.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.gui.bo.AigaGui;
import com.asiainfo.aiga.gui.dao.IAigaGuiDAO;

public class AigaGuiDAOImpl extends HibernateDaoSupport implements IAigaGuiDAO {

	public void delete(AigaGui value) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(value);
	}

	public AigaGui[] getUpdateByCriteria(DetachedCriteria criteria) throws Exception {
		// TODO Auto-generated method stub
		List<AigaGui> aigaGuis = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaGuis.toArray(new AigaGui[0]);
	}

	public AigaGui[] getUpdateBySQL(String sql) throws Exception {
		// TODO Auto-generated method stub
		List<AigaGui> aigaGuis = this.getHibernateTemplate().find(sql);
		return aigaGuis.toArray(new AigaGui[0]);
	}

	public void saveOrUpdate(AigaGui value) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(value);
	}

	public AigaGui[] getAigaGuisByCriteria(DetachedCriteria criteria)
			throws Exception {
		List<AigaGui> aigaGuis = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaGuis.toArray(new AigaGui[0]);
	}

	@Override
	public List getAigaGuisByHql(String hql) throws Exception {
		// TODO Auto-generated method stub
		return this.getHibernateTemplate().find(hql);
	}

}
