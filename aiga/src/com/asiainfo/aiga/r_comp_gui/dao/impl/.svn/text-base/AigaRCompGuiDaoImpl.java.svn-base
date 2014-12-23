package com.asiainfo.aiga.r_comp_gui.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.asiainfo.aiga.r_comp_gui.bo.AigaGuiCompRela;
import com.asiainfo.aiga.r_comp_gui.dao.IAigaRCompGuiDAO;

/**
 * Created on 2014-6-25
 * <p>
 * Description: []
 * </p>
 */
public class AigaRCompGuiDaoImpl extends HibernateDaoSupport implements
		IAigaRCompGuiDAO {

	public AigaGuiCompRela[] getAigaGuiCompRelaBySql(String querySql)
			throws Exception {
		List<AigaGuiCompRela> rCaseCompList = this.getHibernateTemplate().find(
				querySql);
		return rCaseCompList.toArray(new AigaGuiCompRela[0]);
	}

	public AigaGuiCompRela[] getAigaGuiCompRelaByCriteria(
			DetachedCriteria criteria) throws Exception {
		List<AigaGuiCompRela> AigaGuiCompRela = this.getHibernateTemplate()
				.findByCriteria(criteria);
		return AigaGuiCompRela.toArray(new AigaGuiCompRela[0]);
	}

	public AigaGuiCompRela[] getUpdateByCriteria(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	public void saveOrUpdate(AigaGuiCompRela aValue) throws Exception {
		this.getHibernateTemplate().saveOrUpdate(aValue);

	}

	public void delete(AigaGuiCompRela aValue) throws Exception {
		this.getHibernateTemplate().delete(aValue);

	}

	@Override
	public List getAigaGuiCompRelaByHql(String hql) throws Exception {
		// TODO Auto-generated method stub
		return this.getHibernateTemplate().find(hql);
	}

}
