package com.asiainfo.aiga.funCaseRela.dao.impl;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.funCaseRela.bo.AigaFunCaseRela;
import com.asiainfo.aiga.funCaseRela.bo.AigaHisFunCaseRela;
import com.asiainfo.aiga.funCaseRela.dao.IAigaFunCaseRelaDAO;

public class AigaFunCaseRelaDAOImpl extends HibernateDaoSupport implements IAigaFunCaseRelaDAO {

	@Override
	public void delete(AigaFunCaseRela aigaFunCaseRela) throws Exception {
		this.getHibernateTemplate().delete(aigaFunCaseRela);
	}

	@Override
	public void deleteAll(AigaFunCaseRela[] aigaFunCaseRelas) throws Exception {
		this.getHibernateTemplate().deleteAll(Arrays.asList(aigaFunCaseRelas));
	}

	@Override
	public AigaFunCaseRela[] getAigaCaseRelaByCriteria(
			DetachedCriteria criteria) throws Exception {
		List<AigaFunCaseRela> aigaFunCaseRelas=this.getHibernateTemplate().findByCriteria(criteria);
		return aigaFunCaseRelas.toArray(new AigaFunCaseRela[0]);
	}

	@Override
	public AigaFunCaseRela[] getAigaCaseRelaBySql(String querySql)
			throws Exception {
		List<AigaFunCaseRela> aigaFunCaseRelas=this.getHibernateTemplate().find(querySql);
		return aigaFunCaseRelas.toArray(new AigaFunCaseRela[0]);
	}

	@Override
	public void saveOrUpdate(AigaFunCaseRela aigaFunCaseRela) throws Exception {
		this.getHibernateTemplate().saveOrUpdate(aigaFunCaseRela);
	}

	@Override
	public void saveOrUpdateAll(AigaFunCaseRela[] aigaFunCaseRelas)
			throws Exception {
		this.getHibernateTemplate().saveOrUpdateAll(Arrays.asList(aigaFunCaseRelas));
	}

	@Override
	public void saveOrUpdate(AigaHisFunCaseRela aigaHisFunCaseRela)
			throws Exception {
		this.getHibernateTemplate().save(aigaHisFunCaseRela);
	}

	@Override
	public void saveOrUpdateAll(AigaHisFunCaseRela[] aigaHisFunCaseRelas)
			throws Exception {
		this.getHibernateTemplate().saveOrUpdateAll(Arrays.asList(aigaHisFunCaseRelas));
	}

	@Override
	public List getObjectBySQL(String SQL) throws Exception {
		final String querySql = SQL;
		List list = this.getHibernateTemplate().executeFind(new HibernateCallback() {  
		    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
		         SQLQuery query = session.createSQLQuery(querySql);    
		         return query.list();  
		            }  
		        });  
		return list;
	}

	@Override
	public AigaHisFunCaseRela[] getAigaHisCaseRelaBySql(String querySql)
			throws Exception {
		List<AigaHisFunCaseRela> aigaHisFunCaseRelas=this.getHibernateTemplate().find(querySql);
		return aigaHisFunCaseRelas.toArray(new AigaHisFunCaseRela[0]);
	}

}
