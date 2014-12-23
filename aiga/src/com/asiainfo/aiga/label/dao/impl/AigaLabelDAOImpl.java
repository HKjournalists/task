package com.asiainfo.aiga.label.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.label.bo.AigaLabel;
import com.asiainfo.aiga.label.dao.IAigaLabelDAO;

public class AigaLabelDAOImpl extends HibernateDaoSupport implements IAigaLabelDAO {

	public void delete(AigaLabel value) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(value);
	}

	public AigaLabel[] getAigaLabelByCriteria(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().setCacheQueries(true);
		List<AigaLabel> aigaLabels = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaLabels.toArray(new AigaLabel[0]);
	}

	public AigaLabel[] getAigaLabelBySql(String querySql) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().setCacheQueries(true);
		List<AigaLabel> aigaLabels = this.getHibernateTemplate().find(querySql);
		return aigaLabels.toArray(new AigaLabel[0]);
	}

	public void saveOrUpdate(AigaLabel value) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(value);
	}
	
	public AigaLabel[] getAigaLabelLeafBySql(String querySql) throws Exception {
		this.getHibernateTemplate().setCacheQueries(true);
		
		final String sql = querySql;
		List<AigaLabel> viewRecordList = this.getHibernateTemplate().executeFind(new HibernateCallback() {  
		    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
		        	return session.createSQLQuery(sql).addEntity("AigaLabel",AigaLabel.class).list();    
		            }  
		        });  
		List<AigaLabel> aigaLabels = viewRecordList;
		return aigaLabels.toArray(new AigaLabel[0]);
	}

}
