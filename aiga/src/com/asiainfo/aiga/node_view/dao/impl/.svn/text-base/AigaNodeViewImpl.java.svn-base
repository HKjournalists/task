package com.asiainfo.aiga.node_view.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.node_view.bo.NodeView;
import com.asiainfo.aiga.node_view.dao.IAigaNodeViewDAO;

/**
 * Created on 2014-7-4
 * <p>Description: [描述该类概要功能介绍]</p>
*/
public class AigaNodeViewImpl extends HibernateDaoSupport implements IAigaNodeViewDAO
{

	
	public com.asiainfo.aiga.node_view.bo.NodeView[] getNodeViewBySql(String querySql) throws Exception
	{
		// TODO Auto-generated method stub
		return null;
	}

	
	public com.asiainfo.aiga.node_view.bo.NodeView[] NodeView(DetachedCriteria criteria) throws Exception
	{
		List<NodeView> list = this.getHibernateTemplate().findByCriteria(criteria);
		return list.toArray(new NodeView[0]);
	}

	
	public void saveOrUpdate(com.asiainfo.aiga.node_view.bo.NodeView aValue) throws Exception
	{
		// TODO Auto-generated method stub
		
	}

	
	public void delete(com.asiainfo.aiga.node_view.bo.NodeView aValue) throws Exception
	{
		// TODO Auto-generated method stub
		
	}

	
	public com.asiainfo.aiga.node_view.bo.NodeView[] getNodeViewByKeyword(DetachedCriteria criteria) throws Exception
	{
		List<NodeView> list = this.getHibernateTemplate().findByCriteria(criteria);
		return list.toArray(new NodeView[0]);
	}


}
