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
import com.asiainfo.aiga.userCase.bo.AigaHisSubElem;
import com.asiainfo.aiga.userCase.bo.AigaTestSubElem;
import com.asiainfo.aiga.userCase.dao.IAigaTestSubElemDAO;

public class AigaTestSubElemDAOImpl extends HibernateDaoSupport implements IAigaTestSubElemDAO {

	@Override
	public AigaTestSubElem[] getTestSubElem(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		criteria.add(Restrictions.ne("isDelete", 1));
		List<AigaTestSubElem> aigaTestSubElems = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaTestSubElems.toArray(new AigaTestSubElem[0]);
	}

	@Override
	public void saveOrUpdate(AigaTestSubElem aValue) throws Exception {
		// TODO Auto-generated method stub
		String operatorType = "";
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
		String subTaskTag = request.getSession().getAttribute("subTaskTag").toString();
		String normalMac = CommonHelper.decodeCN(request.getSession().getAttribute("normalMac").toString());
		String TemporaryTag = request.getSession().getAttribute("TemporaryTag").toString();
		if(user==null)
			throw new Exception("当前用户尚未登录");
		if(aValue.getSubElemId()==null)
			operatorType = "add";
		else
			operatorType = "modify";
		aValue.setIsDelete(0);
		this.getHibernateTemplate().saveOrUpdate(aValue);
		AigaHisSubElem aigaHisSubElem = new AigaHisSubElem();
		aigaHisSubElem.setElemId(aigaHisSubElem.getElemId());
		aigaHisSubElem.setElemTestLogic(aigaHisSubElem.getElemTestLogic());
		aigaHisSubElem.setOperateTime(new Timestamp(new Date().getTime()));
		aigaHisSubElem.setOperatorName(user.getUserName());
		aigaHisSubElem.setOperatorType(operatorType);
		aigaHisSubElem.setOperatorUser(user.getUserAccount());
		aigaHisSubElem.setSubElemId(aValue.getSubElemId());
		aigaHisSubElem.setElemValue(aValue.getElemValue());
		aigaHisSubElem.setTakeValueMethod(aValue.getTakeValueMethod());
		aigaHisSubElem.setValueRemark(aValue.getValueRemark());
		if(subTaskTag!=null&&!subTaskTag.equals("")){
			aigaHisSubElem.setSubTaskTag(subTaskTag);
			aigaHisSubElem.setEditType(1);
		}
		if(normalMac!=null&&!normalMac.equals("")){
			aigaHisSubElem.setNormalMac(normalMac);
			aigaHisSubElem.setEditType(2);
		}
		if(TemporaryTag!=null&&!TemporaryTag.equals("")){
			aigaHisSubElem.setTemporaryTag(TemporaryTag);
			aigaHisSubElem.setEditType(3);
		}
		this.getHibernateTemplate().save(aigaHisSubElem);
	}

	@Override
	public void deleteTestSubElem(AigaTestSubElem aValue) throws Exception {
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
		AigaHisSubElem aigaHisSubElem = new AigaHisSubElem();
		aigaHisSubElem.setElemId(aigaHisSubElem.getElemId());
		aigaHisSubElem.setElemTestLogic(aigaHisSubElem.getElemTestLogic());
		aigaHisSubElem.setOperateTime(new Timestamp(new Date().getTime()));
		aigaHisSubElem.setOperatorName(user.getUserName());
		aigaHisSubElem.setOperatorType("delete");
		aigaHisSubElem.setOperatorUser(user.getUserAccount());
		aigaHisSubElem.setSubElemId(aValue.getSubElemId());
		aigaHisSubElem.setElemValue(aValue.getElemValue());
		aigaHisSubElem.setTakeValueMethod(aValue.getTakeValueMethod());
		aigaHisSubElem.setValueRemark(aValue.getValueRemark());
		if(subTaskTag!=null&&!subTaskTag.equals("")){
			aigaHisSubElem.setSubTaskTag(subTaskTag);
			aigaHisSubElem.setEditType(1);
		}
		if(normalMac!=null&&!normalMac.equals("")){
			aigaHisSubElem.setNormalMac(normalMac);
			aigaHisSubElem.setEditType(2);
		}
		if(TemporaryTag!=null&&!TemporaryTag.equals("")){
			aigaHisSubElem.setTemporaryTag(TemporaryTag);
			aigaHisSubElem.setEditType(3);
		}
		this.getHibernateTemplate().save(aigaHisSubElem);
	}
	
	public AigaHisSubElem[] getHisSubElemBySql(String querySql) throws Exception {
		List<AigaHisSubElem> historys = this.getHibernateTemplate().find(querySql);
		return historys.toArray(new AigaHisSubElem[0]);
	}

	@Override
	public AigaTestSubElem[] getTestSubElemBySql(String querySql)
			throws Exception {
			List<AigaTestSubElem> historys = this.getHibernateTemplate().find(querySql);
		return historys.toArray(new AigaTestSubElem[0]);
	}

}
