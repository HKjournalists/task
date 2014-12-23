package com.asiainfo.aiga.userCase.service;

import java.util.List;
import java.util.Map;

import org.hibernate.criterion.DetachedCriteria;

import net.sf.json.JSONArray;

import com.asiainfo.aiga.caseLabelRela.bo.AigaCaseLabelRela;
import com.asiainfo.aiga.collection.bo.AigaCaseCollection;
import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.component.bo.AigaComponent;
import com.asiainfo.aiga.funCaseRela.bo.AigaFunCaseRela;
import com.asiainfo.aiga.node_view.bo.NodeView;
import com.asiainfo.aiga.r_collect_case.bo.AigaRFunCase;
import com.asiainfo.aiga.requisition.bo.AigaRequisition;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.bo.AigaHisCase;
import com.asiainfo.aiga.userCase.bo.extend.AigaInstCase;

/**
 * Created on 2014-6-23
 * <p>Description: [描述该类概要功能介绍]</p>
*/
public interface IAigaCaseSV
{
	public void deleteAigaCase(String caseId,Class className) throws Exception ;
	public AigaCase[] getAigaCaseById(Integer aigaId,Class className) throws Exception;
	public void saveAigaCase(AigaCase value) throws Exception ;
	public AigaCase[] getAigaCaseAll(Class className) throws Exception;
	public AigaComponent[] getCompsByCaseId(String caseId)throws Exception;
	public AigaComponent[] getCompsAll(Class clazz)throws Exception;
	public AigaComponent getCompsByCompId(String compId,Class clazz)throws Exception;
	public boolean saveCase(AigaCase aigaCase,String[] compIdArray,String[] inValArray,String[] expectValArray,String[] hingeArray,String[] arguName,String[] manualTaskId);
	public AigaCase[] getAigaCaseByParentId(Integer parentId,Class clazz)throws Exception;
	public AigaCaseCollection unionCase(AigaCaseCollection aigaCaseCollection,String[] strings);
	public AigaCase[] getAigaCaseBySql(String querySql) throws Exception;
	public AigaRequisition[] getAigaRequisitionById(Integer requisitionId)throws Exception;
	public JSONArray getCaseCompsByCaseId(String caseId,String manualTaskId) throws Exception;
	public String getAigaCompByCaseId(String caseId,String taskId) throws Exception;
	public AigaCaseCollection[] getCaseCollectionById(String collectId,Class clazz)throws Exception;
	public NodeView[] getNodeViewByKeyword(String keyword,String nodeTable)throws Exception;
	public NodeView[] getNodeViewByKeyword(String keyword)throws Exception;
	public NodeView[] getNodeViewsByCondition(Map map)throws Exception;
	public AigaCase[] getAigaCaseByCaseIds(String caseIds,Class clazz)throws Exception;
	public Object[] getAigaExtBySubTaskId(Integer subTaskId,Class clazz)throws Exception;
	
	public AigaCaseLabelRela[] getCaseLabelRelaBySql(String querySql) throws Exception;
	
	public void saveCaseLabelRela(AigaCaseLabelRela value) throws Exception;
	
	public void deleteCaseLabelRela(AigaCaseLabelRela value) throws Exception;
	
	public void savePasteCase(Integer parentId,String name,Integer caseId,AigaUser currentUser) throws Exception;
	
	public List getAigaCaseByHql(String hql)throws Exception;
	
	public AigaInstCase[] getUnApprovalCase(String staffNo)throws Exception;
	
	public void saveApprovalCase(AigaInstCase value)throws Exception;
	
//	public void saveCaseFolder(String folderName,String caseId)throws Exception;
//	public void editCaseFolder(String folderName,String caseId)throws Exception;
//	public void deleteCaseFolder(String folderName,String caseId)throws Exception;
	public void saveCaseOrder(String caseIds)throws Exception;
	public void saveBatchApprovalCase(String caseIds,AigaUser currentUser)throws Exception;
	
	public void saveImportCase(String caseJson)throws Exception;
	
	public AigaCase[] getCaseByFunId(Integer funId)throws Exception;
	
	public AigaCase[] getCaseBySecId(Integer secId)throws Exception;
	
	public void saveCaseFormForNew(AigaCase aValue,String caseElemJson)throws Exception;
	
	public void deleteCaseForNew(Integer caseId)throws Exception;
	
	public void deleteCaseByIdsForNew(String caseIds)throws Exception;
	
	public AigaHisCase[] getHisCaseBySql(String querySql) throws Exception;
	
	public AigaHisCase[] getHisCaseByCriteria(DetachedCriteria criteria) throws Exception;
	
	public AigaInstCase[] getInstCaseBySql(String querySql) throws Exception;
	
	public AigaRFunCase[] getAigaRFunCaseBySql(String querySql) throws Exception;
	
	public AigaCase[] getAigaCaseByCriteria(DetachedCriteria criteria) throws Exception;
	
	public AigaFunCaseRela[] getFunCaseRelaByFunId(Integer funId,String isQueryAll)throws Exception;
	
}
