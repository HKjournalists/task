package com.asiainfo.aiga.userCase.service.impl;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.asiainfo.aiga.caseLabelRela.bo.AigaCaseLabelRela;
import com.asiainfo.aiga.collection.bo.AigaCaseCollection;
import com.asiainfo.aiga.collection.dao.IAigaCaseCollectionDAO;
import com.asiainfo.aiga.common.DynamicBean;
import com.asiainfo.aiga.common.helper.CommonHelper;
import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.component.bo.AigaComponent;
import com.asiainfo.aiga.component.bo.extend.AigaInstComponent;
import com.asiainfo.aiga.component.dao.IAigaComponentDAO;
import com.asiainfo.aiga.funCaseRela.bo.AigaFunCaseRela;
import com.asiainfo.aiga.funCaseRela.bo.AigaHisFunCaseRela;
import com.asiainfo.aiga.funCaseRela.dao.IAigaFunCaseRelaDAO;
import com.asiainfo.aiga.funCaseRela.service.IAigaFunCaseRelaSV;
import com.asiainfo.aiga.manualTask.bo.AigaManualTask;
import com.asiainfo.aiga.manualTask.dao.IAigaManualTaskDao;
import com.asiainfo.aiga.node_view.bo.NodeView;
import com.asiainfo.aiga.node_view.dao.IAigaNodeViewDAO;
import com.asiainfo.aiga.r_case_comp.bo.AigaRCaseComp;
import com.asiainfo.aiga.r_case_comp.bo.extend.AigaBaseRCaseComp;
import com.asiainfo.aiga.r_case_comp.bo.extend.AigaInstRCaseComp;
import com.asiainfo.aiga.r_case_comp.dao.IAigaRCaseCompDAO;
import com.asiainfo.aiga.r_collect_case.bo.AigaRCollectCase;
import com.asiainfo.aiga.r_collect_case.bo.AigaRFunCase;
import com.asiainfo.aiga.r_collect_case.bo.extend.AigaInstRCollectCase;
import com.asiainfo.aiga.r_collect_case.dao.IAigaRCollectCaseDAO;
import com.asiainfo.aiga.r_collect_case.dao.IAigaRFunCaseDAO;
import com.asiainfo.aiga.r_elem_case.bo.AigaRElemCase;
import com.asiainfo.aiga.r_elem_case.dao.IAigaRElemCaseDAO;
import com.asiainfo.aiga.requisition.bo.AigaRequisition;
import com.asiainfo.aiga.requisition.dao.IAigaRequisitionDAO;
import com.asiainfo.aiga.userCase.bo.AigaAutotestParams;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.bo.AigaHisCase;
import com.asiainfo.aiga.userCase.bo.AigaRCaseElem;
import com.asiainfo.aiga.userCase.bo.AigaRElemSec;
import com.asiainfo.aiga.userCase.bo.extend.AigaBaseCase;
import com.asiainfo.aiga.userCase.bo.extend.AigaInstCase;
import com.asiainfo.aiga.userCase.dao.IAigaAutotestParamsDAO;
import com.asiainfo.aiga.userCase.dao.IAigaCaseDAO;
import com.asiainfo.aiga.userCase.dao.IAigaRFunElemDAO;
import com.asiainfo.aiga.userCase.dao.IAigaSeceneDAO;
import com.asiainfo.aiga.userCase.service.IAigaCaseSV;

/**
 * Created on 2014-6-23
 * <p>Description: []</p>
*/

public class AigaCaseSVImpl implements IAigaCaseSV
{ 
	private IAigaCaseDAO caseDAO;
	private IAigaComponentDAO compDAO;
	private IAigaRCaseCompDAO rCaseCompDAO;
	private IAigaRCollectCaseDAO rCollectCaseDAO;
	private IAigaCaseCollectionDAO collectionDAO;
	private IAigaRequisitionDAO requisitionDAO;
	private IAigaNodeViewDAO nodeDAO;
	private IAigaRElemCaseDAO rElemCaseDAO;
	private IAigaManualTaskDao aigaManualTaskDao;
	private IAigaAutotestParamsDAO aigaAutotestParamsDAO;
	
	private IAigaFunCaseRelaDAO aigaFunCaseRelaDao;
	
	private IAigaRFunElemDAO aigaRFunElemDAO;
	private IAigaSeceneDAO aigaSeceneDAO;
	
	private IAigaRFunCaseDAO rFunCaseDAO;
	
	private IAigaFunCaseRelaSV aigaFunCaseRelaSV;
	public void setAigaRFunElemDAO(IAigaRFunElemDAO aigaRFunElemDAO) {
		this.aigaRFunElemDAO = aigaRFunElemDAO;
	}

	public void setAigaAutotestParamsDAO(
			IAigaAutotestParamsDAO aigaAutotestParamsDAO) {
		this.aigaAutotestParamsDAO = aigaAutotestParamsDAO;
	}

	public void setAigaManualTaskDao(IAigaManualTaskDao aigaManualTaskDao) {
		this.aigaManualTaskDao = aigaManualTaskDao;
	}

	public void setrElemCaseDAO(IAigaRElemCaseDAO rElemCaseDAO) {
		this.rElemCaseDAO = rElemCaseDAO;
	}

	public void setNodeDAO(IAigaNodeViewDAO nodeDAO)
	{
		this.nodeDAO = nodeDAO;
	}

	public void setrCollectCaseDAO(IAigaRCollectCaseDAO rCollectCaseDAO)
	{
		this.rCollectCaseDAO = rCollectCaseDAO;
	}

	public void setCollectionDAO(IAigaCaseCollectionDAO collectionDAO)
	{
		this.collectionDAO = collectionDAO;
	}

	public void setrCaseCompDAO(IAigaRCaseCompDAO rCaseCompDAO)
	{
		this.rCaseCompDAO = rCaseCompDAO;
	}

	public void setCompDAO(IAigaComponentDAO compDAO)
	{
		this.compDAO = compDAO;
	}

	public void setCaseDAO(IAigaCaseDAO caseDAO)
	{
		this.caseDAO = caseDAO;
	}

	public void setRequisitionDAO(IAigaRequisitionDAO requisitionDAO)
	{
		this.requisitionDAO = requisitionDAO;
	}
	
	public void setAigaSeceneDAO(IAigaSeceneDAO aigaSeceneDAO) {
		this.aigaSeceneDAO = aigaSeceneDAO;
	}


	public void setAigaFunCaseRelaSV(IAigaFunCaseRelaSV aigaFunCaseRelaSV) {
		this.aigaFunCaseRelaSV = aigaFunCaseRelaSV;
	}
	
	public AigaCase[] getAigaCaseById(Integer aigaId,Class className) throws Exception {

		DetachedCriteria criteria =  DetachedCriteria.forClass(className);
		criteria.add(Restrictions.eq("caseId", aigaId));
		AigaCase[] aigaCases = caseDAO.getAigaCaseByCriteria(criteria);
		return aigaCases;
	}

	public void saveAigaCase(AigaCase value) throws Exception {
		caseDAO.saveOrUpdate(value);
	}

	public AigaCase[] getAigaCaseAll(Class className) throws Exception
	{
	
		return caseDAO.getAigaCaseBySql("from "+className.getName());
	}

	public void deleteAigaCase(String caseId,Class className) throws Exception
	{
		AigaCase[] aigaCases = this.getAigaCaseById(Integer.valueOf(caseId),className);
		if(aigaCases.length==1){
			caseDAO.delete(aigaCases[0]);
			DetachedCriteria criteria = DetachedCriteria.forClass(className);
			criteria.add(Restrictions.eq("caseId", Integer.valueOf(caseId)));
			AigaRCaseComp[] aigaRCaseComps = rCaseCompDAO.getAigaRCaseCompByCriteria(criteria);
			for(AigaRCaseComp aigaRCaseComp : aigaRCaseComps)
				rCaseCompDAO.delete(aigaRCaseComp);
		}
	}
	/*unWrite*/
	public AigaComponent[] getCompsByCaseId(String caseId) throws Exception{
		
		String hql="from AigaRCaseComp as a, AigaComponent as b where a.compId=b.compId and a.caseId='"+caseId+"' order by a.r_order";
		
		System.out.println("=======>>>"+hql);
		return compDAO.getAigaComponentBySql(hql);
		
	}

	
	public AigaComponent[] getCompsAll(Class clazz) throws Exception
	{
		return compDAO.getAigaComponentBySql("from "+clazz.getName());
	}

	
	public AigaComponent getCompsByCompId(String compId,Class clazz) throws Exception
	{
		AigaComponent[] compArray=compDAO.getAigaComponentBySql("from "+clazz.getName()+" where compId='"+compId+"'");
		if(compArray!=null &&compArray.length==1){
			return compArray[0];
		}
		return null;
	}
	
	public boolean saveCase(AigaCase aigaCase,String[] compIdArray,String[] inValArray,String[] expectValArray,String[] hingeArray,String[] arguName,String[] manualTaskId){
		try {
//			caseDAO.saveOrUpdate(aigaCase);
			AigaRCaseComp[] rCaseComps = rCaseCompDAO
					.getAigaRCaseCompBySql("from AigaInstRCaseComp where caseId="
							+ aigaCase.getCaseId());
			for (AigaRCaseComp r : rCaseComps) {
				rCaseCompDAO.delete(r);
			}
			for (int i = 0, n = compIdArray.length; i < n; i++) {
				try {
					String inVal = inValArray[i];
					String outVal = "";
					String expectVal = expectValArray[i];
					AigaRCaseComp aValue = new AigaInstRCaseComp(
							aigaCase.getCaseId(),
							Integer.parseInt(compIdArray[i]), i, inVal, outVal,
							expectVal, hingeArray[i], expectVal,arguName[i],Integer.parseInt(manualTaskId[i]));
					rCaseCompDAO.saveOrUpdate(aValue);
				} catch (Exception e) {
					e.printStackTrace();
					return false;
				}
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		return true;
	}

	public AigaCaseCollection unionCase(AigaCaseCollection aigaCaseCollection,String[] strings){
		try
		{
			collectionDAO.saveOrUpdate(aigaCaseCollection);
		}
		catch (Exception e1)
		{
		
			e1.printStackTrace();
			return null;
		}

		for(int i=0,n=strings.length;i<n;i++){
			try
			{
				AigaRCollectCase aValue=new AigaInstRCollectCase(aigaCaseCollection.getCollectionId(),Integer.parseInt(strings[i]),i);
			
			rCollectCaseDAO.saveOrUpdate(aValue);
			}
			catch (Exception e)
			{
				e.printStackTrace();
				return null;
			}
		}
		return aigaCaseCollection;
	}


	public AigaCase[] getAigaCaseByParentId(Integer parentId,Class clazz) throws Exception
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(clazz);
		criteria.add(Restrictions.eq("parentId", parentId));
		return caseDAO.getAigaCaseByCriteria(criteria);
	}

	
	public AigaCase[] getAigaCaseBySql(String querySql) throws Exception {
		return caseDAO.getAigaCaseBySql(querySql);
	}
	
	public List getAigaCaseByHql(String hql)throws Exception{
		return caseDAO.getCaseByHql(hql);
	}

	public String getAigaCompByCaseId(String caseId,String taskId) throws Exception {
		// TODO Auto-generated method stub
		AigaCase[] aigaCases = this.getAigaCaseById(Integer.valueOf(caseId), AigaInstCase.class);
		if(aigaCases.length!=1)
			throw new Exception("查询到的用例不唯一");
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstRCaseComp.class);
		criteria.add(Restrictions.eq("caseId", Integer.valueOf(caseId)));
		criteria.addOrder(Order.asc("ROrder"));
		AigaRCaseComp[] aigaRCaseComps = rCaseCompDAO.getAigaRCaseCompByCriteria(criteria);
		if(aigaRCaseComps.length<=0)
			throw new Exception("未查找到用例与组件关联关系");
		JSONObject json = new JSONObject();
		json.put("id", caseId);
		json.put("taskId",taskId);
		json.put("url", aigaCases[0].getUrl());
		json.put("casename", aigaCases[0].getCaseName());
		JSONArray steps = new JSONArray();
		for(AigaRCaseComp aigaRCaseComp : aigaRCaseComps){
			String compName = "";
			String arguName = "";
			DetachedCriteria compoCriteria = DetachedCriteria.forClass(AigaInstComponent.class);
			compoCriteria.add(Restrictions.eq("compId", aigaRCaseComp.getCompId()));
			AigaComponent[] component = compDAO.getAigaComponentByCriteria(compoCriteria);
			if(component.length!=1)
				throw new Exception("未查找到组件信息");
			arguName = aigaRCaseComp.getArguName();
			Integer parentId = aigaRCaseComp.getCompId();
			while(!parentId.equals(1)){
				DetachedCriteria compCriteria = DetachedCriteria.forClass(AigaInstComponent.class);
				compCriteria.add(Restrictions.eq("compId", parentId));
				AigaComponent[] components = compDAO.getAigaComponentByCriteria(compCriteria);
				if(components.length!=1)
					throw new Exception("未查找到组件信息");
				compName = components[0].getCompName()+"."+compName;
				parentId = components[0].getParentId();
			}
			if(compName.length()!=0)
				compName = compName.substring(0, compName.length()-1);
			JSONObject step = new JSONObject();
			step.put("component", compName);
			if(aigaRCaseComp.getInVal()!=null&&aigaRCaseComp.getInVal().length()!=0){
				JSONArray inValArray = JSONArray.fromObject(aigaRCaseComp.getInVal());
				JSONObject arguJson = new JSONObject();
				for(int i=0,n=inValArray.size();i<n;i++){
					JSONObject value = new JSONObject();
					JSONObject valueArray = JSONObject.fromObject(inValArray.get(i));
					if(valueArray!=null){
						value.put("value", valueArray.get("value"));
						value.put("expect", aigaRCaseComp.getExpectVal());
						arguJson.put(valueArray.get("key"), value);
					}
				}
				step.put("arguments",arguJson);
			}else
				step.put("arguments","");
			steps.add(step);
		}
		json.put("steps", steps);
		return json.toString();
	}

	public AigaRequisition[] getAigaRequisitionById(Integer requisitionId) throws Exception
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRequisition.class);
		criteria.add(Restrictions.eq("reqId", requisitionId));
		return requisitionDAO.getAigaRequisitionByCriteria(criteria);
	}

	public JSONArray getCaseCompsByCaseId(String caseId,String manualTaskId) throws Exception
	{
		JSONArray retObjs =new JSONArray();
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstRCaseComp.class);
		criteria.add(Restrictions.eq("caseId", Integer.parseInt(caseId)));
		criteria.add(Restrictions.eq("manualTaskId", Integer.parseInt(manualTaskId)));
		criteria.addOrder(Order.asc("ROrder"));
		AigaRCaseComp[] aigaRCaseComps=rCaseCompDAO.getAigaRCaseCompByCriteria(criteria);
		for(AigaRCaseComp aigaRCaseComp:aigaRCaseComps){
			DetachedCriteria criteria2 = DetachedCriteria.forClass(AigaInstComponent.class);
			criteria2.add(Restrictions.eq("compId", aigaRCaseComp.getCompId()));
			AigaComponent[] aigaComponents = compDAO.getAigaComponentByCriteria(criteria2);
			if(aigaComponents.length!=1)
				throw new Exception("组件信息缺失，组件ID"+aigaRCaseComp.getCompId());
			JSONObject compObject = new JSONObject();
			compObject.put("id", aigaRCaseComp.getRefId());
			compObject.put("text", aigaComponents[0].getCompName());
			compObject.put("leaf", true);
			
			compObject.put("refId", aigaRCaseComp.getRefId());
			compObject.put("compId", aigaRCaseComp.getCompId());
			compObject.put("compName", aigaComponents[0].getCompName());
			compObject.put("inVal", aigaRCaseComp.getInVal());
			compObject.put("expectVal", aigaRCaseComp.getExpectVal());
			compObject.put("compDesc", aigaComponents[0].getCompDesc());
			compObject.put("manualTaskId", aigaRCaseComp.getManualTaskId());
			retObjs.add(compObject);
		}
		return  retObjs;
	}
	public AigaCaseCollection[] getCaseCollectionById(String collectId,Class clazz)throws Exception{
		DetachedCriteria criteria = DetachedCriteria.forClass(clazz);
		criteria.add(Restrictions.eq("collectId", Integer.parseInt(collectId)));
		return collectionDAO.getAigaCaseCollectionByCriteria(criteria);
	}

	public NodeView[] getNodeViewByKeyword(String keyword,String nodeTable) throws Exception
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(NodeView.class);
		criteria.add(Expression.like("id.nodeName","%"+keyword+"%"));
		criteria.add(Expression.eq("id.nodeTable",nodeTable));
		return nodeDAO.getNodeViewByKeyword(criteria);
		
	}
	
	public NodeView[] getNodeViewsByCondition(Map map) throws Exception
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(NodeView.class);
		Iterator it=map.entrySet().iterator();
		while(it.hasNext()){
			 Map.Entry entry = (Map.Entry)it.next();
			String key=(String) entry.getKey();
			criteria.add(Restrictions.eq(key,map.get(key) ));
		}

		return nodeDAO.NodeView(criteria);
	}

	
	public NodeView[] getNodeViewByKeyword(String keyword) throws Exception
	{
		DetachedCriteria criteria = DetachedCriteria.forClass(NodeView.class);
		criteria.add(Expression.like("id.nodeName","%"+keyword+"%"));
		return nodeDAO.getNodeViewByKeyword(criteria);
		
	}

	public AigaCase[] getAigaCaseByCaseIds(String caseIds, Class clazz)
			throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(clazz);
		String[] caseId = caseIds.split(",");
		List<Integer> caseList = new ArrayList<Integer>();
		for(String cases:caseId){
			caseList.add(Integer.valueOf(cases));
		}
		criteria.add(Restrictions.in("caseId", caseList));
		AigaCase[] aigaCases = caseDAO.getAigaCaseByCriteria(criteria);
		return aigaCases;
	}
	
	public Object[] getAigaExtBySubTaskId(Integer subTaskId,Class clazz) throws Exception {

		String HQL=" FROM AigaRFunCase t where t.funId in (SELECT a.funId FROM AigaFunPoint a ";
		if(!subTaskId.equals(""))HQL+="where subTaskId ="+subTaskId;
		HQL	+=")  and exists (select 1 from AigaInstCase b where b.caseId=t.caseId and b.isDelete<>1) order by t.caseId";
		AigaRFunCase[] aigaRFunCases=rFunCaseDAO.getRFunCaseBySql(HQL);
		Object[] retObjects=new Object[aigaRFunCases.length];
		if(aigaRFunCases.length>0){
	
		for(int i=0,n=aigaRFunCases.length;i<n;i++){
			if(aigaRFunCases[i].getRefValue()==null || aigaRFunCases[i].getRefValue().length()!=3){
				aigaRFunCases[i].setRefValue("000");
			}
			DetachedCriteria criteria = DetachedCriteria.forClass(clazz);
			criteria.add(Restrictions.eq("caseId", aigaRFunCases[i].getCaseId()));
			AigaCase[] aigaCases = caseDAO.getAigaCaseByCriteria(criteria);
			if(aigaCases.length!=1)
				throw new Exception("用例缺失");
			Object[] objs=new Object[]{aigaRFunCases[i],aigaCases[0]};
			DynamicBean bean = new DynamicBean(objs);
			retObjects[i]=bean.getObject();
		}
		}
	
		return retObjects;
	}
	
	public AigaCaseLabelRela[] getCaseLabelRelaBySql(String querySql) throws Exception {
		return caseDAO.getCaseLabelRelaBySql(querySql);
	}
	
	public void saveCaseLabelRela(AigaCaseLabelRela value) throws Exception {
		caseDAO.saveCaseLabelRela(value);
	}
	
	public void deleteCaseLabelRela(AigaCaseLabelRela value) throws Exception {
		caseDAO.deleteCaseLabelRela(value);
	}
	
	public void savePasteCase(Integer parentId,String name,Integer caseId,AigaUser currentUser)throws Exception{
		List<AigaInstCase> aigaInstCase = caseDAO.getCaseByHql("from AigaInstCase where caseId="+caseId);
		if(aigaInstCase.size()!=1)
			throw new Exception("未查询到用例，用例ID："+caseId);
		
		AigaInstCase instCase = new AigaInstCase();
		instCase.setAuthor(currentUser.getUserName());
		instCase.setCaseDesc(aigaInstCase.get(0).getCaseDesc());
		instCase.setCaseName(name);
		instCase.setCreateTime(new Timestamp(new Date().getTime()));
		instCase.setLatestOperator(aigaInstCase.get(0).getLatestOperator());
		instCase.setFunFolderId(parentId);
		instCase.setUpdateTime(new Timestamp(new Date().getTime()));
		instCase.setUrl(aigaInstCase.get(0).getUrl());
		instCase.setAuthorNo(currentUser.getUserAccount());
		instCase.setBaseCaseId(aigaInstCase.get(0).getBaseCaseId());
		instCase.setSysLabel(aigaInstCase.get(0).getSysLabel());
		instCase.setOwnLabel(aigaInstCase.get(0).getOwnLabel());
		instCase.setStatus(1);
		instCase.setImportant(aigaInstCase.get(0).getImportant());
		instCase.setMaintenanceFac(aigaInstCase.get(0).getMaintenanceFac());
		instCase.setRegressionTest(aigaInstCase.get(0).getRegressionTest());
		instCase.setHasTest(aigaInstCase.get(0).getHasTest());
		instCase.setTestType(aigaInstCase.get(0).getTestType());
		instCase.setCaseType(aigaInstCase.get(0).getCaseType());
		instCase.setEfficiencyTest(aigaInstCase.get(0).getEfficiencyTest());
		instCase.setEfficiencyTestType(aigaInstCase.get(0).getEfficiencyTestType());
		instCase.setTeminalTest(aigaInstCase.get(0).getTeminalTest());
		this.saveAigaCase(instCase);
		
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaManualTask.class);
		criteria.add(Restrictions.eq("caseId", caseId));
		AigaManualTask[] aigaManualTasks = aigaManualTaskDao.getManualTask(criteria);
		for(AigaManualTask aigaManualTask : aigaManualTasks){
			AigaManualTask manualTask = new AigaManualTask();
			manualTask.setCaseId(instCase.getCaseId());
			manualTask.setCreateTime(new Timestamp(new Date().getTime()));
			manualTask.setPreResult(aigaManualTask.getPreResult());
			manualTask.setPreTestData(aigaManualTask.getPreTestData());
			manualTask.setTaskName(aigaManualTask.getTaskName());
			manualTask.setTaskOrder(aigaManualTask.getTaskOrder());
			manualTask.setTaskDesc(aigaManualTask.getTaskDesc());
			manualTask.setUpdateTime(new Timestamp(new Date().getTime()));
			manualTask.setDescribe(aigaManualTask.getDescribe());
			aigaManualTaskDao.saveManualTask(manualTask);
			
			criteria = DetachedCriteria.forClass(AigaInstRCaseComp.class);
			criteria.add(Restrictions.eq("caseId", caseId));
			criteria.add(Restrictions.eq("manualTaskId", aigaManualTask.getTaskId()));
			AigaRCaseComp[] aigaRCaseComps = rCaseCompDAO.getAigaRCaseCompByCriteria(criteria);
			for(AigaRCaseComp aigaRCaseComp : aigaRCaseComps){
				AigaRCaseComp rCaseComp = new AigaInstRCaseComp();
				rCaseComp.setArguName(aigaRCaseComp.getArguName());
				rCaseComp.setCaseId(instCase.getCaseId());
				rCaseComp.setCompId(aigaRCaseComp.getCompId());
				rCaseComp.setExpectVal(aigaRCaseComp.getExpectVal());
				rCaseComp.setHinge(aigaRCaseComp.getHinge());
				rCaseComp.setInVal(aigaRCaseComp.getInVal());
				rCaseComp.setRefDesc(aigaRCaseComp.getRefDesc());
				rCaseComp.setRemark(aigaRCaseComp.getRemark());
				rCaseComp.setROrder(aigaRCaseComp.getROrder());
				rCaseComp.setManualTaskId(manualTask.getTaskId());
				rCaseCompDAO.saveOrUpdate(rCaseComp);
			}
		}
		
		criteria = DetachedCriteria.forClass(AigaAutotestParams.class);
		criteria.add(Restrictions.eq("caseId", caseId));
		criteria.add(Restrictions.eq("parentId", 1));
		AigaAutotestParams[] aigaRootParams = aigaAutotestParamsDAO.getAigaAutotestParams(criteria);
		for(AigaAutotestParams aigaRootParam : aigaRootParams){
			AigaAutotestParams rootParam = new AigaAutotestParams();
			rootParam.setCaseId(instCase.getCaseId());
			rootParam.setExeSql(aigaRootParam.getExeSql());
			rootParam.setIsleaf("N");
			rootParam.setParamDesc(aigaRootParam.getParamDesc());
			rootParam.setParamName(aigaRootParam.getParamName());
			rootParam.setParamValue(aigaRootParam.getParamValue());
			rootParam.setParentId(1);
			
			aigaAutotestParamsDAO.saveAigaAutotestParams(rootParam);
			
			criteria = DetachedCriteria.forClass(AigaAutotestParams.class);
			criteria.add(Restrictions.eq("caseId", caseId));
			criteria.add(Restrictions.eq("parentId", aigaRootParam.getParamId()));
			AigaAutotestParams[] aigaParams = aigaAutotestParamsDAO.getAigaAutotestParams(criteria);
			
			for(AigaAutotestParams aigaParam : aigaParams){
				AigaAutotestParams aigaAutotestParams = new AigaAutotestParams();
				
				aigaAutotestParams.setCaseId(instCase.getCaseId());
				aigaAutotestParams.setExeSql(aigaParam.getExeSql());
				aigaAutotestParams.setIsleaf("Y");
				aigaAutotestParams.setParamDesc(aigaParam.getParamDesc());
				aigaAutotestParams.setParamName(aigaParam.getParamName());
				aigaAutotestParams.setParamValue(aigaParam.getParamValue());
				aigaAutotestParams.setParentId(rootParam.getParamId());
				
				aigaAutotestParamsDAO.saveAigaAutotestParams(aigaAutotestParams);
			}
		}
	}
	
	public AigaInstCase[] getUnApprovalCase(String staffNo)throws Exception{
		List<AigaInstCase> aigaInstCases = caseDAO.getCaseByHql("from AigaInstCase where status=1");
		return aigaInstCases.toArray(new AigaInstCase[0]);
	}

	@Override
	public void saveApprovalCase(AigaInstCase value) throws Exception {
		
		if(value.getStatus().equals(3)){
			AigaBaseCase aigaBaseCase = null;
			if(value.getBaseCaseId()!=null){
				List aigaBaseCases = caseDAO.getCaseByHql("from AigaBaseCase where caseId="+value.getBaseCaseId());
				if(aigaBaseCases.size()!=1)
					throw new Exception("未查找到用例在aiga_base_case中，caseId:"+value.getBaseCaseId());
				aigaBaseCase = (AigaBaseCase)aigaBaseCases.get(0);
			}else{
				aigaBaseCase = new AigaBaseCase();
				
				aigaBaseCase.setAuthor(value.getAuthor());
				aigaBaseCase.setAuthorNo(value.getAuthorNo());
				aigaBaseCase.setCaseDesc(value.getCaseDesc());
				aigaBaseCase.setCaseName(value.getCaseName());
				aigaBaseCase.setCreateTime(value.getCreateTime());
				aigaBaseCase.setLatestOperator(value.getLatestOperator());
				aigaBaseCase.setOwnLabel(value.getOwnLabel());
				aigaBaseCase.setFunFolderId(value.getFunFolderId());
				aigaBaseCase.setSysLabel(value.getSysLabel());
				aigaBaseCase.setUpdateTime(value.getUpdateTime());
				aigaBaseCase.setUrl(value.getUrl());
			}
			caseDAO.saveOrUpdate(aigaBaseCase);
			value.setBaseCaseId(aigaBaseCase.getCaseId());
			caseDAO.saveOrUpdate(value);
			
			List aigaBaseRCaseComps = rCaseCompDAO.getAigaRCaseByHql("from AigaBaseRCaseComp where caseId="+value.getBaseCaseId());
			for(Object aigaBaseRCaseComp : aigaBaseRCaseComps){
				AigaBaseRCaseComp baseRCaseComp = (AigaBaseRCaseComp)aigaBaseRCaseComp;
				rCaseCompDAO.delete(baseRCaseComp);
			}
			
			List aigaInstRCaseComps = rCaseCompDAO.getAigaRCaseByHql("from AigaInstRCaseComp where caseId="+value.getCaseId());
			for(Object aigaInstRCaseComp : aigaInstRCaseComps){
				AigaInstRCaseComp caseComp = (AigaInstRCaseComp)aigaInstRCaseComp;
				Integer compId = caseComp.getCompId();
				List components = compDAO.getAigaComponentByHql("from AigaInstComponent where compId="+compId);
				if(components.size()==1){
					AigaInstComponent aigaInstComponent = (AigaInstComponent)components.get(0);
					Integer baseCompId = aigaInstComponent.getBaseCompId();
					if(baseCompId!=null){
						AigaBaseRCaseComp baseRCaseComp = new AigaBaseRCaseComp();
						baseRCaseComp.setCaseId(aigaBaseCase.getCaseId());
						baseRCaseComp.setArguName(caseComp.getArguName());
						baseRCaseComp.setCompId(baseCompId);
						baseRCaseComp.setExpectVal(caseComp.getExpectVal());
						baseRCaseComp.setHinge(caseComp.getHinge());
						baseRCaseComp.setInVal(caseComp.getInVal());
						baseRCaseComp.setOutVal(caseComp.getOutVal());
						baseRCaseComp.setRefDesc(caseComp.getRefDesc());
						baseRCaseComp.setRemark(caseComp.getRemark());
						baseRCaseComp.setROrder(caseComp.getROrder());
						
						rCaseCompDAO.saveOrUpdate(baseRCaseComp);
						caseComp.setBaseRefId(baseRCaseComp.getRefId());
						rCaseCompDAO.saveOrUpdate(caseComp);
					}
				}
			}
		}else{
			this.saveAigaCase(value);
		}
	}

//	@Override
//	public void saveCaseFolder(String folderName, String caseId)
//			throws Exception {
//		// TODO Auto-generated method stub
//	    List<AigaInstCase> aigaInstCase = caseDAO.getCaseByHql("from AigaInstCase where caseId="+caseId);
//	    if(aigaInstCase.size()!=1)
//			throw new Exception("未查找到用例的文件夹");
//		if(aigaInstCase.get(0).getIsLeaf().equals('Y'))
//			throw new Exception("不可以在叶子节点添加folder");
//		String[] folderNames = folderName.split("\\.");
//		String folderId = caseId;
//		for(String name : folderNames){
//			DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstCase.class);
//			criteria.add(Restrictions.eq("parentId", Integer.valueOf(folderId)));
//			criteria.add(Restrictions.eq("caseName", name));
//			
//			AigaCase[] aigaCases =  caseDAO.getUpdateByCriteria(criteria);
//			if(aigaCases.length==0){
//				AigaInstCase folder = new AigaInstCase();
//				folder.setCaseName(name);
//				folder.setIsLeaf("N");
//				folder.setParentId(Integer.valueOf(folderId));
//				folder.setCreateTime(new Timestamp(new Date().getTime()));
//				folder.setUpdateTime(new Timestamp(new Date().getTime()));
//				
//				caseDAO.saveOrUpdate(folder);
//				folderId = folder.getCaseId().toString();
//			}else
//				folderId = aigaCases[0].getCaseId().toString();
//		}
//	}
//
//	@Override
//	public void editCaseFolder(String folderName, String caseId)
//			throws Exception {
//		// TODO Auto-generated method stub
//		String[] folderNames = folderName.split("\\.");
//		for(int i=0,n=folderNames.length;i<n;i++){
//			String folderId = caseId;
//			if(i==0){
//				List<AigaInstCase> aigaInstCase = caseDAO.getCaseByHql("from AigaInstCase where caseId="+caseId);
//				if(aigaInstCase.size()!=1)
//					throw new Exception("未查找到用例的文件夹");
//				if(aigaInstCase.get(0).getIsLeaf().equals('Y'))
//					throw new Exception("不可以在叶子节点添加folder");
//				AigaInstCase instCase = aigaInstCase.get(0);
//				instCase.setCaseName(folderNames[i]);
//				caseDAO.saveOrUpdate(instCase);
//				folderId = instCase.getCaseId().toString();
//			}else{
//				DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstCase.class);
//				criteria.add(Restrictions.eq("parentId", Integer.valueOf(caseId)));
//				criteria.add(Restrictions.eq("caseName", folderNames[i]));
//				AigaCase[] aigaCases =  caseDAO.getUpdateByCriteria(criteria);
//				if(aigaCases.length==0){
//					AigaInstCase folder = new AigaInstCase();
//					folder.setCaseName(folderNames[i]);
//					folder.setIsLeaf("N");
//					folder.setParentId(Integer.valueOf(folderId));
//					folder.setCreateTime(new Timestamp(new Date().getTime()));
//					folder.setUpdateTime(new Timestamp(new Date().getTime()));
//					
//					caseDAO.saveOrUpdate(folder);
//					folderId = folder.getCaseId().toString();
//				}else
//					folderId = aigaCases[0].getCaseId().toString();
//			}
//		}
//	}
//
//	@Override
//	public void deleteCaseFolder(String folderName, String caseId)
//			throws Exception {
//		// TODO Auto-generated method stub
//		DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstCase.class);
//		criteria.add(Restrictions.eq("parentId", Integer.valueOf(caseId)));
//		AigaCase[] aigaCases =  caseDAO.getUpdateByCriteria(criteria);
//		if(aigaCases.length==0){
//			criteria = DetachedCriteria.forClass(AigaInstCase.class);
//			criteria.add(Restrictions.eq("caseId", Integer.valueOf(caseId)));
//			AigaCase[] cases = caseDAO.getUpdateByCriteria(criteria);
//			caseDAO.delete(cases[0]);
//		}else
//			throw new Exception("节点下还有子节点，不可以删除");
//	}

	@Override
	public void saveCaseOrder(String caseIds) throws Exception {
		// TODO Auto-generated method stub
		if(caseIds!=null||!caseIds.equals("")){
			String[] caseElemId = caseIds.split(",");
			for(int i=0,n=caseElemId.length;i<n;i++){
				String elemTag = caseElemId[i].split(":")[0];
				String caseId = caseElemId[i].split(":")[1];
				DetachedCriteria criteria = DetachedCriteria.forClass(AigaRElemCase.class);
				criteria.add(Restrictions.eq("caseId", Integer.valueOf(caseId)));
				criteria.add(Restrictions.eq("elemTag", elemTag));
				AigaRElemCase[] aigaRElemCases = rElemCaseDAO.getRElemCaseByCriteria(criteria);
				if(aigaRElemCases.length!=1)
					throw new Exception("查询到的用例与要素关联关系不唯一,caseId:"+caseId+",elemTag:"+elemTag);
				aigaRElemCases[0].setCaseOrder(i);
				rElemCaseDAO.saveOrUpdate(aigaRElemCases[0]);
			}
		}
	}

	@Override
	public void saveBatchApprovalCase(String caseIds,AigaUser currentUser) throws Exception {
		String[] caseId = caseIds.split(",");
		for(String id : caseId){
			List<AigaInstCase> aigaInstCase = caseDAO.getCaseByHql("from AigaInstCase where caseId="+id);
			if(aigaInstCase==null||aigaInstCase.size()==0)
				continue;
			AigaInstCase instCase = aigaInstCase.get(0);
			instCase.setStatus(3);
			instCase.setApprovalName(currentUser.getUserName());
			instCase.setApprovalPsn(currentUser.getUserAccount());
			this.saveApprovalCase(instCase);
		}
	}

	@Override
	public void saveImportCase(String caseJson) throws Exception {
		// TODO Auto-generated method stub
		AigaInstComponent aigaInstComponent = null;
		AigaInstCase aigaInstCase = null;
		JSONObject testCase = JSONObject.fromObject(caseJson);
		String url = testCase.get("url").toString();
		String name = testCase.getString("name");
		Integer caseFolderId = 1;
		String[] caseNames = name.split("\\.");
		for(int j=0,k=caseNames.length;j<k;j++){
			if(j==caseNames.length-1){
				DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstCase.class);
				criteria.add(Restrictions.eq("parentId", caseFolderId));
				criteria.add(Restrictions.eq("caseName", caseNames[j]));
				AigaCase[] aigaCases = caseDAO.getAigaCaseByCriteria(criteria);
				if(aigaCases.length==0)
					aigaInstCase = new AigaInstCase();
				else
					aigaInstCase = (AigaInstCase)aigaCases[0];
				aigaInstCase.setUrl(url);
				aigaInstCase.setCaseName(caseNames[j]);
				aigaInstCase.setStatus(1);
				aigaInstCase.setAuthor("UNKNOW");
				aigaInstCase.setAuthorNo("UNKNOW");
				aigaInstCase.setCreateTime(new Date());
				aigaInstCase.setUpdateTime(new Date());
				aigaInstCase.setFunFolderId(caseFolderId);
				caseDAO.saveOrUpdate(aigaInstCase);
			}else{
				DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstCase.class);
				criteria.add(Restrictions.eq("parentId", caseFolderId));
				criteria.add(Restrictions.eq("caseName", caseNames[j]));
				AigaCase[] aigaCases = caseDAO.getAigaCaseByCriteria(criteria);
				if(aigaCases.length==0){
					AigaInstCase caseFolder = new AigaInstCase();
					caseFolder.setCaseName(caseNames[j]);
					caseFolder.setStatus(3);
					caseFolder.setAuthor("UNKNOW");
					caseFolder.setAuthorNo("UNKNOW");
					caseFolder.setCreateTime(new Date());
					caseFolder.setUpdateTime(new Date());
					caseFolder.setFunFolderId(caseFolderId);
					caseDAO.saveOrUpdate(caseFolder);
					caseFolderId = caseFolder.getCaseId();
				}else{
					caseFolderId = aigaCases[0].getCaseId();
				}
			}
		}
		
		JSONArray comps = JSONArray.fromObject(testCase.get("steps"));
		for(int i=0,n=comps.size();i<n;i++){
			JSONObject comp = JSONObject.fromObject(comps.get(i));
			String compName = comp.getString("component");
			Integer folderId =  1;
			String[] names = compName.split("\\.");
			for(int j=0,k=names.length;j<k;j++){
				if(j==names.length-1){
					DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstComponent.class);
					criteria.add(Restrictions.eq("parentId", folderId));
					criteria.add(Restrictions.eq("compName", names[j]));
					AigaComponent[] aigaInstComponents = compDAO.getAigaComponentByCriteria(criteria);
					if(aigaInstComponents.length==0)
						aigaInstComponent = new AigaInstComponent();
					else
						aigaInstComponent = (AigaInstComponent)aigaInstComponents[0];
					aigaInstComponent.setCompName(names[j]);
					aigaInstComponent.setCreateTime(new Timestamp(new Date().getTime()));
					aigaInstComponent.setUpdateTime(new Timestamp(new Date().getTime()));
					aigaInstComponent.setAuthor("UNKNOW");
					aigaInstComponent.setAuthorNo("UNKNOW");
					aigaInstComponent.setApprovalPsn("UNKNOW");
					aigaInstComponent.setApprovalName("UNKNOW");
					aigaInstComponent.setUpdateTime(new Timestamp(new Date().getTime()));
					aigaInstComponent.setCreateTime(new Timestamp(new Date().getTime()));
					aigaInstComponent.setIsLeaf("Y");
					aigaInstComponent.setPermission(1);
					aigaInstComponent.setParentId(folderId);
					compDAO.saveOrUpdate(aigaInstComponent);
				}else{
					DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstComponent.class);
					criteria.add(Restrictions.eq("parentId", folderId));
					criteria.add(Restrictions.eq("compName", names[j]));
					AigaComponent[] aigaInstComponents = compDAO.getAigaComponentByCriteria(criteria);
					if(aigaInstComponents.length==0){
						AigaInstComponent compFolder = new AigaInstComponent();
						compFolder.setCompName(names[j]);
						compFolder.setParentId(folderId);
						compFolder.setAuthor("UNKNOW");
						compFolder.setAuthorNo("UNKNOW");
						compFolder.setApprovalPsn("UNKNOW");
						compFolder.setApprovalName("UNKNOW");
						compFolder.setUpdateTime(new Timestamp(new Date().getTime()));
						compFolder.setCreateTime(new Timestamp(new Date().getTime()));
						compFolder.setIsLeaf("N");
						compFolder.setPermission(0);
						compFolder.setParentId(folderId);
						compDAO.saveOrUpdate(compFolder);
						folderId = compFolder.getCompId();
					}else{
						folderId = aigaInstComponents[0].getCompId();
					}
				}
			}
			JSONArray inValue = new JSONArray();
			AigaInstRCaseComp aigaInstRCaseComp = new AigaInstRCaseComp();
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstRCaseComp.class);
			criteria.add(Restrictions.eq("caseId", aigaInstCase.getCaseId()));
			criteria.add(Restrictions.eq("compId", aigaInstComponent.getCompId()));
			AigaRCaseComp[] rCaseComps = rCaseCompDAO.getAigaRCaseCompByCriteria(criteria);
			for(AigaRCaseComp rCaseComp : rCaseComps){
				rCaseCompDAO.delete(rCaseComp);
			}
			JSONObject arguments = comp.getJSONObject("arguments");
			for(Object key : arguments.keySet()){
				JSONObject val = new JSONObject();
				JSONObject argu = arguments.getJSONObject(key.toString());
				String arguValue = argu.getString("value");
				String expectVal = argu.getString("expect");
				if(expectVal!=null&&!expectVal.equals(""))
					aigaInstRCaseComp.setExpectVal(expectVal);
				val.put("key",key);
				val.put("value", arguValue);
				inValue.add(val);
			}
			aigaInstRCaseComp.setInVal(inValue.toString());
			aigaInstRCaseComp.setROrder(i);
			aigaInstRCaseComp.setCompId(aigaInstComponent.getCompId());
			aigaInstRCaseComp.setCaseId(aigaInstCase.getCaseId());
			rCaseCompDAO.saveOrUpdate(aigaInstRCaseComp);
		}
	}

	@Override
	public AigaFunCaseRela[] getFunCaseRelaByFunId(Integer funId,String isQueryAll) throws Exception {
		
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaFunCaseRela.class);
		criteria.add(Restrictions.eq("folderId", funId));
		if(isQueryAll.equals("0")){
			criteria.add(Restrictions.eq("relaType", "owner"));
		}
		return  aigaFunCaseRelaDao.getAigaCaseRelaByCriteria(criteria);
	}
	
	@Override
	public AigaCase[] getCaseByFunId(Integer funId) throws Exception {
		// TODO Auto-generated method stub
		AigaCase[] aigaCases = {};
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRElemSec.class);
		criteria.add(Restrictions.eq("funId", funId));
		AigaRElemSec[] aigaRElemSecs = aigaSeceneDAO.getRElemSecene(criteria);
		Set<Integer> secIds=new HashSet<Integer>();
		//List<Integer> secIds = new ArrayList<Integer>();
		for(AigaRElemSec aigaRElemSec : aigaRElemSecs){
			secIds.add(aigaRElemSec.getSecId());
		}
		if(secIds.size()>0){
			criteria = DetachedCriteria.forClass(AigaInstCase.class);
			criteria.add(Restrictions.in("secId",secIds));
			criteria.addOrder(Order.asc("caseId"));
			aigaCases = caseDAO.getAigaCaseByCriteria(criteria);
		}
		/*		AigaCase[] aigaCases = {};
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaRFunElem.class);
		criteria.add(Restrictions.eq("funId", funId));
		AigaRFunElem[] aigaRFunElems = aigaRFunElemDAO.getRFunElem(criteria);
		List<Integer> elemIds = new ArrayList<Integer>();
		for(AigaRFunElem aigaRFunElem : aigaRFunElems){
			elemIds.add(aigaRFunElem.getElemId());
		}
		
		if(elemIds.size()>0){
			criteria = DetachedCriteria.forClass(AigaRElemSec.class);
			criteria.add(Restrictions.in("elemId",elemIds));
			AigaRElemSec[] aigaRElemSecs = aigaSeceneDAO.getRElemSecene(criteria);
			List<Integer> secIds = new ArrayList<Integer>();
			for(AigaRElemSec aigaRElemSec : aigaRElemSecs){
				secIds.add(aigaRElemSec.getSecId());
			}
			if(secIds.size()>0){
				criteria = DetachedCriteria.forClass(AigaInstCase.class);
				criteria.add(Restrictions.in("secId",secIds));
				criteria.addOrder(Order.asc("secId"));
				aigaCases = caseDAO.getAigaCaseByCriteria(criteria);
			}
		}*/
		return aigaCases;
	}

	@Override
	public AigaCase[] getCaseBySecId(Integer secId) throws Exception {
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstCase.class);
		criteria.add(Restrictions.eq("secId", secId));
		return caseDAO.getAigaCaseByCriteria(criteria);
	}

	@Override
	public void saveCaseFormForNew(AigaCase aValue, String caseElemJson)
			throws Exception {
		// TODO Auto-generated method stub
		this.saveAigaCase(aValue);
		Map map=convert(aValue);
		if(map.size()>0){
			AigaFunCaseRela aigaFunCaseRela=(AigaFunCaseRela)map.get("AigaFunCaseRela");
			aigaFunCaseRela.setRelaType("owner");
			aigaFunCaseRela.setParentFolderId(aigaFunCaseRela.getFolderId());
			aigaFunCaseRelaDao.saveOrUpdate(aigaFunCaseRela);
			
			AigaHisFunCaseRela aigaHisFunCaseRela=(AigaHisFunCaseRela)map.get("AigaHisFunCaseRela");
			aigaHisFunCaseRela.setRelaId(aigaFunCaseRela.getRelaId());
			aigaHisFunCaseRela.setRelaType(aigaFunCaseRela.getRelaType());
			aigaHisFunCaseRela.setParentFolderId(aigaFunCaseRela.getParentFolderId());
			aigaHisFunCaseRela.setOperateType("add");
			aigaFunCaseRelaDao.saveOrUpdate(aigaHisFunCaseRela);
		}
		
		Integer caseId = aValue.getCaseId();
		DetachedCriteria criteria2 = DetachedCriteria.forClass(AigaRCaseElem.class);
		criteria2.add(Restrictions.eq("caseId", caseId));
		AigaRCaseElem[] aigaRCaseElemValues = caseDAO.getAigaRCaseElem(criteria2);
		for(AigaRCaseElem aigaRCaseElemValue : aigaRCaseElemValues){
			caseDAO.deleteAigaRCaseElem(aigaRCaseElemValue);
		}
		if(caseElemJson!=null&&!caseElemJson.equals("")){
			JSONArray array = JSONArray.fromObject(caseElemJson);
			for(int i=0,n=array.size();i<n;i++){
				JSONObject jsonObject = JSONObject.fromObject(array.get(i));
				Iterator iterator = jsonObject.keys();
				String elemId = iterator.next().toString();
				String subElemId = jsonObject.getString(elemId);
				DetachedCriteria criteria = DetachedCriteria.forClass(AigaRCaseElem.class);
				criteria.add(Restrictions.eq("caseId", caseId));
				criteria.add(Restrictions.eq("elemId", Integer.valueOf(elemId)));
				AigaRCaseElem[] aigaRCaseElems = caseDAO.getAigaRCaseElem(criteria);
				if(aigaRCaseElems!=null&&aigaRCaseElems.length==1){
					aigaRCaseElems[0].setSubElemId(Integer.valueOf(subElemId));
					caseDAO.saveAigaRCaseElem(aigaRCaseElems[0]);
				}else{
					AigaRCaseElem aigaRCaseElem = new AigaRCaseElem();
					aigaRCaseElem.setCaseId(caseId);
					aigaRCaseElem.setElemId(Integer.valueOf(elemId));
					aigaRCaseElem.setSubElemId(Integer.valueOf(subElemId));
					caseDAO.saveAigaRCaseElem(aigaRCaseElem);
				}
			}
		}
	}

	@Override
	public void deleteCaseForNew(Integer caseId) throws Exception {
		// TODO Auto-generated method stub
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstCase.class);
		criteria.add(Restrictions.eq("caseId", caseId));
		AigaCase[] aigaCases = caseDAO.getAigaCaseByCriteria(criteria);
		if(aigaCases!=null&&aigaCases.length==1)
			caseDAO.delete(aigaCases[0]);
		DetachedCriteria criteria2 = DetachedCriteria.forClass(AigaRCaseElem.class);
		criteria2.add(Restrictions.eq("caseId", caseId));
		AigaRCaseElem[] aigaRCaseElemValues = caseDAO.getAigaRCaseElem(criteria2);
		for(AigaRCaseElem aigaRCaseElemValue : aigaRCaseElemValues){
			caseDAO.deleteAigaRCaseElem(aigaRCaseElemValue);
		}
	}

	@Override
	public void deleteCaseByIdsForNew(String caseIds) throws Exception {
		// TODO Auto-generated method stub
		if(caseIds!=null&&caseIds.length()!=0){
			String[] caseId = caseIds.split(",");
			for(String id:caseId){
				DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstCase.class);
				criteria.add(Restrictions.eq("caseId", Integer.valueOf(id)));
				AigaCase[] aigaCases = caseDAO.getAigaCaseByCriteria(criteria);
				if(aigaCases!=null&&aigaCases.length==1)
					caseDAO.delete(aigaCases[0]);
				DetachedCriteria criteria2 = DetachedCriteria.forClass(AigaRCaseElem.class);
				criteria2.add(Restrictions.eq("caseId", Integer.valueOf(id)));
				AigaRCaseElem[] aigaRCaseElemValues = caseDAO.getAigaRCaseElem(criteria2);
				for(AigaRCaseElem aigaRCaseElemValue : aigaRCaseElemValues){
					caseDAO.deleteAigaRCaseElem(aigaRCaseElemValue);
				}
			}
		}
		AigaFunCaseRela[] aigaCaseRelas=aigaFunCaseRelaDao.getAigaCaseRelaBySql("from AigaFunCaseRela where caseId in ("+caseIds+")");
		AigaHisFunCaseRela[] aigaHisFunCaseRelas=aigaFunCaseRelaSV.convert(aigaCaseRelas, "delete");
		aigaFunCaseRelaDao.saveOrUpdateAll(aigaHisFunCaseRelas);
		aigaFunCaseRelaDao.deleteAll(aigaCaseRelas);
	}
	
	public AigaHisCase[] getHisCaseBySql(String querySql) throws Exception {
		return caseDAO.getHisCaseBySql(querySql);
	}
	
	public AigaInstCase[] getInstCaseBySql(String querySql) throws Exception {
		return caseDAO.getInstCaseBySql(querySql);
	}

	public void setRFunCaseDAO(IAigaRFunCaseDAO funCaseDAO) {
		this.rFunCaseDAO = funCaseDAO;
	}

	@Override
	public AigaRFunCase[] getAigaRFunCaseBySql(String querySql)
			throws Exception {
		return caseDAO.getAigaRFunCaseBySql(querySql);
	}

	@Override
	public AigaCase[] getAigaCaseByCriteria(DetachedCriteria criteria)
			throws Exception {
		return caseDAO.queryAigaCaseByCriteria(criteria);
	}

	@Override
	public AigaHisCase[] getHisCaseByCriteria(DetachedCriteria criteria)
			throws Exception {
		// TODO Auto-generated method stub
		return caseDAO.getHisCaseByCriteria(criteria);
	}

	public void setAigaFunCaseRelaDao(IAigaFunCaseRelaDAO aigaFunCaseRelaDao) {
		this.aigaFunCaseRelaDao = aigaFunCaseRelaDao;
	}
	
	public Map convert(AigaCase aigaCase)throws Exception{
		Map map=new HashMap();
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		String subTaskTag = request.getSession().getAttribute("subTaskTag").toString();
		String normalMac = CommonHelper.decodeCN(request.getSession().getAttribute("normalMac").toString());
		String temporaryTag = request.getSession().getAttribute("TemporaryTag").toString();
		Integer folderId = Integer.valueOf(request.getSession().getAttribute("funFolderId").toString());
		AigaFunCaseRela[] aigaFunCaseRelas=aigaFunCaseRelaDao.getAigaCaseRelaBySql(" from AigaFunCaseRela where folderId="+folderId+" and caseId="+aigaCase.getCaseId());
		if(aigaFunCaseRelas!=null&&aigaFunCaseRelas.length>0&&aigaFunCaseRelas[0]!=null){
			
		}else{
			AigaFunCaseRela aigaFunCaseRela=new AigaFunCaseRela();
			aigaFunCaseRela.setCaseId(aigaCase.getCaseId());
			aigaFunCaseRela.setFolderId(folderId);
			aigaFunCaseRela.setQuoteTime(new Timestamp(aigaCase.getCreateTime().getTime()));
			aigaFunCaseRela.setUpdateTime(new Timestamp(aigaCase.getUpdateTime().getTime()));
			aigaFunCaseRela.setLatestOperator(aigaCase.getLatestOperator());
			aigaFunCaseRela.setRegressionTest(aigaCase.getRegressionTest());
			aigaFunCaseRela.setEfficiencyTest(aigaCase.getEfficiencyTest());
			aigaFunCaseRela.setEfficiencyTestType(aigaCase.getEfficiencyTestType());
			aigaFunCaseRela.setTeminalTest(aigaCase.getTeminalTest());
			aigaFunCaseRela.setHasTest(aigaCase.getHasTest());
			aigaFunCaseRela.setIsAvailAuto(aigaCase.getIsAvailAuto());
			aigaFunCaseRela.setIsFinishAuto(aigaCase.getIsFinishAuto());
			aigaFunCaseRela.setTestType(aigaCase.getTestType());
			map.put("AigaFunCaseRela", aigaFunCaseRela);
			
			AigaHisFunCaseRela aigaHisFunCaseRela=new AigaHisFunCaseRela();
			aigaHisFunCaseRela.setCaseId(aigaCase.getCaseId());
			aigaHisFunCaseRela.setFolderId(folderId);
			aigaHisFunCaseRela.setOperateTime(new Timestamp(aigaCase.getUpdateTime().getTime()));
			aigaHisFunCaseRela.setLatestOperator(aigaCase.getLatestOperator());
			aigaHisFunCaseRela.setRegressionTest(aigaCase.getRegressionTest());
			aigaHisFunCaseRela.setEfficiencyTest(aigaCase.getEfficiencyTest());
			aigaHisFunCaseRela.setEfficiencyTestType(aigaCase.getEfficiencyTestType());
			aigaHisFunCaseRela.setTeminalTest(aigaCase.getTeminalTest());
			aigaHisFunCaseRela.setHasTest(aigaCase.getHasTest());
			aigaHisFunCaseRela.setIsAvailAuto(aigaCase.getIsAvailAuto());
			aigaHisFunCaseRela.setIsFinishAuto(aigaCase.getIsFinishAuto());
			aigaHisFunCaseRela.setTestType(aigaCase.getTestType());
			aigaHisFunCaseRela.setSubTaskTag(subTaskTag);
			aigaHisFunCaseRela.setTemporaryTag(temporaryTag);
			aigaHisFunCaseRela.setNormalMac(normalMac);
			aigaHisFunCaseRela.setEditType(StringUtils.isNotBlank(subTaskTag)?1:(StringUtils.isNotBlank(normalMac)?2:(StringUtils.isNotBlank(temporaryTag)?3:null)));
			map.put("AigaHisFunCaseRela", aigaHisFunCaseRela);
		}
		return map;
	}

	
}
