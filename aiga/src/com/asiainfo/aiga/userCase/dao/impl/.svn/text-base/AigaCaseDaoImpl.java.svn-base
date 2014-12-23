package com.asiainfo.aiga.userCase.dao.impl;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.asiainfo.aiga.caseLabelRela.bo.AigaCaseLabelRela;
import com.asiainfo.aiga.common.helper.CommonHelper;
import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.r_collect_case.bo.AigaRFunCase;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.bo.AigaHisCase;
import com.asiainfo.aiga.userCase.bo.AigaRCaseElem;
import com.asiainfo.aiga.userCase.bo.extend.AigaInstCase;
import com.asiainfo.aiga.userCase.dao.IAigaCaseDAO;

/**
 * Created on 2014-6-23
 * <p>Description: [描述该类概要功能介绍]</p>
*/
public class AigaCaseDaoImpl extends HibernateDaoSupport implements IAigaCaseDAO
{

	public AigaCase[] getAigaCaseBySql(String querySql) throws Exception
	{
		List<AigaCase> aigaCaseList = this.getHibernateTemplate().find(querySql);
		return aigaCaseList.toArray(new AigaCase[0]);
	}

	public AigaCase[] getAigaCaseByCriteria(DetachedCriteria criteria) throws Exception
	{
		criteria.add(Restrictions.ne("isDelete", 1));
		List<AigaCase> aigaCases = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaCases.toArray(new AigaCase[0]);
	}

	public void saveOrUpdate(AigaCase aValue) throws Exception
	{
		// TODO Auto-generated method stub
		String operatorType = "";
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
		String subTaskTag = request.getSession().getAttribute("subTaskTag").toString();
		String normalMac = CommonHelper.decodeCN(request.getSession().getAttribute("normalMac").toString());
		String TemporaryTag = request.getSession().getAttribute("TemporaryTag").toString();
		Object isCaseApproval = request.getSession().getAttribute("isCaseApproval");
		if(user==null)
			throw new Exception("当前用户尚未登录");
		if(aValue.getCaseId()==null){
			operatorType = "add";
			aValue.setCreateTime(new Timestamp(new Date().getTime()));
			aValue.setAuthor(user.getUserAccount());
		}else{
			operatorType = "modify";
		}
		aValue.setLatestOperator(user.getUserName());
		aValue.setUpdateTime(new Timestamp(new Date().getTime()));
		aValue.setIsDelete(0);
		this.getHibernateTemplate().saveOrUpdate(aValue);
		AigaHisCase aigaHisCase = new AigaHisCase();
		aigaHisCase.setAuthor(aValue.getAuthor());
		aigaHisCase.setAuthorNo(aValue.getAuthorNo());
		aigaHisCase.setCaseDesc(aValue.getCaseDesc());
		aigaHisCase.setCaseId(aValue.getCaseId());
		aigaHisCase.setCaseName(aValue.getCaseName());
		aigaHisCase.setCasePreCond(aValue.getCasePreCond());
		aigaHisCase.setCaseType(aValue.getCaseType());
		aigaHisCase.setEfficiencyTest(aValue.getEfficiencyTest());
		aigaHisCase.setEfficiencyTestType(aValue.getEfficiencyTestType());
		aigaHisCase.setElemvalue(aValue.getElemvalue());
		aigaHisCase.setFunFolderId(aValue.getFunFolderId());
		aigaHisCase.setHasTest(aValue.getHasTest());
		aigaHisCase.setImportant(aValue.getImportant());
		aigaHisCase.setLatestOperator(aValue.getLatestOperator());
		aigaHisCase.setMaintenanceFac(aValue.getMaintenanceFac());
		aigaHisCase.setNormalMac(normalMac);
		aigaHisCase.setOperateTime(new Timestamp(aValue.getUpdateTime().getTime()));
		aigaHisCase.setOperatorName(user.getUserName());
		aigaHisCase.setOperatorType(operatorType);
		aigaHisCase.setOperatorUser(user.getUserAccount());
		aigaHisCase.setOwnLabel(aValue.getOwnLabel());
		aigaHisCase.setPreResult(aValue.getPreResult());
		aigaHisCase.setRegressionTest(aValue.getRegressionTest());
		aigaHisCase.setSecId(aValue.getSecId());
		if(subTaskTag!=null&&!subTaskTag.equals("")){
			aigaHisCase.setSubTaskTag(subTaskTag);
			aigaHisCase.setEditType(1);
		}
		if(normalMac!=null&&!normalMac.equals("")){
			aigaHisCase.setNormalMac(normalMac);
			aigaHisCase.setEditType(2);
		}
		if(TemporaryTag!=null&&!TemporaryTag.equals("")){
			aigaHisCase.setTemporaryTag(TemporaryTag);
			aigaHisCase.setEditType(3);
		}
		if(isCaseApproval!=null&&!isCaseApproval.toString().equals("")){
			aigaHisCase.setEditType(4);
		}
		aigaHisCase.setSysLabel(aValue.getSysLabel());
		aigaHisCase.setTeminalTest(aValue.getTeminalTest());
		aigaHisCase.setTemporaryTag(TemporaryTag);
		aigaHisCase.setTestType(aValue.getTestType());
		aigaHisCase.setUrl(aValue.getUrl());
		aigaHisCase.setIsAvailAuto(aValue.getIsAvailAuto());
		aigaHisCase.setIsDelete(0);
		aigaHisCase.setIsFinishAuto(aValue.getIsFinishAuto());
		this.getHibernateTemplate().saveOrUpdate(aigaHisCase);
	}

	public void delete(AigaCase aValue) throws Exception
	{
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
		AigaHisCase aigaHisCase = new AigaHisCase();
		aigaHisCase.setAuthor(aValue.getAuthor());
		aigaHisCase.setAuthorNo(aValue.getAuthorNo());
		aigaHisCase.setCaseDesc(aValue.getCaseDesc());
		aigaHisCase.setCaseId(aValue.getCaseId());
		aigaHisCase.setCaseName(aValue.getCaseName());
		aigaHisCase.setCasePreCond(aValue.getCasePreCond());
		aigaHisCase.setCaseType(aValue.getCaseType());
		aigaHisCase.setEfficiencyTest(aValue.getEfficiencyTest());
		aigaHisCase.setEfficiencyTestType(aValue.getEfficiencyTestType());
		aigaHisCase.setElemvalue(aValue.getElemvalue());
		aigaHisCase.setFunFolderId(aValue.getFunFolderId());
		aigaHisCase.setHasTest(aValue.getHasTest());
		aigaHisCase.setImportant(aValue.getImportant());
		aigaHisCase.setLatestOperator(aValue.getLatestOperator());
		aigaHisCase.setMaintenanceFac(aValue.getMaintenanceFac());
		aigaHisCase.setNormalMac(normalMac);
		aigaHisCase.setOperateTime(new Timestamp(new Date().getTime()));
		aigaHisCase.setOperatorName(user.getUserName());
		aigaHisCase.setOperatorType("delete");
		aigaHisCase.setOperatorUser(user.getUserAccount());
		aigaHisCase.setOwnLabel(aValue.getOwnLabel());
		aigaHisCase.setPreResult(aValue.getPreResult());
		aigaHisCase.setRegressionTest(aValue.getRegressionTest());
		aigaHisCase.setSecId(aValue.getSecId());
		if(subTaskTag!=null&&!subTaskTag.equals("")){
			aigaHisCase.setSubTaskTag(subTaskTag);
			aigaHisCase.setEditType(1);
		}
		if(normalMac!=null&&!normalMac.equals("")){
			aigaHisCase.setNormalMac(normalMac);
			aigaHisCase.setEditType(2);
		}
		if(TemporaryTag!=null&&!TemporaryTag.equals("")){
			aigaHisCase.setTemporaryTag(TemporaryTag);
			aigaHisCase.setEditType(3);
		}
		aigaHisCase.setSysLabel(aValue.getSysLabel());
		aigaHisCase.setTeminalTest(aValue.getTeminalTest());
		aigaHisCase.setTemporaryTag(TemporaryTag);
		aigaHisCase.setTestType(aValue.getTestType());
		aigaHisCase.setUrl(aValue.getUrl());
		aigaHisCase.setIsAvailAuto(aValue.getIsAvailAuto());
		aigaHisCase.setIsDelete(0);
		aigaHisCase.setIsFinishAuto(aValue.getIsFinishAuto());
		this.getHibernateTemplate().saveOrUpdate(aigaHisCase);
	}

	public AigaCase[] getUpdateByCriteria(DetachedCriteria criteria) throws Exception
	{
		List<AigaCase> aigaCases = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaCases.toArray(new AigaCase[0]);
	}
	
	public AigaCaseLabelRela[] getCaseLabelRelaBySql(String querySql) throws Exception {
		List<AigaCaseLabelRela> relas = this.getHibernateTemplate().find(querySql);
		return relas.toArray(new AigaCaseLabelRela[0]);
	}
	
	public void saveCaseLabelRela(AigaCaseLabelRela value) throws Exception {
		this.getHibernateTemplate().save(value);
	}
	
	public void deleteCaseLabelRela(AigaCaseLabelRela value) throws Exception {
		this.getHibernateTemplate().delete(value);
	}

	public List getCaseByHql(String hql)throws Exception{
		return this.getHibernateTemplate().find(hql);
	}

	@Override
	public AigaRCaseElem[] getAigaRCaseElem(DetachedCriteria criteria) throws Exception {
		// TODO Auto-generated method stub
		List<AigaRCaseElem> aigaRCaseElems = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaRCaseElems.toArray(new AigaRCaseElem[0]);
	}
	
	@Override
	public AigaRCaseElem[] getAigaRCaseElem(String queryString) throws Exception {
		List<AigaRCaseElem> aigaRCaseElems = this.getHibernateTemplate().find(queryString);
		return aigaRCaseElems.toArray(new AigaRCaseElem[0]);
	}
	
	@Override
	public void saveAigaRCaseElem(AigaRCaseElem aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(aValue);
	}

	@Override
	public void deleteAigaRCaseElem(AigaRCaseElem aValue) throws Exception {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(aValue);
	}
	
	public AigaInstCase[] getInstCaseBySql(String querySql) throws Exception {
		List<AigaInstCase> relas = this.getHibernateTemplate().find(querySql);
		return relas.toArray(new AigaInstCase[0]);
	}
	
	public AigaHisCase[] getHisCaseBySql(String querySql) throws Exception {
		List<AigaHisCase> cases = this.getHibernateTemplate().find(querySql);
		return cases.toArray(new AigaHisCase[0]);
	}
	
	public AigaRFunCase[] getAigaRFunCaseBySql(String querySql)
			throws Exception {
		List<AigaRFunCase> relas = this.getHibernateTemplate().find(querySql);
		return relas.toArray(new AigaRFunCase[0]);
	}

	@Override
	public AigaCase[] getAigaCaseByCriteria(DetachedCriteria criteria,
			Integer start, Integer limit) throws Exception {
		// TODO Auto-generated method stub
		criteria.add(Restrictions.ne("isDelete", 1));
		List<AigaCase> aigaCases = this.getHibernateTemplate().findByCriteria(criteria,start,limit);
		return aigaCases.toArray(new AigaCase[0]);
	}
	
	public int getAigaCaseCount(DetachedCriteria criteria) throws Exception {
		criteria.add(Restrictions.ne("isDelete", 1));
		criteria.setProjection(Projections.count("caseId"));
		List list = this.getHibernateTemplate().findByCriteria(criteria);
		return (Integer)list.get(0);
	}
	@Override
	public AigaCase[] queryAigaCaseByCriteria(DetachedCriteria criteria) throws Exception
	{
		List<AigaCase> aigaCases = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaCases.toArray(new AigaCase[0]);
	}

	@Override
	public AigaHisCase[] getHisCaseByCriteria(DetachedCriteria criteria)
			throws Exception {
		List<AigaHisCase> aigaHisCases = this.getHibernateTemplate().findByCriteria(criteria);
		return aigaHisCases.toArray(new AigaHisCase[0]);
	}
	
	public boolean updateAigaHisCaseBySql(String sql){
		if(StringUtils.isBlank(sql)){
			return false;
		}else{
			final String querySql = sql;
			this.getHibernateTemplate().execute(new HibernateCallback() {
				public Object doInHibernate(Session session) throws HibernateException, SQLException {  
					SQLQuery query = session.createSQLQuery(querySql);    
					return query.executeUpdate();
				}  
			}); 
			return true;
		}
	
	}
}
