package com.lb.app.automation.dao.impl;

import java.util.List;

import org.hibernate.SQLQuery;
import org.springframework.stereotype.Repository;

import com.lb.app.automation.dao.IAutoKeywordDetailDao;
import com.lb.app.automation.model.AutoKeywordDetail;
import com.lb.app.common.dao.impl.GenericDAO;

@Repository
public class AutoKeywordDetailDao  extends GenericDAO<AutoKeywordDetail> implements IAutoKeywordDetailDao{

	public List<AutoKeywordDetail> queryByScriptid(String scriptid){
		
		String sql = "select * from auto_keyworddetail where keyworddetailid in(" +        
				"select distinct keyworddetailid from auto_script s, auto_scriptdetail sd, auto_keyworddetail kd " +
				"where s.scriptid = sd.scriptid and kd.keywordid = sd.keywordid and kd.parameter is not null and s.scriptid = ?)";
		SQLQuery query = sessionFactory.getCurrentSession().createSQLQuery(sql).addEntity(AutoKeywordDetail.class);
		query.setParameter(0, scriptid);
		return query.list();
	}
}
