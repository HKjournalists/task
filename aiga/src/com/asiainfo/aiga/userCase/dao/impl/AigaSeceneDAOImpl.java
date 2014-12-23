package com.asiainfo.aiga.userCase.dao.impl;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.asiainfo.aiga.common.helper.CommonHelper;
import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.userCase.bo.AigaHisSecene;
import com.asiainfo.aiga.userCase.bo.AigaRElemSec;
import com.asiainfo.aiga.userCase.bo.AigaSecene;
import com.asiainfo.aiga.userCase.dao.IAigaSeceneDAO;

public class AigaSeceneDAOImpl extends HibernateDaoSupport implements IAigaSeceneDAO {

	@Override
	public AigaSecene[] getSecene(DetachedCriteria criteria) throws Exception {
		// TODO Auto-generated method stub
		criteria.add(Restrictions.ne("isDelete", 1));
		List<AigaSecene> aigaSecenes = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaSecenes.toArray(new AigaSecene[0]);
	}

	@Override
	public void saveSecene(AigaSecene aValue) throws Exception {
		// TODO Auto-generated method stub
		String operatorType = "";
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
		String subTaskTag = request.getSession().getAttribute("subTaskTag").toString();
		String normalMac = CommonHelper.decodeCN(request.getSession().getAttribute("normalMac").toString());
		String TemporaryTag = request.getSession().getAttribute("TemporaryTag").toString();
		if(user==null)
			throw new Exception("当前用户尚未登录");
		if(aValue.getSecId()==null)
			operatorType = "add";
		else
			operatorType = "modify";
		aValue.setIsDelete(0);
		this.getHibernateTemplate().saveOrUpdate(aValue);
		AigaHisSecene aigaHisSecene = new AigaHisSecene();
		aigaHisSecene.setAnalysisMethod(aValue.getAnalysisMethod());
		aigaHisSecene.setOperateTime(new Timestamp(new Date().getTime()));
		aigaHisSecene.setOperatorName(user.getUserName());
		aigaHisSecene.setOperatorType(operatorType);
		aigaHisSecene.setOperatorUser(user.getUserAccount());
		aigaHisSecene.setSeceneName(aValue.getSeceneName());
		aigaHisSecene.setSecId(aValue.getSecId());
		aigaHisSecene.setSecOrder(aValue.getSecOrder());
		if(subTaskTag!=null&&!subTaskTag.equals("")){
			aigaHisSecene.setSubTaskTag(subTaskTag);
			aigaHisSecene.setEditType(1);
		}
		if(normalMac!=null&&!normalMac.equals("")){
			aigaHisSecene.setNormalMac(normalMac);
			aigaHisSecene.setEditType(2);
		}
		if(TemporaryTag!=null&&!TemporaryTag.equals("")){
			aigaHisSecene.setTemporaryTag(TemporaryTag);
			aigaHisSecene.setEditType(3);
		}
		this.getHibernateTemplate().saveOrUpdate(aigaHisSecene);
	}

	@Override
	public void deleteSecene(AigaSecene aValue) throws Exception {
		// TODO Auto-generated method stub
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
		String subTaskTag = request.getSession().getAttribute("subTaskTag").toString();
		String normalMac = CommonHelper.decodeCN(request.getSession().getAttribute("normalMac").toString());
		String TemporaryTag = request.getSession().getAttribute("TemporaryTag").toString();
		if(user==null)
			throw new Exception("当前用户尚未登录");
		aValue.setIsDelete(1);
		this.getHibernateTemplate().saveOrUpdate(aValue);
		AigaHisSecene aigaHisSecene = new AigaHisSecene();
		aigaHisSecene.setAnalysisMethod(aValue.getAnalysisMethod());
		aigaHisSecene.setOperateTime(new Timestamp(new Date().getTime()));
		aigaHisSecene.setOperatorName(user.getUserName());
		aigaHisSecene.setOperatorType("delete");
		aigaHisSecene.setOperatorUser(user.getUserAccount());
		aigaHisSecene.setSeceneName(aValue.getSeceneName());
		aigaHisSecene.setSecId(aValue.getSecId());
		aigaHisSecene.setSecOrder(aValue.getSecOrder());
		if(subTaskTag!=null&&!subTaskTag.equals("")){
			aigaHisSecene.setSubTaskTag(subTaskTag);
			aigaHisSecene.setEditType(1);
		}
		if(normalMac!=null&&!normalMac.equals("")){
			aigaHisSecene.setNormalMac(normalMac);
			aigaHisSecene.setEditType(2);
		}
		if(TemporaryTag!=null&&!TemporaryTag.equals("")){
			aigaHisSecene.setTemporaryTag(TemporaryTag);
			aigaHisSecene.setEditType(3);
		}
		this.getHibernateTemplate().saveOrUpdate(aigaHisSecene);
	}

	@Override
	public AigaRElemSec[] getRElemSecene(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		List<AigaRElemSec> aigaRElemSecs = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaRElemSecs.toArray(new AigaRElemSec[0]);
	}

	@Override
	public void deleteRElemSec(AigaRElemSec aigaRElemSec) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(aigaRElemSec);
	}

	@Override
	public void saveRElemSec(AigaRElemSec aigaRElemSec) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aigaRElemSec);
	}
	
	public AigaHisSecene[] getHisSeceneBySql(String querySql) throws Exception {
		List<AigaHisSecene> secenes = this.getHibernateTemplate().find(querySql);
		return secenes.toArray(new AigaHisSecene[0]);
	}
	@Override
	public AigaSecene[] getSeceneBySql(String querySql) throws Exception {
		List<AigaHisSecene> secenes = this.getHibernateTemplate().find(querySql);
		return secenes.toArray(new AigaSecene[0]);
	}
}
