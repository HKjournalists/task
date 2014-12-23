package com.asiainfo.aiga.component.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.component.bo.AigaComponent;
import com.asiainfo.aiga.component.bo.extend.AigaBaseComponent;
import com.asiainfo.aiga.component.dao.IAigaComponentDAO;

public class AigaComponentDAOImpl extends HibernateDaoSupport implements IAigaComponentDAO{

	public void delete(AigaComponent value) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(value);
	}

	public AigaComponent[] getAigaComponentBySql(String querySql)
			throws Exception {
		List<Object> aigaComponents = this.getHibernateTemplate().find(querySql);
		int n=aigaComponents.size();
		AigaComponent[] array=new AigaComponent[n];
		for(int i=0;i<n;i++){
			AigaComponent comp=new AigaBaseComponent();
			Object aigaObj=aigaComponents.get(i);
			if(aigaObj.getClass().isArray()){
			Object[] objs=(Object[])aigaObj;
//			遍历对象，把AigaComponent取出
			for(Object obj:objs){
				if(obj instanceof AigaComponent){
					array[i]=(AigaComponent)obj;
				}
			}
			}else{
				array=aigaComponents.toArray(new AigaComponent[0]);
			}
		}
		
		return array;
	}

	public void saveOrUpdate(AigaComponent value) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(value);
	}

	public AigaComponent[] getAigaComponentByCriteria(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaComponent> aigaComponents = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaComponents.toArray(new AigaComponent[0]);
	}

	@Override
	public List getAigaComponentByHql(String hql) throws Exception {
		// TODO Auto-generated method stub
		return this.getHibernateTemplate().find(hql);
	}
}
