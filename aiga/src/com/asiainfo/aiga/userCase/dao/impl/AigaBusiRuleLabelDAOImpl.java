package com.asiainfo.aiga.userCase.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.userCase.bo.AigaAutotestParams;
import com.asiainfo.aiga.userCase.bo.AigaBusiRuleLabel;
import com.asiainfo.aiga.userCase.dao.IAigaBusiRuleLabelDAO;

public class AigaBusiRuleLabelDAOImpl extends HibernateDaoSupport implements IAigaBusiRuleLabelDAO {

	@Override
	public AigaBusiRuleLabel[] getAigaBusiRuleLabel(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaAutotestParams> aigaBusiRuleLabel = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaBusiRuleLabel.toArray(new AigaBusiRuleLabel[0]);
	}

	@Override
	public void deleteAigaBusiRuleLabel(AigaBusiRuleLabel aValue)
			throws Exception {
		this.getHibernateTemplate().delete(aValue);
		
	}

	@Override
	public List getAigaBusiRuleLabelList(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		return this.getHibernateTemplate().findByCriteria(criteria);
	}

	@Override
	public void saveAigaBusiRuleLabel(AigaBusiRuleLabel aValue)
			throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

}
