package com.asiainfo.aiga.userCase.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Conjunction;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Disjunction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.common.helper.CommonHelper;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.bo.AigaHisElem;
import com.asiainfo.aiga.userCase.bo.AigaHisSubElem;
import com.asiainfo.aiga.userCase.bo.AigaRCaseElem;
import com.asiainfo.aiga.userCase.bo.AigaRElemSec;
import com.asiainfo.aiga.userCase.bo.AigaRFunElem;
import com.asiainfo.aiga.userCase.bo.AigaSecene;
import com.asiainfo.aiga.userCase.bo.AigaTestElem;
import com.asiainfo.aiga.userCase.bo.AigaTestSubElem;
import com.asiainfo.aiga.userCase.bo.extend.AigaInstCase;
import com.asiainfo.aiga.userCase.dao.IAigaCaseDAO;
import com.asiainfo.aiga.userCase.dao.IAigaRFunElemDAO;
import com.asiainfo.aiga.userCase.dao.IAigaSeceneDAO;
import com.asiainfo.aiga.userCase.dao.IAigaTestElemDAO;
import com.asiainfo.aiga.userCase.dao.IAigaTestSubElemDAO;
import com.asiainfo.aiga.userCase.service.IAigaTestElemSV;

public class AigaTestElemSVImpl implements IAigaTestElemSV {

	private IAigaTestElemDAO aigaTestElemDAO;
	private IAigaTestSubElemDAO aigaTestSubElemDAO;
	private IAigaRFunElemDAO aigaRFunElemDAO;
	private IAigaSeceneDAO aigaSeceneDAO;
	private IAigaCaseDAO aigaCaseDAO;
	
	public void setAigaCaseDAO(IAigaCaseDAO aigaCaseDAO) {
		this.aigaCaseDAO = aigaCaseDAO;
	}

	public void setAigaSeceneDAO(IAigaSeceneDAO aigaSeceneDAO) {
		this.aigaSeceneDAO = aigaSeceneDAO;
	}

	public void setAigaTestSubElemDAO(IAigaTestSubElemDAO aigaTestSubElemDAO) {
		this.aigaTestSubElemDAO = aigaTestSubElemDAO;
	}
	
	public void setAigaTestElemDAO(IAigaTestElemDAO aigaTestElemDAO) {
		this.aigaTestElemDAO = aigaTestElemDAO;
	}
	
	public void setAigaRFunElemDAO(IAigaRFunElemDAO aigaRFunElemDAO) {
		this.aigaRFunElemDAO = aigaRFunElemDAO;
	}

	@Override
	public AigaTestElem[] getTestElemByFunId(Integer funId) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRFunElem.class);
		criteria.add(Restrictions.eq("funId", funId));
		AigaRFunElem[] aigaRFunElems = aigaRFunElemDAO.getRFunElem(criteria);
		List<Integer> integers = new ArrayList<Integer>();
		for(AigaRFunElem aigaRFunElem : aigaRFunElems){
			integers.add(aigaRFunElem.getElemId());
		}
		AigaTestElem[] aigaTestElems = {};
		if(integers.size()>0){
			criteria = DetachedCriteria.forClass(AigaTestElem.class);
			criteria.add(Restrictions.in("elemId", integers));
			aigaTestElems = aigaTestElemDAO.getAigaTestElem(criteria);
		}
		return aigaTestElems;
	}

	@Override
	public void saveTestElem(AigaTestElem aValue) throws Exception {
		// TODO Auto-generated method stub
		aigaTestElemDAO.saveOrUpdate(aValue);
	}

	@Override
	public AigaTestElem getTestElemById(Integer id) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaTestElem.class);
		criteria.add(Restrictions.eq("elemId", id));
		AigaTestElem[] aigaTestElems = aigaTestElemDAO.getAigaTestElem(criteria);
		if(aigaTestElems.length==1)
			return aigaTestElems[0];
		else
			return new AigaTestElem();
	}

	@Override
	public JSONArray getTestElemTreeGrid(Integer funId) throws Exception {
		// TODO Auto-generated method stub
		JSONArray array = new JSONArray();
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRFunElem.class);
		criteria.add(Restrictions.eq("funId", funId));
		criteria.addOrder(Order.asc("relaOrder"));
		AigaRFunElem[] aigaRFunElems = aigaRFunElemDAO.getRFunElem(criteria);
		for(AigaRFunElem aigaRFunElem : aigaRFunElems){
			criteria = DetachedCriteria.forClass(AigaTestElem.class);
			criteria.add(Restrictions.eq("elemId", aigaRFunElem.getElemId()));
			AigaTestElem[] aigaTestElems = aigaTestElemDAO.getAigaTestElem(criteria);
			if(aigaTestElems.length==1){
				JSONObject json = new JSONObject();
				json.put("id", aigaTestElems[0].getElemId());
				json.put("parentId", -1);
				json.put("text", aigaTestElems[0].getElemName());
				json.put("expanded", false);
				json.put("leaf", false);
				json.put("value", aigaTestElems[0].getElemId());
				json.put("elemId", aigaTestElems[0].getElemId());
				json.put("elemTag", aigaTestElems[0].getElemTag());
				json.put("elemName", aigaTestElems[0].getElemName());
				json.put("elemSysAchieveType", aigaTestElems[0].getElemSysAchieveType());
				json.put("applicateSys", aigaTestElems[0].getApplicateSys());
				json.put("isGlobalElem", aigaTestElems[0].getIsGlobalElem());
				json.put("sysId", aigaTestElems[0].getSysId());
				json.put("relaOrder", aigaRFunElem.getRelaOrder());
				json.put("checked", false);
				
				array.add(json);
			}
		}
		return array;
	}

	@Override
	public JSONArray getSubTestElemTreeGrid(Integer testElemId,String type)
			throws Exception {
		// TODO Auto-generated method stub
		JSONArray array = new JSONArray();
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaTestSubElem.class);
		criteria.add(Restrictions.eq("elemId", testElemId));
		AigaTestSubElem[] aigaTestSubElems = aigaTestSubElemDAO.getTestSubElem(criteria);
		for(AigaTestSubElem aigaTestSubElem : aigaTestSubElems){
			JSONObject json = new JSONObject();
			json.put("id", aigaTestSubElem.getSubElemId()+new Date().getTime()+((int)(Math.random()*100000)));
			json.put("parentId", testElemId);
			json.put("text", "");
			json.put("expanded", false);
			json.put("leaf", true);
			json.put("value", aigaTestSubElem.getSubElemId());
			json.put("subElemId", aigaTestSubElem.getSubElemId());
			json.put("elemId", aigaTestSubElem.getElemId());
			json.put("elemValue", aigaTestSubElem.getElemValue());
			json.put("elemTestLogic", aigaTestSubElem.getElemTestLogic());
			json.put("takeValueMethod", aigaTestSubElem.getTakeValueMethod());
			json.put("valueRemark", aigaTestSubElem.getValueRemark());
			if(type!=null&&type.equals("rela"))
				json.put("checked", false);
			array.add(json);
		}
		return array;
	}
	@Override
	public JSONArray getSubTestElemTreeGridByCondition(Integer testElemId,String type,String elemName,String elemValue)
			throws Exception {
		// TODO Auto-generated method stub
		JSONArray array = new JSONArray();
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaTestSubElem.class);
		criteria.add(Restrictions.eq("elemId", testElemId));
		AigaTestSubElem[] aigaTestSubElems = aigaTestSubElemDAO.getTestSubElem(criteria);
		for(AigaTestSubElem aigaTestSubElem : aigaTestSubElems){
			JSONObject json = new JSONObject();
			json.put("id", aigaTestSubElem.getSubElemId()+new Date().getTime()+((int)(Math.random()*100000)));
			json.put("parentId", testElemId);
			json.put("text", "");
			json.put("expanded", false);
			json.put("leaf", true);
			json.put("value", aigaTestSubElem.getSubElemId());
			json.put("subElemId", aigaTestSubElem.getSubElemId());
			json.put("elemId", aigaTestSubElem.getElemId());
			json.put("elemValue", aigaTestSubElem.getElemValue());
			json.put("elemTestLogic", aigaTestSubElem.getElemTestLogic());
			json.put("takeValueMethod", aigaTestSubElem.getTakeValueMethod());
			json.put("valueRemark", aigaTestSubElem.getValueRemark());
			if(type!=null&&type.equals("rela"))
				json.put("checked", false);
			array.add(json);
		}
		return array;
	}
	@Override
	public JSONArray getTestElemRTreeGrid(Integer funId,Integer sysId) throws Exception {
		// TODO Auto-generated method stub
		JSONArray array = new JSONArray();
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaTestElem.class);
		Disjunction disjunction = Restrictions.disjunction();
		Conjunction conjunction = Restrictions.conjunction();
		conjunction.add(Restrictions.eq("isGlobalElem", 1));
		conjunction.add(Restrictions.eq("sysId", sysId));
		conjunction.add(Restrictions.isNotNull("sysId"));
		disjunction.add(Restrictions.eq("funId", funId));
		disjunction.add(conjunction);
		criteria.add(disjunction);
		AigaTestElem[] aigaTestElems = aigaTestElemDAO.getAigaTestElem(criteria);
		for(AigaTestElem aigaTestElem : aigaTestElems){
			JSONObject json = new JSONObject();
			json.put("id", aigaTestElem.getElemId());
			json.put("parentId", -1);
			json.put("text", aigaTestElem.getElemName());
			json.put("expanded", false);
			json.put("leaf", false);
			json.put("value", aigaTestElem.getElemId());
			json.put("elemId", aigaTestElem.getElemId());
			json.put("elemTag", aigaTestElem.getElemTag());
			json.put("elemName", aigaTestElem.getElemName());
			json.put("elemSysAchieveType", aigaTestElem.getElemSysAchieveType());
			json.put("applicateSys", aigaTestElem.getApplicateSys());
			json.put("isGlobalElem", aigaTestElem.getIsGlobalElem());
			json.put("sysId", aigaTestElem.getSysId());
			criteria = DetachedCriteria.forClass(AigaRFunElem.class);
			criteria.add(Restrictions.eq("funId", funId));
			criteria.add(Restrictions.eq("elemId", aigaTestElem.getElemId()));
			AigaRFunElem[] aigaRFunElems = aigaRFunElemDAO.getRFunElem(criteria);
			if(aigaRFunElems!=null&&aigaRFunElems.length==1)
				json.put("checked", true);
			else
				json.put("checked", false);
			array.add(json);
			
		}
		return array;
	}
	@Override
	public JSONArray getTestElemRTreeGridByCondition(Integer funId,Integer sysId,String elemName,String elemValue) throws Exception {
		// TODO Auto-generated method stub
		JSONArray array = new JSONArray();
		if(elemName!=null)elemName=elemName.trim();
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaTestElem.class);
		Disjunction disjunction = Restrictions.disjunction();
		Conjunction conjunction = Restrictions.conjunction();
		conjunction.add(Restrictions.eq("isGlobalElem", 1));
		conjunction.add(Restrictions.eq("sysId", sysId));
		conjunction.add(Restrictions.isNotNull("sysId"));
		disjunction.add(Restrictions.eq("funId", funId));
//		disjunction.add(Restrictions.like("elemValue", elemValue));
		disjunction.add(conjunction);
		criteria.add(disjunction);
//		criteria.add(Restrictions.like("elemName", "%"+elemName+"%"));
		criteria.addOrder( Order.desc("isGlobalElem"));
		criteria.addOrder( Order.desc("elemId"));
		AigaTestElem[] aigaTestElems = aigaTestElemDAO.getAigaTestElem(criteria);
		for(AigaTestElem aigaTestElem : aigaTestElems){
			JSONObject json = new JSONObject();
			json.put("id", aigaTestElem.getElemId());
			json.put("parentId", -1);
			json.put("text", aigaTestElem.getElemName());
			json.put("expanded", false);
			json.put("leaf", false);
			json.put("value", aigaTestElem.getElemId());
			json.put("elemId", aigaTestElem.getElemId());
			json.put("elemTag", aigaTestElem.getElemTag());
			json.put("elemName", aigaTestElem.getElemName());
			json.put("elemSysAchieveType", aigaTestElem.getElemSysAchieveType());
			json.put("applicateSys", aigaTestElem.getApplicateSys());
			json.put("isGlobalElem", aigaTestElem.getIsGlobalElem());
			json.put("sysId", aigaTestElem.getSysId());
			criteria = DetachedCriteria.forClass(AigaRFunElem.class);
			criteria.add(Restrictions.eq("funId", funId));
			criteria.add(Restrictions.eq("elemId", aigaTestElem.getElemId()));
			AigaRFunElem[] aigaRFunElems = aigaRFunElemDAO.getRFunElem(criteria);
			if(aigaRFunElems!=null&&aigaRFunElems.length==1){
				if(elemName.trim().length()>0){
					String _elemName=String.valueOf(json.get("elemName"));
					json.put("elemName",CommonHelper.resplaceAllIgnoreCase(_elemName, elemName, "<font color='red'>", "</font>"));
				}
				json.put("checked", true);
			}
			else{
				if(elemName!=null){
					String _elemName=String.valueOf(json.get("elemName"));
					if(_elemName.indexOf(elemName.trim())==-1)continue;
					else if(elemName.trim().length()>0){
						json.put("elemName",CommonHelper.resplaceAllIgnoreCase(_elemName, elemName, "<font color='red'>", "</font>"));
					}
				}
				json.put("checked", false);
			}
				
			array.add(json);
			
		}
		return array;
	}
	@Override
	public JSONArray getTestElemBySecId(Integer secId,Integer caseId) throws Exception {
		// TODO Auto-generated method stub
		JSONArray array = new JSONArray();
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRElemSec.class);
		criteria.add(Restrictions.eq("secId", secId));
		criteria.addOrder(Order.asc("elemOrder"));
		AigaRElemSec[] aigaRElemSecs = aigaSeceneDAO.getRElemSecene(criteria);
		for(AigaRElemSec aigaRElemSec : aigaRElemSecs){
			criteria = DetachedCriteria.forClass(AigaTestElem.class);
			criteria.add(Restrictions.eq("elemId", aigaRElemSec.getElemId()));
			AigaTestElem[] aigaTestElems = aigaTestElemDAO.getAigaTestElem(criteria);
			for(AigaTestElem aigaTestElem : aigaTestElems){
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("elemId", aigaTestElem.getElemId());
				jsonObject.put("elemTag",aigaTestElem.getElemTag());
				jsonObject.put("elemName",aigaTestElem.getElemName());
				jsonObject.put("elemSysAchieveType",aigaTestElem.getElemSysAchieveType());
				jsonObject.put("applicateSys",aigaTestElem.getApplicateSys());
				jsonObject.put("isGlobalElem",aigaTestElem.getIsGlobalElem());
				jsonObject.put("sysId",aigaTestElem.getSysId());
				jsonObject.put("funId",aigaTestElem.getFunId());
				jsonObject.put("subElemIds",aigaRElemSec.getSubElemIds());
				if(caseId!=null&&!caseId.equals(0)){
					DetachedCriteria criteria2 = DetachedCriteria.forClass(AigaRCaseElem.class);
					criteria2.add(Restrictions.eq("caseId", caseId));
					criteria2.add(Restrictions.eq("elemId", aigaTestElem.getElemId()));
					AigaRCaseElem[] aigaRCaseElems = aigaCaseDAO.getAigaRCaseElem(criteria2);
					if(aigaRCaseElems!=null&&aigaRCaseElems.length==1)
						jsonObject.put("subElemValue",aigaRCaseElems[0].getSubElemId());
					else
						jsonObject.put("subElemValue","");
				}else
					jsonObject.put("subElemValue","");
				array.add(jsonObject);
			}
		}
		return array;
	}

	@Override
	public AigaTestSubElem[] getSubElemByIds(List<Integer> ids)
			throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaTestSubElem.class);
		criteria.add(Restrictions.in("subElemId", ids));
		return aigaTestSubElemDAO.getTestSubElem(criteria);
	}

	@Override
	public AigaTestSubElem[] getSubElemByElemId(Integer elemId)
			throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaTestSubElem.class);
		criteria.add(Restrictions.eq("elemId", elemId));
		return aigaTestSubElemDAO.getTestSubElem(criteria);
	}

	@Override
	public Integer saveTestElemAndRelaFun(AigaTestElem aValue,Integer funId) throws Exception {
		// TODO Auto-generated method stub
		this.saveTestElem(aValue);
		Integer elemId = aValue.getElemId();
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRFunElem.class);
//		criteria.add(Restrictions.eq("elemId", elemId));
		criteria.add(Restrictions.eq("funId", funId));
		criteria.addOrder(Order.desc("relaOrder"));
		AigaRFunElem[] aigaRFunElems = aigaRFunElemDAO.getRFunElem(criteria);
		int maxIndex=0;
		if(aigaRFunElems.length>0&&aigaRFunElems[0]!=null){
			if(((AigaRFunElem)aigaRFunElems[0]).getRelaOrder()==null){
				throw new NullPointerException("存在未排序测试要素，请先保存顺序再新增或修改要素！");
			}
			maxIndex=((AigaRFunElem)aigaRFunElems[0]).getRelaOrder()+1;
			boolean flag=true;//是否新增要素
			for(AigaRFunElem aigaRFunElem:aigaRFunElems){
				if(aigaRFunElem.getElemId().equals(elemId)){flag=false;break;}
			}
			if(flag){
				AigaRFunElem aigaRFunElem = new AigaRFunElem();
				aigaRFunElem.setFunId(funId);
				aigaRFunElem.setElemId(elemId);
				aigaRFunElem.setRelaOrder(maxIndex);
				aigaRFunElemDAO.saveOrUpdate(aigaRFunElem);
			}
		}else{
			AigaRFunElem aigaRFunElem = new AigaRFunElem();
			aigaRFunElem.setFunId(funId);
			aigaRFunElem.setElemId(elemId);
			aigaRFunElem.setRelaOrder(maxIndex);
			aigaRFunElemDAO.saveOrUpdate(aigaRFunElem);
		}
		
		
		return aValue.getElemId();
	}

	@Override
	public void saveAigaSubElem(AigaTestSubElem aValue) throws Exception {
		// TODO Auto-generated method stub
		aigaTestSubElemDAO.saveOrUpdate(aValue);
	}

	@Override
	public void deleteAigaElem(Integer funId, String elemIds) throws Exception {
		// TODO Auto-generated method stub
		if(elemIds!=null&&elemIds.length()>0){
			List<Integer> integers = new ArrayList<Integer>();
			List<String> elemTag_list = new ArrayList<String>();
			String[] elemId = elemIds.split(",");
			for(String id : elemId){
				integers.add(Integer.valueOf(id));
			}
			//查询删除的所有测试要素，删除测试要素与功能点的关系
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaRFunElem.class);
			criteria.add(Restrictions.eq("funId", funId));
			criteria.add(Restrictions.in("elemId", integers));
			AigaRFunElem[] aigaRFunElems = aigaRFunElemDAO.getRFunElem(criteria);
			for(AigaRFunElem aigaRFunElem : aigaRFunElems){
				aigaRFunElemDAO.deleteRFunElem(aigaRFunElem);
			}
			//查询所有的测试要素，删除测试要素
			criteria = DetachedCriteria.forClass(AigaTestElem.class);
			criteria.add(Restrictions.eq("funId", funId));
			criteria.add(Restrictions.in("elemId", integers));
			AigaTestElem[] aigaTestElems = aigaTestElemDAO.getAigaTestElem(criteria);
			for(AigaTestElem aigaTestElem : aigaTestElems){
				//根据私有要素还是共有要素判断是否删除测试要素下的要素值
				elemTag_list.add(aigaTestElem.getElemTag());
				if(aigaTestElem.getIsGlobalElem()!=null&&aigaTestElem.getIsGlobalElem().equals(0)){
					criteria = DetachedCriteria.forClass(AigaTestSubElem.class);
					criteria.add(Restrictions.eq("elemId", aigaTestElem.getElemId()));
					AigaTestSubElem[] aigaTestSubElems = aigaTestSubElemDAO.getTestSubElem(criteria);
					for(AigaTestSubElem aigaTestSubElem : aigaTestSubElems){
						aigaTestSubElemDAO.deleteTestSubElem(aigaTestSubElem);
					}
					if(aigaTestElem.getStaffId()==null){//私有的测试要素直接删除
						aigaTestElemDAO.deleteAigaTestElem(aigaTestElem);
					}else{//公共要素修改禁用标识
						aigaTestElem.setIsDelete(1);
						aigaTestElemDAO.saveOrUpdate(aigaTestElem);
					}
				}else if(aigaTestElem.getIsGlobalElem()!=null&&aigaTestElem.getIsGlobalElem().equals(1)){
					
				}
			}
			
			
			//根据测试要素和功能点，删除测试要素和测试场景的关联关系
			criteria = DetachedCriteria.forClass(AigaRElemSec.class);
			criteria.add(Restrictions.eq("funId", funId));
			criteria.add(Restrictions.in("elemId", integers));

			AigaRElemSec[] relemSeces = aigaSeceneDAO.getRElemSecene(criteria);
			List<Integer> sec_Id_list = new ArrayList<Integer>();
			for(AigaRElemSec eleSec:relemSeces){
				sec_Id_list.add(eleSec.getSecId());
				aigaSeceneDAO.deleteRElemSec(eleSec);	
			}
			//根据测试要素查询关联的场景，然后根据场景查询关联的测试用例，然后查询用例和测试要素的关联关系并删除。
			if(sec_Id_list.size() > 0){
				criteria = DetachedCriteria.forClass(AigaInstCase.class);
				criteria.add(Restrictions.in("secId", sec_Id_list));
				AigaCase[] aiga_cases = aigaCaseDAO.getAigaCaseByCriteria(criteria);
				for(AigaCase aigacase:aiga_cases){
					criteria = DetachedCriteria.forClass(AigaRCaseElem.class);
					criteria.add(Restrictions.in("elemId", integers));
					criteria.add(Restrictions.eq("caseId", aigacase.getCaseId()));
					AigaRCaseElem[] rcaseElemes = aigaCaseDAO.getAigaRCaseElem(criteria);
					for(AigaRCaseElem ce : rcaseElemes)
						aigaCaseDAO.deleteAigaRCaseElem(ce);
		
				}
			}
		}
	}

	@Override
	public AigaTestSubElem getAigaTestSubElemById(Integer SubElemId)
			throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaTestSubElem.class);
		criteria.add(Restrictions.eq("subElemId", SubElemId));
		AigaTestSubElem[] aigaTestSubElems = aigaTestSubElemDAO.getTestSubElem(criteria);
		if(aigaTestSubElems!=null&&aigaTestSubElems.length==1)
			return aigaTestSubElems[0];
		else 
			return new AigaTestSubElem();
	}

	@Override
	public String saveFunElemRela(Integer funId, String elemIds) throws Exception {
		// TODO Auto-generated method stub
		String msg="";
		if(elemIds!=null&&elemIds.length()>0){
			//要保存的要素
			List<Integer> integers = new ArrayList<Integer>();
			String[] elemId = elemIds.split(",");
			for(String id : elemId){
				integers.add(Integer.valueOf(id));
			}
			AigaTestElem[] aigaTestElems=aigaTestElemDAO.getAigaTestElem(" from AigaTestElem " +
					" where elemId in(select distinct elemId from AigaRElemSec where funId="+funId+")");
			if(aigaTestElems!=null&&aigaTestElems.length>0&&aigaTestElems[0]!=null){
				for(AigaTestElem aigaTestElem:aigaTestElems){
					if(integers.contains(aigaTestElem.getElemId())){
						continue;
					}else{
						msg+=aigaTestElem.getElemName()+",";
					}
				}
			}
			if(msg.length()==0){
				DetachedCriteria criteria = DetachedCriteria.forClass(AigaRFunElem.class);
				criteria.add(Restrictions.eq("funId", funId));
				criteria.addOrder(Order.desc("relaOrder"));
				AigaRFunElem[] aigaRFunElems = aigaRFunElemDAO.getRFunElem(criteria);
				int maxIndex=0;
				if(aigaRFunElems.length>0&&aigaRFunElems[0]!=null){
					if(aigaRFunElems[0].getRelaOrder()==null){
						throw new NullPointerException("存在未排序测试要素，请先保存顺序再关联要素！");
					}
					maxIndex=aigaRFunElems[0].getRelaOrder()+1;
					for(AigaRFunElem aigaRFunElem : aigaRFunElems){
						if(integers.contains(aigaRFunElem.getElemId())){
							integers.remove(aigaRFunElem.getElemId());
						}else{
							aigaRFunElemDAO.deleteRFunElem(aigaRFunElem);
						}
					}
				}
				for(Integer id : integers){
					AigaRFunElem aigaRFunElem = new AigaRFunElem();
					aigaRFunElem.setFunId(funId);
					aigaRFunElem.setElemId(id);
					aigaRFunElem.setRelaOrder(maxIndex);
					aigaRFunElemDAO.saveOrUpdate(aigaRFunElem);
					maxIndex++;
				}
			}else{
				msg=msg.substring(0,msg.length()-1);
				msg="要素<font color='red'>"+msg+"</font>已被场景关联，不能删除！";
			}
		}
		return msg;
	}

	@Override
	public void saveElemRelaOrder(Integer funId, String orderJson)
			throws Exception {
		// TODO Auto-generated method stub
		if(orderJson!=null&&orderJson.length()>0){
			JSONArray array = JSONArray.fromObject(orderJson);
			for(int i=0,n=array.size();i<n;i++){
				JSONObject jsonObject = JSONObject.fromObject(array.get(i));
				Iterator iterator = jsonObject.keys();
				String id = (String)iterator.next();
				String order = jsonObject.getString(id);
				
				DetachedCriteria criteria = DetachedCriteria.forClass(AigaRFunElem.class);
				criteria.add(Restrictions.eq("funId", funId));
				criteria.add(Restrictions.eq("elemId", Integer.valueOf(id)));
				AigaRFunElem[] aigaRFunElems = aigaRFunElemDAO.getRFunElem(criteria);
				if(aigaRFunElems.length==1){
					aigaRFunElems[0].setRelaOrder(Integer.valueOf(order));
					aigaRFunElemDAO.saveOrUpdate(aigaRFunElems[0]);
				}
			}
		}
	}

	@Override
	public String getDeleteElemMsg(String elemIds, String funId) throws Exception {
		// TODO Auto-generated method stub
		String msg = "";
		List<String> msgs = new ArrayList<String>();
		if(StringUtils.isNotBlank(elemIds)){
			AigaTestElem[] aigaTestElems=aigaTestElemDAO.getAigaTestElem("from AigaTestElem where elemId in " +
					" (select distinct elemId from AigaRElemSec where elemId in ("+elemIds+")) and isDelete<>1");
			/*AigaSecene[] aigaSecenes=aigaSeceneDAO.getSeceneBySql(" from AigaSecene where secId in (select distinct secId from AigaRElemSec where elemId in ("+elemIds+")) and isDelete<>1");
			if(aigaSecenes!=null&&aigaSecenes.length>0&&aigaSecenes[0]!=null){
				for(AigaSecene aigaSecene:aigaSecenes){
					msgs.add(aigaSecene.getSeceneName());
				}
			}*/
			if(aigaTestElems!=null&&aigaTestElems.length>0&&aigaTestElems[0]!=null){
				for(AigaTestElem aigaTestElem:aigaTestElems){
					msgs.add(aigaTestElem.getElemName());
				}
			}else{
//				String[] elemId = elemIds.split(",");
//				for(String id : elemId){
//					DetachedCriteria criteria = DetachedCriteria.forClass(AigaRElemSec.class);
//					criteria.add(Restrictions.eq("elemId", Integer.valueOf(id)));
//					criteria.add(Restrictions.eq("funId", Integer.valueOf(funId)));
//					AigaRElemSec[] aigaRElemSecs = aigaSeceneDAO.getRElemSecene(criteria);
//					if(aigaRElemSecs!=null&&aigaRElemSecs.length>0){
//						criteria = DetachedCriteria.forClass(AigaTestElem.class);
//						criteria.add(Restrictions.eq("elemId", Integer.valueOf(id)));
//						aigaTestElems = aigaTestElemDAO.getAigaTestElem(criteria);
//						if(aigaTestElems==null||aigaTestElems.length!=1)
//							throw new Exception("查询不到相应的要素信息，要素ID:"+id);
//						msgs.add(aigaTestElems[0].getElemName());
//					}
//				}
			}
			
		}
		if(msgs.size()>0){
			msg += "选中的要素<font color=\"red\">";
			for(int i=0,n=msgs.size();i<n;i++){
				if(i==n-1)
					msg += msgs.get(i);
				else
					msg += msgs.get(i)+",";
			}
			msg += "</font>已被场景关联，不能删除！";
		}
		return msg;
	}

	@Override
	public String deleteSubElemByIds(String ids) throws Exception {
		String msg="";
		AigaTestSubElem[] aigaTestSubElems =aigaTestSubElemDAO.getTestSubElemBySql("from AigaTestSubElem " +
				"where subElemId in (select distinct subElemId from AigaRCaseElem where subElemId in ("+ids+")) and isDelete<>1");
		if(aigaTestSubElems!=null&&aigaTestSubElems.length>0&&aigaTestSubElems[0]!=null){
			for(AigaTestSubElem aigaTestSubElem:aigaTestSubElems){
				msg+=aigaTestSubElem.getElemValue()+",";
			}
			msg.substring(0,msg.length()-1);
		}else{
			if(ids!=null&&ids.length()!=0){
				String[] subElemIds = ids.split(",");
				for(String subElemId : subElemIds){
					DetachedCriteria criteria = DetachedCriteria.forClass(AigaTestSubElem.class);
					criteria.add(Restrictions.eq("subElemId", Integer.valueOf(subElemId)));
					aigaTestSubElems = aigaTestSubElemDAO.getTestSubElem(criteria);
					if(aigaTestSubElems!=null&&aigaTestSubElems.length==1){
						aigaTestSubElemDAO.deleteTestSubElem(aigaTestSubElems[0]);
					}
				}
			}
		}
		return msg;
	}
	
	public AigaHisSubElem[] getHisSubElemBySql(String querySql) throws Exception {
		return aigaTestSubElemDAO.getHisSubElemBySql(querySql);
	}
	
	public AigaHisElem[] getHisElemBySql(String querySql) throws Exception {
		return aigaTestElemDAO.getHisElemBySql(querySql);
	}

	@Override
	public void approvalTestElem(AigaTestElem aValue) throws Exception {
		aigaTestElemDAO.approvalsaveOrUpdate(aValue);
	}

	@Override
	public AigaHisElem[] getHisElemByElemId(Integer elemId) throws Exception {
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaHisElem.class);
		criteria.add(Restrictions.eq("elemId", elemId));
		criteria.addOrder(Order.desc("operateTime"));  
		return aigaTestElemDAO.getAigaHisElem(criteria);
	}

	@Override
	public AigaTestElem[] getTestElemByCriteria(DetachedCriteria criteria) throws Exception {
		return aigaTestElemDAO.getAigaTestElem(criteria);
	}

}
