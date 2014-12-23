package com.asiainfo.aiga.statistics.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.statistics.bo.AigaMonthRepKpi;
import com.asiainfo.aiga.statistics.bo.AigaMonthRunKpi;
import com.asiainfo.aiga.statistics.bo.AigaMonthDelSla;
import com.asiainfo.aiga.statistics.bo.StatKpiTarget;
import com.asiainfo.aiga.statistics.dao.IStatisticsDAO;
public class StatisticsDAOImpl extends HibernateDaoSupport implements IStatisticsDAO {
	public AigaMonthRunKpi[] getAigaKpiByCriteria(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaMonthRunKpi> aigaKpis = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaKpis.toArray(new AigaMonthRunKpi[0]);
	}
	public AigaMonthRunKpi[] getAigaKpiBySql(String querySql) throws Exception {
		// TODO Auto-generated method stub
		List<Object> aigaKpis = this.getHibernateTemplate().find(querySql);
		int n=aigaKpis.size();
		AigaMonthRunKpi[] array=new AigaMonthRunKpi[n];
		for(int i=0;i<n;i++){
			Object aigaObj=aigaKpis.get(i);
			if(aigaObj.getClass().isArray()){
			Object[] objs=(Object[])aigaObj;
			for(Object obj:objs){
				if(obj instanceof AigaMonthRunKpi){
					array[i]=(AigaMonthRunKpi)obj;
				}
			}
			}else{
				array=aigaKpis.toArray(new AigaMonthRunKpi[0]);
			}
		}
		
		return array;
	}
	public List getAllAigaKpiBySql(String querySql) throws Exception {
		// TODO Auto-generated method stub
        List<Object> allAigaKpi = this.getHibernateTemplate().find(querySql);
		return allAigaKpi;
	}
	public void saveOrUpdate(Object aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}
	@Override
	public List getObjectByHQL(String HQL) throws Exception {
		// TODO Auto-generated method stub
		List list= this.getHibernateTemplate().find(HQL);
		return list;
	}
	@Override
	public AigaMonthDelSla[] getAigaMonthDelSla(String querySql)
			throws Exception {
		List<Object> aigaMonthDelSlas = this.getHibernateTemplate().find(querySql);
		int n=aigaMonthDelSlas.size();
		AigaMonthDelSla[] array=new AigaMonthDelSla[n];
		for(int i=0;i<n;i++){
			Object aigaObj=aigaMonthDelSlas.get(i);
			if(aigaObj.getClass().isArray()){
				Object[] objs=(Object[])aigaObj;
				for(Object obj:objs){
					if(obj instanceof AigaMonthDelSla){
						array[i]=(AigaMonthDelSla)obj;
					}
				}
			}else{
				array=aigaMonthDelSlas.toArray(new AigaMonthDelSla[0]);
			}
		}
		return array;
	}
	@Override
	public void saveAigaMonthDelSla(AigaMonthDelSla aValue) throws Exception {
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}
	@Override
	public boolean manageKpi(String SQL) throws Exception {
		
		final String sql = SQL;
		this.getHibernateTemplate().execute(new HibernateCallback() {  
		    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
		         SQLQuery query = session.createSQLQuery(sql);    
		         return query.executeUpdate();  
		    }  
	    });
		return true;
	}
	@Override
	public boolean updateBySQL(String SQL) throws Exception {
		final String sql = SQL;
		this.getHibernateTemplate().execute(new HibernateCallback() {  
		    public Object doInHibernate(Session session) throws HibernateException, SQLException {  
		         SQLQuery query = session.createSQLQuery(sql);    
		         return query.executeUpdate();  
		    }  
	    });
		return true;
	}
	@Override
	public AigaMonthRepKpi[] getAigaMonthRepKpi(String querySql)
			throws Exception {
		// TODO Auto-generated method stub
		List<Object> aigaRepKpis = this.getHibernateTemplate().find(querySql);
		int n=aigaRepKpis.size();
		AigaMonthRepKpi[] array=new AigaMonthRepKpi[n];
		for(int i=0;i<n;i++){
			Object aigaObj=aigaRepKpis.get(i);
			if(aigaObj.getClass().isArray()){
			Object[] objs=(Object[])aigaObj;
			for(Object obj:objs){
				if(obj instanceof AigaMonthRepKpi){
					array[i]=(AigaMonthRepKpi)obj;
				}
			}
			}else{
				array=aigaRepKpis.toArray(new AigaMonthRepKpi[0]);
			}
		}
		
		return array;
	}
	@Override
	public void saveAigaMonthRepKpi(AigaMonthRepKpi aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}
	@Override
	public StatKpiTarget[] getStatKpiTarget(String querySql) throws Exception {
		// TODO Auto-generated method stub
		List<StatKpiTarget> statKpiTarget = this.getHibernateTemplate().find(querySql);
		
		
		return  statKpiTarget.toArray(new StatKpiTarget[0]);
	}
	@Override
	public void saveStatKpiTarget(StatKpiTarget aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}
	@Override
	public void delObject(Object aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(aValue);
		
	}
}
