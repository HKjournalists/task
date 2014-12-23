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
import com.asiainfo.aiga.userCase.bo.AigaHisElem;
import com.asiainfo.aiga.userCase.bo.AigaTestElem;
import com.asiainfo.aiga.userCase.dao.IAigaTestElemDAO;

public class AigaTestElemDAOImpl extends HibernateDaoSupport implements IAigaTestElemDAO {

	@Override
	public AigaTestElem[] getAigaTestElem(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		criteria.add(Restrictions.ne("isDelete", 1));
		List<AigaTestElem> aigaTestElems = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaTestElems.toArray(new AigaTestElem[0]);
	}

	@Override
	public void saveOrUpdate(AigaTestElem aValue) throws Exception {
		// TODO Auto-generated method stub
		String operatorType = "";
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
		String subTaskTag = request.getSession().getAttribute("subTaskTag").toString();
		String normalMac = CommonHelper.decodeCN(request.getSession().getAttribute("normalMac").toString());
		String TemporaryTag = request.getSession().getAttribute("TemporaryTag").toString();
		if(user==null)
			throw new Exception("当前用户尚未登录");
		if(aValue.getElemId()==null)
			operatorType = "add";
		else
			operatorType = "modify";
		aValue.setIsDelete(0);
		this.getHibernateTemplate().saveOrUpdate(aValue);
		AigaHisElem aigaHisElem = new AigaHisElem();
		aigaHisElem.setAddReason(aValue.getAddReason());
		aigaHisElem.setAddReasonType(aValue.getAddReasonType());
		aigaHisElem.setApplicateSys(aValue.getApplicateSys());
		aigaHisElem.setElemId(aValue.getElemId());
		aigaHisElem.setElemName(aValue.getElemName());
		aigaHisElem.setElemSysAchieveType(aValue.getElemSysAchieveType());
		aigaHisElem.setElemTag(aValue.getElemTag());
		aigaHisElem.setFunId(aValue.getFunId());
		aigaHisElem.setFunName(aValue.getFunName());
		aigaHisElem.setIsDelete(aValue.getIsDelete());
		aigaHisElem.setIsGlobalElem(aValue.getIsGlobalElem());
		aigaHisElem.setOperateTime(new Timestamp(new Date().getTime()));
		aigaHisElem.setOperatorName(user.getUserName());
		aigaHisElem.setOperatorType(operatorType);
		aigaHisElem.setOperatorUser(user.getUserAccount());
		aigaHisElem.setStaffId(aValue.getStaffId());
		aigaHisElem.setStaffName(aValue.getStaffName());
		aigaHisElem.setSysId(aValue.getSysId());
		aigaHisElem.setSysName(aValue.getSysName());
		if(subTaskTag!=null&&!subTaskTag.equals("")){
			aigaHisElem.setSubTaskTag(subTaskTag);
			aigaHisElem.setEditType(1);
		}
		if(normalMac!=null&&!normalMac.equals("")){
			aigaHisElem.setNormalMac(normalMac);
			aigaHisElem.setEditType(2);
		}
		if(TemporaryTag!=null&&!TemporaryTag.equals("")){
			aigaHisElem.setTemporaryTag(TemporaryTag);
			aigaHisElem.setEditType(3);
		}
		this.getHibernateTemplate().saveOrUpdate(aigaHisElem);
	}

	@Override
	public void deleteAigaTestElem(AigaTestElem aValue) throws Exception {
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
		AigaHisElem aigaHisElem = new AigaHisElem();
		aigaHisElem.setAddReason(aValue.getAddReason());
		aigaHisElem.setAddReasonType(aValue.getAddReasonType());
		aigaHisElem.setApplicateSys(aValue.getApplicateSys());
		aigaHisElem.setElemId(aValue.getElemId());
		aigaHisElem.setElemName(aValue.getElemName());
		aigaHisElem.setElemSysAchieveType(aValue.getElemSysAchieveType());
		aigaHisElem.setElemTag(aValue.getElemTag());
		aigaHisElem.setFunId(aValue.getFunId());
		aigaHisElem.setFunName(aValue.getFunName());
		aigaHisElem.setIsDelete(aValue.getIsDelete());
		aigaHisElem.setIsGlobalElem(aValue.getIsGlobalElem());
		aigaHisElem.setOperateTime(new Timestamp(new Date().getTime()));
		aigaHisElem.setOperatorName(user.getUserName());
		aigaHisElem.setOperatorType("delete");
		aigaHisElem.setOperatorUser(user.getUserAccount());
		aigaHisElem.setStaffId(aValue.getStaffId());
		aigaHisElem.setStaffName(aValue.getStaffName());
		aigaHisElem.setSysId(aValue.getSysId());
		aigaHisElem.setSysName(aValue.getSysName());
		if(subTaskTag!=null&&!subTaskTag.equals("")){
			aigaHisElem.setSubTaskTag(subTaskTag);
			aigaHisElem.setEditType(1);
		}
		if(normalMac!=null&&!normalMac.equals("")){
			aigaHisElem.setNormalMac(normalMac);
			aigaHisElem.setEditType(2);
		}
		if(TemporaryTag!=null&&!TemporaryTag.equals("")){
			aigaHisElem.setTemporaryTag(TemporaryTag);
			aigaHisElem.setEditType(3);
		}
		this.getHibernateTemplate().saveOrUpdate(aigaHisElem);
	}
	
	public AigaHisElem[] getHisElemBySql(String querySql) throws Exception {
		List<AigaHisElem> historys = this.getHibernateTemplate().find(querySql);
		return historys.toArray(new AigaHisElem[0]);
	}

	@Override
	public void approvalsaveOrUpdate(AigaTestElem aValue) throws Exception {
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

	@Override
	public AigaHisElem[] getAigaHisElem(DetachedCriteria criteria)
			throws Exception {
		List<AigaHisElem> aigaHisElems = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaHisElems.toArray(new AigaHisElem[0]);
	}

	@Override
	public AigaTestElem[] getAigaTestElem(String querySql) throws Exception {
		List<AigaTestElem> historys = this.getHibernateTemplate().find(querySql);
		return historys.toArray(new AigaTestElem[0]);
	}

}
