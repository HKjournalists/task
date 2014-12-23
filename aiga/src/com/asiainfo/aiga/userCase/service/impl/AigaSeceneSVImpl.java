package com.asiainfo.aiga.userCase.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.asiainfo.aiga.funCaseRela.bo.AigaFunCaseRela;
import com.asiainfo.aiga.funCaseRela.dao.IAigaFunCaseRelaDAO;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.bo.AigaHisSecene;
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
import com.asiainfo.aiga.userCase.service.IAigaSeceneSV;

public class AigaSeceneSVImpl implements IAigaSeceneSV {

	private IAigaSeceneDAO aigaSeceneDAO;
	private IAigaTestElemDAO aigaTestElemDAO;
	private IAigaTestSubElemDAO aigaTestSubElemDAO;
	private IAigaRFunElemDAO aigaRFunElemDAO;
	private IAigaCaseDAO aigaCaseDAO;
	private IAigaFunCaseRelaDAO aigaFunCaseRelaDAO;
	
	public void setAigaCaseDAO(IAigaCaseDAO aigaCaseDAO) {
		this.aigaCaseDAO = aigaCaseDAO;
	}

	public void setAigaRFunElemDAO(IAigaRFunElemDAO aigaRFunElemDAO) {
		this.aigaRFunElemDAO = aigaRFunElemDAO;
	}

	public void setAigaTestSubElemDAO(IAigaTestSubElemDAO aigaTestSubElemDAO) {
		this.aigaTestSubElemDAO = aigaTestSubElemDAO;
	}

	public void setAigaTestElemDAO(IAigaTestElemDAO aigaTestElemDAO) {
		this.aigaTestElemDAO = aigaTestElemDAO;
	}

	public void setAigaFunCaseRelaDAO(IAigaFunCaseRelaDAO aigaFunCaseRelaDAO) {
		this.aigaFunCaseRelaDAO = aigaFunCaseRelaDAO;
	}

	public void setAigaSeceneDAO(IAigaSeceneDAO aigaSeceneDAO) {
		this.aigaSeceneDAO = aigaSeceneDAO;
	}

	@Override
	public JSONArray getAigaSeceneByFunId(Integer funId) throws Exception {
		// TODO Auto-generated method stub
		JSONArray array = new JSONArray();
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRFunElem.class);
		criteria.add(Restrictions.eq("funId", funId));
		AigaRFunElem[] aigaRFunElems = aigaRFunElemDAO.getRFunElem(criteria);
		List<Integer> elemIds  = new ArrayList<Integer>();
		for(AigaRFunElem aigaRFunElem : aigaRFunElems){
			elemIds.add(aigaRFunElem.getElemId());
		}
		if(elemIds.size()>0){
			criteria = DetachedCriteria.forClass(AigaRElemSec.class);
			criteria.add(Restrictions.in("elemId", elemIds));
			criteria.add(Restrictions.eq("funId", funId));
			AigaRElemSec[] aigaRElemSecs = aigaSeceneDAO.getRElemSecene(criteria);
			List<Integer> secIds = new ArrayList<Integer>();
			for(AigaRElemSec aigaRElemSec : aigaRElemSecs){
				secIds.add(aigaRElemSec.getSecId());
			}
			if(secIds.size()>0){
				criteria = DetachedCriteria.forClass(AigaSecene.class);
				criteria.add(Restrictions.in("secId", secIds));
				criteria.addOrder(Order.asc("secOrder"));
				AigaSecene[] aigaSecenes = aigaSeceneDAO.getSecene(criteria);
				for(AigaSecene aigaSecene : aigaSecenes){
					JSONObject json = new JSONObject();
					json.put("id", aigaSecene.getSecId()+new Date().getTime()+((int)(Math.random()*100000)));
					json.put("parentId", -1);
					json.put("text", aigaSecene.getSeceneName());
					json.put("expanded", false);
					json.put("leaf", false);
					json.put("value", aigaSecene.getSecId());
					json.put("type", "sec");
					json.put("secId", aigaSecene.getSecId());
					json.put("seceneName", aigaSecene.getSeceneName());
					json.put("analysisMethod", aigaSecene.getAnalysisMethod());
					json.put("checked", false);
					
					array.add(json);
				}
			}
		}
		return array;
	}

	@Override
	public void saveAigaSecene(AigaSecene aValue) throws Exception {
		// TODO Auto-generated method stub
		aigaSeceneDAO.saveSecene(aValue);
	}

	@Override
	public AigaSecene getAigaSeceneById(Integer secId) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaSecene.class);
		criteria.add(Restrictions.eq("secId", secId));
		AigaSecene[] aigaSecenes = aigaSeceneDAO.getSecene(criteria);
		if(aigaSecenes.length==1)
			return aigaSecenes[0];
		else
			return new AigaSecene();
	}

	@Override
	public JSONArray getAigaElemBySecId(Integer secId) throws Exception {
		// TODO Auto-generated method stub
		JSONArray array = new JSONArray();
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRElemSec.class);
		criteria.add(Restrictions.eq("secId", secId));
		AigaRElemSec[] aigaRElemSecs = aigaSeceneDAO.getRElemSecene(criteria);
		List<Integer> lists = new ArrayList<Integer>();
		for(AigaRElemSec aigaRElemSec : aigaRElemSecs){
			lists.add(aigaRElemSec.getElemId());
		}
		
		if(lists.size()!=0){
			criteria = DetachedCriteria.forClass(AigaTestElem.class);
			criteria.add(Restrictions.in("elemId", lists));
			AigaTestElem[] aigaTestElems = aigaTestElemDAO.getAigaTestElem(criteria);
			for(AigaTestElem aigaTestElem : aigaTestElems){
				JSONObject json = new JSONObject();
				json.put("id", aigaTestElem.getElemId()+new Date().getTime()+((int)(Math.random()*100000)));
				json.put("parentId", secId);
				json.put("text", "");
				json.put("expanded", false);
				json.put("leaf", false);
				json.put("value", "0");
				for(AigaRElemSec aigaRElemSec : aigaRElemSecs){
					if(aigaRElemSec.getElemId().equals(aigaTestElem.getElemId())){
						json.put("value", aigaRElemSec.getSubElemIds()==null||aigaRElemSec.getSubElemIds().equals("")?"0":aigaRElemSec.getSubElemIds());
						break;
					}
				}
				json.put("type", "elem");
				json.put("elemId", aigaTestElem.getElemId());
				json.put("elemTag", aigaTestElem.getElemTag());
				json.put("elemName", aigaTestElem.getElemName());
				json.put("elemSysAchieveType", aigaTestElem.getElemSysAchieveType());
				json.put("applicateSys", aigaTestElem.getApplicateSys());
				json.put("isGlobalElem", aigaTestElem.getIsGlobalElem());
				json.put("sysId", aigaTestElem.getSysId());
				
				array.add(json);
			}
		}
		return array;
	}

	@Override
	public JSONArray getAigaSubElemBySubIds(String subIds) throws Exception {
		// TODO Auto-generated method stub
		JSONArray array = new JSONArray();
		if(subIds!=null&&subIds.length()>0){
			List<Integer> lists = new ArrayList<Integer>();
			String[] subElemIds = subIds.split(",");
			for(String subElemId : subElemIds){
				lists.add(Integer.valueOf(subElemId));
			}
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaTestSubElem.class);
			criteria.add(Restrictions.in("subElemId", lists));
			AigaTestSubElem[] aigaTestSubElems = aigaTestSubElemDAO.getTestSubElem(criteria);
			for(AigaTestSubElem aigaTestSubElem : aigaTestSubElems){
				JSONObject json = new JSONObject();
				json.put("id", aigaTestSubElem.getSubElemId()+new Date().getTime()+((int)(Math.random()*100000)));
				json.put("parentId", aigaTestSubElem.getElemId());
				json.put("text", "");
				json.put("expanded", false);
				json.put("leaf", true);
				json.put("value", aigaTestSubElem.getSubElemId());
				json.put("type", "subelem");
				json.put("subElemId", aigaTestSubElem.getSubElemId());
				json.put("elemId", aigaTestSubElem.getElemId());
				json.put("elemValue", aigaTestSubElem.getElemValue());
				json.put("elemTestLogic", aigaTestSubElem.getElemTestLogic());
				json.put("takeValueMethod", aigaTestSubElem.getTakeValueMethod());
				
				array.add(json);
			}
		}
		return array;
	}

	@Override
	public JSONArray getAigaSeceneShowByFunId(Integer funId) throws Exception {
		JSONArray array = new JSONArray();
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaFunCaseRela.class);
		criteria.add(Restrictions.eq("folderId", funId));
		AigaFunCaseRela[] aigaFunCaseRelas = aigaFunCaseRelaDAO.getAigaCaseRelaByCriteria(criteria);
		Map<Integer,Integer> map = new HashMap<Integer,Integer>();
		if(null!=aigaFunCaseRelas && aigaFunCaseRelas.length>0){
			for(int i=0;i<aigaFunCaseRelas.length;i++){
				criteria = DetachedCriteria.forClass(AigaInstCase.class);
				criteria.add(Restrictions.eq("caseId", aigaFunCaseRelas[i].getCaseId()));
				criteria.addOrder(Order.asc("caseId"));
				AigaCase[] aigaCases = aigaCaseDAO.getAigaCaseByCriteria(criteria);
				if(null!=aigaCases && aigaCases.length>0){
					if(StringUtils.isNotBlank(aigaCases[0].getSecId().toString())){
						map.put(aigaCases[0].getSecId(), aigaCases[0].getSecId());
					}
				}
			}
		}
		Object[] secIds = map.keySet().toArray();
		if(StringUtils.isNotBlank(secIds.toString())){
			criteria = DetachedCriteria.forClass(AigaSecene.class);
			criteria.add(Restrictions.in("secId", secIds));
			criteria.addOrder(Order.asc("secOrder"));
			AigaSecene[] aigaSecenes = aigaSeceneDAO.getSecene(criteria);
			for(AigaSecene aigaSecene : aigaSecenes){
				JSONObject json = new JSONObject();
				json.put("constantId", aigaSecene.getSecId()+new Date().getTime());
				json.put("categoryName", "secene_show");
				json.put("category", "SECENE_SHOW");
				json.put("show", aigaSecene.getSeceneName());
				json.put("value", aigaSecene.getSecId());
				json.put("other1", "");
				json.put("other2", "");
				json.put("memo", "");
				array.add(json);
			}
		}
		
		return array;
	}

	@Override
	public JSONArray getAigaSubElemShowByFunId(Integer funId) throws Exception {
		// TODO Auto-generated method stub
		JSONArray array = new JSONArray();
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRFunElem.class);
		criteria.add(Restrictions.eq("funId", funId));
		AigaRFunElem[] aigaRFunElems = aigaRFunElemDAO.getRFunElem(criteria);
		List<Integer> elemIds = new ArrayList<Integer>();
		for(AigaRFunElem aigaRFunElem : aigaRFunElems){
			elemIds.add(aigaRFunElem.getElemId());
		}
		if(elemIds.size()>0){
			criteria = DetachedCriteria.forClass(AigaTestSubElem.class);
			criteria.add(Restrictions.in("elemId", elemIds));
			AigaTestSubElem[] aigaTestSubElems = aigaTestSubElemDAO.getTestSubElem(criteria);
			for(AigaTestSubElem aigaTestSubElem : aigaTestSubElems){
				JSONObject json = new JSONObject();
				json.put("constantId", aigaTestSubElem.getSubElemId()+new Date().getTime());
				json.put("categoryName", "sub_elem_show");
				json.put("category", "SUB_ELEM_SHOW");
				json.put("show", aigaTestSubElem.getElemValue());
				json.put("value", aigaTestSubElem.getSubElemId());
				json.put("other1", "");
				json.put("other2", "");
				json.put("memo", "");
				
				array.add(json);
			}
		}
		return array;
	}
	@Override
	public String  saveSceneAndRela(AigaSecene aigaSecene, Integer funId, String elemData,String type)
			throws Exception {
		String msg="";
		if("edit".equals(type)){
			Set<Integer> set=new HashSet<Integer>();
			if(elemData!=null&&elemData.length()>0){
				JSONObject jsonObject = JSONObject.fromObject(elemData);
				for(Object elemId : jsonObject.keySet()){
					JSONArray array = JSONArray.fromObject(jsonObject.get(elemId));
					for(Object obj:array){
						set.add(Integer.valueOf((String)obj));
					}
				}
			}
			AigaRCaseElem[] aigaRCaseElems=aigaCaseDAO.getAigaRCaseElem(" from AigaRCaseElem where caseId in (select caseId" +
					" from AigaInstCase where caseId in (select caseId from AigaFunCaseRela where folderId="+funId
					+" and relaType='owner') and secId="+aigaSecene.getSecId()+" and isDelete <> 1)");
			if(aigaRCaseElems!=null&&aigaRCaseElems.length>0&&aigaRCaseElems[0]!=null){
				for(AigaRCaseElem aigaRCaseElem:aigaRCaseElems){
					if(set.contains(aigaRCaseElem.getSubElemId())){
						continue;
					}else{
						DetachedCriteria criteria = DetachedCriteria.forClass(AigaTestSubElem.class);
						criteria.add(Restrictions.eq("subElemId", aigaRCaseElem.getSubElemId()));
						AigaTestSubElem[] aigaTestSubElems=aigaTestSubElemDAO.getTestSubElem(criteria);
						msg+=aigaTestSubElems[0].getElemValue()+",";
					}
				}
			}
		}
		if(msg.length()==0){
			this.saveAigaSecene(aigaSecene);
			Integer secId = aigaSecene.getSecId();
			
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaRElemSec.class);
			criteria.add(Restrictions.eq("secId", secId));
			criteria.add(Restrictions.eq("funId", funId));
			AigaRElemSec[] aigaRElemSecs = aigaSeceneDAO.getRElemSecene(criteria);
			for(int i=0,n=aigaRElemSecs.length;i<n;i++){
				aigaSeceneDAO.deleteRElemSec(aigaRElemSecs[i]);
			}
			if(elemData!=null&&elemData.length()>0){
				JSONObject jsonObject = JSONObject.fromObject(elemData);
				for(Object elemId : jsonObject.keySet()){
					JSONArray array = JSONArray.fromObject(jsonObject.get(elemId));
					String subElemIds = new String();
					for(int j=0,k=array.size();j<k;j++){
						if(j==k-1)
							subElemIds += array.get(j);
						else
							subElemIds += array.get(j)+",";
					}
					AigaRElemSec aigaRElemSec = new AigaRElemSec();
					aigaRElemSec.setSecId(secId);
					aigaRElemSec.setFunId(funId);
					aigaRElemSec.setElemId(Integer.valueOf(elemId.toString()));
					aigaRElemSec.setSubElemIds(subElemIds);
					
					aigaSeceneDAO.saveRElemSec(aigaRElemSec);
				}
			}
		}else{
			msg=msg.substring(0,msg.length()-1);
			msg="要素值<font color='red'>"+msg+"</font>已被用例使用，不能删除！";
		}
		return msg;
	}

	@Override
	public JSONArray getTestElemTreeGrid(Integer funId,Integer secId,String type)throws Exception {
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
				if(type!=null&&(type.equals("edit")||type.equals("copy"))){
					DetachedCriteria criteria2 = DetachedCriteria.forClass(AigaRElemSec.class);
					criteria2.add(Restrictions.eq("elemId", aigaTestElems[0].getElemId()));
					criteria2.add(Restrictions.eq("secId", secId));
					AigaRElemSec[] aigaRElemSec = aigaSeceneDAO.getRElemSecene(criteria2);
					if(aigaRElemSec!=null&&aigaRElemSec.length==1){
						json.put("checked", true);
						json.put("expanded", true);
					}else{
						json.put("checked", false);
						json.put("expanded", false);
					}
				}
				else{
					json.put("checked", false);
					json.put("expanded", false);
				}
				
				array.add(json);
			}
		}
		return array;
	}

	@Override
	public JSONArray getSubTestElemTreeGrid(Integer testElemId,Integer secId, String type)throws Exception {
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
			DetachedCriteria criteria2 = DetachedCriteria.forClass(AigaRElemSec.class);
			criteria2.add(Restrictions.eq("elemId", testElemId));
			criteria2.add(Restrictions.eq("secId", secId));
			AigaRElemSec[] aigaRElemSec = aigaSeceneDAO.getRElemSecene(criteria2);
			if(aigaRElemSec!=null&&aigaRElemSec.length==1){
				boolean isSelect = false;
				String subElemIds = aigaRElemSec[0].getSubElemIds();
				if(subElemIds!=null){
					String[] subElemId = subElemIds.split(",");
					for(String subId:subElemId){
						if(subId.equals(aigaTestSubElem.getSubElemId().toString())){
							isSelect = true;
							break;
						}
					}
				}
				json.put("checked", isSelect);
			}else
				json.put("checked", false);
			array.add(json);
		}
		return array;
	}

	@Override
	public void deleteSecAndRela(String secIds) throws Exception {
		// TODO Auto-generated method stub
		if(secIds!=null&&secIds.length()>0){
			String[] secId = secIds.split(",");
			for(String id:secId){
				DetachedCriteria criteria = DetachedCriteria.forClass(AigaSecene.class);
				criteria.add(Restrictions.eq("secId", Integer.valueOf(id)));
				AigaSecene[] aigaSecenes = aigaSeceneDAO.getSecene(criteria);
				if(aigaSecenes!=null&&aigaSecenes.length==1)
					aigaSeceneDAO.deleteSecene(aigaSecenes[0]);
				criteria = DetachedCriteria.forClass(AigaRElemSec.class);
				criteria.add(Restrictions.eq("secId", Integer.valueOf(id)));
				AigaRElemSec[] aigaRElemSecs = aigaSeceneDAO.getRElemSecene(criteria);
				for(AigaRElemSec aigaRElemSec : aigaRElemSecs){
					aigaSeceneDAO.deleteRElemSec(aigaRElemSec);
				}
			}
		}
	}

	@Override
	public void saveSecOrder(String orderJson, Integer funID) throws Exception {
		// TODO Auto-generated method stub
		if(orderJson!=null&&orderJson.length()>0){
			JSONArray array = JSONArray.fromObject(orderJson);
			for(int i=0,n=array.size();i<n;i++){
				JSONObject jsonObject = JSONObject.fromObject(array.get(i));
				Iterator iterator = jsonObject.keys();
				String id = (String)iterator.next();
				Pattern pattern = Pattern.compile("[0-9]*"); 
				String order = "";
				if(pattern.matcher(id).matches())    
					order = jsonObject.getString(id);
				else{
					if(iterator.hasNext()){
						id = (String)iterator.next();
						if(pattern.matcher(id).matches()){
							order = jsonObject.getString(id);
						}else
							throw new Exception("缺少场景顺序信息");
					}else
						throw new Exception("缺少场景顺序信息");
				}
				DetachedCriteria criteria = DetachedCriteria.forClass(AigaSecene.class);
				criteria.add(Restrictions.eq("secId", Integer.valueOf(id)));
				AigaSecene[] aigaSecenes = aigaSeceneDAO.getSecene(criteria);
				if(aigaSecenes.length==1){
					aigaSecenes[0].setSecOrder(Integer.valueOf(order));
					aigaSeceneDAO.saveSecene(aigaSecenes[0]);
				}
				JSONArray elemOrder = jsonObject.getJSONArray("elemOrder");
				for(int j=0,z=elemOrder.size();j<z;j++){
					JSONObject elemJson = JSONObject.fromObject(elemOrder.get(j));
					Iterator elemIter = elemJson.keys();
					String elemId = (String)elemIter.next();
					String elemOrdeString = elemJson.getString(elemId);
					DetachedCriteria criteria2 = DetachedCriteria.forClass(AigaRElemSec.class);
					criteria2.add(Restrictions.eq("elemId", Integer.valueOf(elemId)));
					criteria2.add(Restrictions.eq("funId", funID));
					criteria2.add(Restrictions.eq("secId", Integer.valueOf(id)));
					AigaRElemSec[] aigaRElemSecs = aigaSeceneDAO.getRElemSecene(criteria2);
					if(aigaRElemSecs!=null&&aigaRElemSecs.length==1){
						aigaRElemSecs[0].setElemOrder(Integer.valueOf(elemOrdeString));
						aigaSeceneDAO.saveRElemSec(aigaRElemSecs[0]);
					}
				}
				
			}
		}
	}

	@Override
	public String getDeleteSecMsg(String secIds) throws Exception {
		// TODO Auto-generated method stub
		String msg = "";
		List<String> msgs = new ArrayList<String>();
		if(secIds!=null&&secIds.length()>0){
			AigaSecene[] aigaSecenes=aigaSeceneDAO.getSeceneBySql("from AigaSecene where secId in " +
					" (select distinct secId from AigaInstCase where secId in ("+secIds+")) and isDelete<>1");
			if(aigaSecenes!=null&&aigaSecenes.length>0&&aigaSecenes[0]!=null){
				for(AigaSecene aigaSecene:aigaSecenes){
					msgs.add(aigaSecene.getSeceneName());
				}
			}
//			String[] secId = secIds.split(",");
//			for(String id : secId){
//				DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstCase.class);
//				criteria.add(Restrictions.eq("secId", Integer.valueOf(id)));
//				AigaCase[] aigaCases = aigaCaseDAO.getAigaCaseByCriteria(criteria);
//				if(aigaCases!=null&&aigaCases.length>0){
//					criteria = DetachedCriteria.forClass(AigaSecene.class);
//					criteria.add(Restrictions.eq("secId", Integer.valueOf(id)));
//					AigaSecene[] aigaSecenes = aigaSeceneDAO.getSecene(criteria);
//					if(aigaSecenes==null||aigaSecenes.length!=1)
//						throw new Exception("查询不到相应的场景信息，场景ID:"+id);
//					msgs.add(aigaSecenes[0].getSeceneName());
//				}
//			}
		}	
		if(msgs.size()>0){
			msg += "选中的场景<font color=\"red\">";
			for(int i=0,n=msgs.size();i<n;i++){
				if(i==n-1)
					msg += msgs.get(i);
				else
					msg += msgs.get(i)+",";
			}
			msg += "</font>已被用例关联，不能删除！";
		}
		return msg;
	}
	
	public AigaHisSecene[] getHisSeceneBySql(String querySql) throws Exception {
		return aigaSeceneDAO.getHisSeceneBySql(querySql);
	}
	@Override
	public AigaSecene[] getSeceneBySql(String querySql) throws Exception {
		return aigaSeceneDAO.getSeceneBySql(querySql);
	}
}
