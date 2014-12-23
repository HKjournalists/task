package com.asiainfo.aiga.qualityManage.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.qualityManage.bo.AigaQualityManage;
import com.asiainfo.aiga.qualityManage.dao.IAigaQualityManageDAO;

public class AigaQualityManageDAOImpl extends HibernateDaoSupport implements IAigaQualityManageDAO {

	@Override
	public AigaQualityManage[] getQM(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaQualityManage> aigaQualityManages = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaQualityManages.toArray(new AigaQualityManage[0]);
	}

}
