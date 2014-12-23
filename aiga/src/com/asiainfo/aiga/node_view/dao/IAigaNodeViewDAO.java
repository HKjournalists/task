package com.asiainfo.aiga.node_view.dao;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.node_view.bo.NodeView;

/**
 * Created on 2014-7-4
 * <p>Description: [描述该类概要功能介绍]</p>
*/
public interface IAigaNodeViewDAO
{
	public NodeView[] getNodeViewBySql(String querySql)throws Exception;
	
	public NodeView[] getNodeViewByKeyword(DetachedCriteria criteria)throws Exception;
	
	public NodeView[] NodeView(DetachedCriteria criteria)throws Exception;
	
	public void saveOrUpdate(NodeView aValue)throws Exception;
	
	public void delete(NodeView aValue)throws Exception;
}
