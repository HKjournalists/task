package com.lb.app.common.dao.impl;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;

import javax.sound.midi.Sequence;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;

import com.lb.app.common.dao.IGenericDAO;

public abstract class GenericDAO<T> implements IGenericDAO<T> {

	private Class<T> entityClass;
	
	public GenericDAO(){
		Type genType = getClass().getGenericSuperclass();
		Type[] params = ((ParameterizedType) genType).getActualTypeArguments();
		this.entityClass = (Class)params[0];
	}

	public GenericDAO(Class<T> clazz) {
		this.entityClass = clazz;
	}

	@Autowired
	protected SessionFactory sessionFactory;

	@Override
	public void create(T t) {
		sessionFactory.getCurrentSession().save(t);
	}

	@Override
	public void delete(T t) {
		sessionFactory.getCurrentSession().delete(t);
	}
	
	@Override
	public void update(T t) {
		sessionFactory.getCurrentSession().update(t);
	}
	
	public void saveOrUpdate(T t){
		sessionFactory.getCurrentSession().saveOrUpdate(t);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public T get(Serializable id){
		return (T)sessionFactory.getCurrentSession().get(entityClass, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public T queryById(String id) {
		return (T) sessionFactory.getCurrentSession().get(entityClass, id);
	}

	@Override
	public List<T> queryAll() {
		String hql = "from " + entityClass.getSimpleName();
		return queryForList(hql, null);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<T> find(String sql, Map params){
		Query query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		for(Object pObject : params.keySet()){
			query.setParameter((String)pObject, params.get(pObject));
		}
		return query.list();

	}
	
	public List<T> findByPage(String sql, Map params, int start, int fetchsize){
		Query query = sessionFactory.getCurrentSession().createSQLQuery(sql);
		for(Object pObject : params.keySet()){
			query.setParameter((String)pObject, params.get(pObject));
		}
		query.setFetchSize(fetchsize);
		query.setFirstResult(start);
		return query.list();

	}
	
	
	public List<T> findbyCriteria(Criterion...criterions){  
        Criteria criteria = sessionFactory.getCurrentSession().createCriteria(entityClass);  
        for(Criterion c:criterions){  
            criteria.add(c);  
        }  
        return criteria.list();  
    }  

	@SuppressWarnings("unchecked")
	protected T queryForObject(String hql, Object[] params) {
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		setQueryParams(query, params);
		return (T) query.uniqueResult();
	}

	@SuppressWarnings("unchecked")
	protected T queryForTopObject(String hql, Object[] params) {
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		setQueryParams(query, params);
		return (T) query.setFirstResult(0).setMaxResults(1).uniqueResult();
	}

	@SuppressWarnings("unchecked")
	protected List<T> queryForList(String hql, Object[] params) {
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		setQueryParams(query, params);
		return query.list();
	}

	@SuppressWarnings("unchecked")
	protected List<T> queryForList(final String hql, final Object[] params,
			final int recordNum) {
		Query query = sessionFactory.getCurrentSession().createQuery(hql);
		setQueryParams(query, params);
		return query.setFirstResult(0).setMaxResults(recordNum).list();
	}

	private void setQueryParams(Query query, Object[] params) {
		if (null == params) {
			return;
		}
		for (int i = 0; i < params.length; i++) {
			query.setParameter(i, params[i]);
		}
	}

}
