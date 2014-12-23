package com.asiainfo.aiga.userCase.web;

import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.Serializable;
import java.io.Writer;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.asiainfo.aiga.caseLabelRela.bo.AigaCaseLabelRela;
import com.asiainfo.aiga.collection.bo.AigaCaseCollection;
import com.asiainfo.aiga.collection.bo.extend.AigaInstCaseCollection;
import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.DynamicBean;
import com.asiainfo.aiga.common.JsonDateToObj;
import com.asiainfo.aiga.common.Tree;
import com.asiainfo.aiga.common.helper.ActionHelper;
import com.asiainfo.aiga.common.helper.CommonHelper;
import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.common.service.ICommonPageinationSV;
import com.asiainfo.aiga.common.xls.ExcelVO;
import com.asiainfo.aiga.common.xls.XlsHelper;
import com.asiainfo.aiga.component.bo.AigaComponent;
import com.asiainfo.aiga.component.bo.extend.AigaInstComponent;
import com.asiainfo.aiga.component.service.impl.AigaCompTree;
import com.asiainfo.aiga.funCaseRela.bo.AigaFunCaseRela;
import com.asiainfo.aiga.funCaseRela.bo.AigaHisFunCaseRela;
import com.asiainfo.aiga.funCaseRela.service.IAigaFunCaseRelaSV;
import com.asiainfo.aiga.funPoint.bo.AigaFunPoint;
import com.asiainfo.aiga.funPoint.service.IAigaFunPointSV;
import com.asiainfo.aiga.label.bo.AigaLabel;
import com.asiainfo.aiga.label.service.IAigaLabelSV;
import com.asiainfo.aiga.manualTask.bo.AigaManualTask;
import com.asiainfo.aiga.manualTask.service.IAigaManualTaskSV;
import com.asiainfo.aiga.node_view.bo.NodeView;
import com.asiainfo.aiga.node_view.service.impl.AigaNodeViewTree;
import com.asiainfo.aiga.r_elem_case.dao.IAigaRElemCaseDAO;
import com.asiainfo.aiga.requisition.bo.AigaRequisition;
import com.asiainfo.aiga.requisition.bo.AigaTestSubReason;
import com.asiainfo.aiga.requisition.bo.AigaTestSubTask;
import com.asiainfo.aiga.requisition.service.IAigaRequisitionSV;
import com.asiainfo.aiga.resource.bo.AigaTestResource;
import com.asiainfo.aiga.resource.service.ITestResourceSV;
import com.asiainfo.aiga.runPlan.bo.AigaRunPlan;
import com.asiainfo.aiga.runPlan.service.IAigaRunPlanSV;
import com.asiainfo.aiga.runTask.bo.AigaRunTask;
import com.asiainfo.aiga.runTask.service.IAigaRunTaskSV;
import com.asiainfo.aiga.sysConstant.bo.SysConstant;
import com.asiainfo.aiga.sysConstant.util.LabelMapUtil;
import com.asiainfo.aiga.sysConstant.util.SysContentUtil;
import com.asiainfo.aiga.testPlan.bo.AigaTestPlan;
import com.asiainfo.aiga.testPlan.service.IAigaTestPlanSV;
import com.asiainfo.aiga.testPlan.web.AigaTestPlanAction;
import com.asiainfo.aiga.testTask.bo.AigaTestTask;
import com.asiainfo.aiga.userCase.bo.AigaAutotestParams;
import com.asiainfo.aiga.userCase.bo.AigaBaseBusi;
import com.asiainfo.aiga.userCase.bo.AigaBusi;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.bo.AigaFunFolder;
import com.asiainfo.aiga.userCase.bo.AigaHisCase;
import com.asiainfo.aiga.userCase.bo.AigaHisElem;
import com.asiainfo.aiga.userCase.bo.AigaRElemSec;
import com.asiainfo.aiga.userCase.bo.AigaSecene;
import com.asiainfo.aiga.userCase.bo.AigaSubSysFolder;
import com.asiainfo.aiga.userCase.bo.AigaSystemFolder;
import com.asiainfo.aiga.userCase.bo.AigaTestElem;
import com.asiainfo.aiga.userCase.bo.AigaTestSubElem;
import com.asiainfo.aiga.userCase.bo.extend.AigaInstCase;
import com.asiainfo.aiga.userCase.caseTrans.CaseHttpSend;
import com.asiainfo.aiga.userCase.dao.IAigaCaseDAO;
import com.asiainfo.aiga.userCase.service.IAigaAutotestParamsSV;
import com.asiainfo.aiga.userCase.service.IAigaBaseBusiSV;
import com.asiainfo.aiga.userCase.service.IAigaBusiSV;
import com.asiainfo.aiga.userCase.service.IAigaCaseSV;
import com.asiainfo.aiga.userCase.service.IAigaFunFolderSV;
import com.asiainfo.aiga.userCase.service.IAigaSeceneSV;
import com.asiainfo.aiga.userCase.service.IAigaSubSysFolderSV;
import com.asiainfo.aiga.userCase.service.IAigaSystemFolderSV;
import com.asiainfo.aiga.userCase.service.impl.AigaCaseTree;
import com.asiainfo.lucene.LuceneEntities.properties.LuceneCommon;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;



/**
 * Created on 2014-6-23
 * <p>Description: [用例Action]</p>
*/

@Controller
public class AigaCaseAction extends BaseAction
{
	private static final String CREATE_CASE_PAGE_URL="case/createCase.jsp";
	private static final String MANAGE_CASE_PAGE_URL="case/manageCase.jsp";
	private static final String EDIT_CASE_PAGE_URL="case/editCase.jsp";
	private static final String MANAGE_COLLECT_PAGE_URL="case/coolectionManage.jsp";
	private List<Map<String, Object>> objList=new ArrayList<Map<String, Object>>();
	private static final String AIGA_FUN_FOLDER="AIGA_FUN_FOLDER";
	private static Logger logger = Logger.getLogger(AigaTestPlanAction.class);

	@Resource(name="commonPageinationSV")
	private ICommonPageinationSV commonPageinationSV;
	
	@Resource(name="testSeceneSV")
	private IAigaSeceneSV aigaSeceneSV;

	@Resource(name="aigaRunTaskSV")
	private IAigaRunTaskSV aigaRunTaskSV;
	
	@Resource(name="funPointSV")
	private IAigaFunPointSV funPSV;
	
	@Resource(name="aigaRunPlanSV")
	private IAigaRunPlanSV aigaRunPlanSV;
	
	@Resource(name="rElemCaseDao")
	private IAigaRElemCaseDAO rElemCaseDAO;
	@Resource(name="caseDao")
	private IAigaCaseDAO caseDAO;
	
	@Resource(name="resourceSV")
	private ITestResourceSV resourceSV;
	
	@Resource(name="freemarkerConfiguration")
	private Configuration freemarkerConfiguration;
	
	@Resource(name="requisitionSV")
	private IAigaRequisitionSV reqSV;
	
	@Resource(name="baseBusiSV")
	private IAigaBaseBusiSV aigaBaseBusiSV;
	
	@Resource(name="busiSV")
	private IAigaBusiSV aigaBusiSV;
	
	@Resource(name="caseSV")
	private IAigaCaseSV aigaCaseSV;
	
	@Resource(name="aigalabelSV")
	private IAigaLabelSV aigaLabelSV;
	
	@Resource(name="funFolderSV")
	private IAigaFunFolderSV aigaFunFolderSV;
	
	@Resource(name="autoTestParamSV")
	private IAigaAutotestParamsSV aigaAutotestParamsSV;
	
	@Resource(name="sysFolderSV")
	private IAigaSystemFolderSV aigaSystemFolderSV;
	
	@Resource(name="subSysFolderSV")
	private IAigaSubSysFolderSV aigaSubSystemFolderSV;
	
	@Resource(name="ManualTaskSV")
	private IAigaManualTaskSV aigaManualTaskSV;
	
	@Resource(name = "testPlanSV")
	private IAigaTestPlanSV testPlanSV;
	@Resource(name = "baseBusiSV")
	
	private IAigaBaseBusiSV baseBusiSV;
	@Resource(name = "testElementSV")
	private com.asiainfo.aiga.userCase.service.IAigaTestElemSV aigaTestElemSV;
	
	@Resource(name = "subSysFolderSV")
	private IAigaSubSysFolderSV aigaSubSysFolderSV;
	
	@Resource(name = "aigaFunCaseRelaSV")
	private IAigaFunCaseRelaSV aigaFunCaseRelaSV;
	
	@RequestMapping(value = "/createCase.html")
	public void showCase(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String elemId=(String)request.getParameter("elemId");
		String reqId=(String)request.getParameter("reqId");
		AigaRequisition aigaRequisition=new AigaRequisition();
		if(reqId!=null && !reqId.equals("null")){
			AigaRequisition[] aigaRequisitions=aigaCaseSV.getAigaRequisitionById(Integer.parseInt(reqId));
			if(aigaRequisitions!=null&&aigaRequisitions.length==1){
				aigaRequisition=aigaRequisitions[0];
			}
		}
		AigaComponent[] compArray= aigaCaseSV.getCompsAll(AigaInstComponent.class);
		request.setAttribute("compArray", compArray);
		request.setAttribute("aigaRequisition", aigaRequisition);
		request.setAttribute("elemId", elemId);
		
		ActionHelper.forwardPage(request, response,CREATE_CASE_PAGE_URL);
	}
//	获取用例树
	@RequestMapping("/getCaseTree.do")
	public void getCaseTree(HttpServletRequest request, HttpServletResponse response)throws Exception{
		ApplicationContext context = RequestContextUtils.getWebApplicationContext(request);
		AigaCaseTree caseTree = (AigaCaseTree)context.getBean("caseTree");
		this.setTree(caseTree,request);
		this.postInfo(request, response);
	}
	
	@RequestMapping("/getCaseTreeSyn.do")
	public void getCaseTreeSyn(HttpServletRequest request, HttpServletResponse response)throws Exception{
//		String type = request.getParameter("type");
		String node = request.getParameter("node");
//		String isMutiSelect = request.getParameter("isMutiSelect");
		String flag = request.getParameter("flag");
		String[] strFunIds=request.getParameterValues("funIds");
		String[] strSubSysIds=request.getParameterValues("subSysIds");
		String[] strSysIds=request.getParameterValues("sysIds");
		String[] strTypes=request.getParameterValues("types");
		String clickFlag = request.getParameter("clickFlag");
		int[] funIds=null;
		int[] subSysIds=null;
		int[] sysIds=null;
		System.out.println("============"+clickFlag);
//		Boolean expanded=false;
		Boolean isAutoExpand=false;
		if(clickFlag!=null&&clickFlag.equals("query")){
			isAutoExpand=true;
		}
		if(isAutoExpand){
			if(strSysIds!=null&&strSysIds.length!=0){
				sysIds=new int[strSysIds.length];
				for(int i=0;i<sysIds.length;i++)sysIds[i]=Integer.valueOf(strSysIds[i]);
			}
			if(strSubSysIds!=null&&strSubSysIds.length!=0&&NaNull(strSubSysIds[0].trim())){
				subSysIds=new int[strSubSysIds.length];
				for(int i=0;i<strSubSysIds.length;i++)subSysIds[i]=Integer.valueOf(strSubSysIds[i]);
			}
			if(strFunIds!=null&&strFunIds.length!=0&&NaNull(strFunIds[0].trim())){
				funIds=new int[strFunIds.length];
				for(int i=0;i<strFunIds.length;i++)funIds[i]=Integer.valueOf(strFunIds[i]);
			}
		}
//		String isLeaf = request.getParameter("isLeaf");
		
		List<Object> childTrees = new ArrayList<Object>();
		
		if(flag.equals("sysFolder")){
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaSystemFolder.class);
			AigaSystemFolder[] aigaSystemFolders = aigaSystemFolderSV.getSystemFolder(criteria);
			for(AigaSystemFolder aigaSystemFolder : aigaSystemFolders){
				Tree childeTree = new Tree();
				if(isAutoExpand)if(sysIds!=null&&!CommonHelper.ArrayHasValue(sysIds,aigaSystemFolder.getSysId()))continue;
				childeTree.setId(aigaSystemFolder.getSysId());
				childeTree.setExpanded(isAutoExpand&&(subSysIds!=null));
				childeTree.setLeaf(false);
				childeTree.setParentId(Integer.valueOf(node));
				childeTree.setText(aigaSystemFolder.getSysName());
				childeTree.setValue(aigaSystemFolder.getSysId().toString());
				childeTree.setType("sysFolder");
				childTrees.add(childeTree);
			}
		}else if(flag.equals("subSysFolder")){
			
			//此时 funIds  为当前本身id
			
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaSubSysFolder.class);
			criteria.add(Restrictions.eq("sysId", Integer.valueOf(node)));
			AigaSubSysFolder[] aigaSubSysFolders = aigaSubSysFolderSV.getSubSysFolder(criteria);
			for(AigaSubSysFolder aigaSubSysFolder : aigaSubSysFolders){
				Tree childeTree = new Tree();
				if(isAutoExpand){
					if(subSysIds!=null&&!CommonHelper.ArrayHasValue(subSysIds,aigaSubSysFolder.getSubsysId())){
						System.out.println(aigaSubSysFolder.getSubsysId());
						continue;
					}else{
						
					}
				}
				childeTree.setId(aigaSubSysFolder.getSubsysId());
				childeTree.setExpanded(isAutoExpand&&(funIds!=null));
				childeTree.setLeaf(false);
				childeTree.setParentId(Integer.valueOf(node));
				childeTree.setText(aigaSubSysFolder.getSysName());
				childeTree.setValue(aigaSubSysFolder.getSubsysId().toString());
				childeTree.setType("subSysFolder");
				childTrees.add(childeTree);
			}
		}else if(flag.equals("funFolder")){
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaFunFolder.class);
			criteria.add(Restrictions.eq("subSysId", Integer.valueOf(node)));
			criteria.add(Restrictions.eq("isInvalid", Short.valueOf("0")));
			AigaFunFolder[] aigaFunFolders = aigaFunFolderSV.getAigaFunFolder(criteria);
			for(AigaFunFolder aigaFunFolder : aigaFunFolders){
				Tree childeTree = new Tree();
				if(isAutoExpand){
					if(funIds!=null&&!CommonHelper.ArrayHasValue(funIds,aigaFunFolder.getFunId()))continue;
				}
				childeTree.setId(Integer.parseInt(String.valueOf(aigaFunFolder.getFunId())));
				childeTree.setExpanded(false);
				childeTree.setLeaf(false);
				childeTree.setParentId(Integer.valueOf(node));
				childeTree.setText(aigaFunFolder.getSysName());
				childeTree.setValue(aigaFunFolder.getFunId().toString());
				childeTree.setType("funFolder");
				//if(isLeaf!=null&&isLeaf.equals("yes")){
				childeTree.setLeaf(true);
				//}
				childTrees.add(childeTree);
			}
		}
//		else{
//			String querySql = "from AigaInstCase where funFolderId=" + node;
//			AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
//			List list = aigaCaseSV.getAigaCaseByHql(querySql);
//			for(Object caseList : list){
//				Tree childeTree = new Tree();
//				AigaInstCase aigaCase = (AigaInstCase)caseList;
//				if(type!=null&&type.equals("manage")){
//					if(aigaCase.getStatus()!=null&&aigaCase.getStatus().equals(1)){
//						if(aigaCase.getAuthorNo()==null||!aigaCase.getAuthorNo().equals(user.getUserAccount()))
//							continue;
//					}
//				}
//				childeTree.setId(aigaCase.getCaseId());
//				childeTree.setExpanded(false);
//				childeTree.setParentId(Integer.valueOf(node));
//				childeTree.setText(aigaCase.getCaseName());
//				childeTree.setValue(aigaCase.getCaseId().toString());
//				childeTree.setType("case");
//				
//				childeTree.setQtip("用例作者："+(aigaCase.getAuthor()==null?"":aigaCase.getAuthor())+"<br>"+
//						"用例描述：" + (aigaCase.getCaseDesc()==null?"":aigaCase.getCaseDesc()));
//				childeTree.setLeaf(true);
//				Object newTree = null;
//				if(isMutiSelect!=null&&childeTree.isLeaf()==true&&isMutiSelect.equals("true")){
//					Map map = new HashMap();
//					map.put("checked", Boolean.valueOf(false));
//					DynamicBean bean = new DynamicBean(childeTree,map);
//					newTree = bean.getObject();
//				}
//				if(newTree==null)
//					childTrees.add(childeTree);
//				else
//					childTrees.add(newTree);
//			}
//		}
		this.setPostInfo("children", childTrees);
		this.postInfo(request, response);
	}
	@RequestMapping("/getCompTree.do")
	public void getCompTree(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			ApplicationContext context = RequestContextUtils.getWebApplicationContext(request);
			AigaCompTree compTree = (AigaCompTree)context.getBean("compTree");
			this.setTree(compTree,request);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
//	编辑用例
	@RequestMapping(value = "/editCase.html")
	public void editCase(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String elemId=(String)request.getParameter("elemId");
		String reqId=(String)request.getParameter("reqId");
		String caseId=request.getParameter("editCaseId");
		AigaCase aigaCase=new AigaInstCase();
		AigaCase[] aigaCases=aigaCaseSV.getAigaCaseById(Integer.parseInt(caseId),AigaInstCase.class);
		if(aigaCases !=null &&aigaCases.length==1){
			aigaCase=aigaCases[0];
		}
		AigaRequisition aigaRequisition=new AigaRequisition();
		if(reqId!=null && !reqId.equals("null")){
			AigaRequisition[] aigaRequisitions=aigaCaseSV.getAigaRequisitionById(Integer.parseInt(reqId));
			if(aigaRequisitions!=null&&aigaRequisitions.length==1){
				aigaRequisition=aigaRequisitions[0];
			}
		}
		request.setAttribute("aigaRequisition", aigaRequisition);
		request.setAttribute("elemId", elemId);
		request.setAttribute("caseId", caseId);
		request.setAttribute("aigaCase", aigaCase);
		request.setAttribute("caseOperType", "1");
		ActionHelper.forwardPage(request, response,EDIT_CASE_PAGE_URL);
	}
	@RequestMapping(value = "/getCompById.do")
	public void getCompById(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String compId=request.getParameter("compId");
	
		AigaComponent comp=aigaCaseSV.getCompsByCompId(compId,AigaInstComponent.class);
		JSONArray json = new JSONArray();
		if(comp!=null&&comp.getCompId()!=null){
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("compId", comp.getCompId());
			jsonObject.put("compName", comp.getCompName());
			jsonObject.put("inVal", "");
			jsonObject.put("expectVal", "");
			jsonObject.put("compDesc", comp.getCompDesc());
			json.add(jsonObject);
		}
		ActionHelper.responseData4JSON(request, response, json);
	}
	/**
	 * <p>Discription:[保存用例]</p>
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveCase.do")
	public void saveCase(HttpServletRequest request, HttpServletResponse response) throws Exception
	{

		String strTable = request.getParameter("table");
		if (strTable != null && strTable.length() > 0)
		{
			JSONArray jsonArr = JSONArray.fromObject(strTable);
			String[] compIdArray=new String[jsonArr.size()];
			String[] inValArray=new String[jsonArr.size()];
			String[] hingeArray=new String[jsonArr.size()];
			String[] expectValArray=new String[jsonArr.size()];
			String[] arguName = new String[jsonArr.size()];
			String[] manualTaskId = new String[jsonArr.size()];
			for (int i = 0, n = jsonArr.size(); i < n; i++)
			{
				JSONObject json = (JSONObject) jsonArr.get(i);
				inValArray[i]=(String)json.get("inVal").toString();
				expectValArray[i]=(String)json.get("expectVal").toString();
				compIdArray[i]=String.valueOf(json.getInt("compId"));
				arguName[i]=(String)json.get("arguName");
				manualTaskId[i]=String.valueOf(json.getInt("manualTaskId"));
			}
			//空用例
			AigaCase aigaCase=null;
			Object[] object = this.transFormToObj(request, new Class[]{AigaInstCase.class});
			if(object.length==1){
				if (object[0] instanceof AigaCase) {
					aigaCase = (AigaCase) object[0];
				}
			}
			Map map=new HashMap();
			Boolean res=aigaCaseSV.saveCase(aigaCase, compIdArray, inValArray,expectValArray, hingeArray,arguName,manualTaskId);
			if(res) {
				String ownLabels = aigaCase.getOwnLabel();
				String sysLabels = aigaCase.getSysLabel();
				saveCaseLabelRela(aigaCase, ownLabels, true);
				saveCaseLabelRela(aigaCase, sysLabels, false);
			}
			
			map.put("success", res);
			map.put("caseId", aigaCase.getCaseId());
			ActionHelper.returnResponseData(request, response, map);
		}
	}
	
	private void saveCaseLabelRela(AigaCase aigaCase, String labelArys, boolean isAuto) throws Exception {
		if(labelArys == null || "".equals(labelArys)) {
			return;
		}
		String[] labelAry = labelArys.split(",");
		for(String label : labelAry) {
			String equal = isAuto?"=":"!=";
			String querySql = "from AigaLabel where label_name='" + label + "' and parent_id"+equal+"51";
			AigaLabel[] results = aigaLabelSV.getAigaLabelBySql(querySql);
			AigaLabel aigaLab = null;
			if(results == null || results.length == 0 || results[0] == null) {
				aigaLab = new AigaLabel();
				aigaLab.setIsLeaf(1);
				aigaLab.setCreateTime(new Date());
				aigaLab.setLabelName(label);
				aigaLab.setLabelDesc(label);
				aigaLab.setParentId(51);
				aigaLabelSV.saveAigaLabel(aigaLab);
			} else {
				aigaLab = results[0];
			}
			String relaSql = "from AigaCaseLabelRela where label_id=" + aigaLab.getLabelId() + " and case_id=" + aigaCase.getCaseId();
			AigaCaseLabelRela[] relas = aigaCaseSV.getCaseLabelRelaBySql(relaSql);
			if(relas == null || relas.length == 0 || relas[0] == null) {
				AigaCaseLabelRela rela = new AigaCaseLabelRela();
				rela.setCaseId(aigaCase.getCaseId());
				rela.setLabelId(aigaLab.getLabelId());
				aigaCaseSV.saveCaseLabelRela(rela);
			}
		}
	}
	
	@Deprecated
	@RequestMapping(value = "/manageCase.html")
	public void manageCaseMain(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		AigaCase[] aicase = aigaCaseSV.getAigaCaseAll(AigaInstCase.class);
		request.setAttribute("aicaseArray", aicase);
		String elemId=(String)request.getParameter("elemId");
		String reqId=(String)request.getParameter("reqId");
		AigaRequisition aigaRequisition=new AigaRequisition();
		if(reqId!=null && !reqId.equals("null")){
			AigaRequisition[] aigaRequisitions=aigaCaseSV.getAigaRequisitionById(Integer.parseInt(reqId));
			if(aigaRequisitions!=null&&aigaRequisitions.length==1){
				aigaRequisition=aigaRequisitions[0];
			}
		}
		request.setAttribute("elemId", elemId);
		request.setAttribute("reqId", reqId);
		request.setAttribute("aigaRequisition", aigaRequisition);
		ActionHelper.forwardPage(request, response, MANAGE_CASE_PAGE_URL);
	}
	
	/**
	 * 
	 * <p>Discription:[ 编辑用例页面加载组件]</p>
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/manageCaseDetail.do")
	public void manageCaseDetail(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		try{
			String caseId=request.getParameter("caseId");
			String node = request.getParameter("node");
			if(caseId==null||caseId.equals(""))
				throw new Exception("缺少参数，caseId");
			JSONArray resObj = null;
			if(node.equals("-1"))
				resObj = aigaManualTaskSV.getAigaManualTaskJson(Integer.valueOf(caseId));
			else
				resObj = aigaCaseSV.getCaseCompsByCaseId(caseId,node);
			
			this.setPostInfo("children", resObj);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@Deprecated
	@RequestMapping(method = RequestMethod.GET, value = "/saveCaseCollect.do")
	public void unionCase(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
			String[] caseOrderArray=request.getParameterValues("caseOrder[]");
			String caseCollectName=request.getParameter("aigaRequisition");
			//String caseCollectDesc=request.getParameter("caseCollectDesc");
			//String caseCollectAuthor=request.getParameter("caseCollectAuthor");
			caseCollectName=	new String(caseCollectName.getBytes("ISO8859-1"),"UTF-8");
		//	caseCollectDesc=new String(caseCollectDesc.getBytes("ISO8859-1"),"UTF-8");
		//	caseCollectAuthor=new String(caseCollectAuthor.getBytes("ISO8859-1"),"UTF-8");
			Timestamp timestamp=new Timestamp(System.currentTimeMillis());
			AigaCaseCollection	aigaCaseCollection=new AigaInstCaseCollection(caseCollectName,caseCollectName,timestamp,timestamp,caseCollectName, caseCollectName);
		Map map=new HashMap();
		AigaCaseCollection aigaCaseCollection_result=aigaCaseSV.unionCase(aigaCaseCollection, caseOrderArray);
		map.put("result", aigaCaseCollection_result);
//		map.put(key, value)
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@Deprecated
	@RequestMapping("/runCaseCollect.do")
	public void runCaseCollect(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String collectId=request.getParameter("collectId");
		ApplicationContext context = RequestContextUtils.getWebApplicationContext(request);
		CaseHttpSend caseHttpSend = (CaseHttpSend)context.getBean("caseSend");
		caseHttpSend.sendCase(collectId);
		Map map=new HashMap();
		map.put("result", true);
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@Deprecated
	@RequestMapping("/CaseCollect.html")
	public void mainCollect(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ActionHelper.forwardPage(request, response, MANAGE_COLLECT_PAGE_URL);
	}
	//根据关键字搜索节点
	@Deprecated
	@RequestMapping("/searchNode.do")
	public void searchNodeByKeyword(HttpServletRequest request,HttpServletResponse response)throws Exception{

		String keyword=request.getParameter("kw");
		keyword=	new String(keyword.getBytes("ISO8859-1"),"UTF-8");
		String nodeTable=request.getParameter("nodeTable");
			nodeTable=	new String(nodeTable.getBytes("ISO8859-1"),"UTF-8");
		NodeView[] nodeViews= aigaCaseSV.getNodeViewByKeyword(keyword,nodeTable);
		Map map=new HashMap();
		map.put("nodeView", nodeViews);
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/getFullTreeById.do")
	public void getFullTreeById(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			ApplicationContext context = RequestContextUtils.getWebApplicationContext(request);
			AigaNodeViewTree  aigaNodeViewTree= (AigaNodeViewTree)context.getBean("nodeTree");
			this.setTree(aigaNodeViewTree,request);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", "获取数据失败");
		}finally{
			this.postInfo(request, response);
		}
	}
	
	
	@RequestMapping("/deleteFunPoints.do")
	private void deleteFunPoints(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String funIds = request.getParameter("funIds");
			if(funIds==null||funIds.equals(""))
				throw new Exception("未从界面获取到caseId参数");
			aigaFunFolderSV.deleteAigaFunFolder(funIds);
			this.setPostInfo("success", true);
			this.setPostInfo("message", "功能点删除成功");
		}catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", "功能点删除失败");
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/deleteCase.do")
	private void deleteCase(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String caseId = request.getParameter("caseId");
			if(caseId==null||caseId=="")
				throw new Exception("未从界面获取到caseId参数");
			aigaCaseSV.deleteAigaCase(caseId,AigaInstCase.class);
			this.setPostInfo("success", true);
			this.setPostInfo("message", "用例删除成功");
		}catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", "用例删除失败");
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getCaseTableByCaseIds.do")
	private void getCaseTableByCaseIds(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String caseIds = request.getParameter("caseIds");
			AigaCase[] aigaCases = aigaCaseSV.getAigaCaseByCaseIds(caseIds, AigaInstCase.class);
			this.setTable(aigaCases);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", "获取数据失败,原因:"+e.getMessage());
		}finally{
			this.postInfo(request, response);
		}
	}
	@RequestMapping("/getCaseExtTableBySubTaskId.do")
	public void getCaseExtTableBySubTaskId(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String subTaskId=request.getParameter("subTaskId");
			if(subTaskId.equals(""))subTaskId="0";
			Object[] caseExt=aigaCaseSV.getAigaExtBySubTaskId(Integer.valueOf(subTaskId),AigaInstCase.class);
			this.setTable(caseExt);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", "获取数据失败,原因:"+e.getMessage());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/saveManualCase.do")
	public void saveManualCase(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			Object[] value = this.transFormToObj(request, new Class[]{AigaInstCase.class});
			if(value!=null&&value.length==1)
				if(value[0] instanceof AigaInstCase)
					aigaCaseSV.saveAigaCase((AigaInstCase)value[0]);
			this.setPostInfo("success", true);
			this.setPostInfo("caseId", ((AigaInstCase)value[0]).getCaseId());
			this.setPostInfo("message", "手工用例保存成功");
		}
		catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", "保存失败,原因:"+e.getMessage());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/pasteCase.do")
	public void pasteCase(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
			if(user==null)
				throw new Exception("未知当前登录人");
			String parentId = request.getParameter("parentId");
			if(parentId==null||parentId.equals(""))
				throw new Exception("缺少请求参数parentId");
			String name = new String(request.getParameter("name").getBytes("ISO8859-1"),"GBK");
			if(name==null||name.equals(""))
				throw new Exception("缺少请求参数name");
			String caseId = request.getParameter("caseId");
			if(caseId==null||caseId.equals(""))
				throw new Exception("缺少请求参数caseId");
			aigaCaseSV.savePasteCase(Integer.valueOf(parentId), name,Integer.valueOf(caseId),user);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", "保存失败,原因:"+e.getMessage());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getUnApprovalCaseTable.do")
	public void getUnApprovalCaseTable(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			AigaInstCase[] aigaInstCases = aigaCaseSV.getUnApprovalCase(null);
			this.setTable(aigaInstCases);
			this.setPostInfo("success", true);
		}catch(Exception e){
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", "获取数据失败,原因:"+e.getMessage());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/saveCaseForm.do")
	public void saveCaseForm(HttpServletRequest request, HttpServletResponse response)throws Exception{
		AigaInstCase aigaInstCase = null;
		try{
			Object[] objects = this.transFormToObj(request, new Class[]{AigaInstCase.class});
			for(Object object : objects){
				if(object instanceof AigaInstCase){
					aigaInstCase = (AigaInstCase)object;
				}
			}
			if(aigaInstCase!=null)
				aigaCaseSV.saveApprovalCase(aigaInstCase);
			this.setPostInfo("success", true);
		}catch(Exception e){
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", "保存失败,原因:"+e.getMessage());
		}finally{
			this.postInfo(request, response);
		}
	}
	
//	@RequestMapping("/saveCaseFolder.do")
//	public void saveCaseFolder(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		try{
//			String folderName = new String(request.getParameter("folderName").getBytes("iso8859-1"),"UTF-8");
//			String caseId = request.getParameter("caseId");
//			aigaCaseSV.saveCaseFolder(folderName, caseId);
//			this.setPostInfo("success", true);
//		}catch(Exception e){
//			this.setPostInfo("success", false);
//		}finally{
//			this.postInfo(request, response);
//		}
//	}
//	
//	@RequestMapping("/editCaseFolder.do")
//	public void editCaseFolder(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		try{
//			String folderName = new String(request.getParameter("folderName").getBytes("iso8859-1"),"UTF-8");
//			String caseId = request.getParameter("caseId");
//			aigaCaseSV.editCaseFolder(folderName, caseId);
//			this.setPostInfo("success", true);
//		}catch(Exception e){
//			this.setPostInfo("success", false);
//		}finally{
//			this.postInfo(request, response);
//		}
//	}
//	
//	@RequestMapping("/deleteCaseFolder.do")
//	public void deleteCaseFolder(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		try{
//			String folderName = new String(request.getParameter("folderName").getBytes("iso8859-1"),"UTF-8");
//			String caseId = request.getParameter("caseId");
//			aigaCaseSV.deleteCaseFolder(folderName, caseId);
//			this.setPostInfo("success", true);
//		}catch(Exception e){
//			this.setPostInfo("success", false);
//		}finally{
//			this.postInfo(request, response);
//		}
//	}
	
	@RequestMapping("/saveCaseOrder.do")
	public void saveCaseOrder(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			String caseElemIds = request.getParameter("caseElemIds");
			aigaCaseSV.saveCaseOrder(caseElemIds);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/batchApprovalCase.do")
	public void batchApprovalCase(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
			if(user==null)
				throw new Exception("未知当前登录人");
			String caseIds = request.getParameter("caseIds");
			if(caseIds!=null&&caseIds.length()!=0)
				aigaCaseSV.saveBatchApprovalCase(caseIds,user);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	@RequestMapping("/usecaseCollectionExport.do")
	public void usecaseCollectionExport(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ExcelVO excelVo=new ExcelVO();
		excelVo.setExportExcelName("");
		excelVo.setTemplateName("");
		Map map=new HashMap();
		excelVo.setDataMap(map);
		XlsHelper.export2Excel(request, response, excelVo);
	}
//	用例集查询
	@RequestMapping("/getUsecaseCollection.do")
	public void getUsecaseCollection(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String SQL="SELECT "+
							" (select sys.sys_name from aiga_system_folder sys where sys.sys_id = fun.sys_id) as systemFolder, "+
							" fun.sys_name as funPointFolder, "+
							" (select map.show from sys_constant map where map.category ='AIGA_FUN_FOLDER' and map.value=fun.FUN_TYPE and  map.category_name ='funType' and rownum=1 ) as funPointType, "+
							" fun.FUN_DESC as funPointDesc, "+
							" fun.MENU_PATH as menuPath, "+
							" (select map.show from sys_constant map where map.category ='AIGA_FUN_FOLDER' and map.value=fun.IMPORTANT_CLASS and  map.category_name ='importantClass' and rownum=1 )  as funPointImportant, "+
							" (SELECT map.show  FROM sys_constant map where map.category='case_important' and rownum =1 and map.value= c.IMPORTANT )as caseImportant, "+
							" c.case_name as caseName, "+
							" c.case_desc as caseDesc, "+
							" c.has_test as isHasTest, "+
							" (SELECT map.show  FROM sys_constant map where map.category='case_fac' and rownum =1 and map.value= c.maintenance_fac ) as maintenanceFac, "+
							" c.case_id as caseId, "+
							" c.test_type as testType, "+
							" fun.base_fun_label as baseFunLabel, "+
							" fun.busi_label as busiLabel" +
					" FROM aiga_inst_case c, aiga_fun_folder fun "+
					" where c.fun_folder_id = fun.fun_id ";
		StringBuffer conditionBuffer=new StringBuffer();
		String funPointFolder=request.getParameter("funPointFolder");
		String systemFolder=request.getParameter("systemFolder");
		String funPointImportant=request.getParameter("funPointImportant");
		String baseFunLabel=request.getParameter("baseFunLabel");
		String busiLabel=request.getParameter("busiLabel");
		String testType=request.getParameter("testType");
		String caseImportant=request.getParameter("caseImportant");
		String maintenanceFac=request.getParameter("maintenanceFac");
		String isRegressionTest=request.getParameter("isRegressionTest");
		
		conditionBuffer.append(BaseAction.NaNull(funPointFolder)?" and fun.sys_name like '%"+decodeCN(funPointFolder).trim()+"%' ":"");
		conditionBuffer.append(BaseAction.NaNull(systemFolder)?" and fun.sys_id ="+systemFolder:"");
		conditionBuffer.append(BaseAction.NaNull(funPointImportant)?" and fun.important_class="+funPointImportant:"");
		conditionBuffer.append(BaseAction.NaNull(caseImportant)?" and c.important="+caseImportant+"":"");
		conditionBuffer.append(BaseAction.NaNull(maintenanceFac)?" and c.maintenance_Fac= "+maintenanceFac:"");
		conditionBuffer.append(BaseAction.NaNull(isRegressionTest)?(isRegressionTest.toLowerCase().trim().equals("true")||isRegressionTest.toLowerCase().trim().equals("on")||isRegressionTest.toLowerCase().trim().equals("1")?" and c.regression_test=1":""):"");
		SQL+=conditionBuffer;
		List<Object[]> list=testPlanSV.getObjectBySQL(SQL);
		JSONObject json=new JSONObject();
		json.put("success", true);
		objList.clear();
		for(Object[] objs:list){
			Map<String, Object> map=new HashMap<String, Object>();
			if(objs.length!=15)throw new  Exception("数据查询长度有误！");
			map.put("systemFolder", NullValueFilter(objs[0]));
			map.put("funPointFolder", NullValueFilter(objs[1]));
			map.put("funPointType", NullValueFilter(objs[2]));
			map.put("funPointDesc", NullValueFilter(objs[3]));
			map.put("menuPath", NullValueFilter(objs[4]));
			map.put("funPointImportant", NullValueFilter(objs[5]));
			map.put("caseImportant", NullValueFilter(objs[6]));
			map.put("caseName", NullValueFilter(objs[7]));
			map.put("caseDesc", NullValueFilter(objs[8]));
			map.put("isHasTest", objs[9]!=null ?objs[9].equals("1")||objs[9].equals("on")?"是":"否":"未指定");
			map.put("maintenanceFac", NullValueFilter(objs[10]));
			map.put("caseId", NullValueFilter(objs[11]));
			map.put("testType", NullValueFilter(objs[12]));
			map.put("baseFunLabel", NullValueFilter(objs[13]));
			map.put("busiLabel", NullValueFilter(objs[14]));
			if(BaseAction.NaNull(testType)&&!CommonHelper.splitAndContain(map.get("testType").toString(), testType))continue;
			if(BaseAction.NaNull(baseFunLabel)&&!CommonHelper.splitAndContain(map.get("baseFunLabel").toString(), baseFunLabel))continue;
			if(BaseAction.NaNull(busiLabel)&&!CommonHelper.splitAndContain(map.get("busiLabel").toString(), busiLabel))continue;
			AigaManualTask[] manualTasks=aigaManualTaskSV.getManualTaskByCaseId(Integer.valueOf((String) map.get("caseId")));
			map.put("data", manualTasks);
			objList.add(map);
		}
		json.put("data", objList);
		ActionHelper.returnResponseApplicatonJson(request, response, json);
	}
	
	@RequestMapping("/downloadCase.do")
	public void downloadCase(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ExcelVO excelVo=new ExcelVO();
		String strCaseIds=request.getParameter("caseIds");
		List list=new ArrayList();
		if(this.NaNull(strCaseIds)){
			strCaseIds+=",";
			for(Map map:objList){
				String caseId=map.get("caseId").toString()+",";
				if(strCaseIds.indexOf(caseId)>-1)list.add(map);
			}
		}
		excelVo.setExportExcelName("用例集.xlsx");
		excelVo.setTemplateName("userCaseCollectionTemplate.xlsx");
		Map beans=new HashMap();
		beans.put("caseList", list);
		excelVo.setDataMap(beans);
		XlsHelper.export2Excel(request, response, excelVo);
	}
	
	private String checkValue(Object value){
		if(value==null){
			return "";
		}else{
			return String.valueOf(value);
		}
	}
	
	@RequestMapping("/getCaseParam.do")
	public void getCaseParam(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			String type = request.getParameter("type");
			SysConstant[] constants = null;
			if(type.equals("case_important")){
				constants = SysContentUtil.getSysContant("case_important");
			}else if(type.equals("case_fac")){
				constants = SysContentUtil.getSysContant("case_fac");
			}else if(type.equals("case_regress")){
				constants = SysContentUtil.getSysContant("case_regress");
			}else if(type.equals("has_test")){
				constants = SysContentUtil.getSysContant("has_test");
			}else if(type.equals("test_type")){
				constants = SysContentUtil.getSysContant("test_type");
			}else if(type.equals("case_type")){
				constants = SysContentUtil.getSysContant("case_type");
			}else if(type.equals("efficiency_test")){
				constants = SysContentUtil.getSysContant("efficiency_test");
			}else if(type.equals("efficiency_test_type")){
				constants = SysContentUtil.getSysContant("efficiency_test_type");
			}else if(type.equals("teminal_test")){
				constants = SysContentUtil.getSysContant("teminal_test");
			}else if(type.equals("elem_type")){
				constants = SysContentUtil.getSysContant("ELEM_TYPE");
			}else if(type.equals("analysis_method")){
				constants = SysContentUtil.getSysContant("ANALYSIS_METHOD");
			}else if(type.equals("test_sub_elem")){
				DetachedCriteria criteria = DetachedCriteria.forClass(AigaRElemSec.class);
				String subElemIds = request.getParameter("subElemIds");
				if(subElemIds==null)
					throw new Exception("缺少请求参数subElemIds");
				List ids = new ArrayList<Integer>();
				ids.add(0);
				if(subElemIds.length()>0){
					String[] subElemId = subElemIds.split(",");
					for(String id : subElemId){
						ids.add(Integer.valueOf(id));
					}
				}
				AigaTestSubElem[] aigaTestSubElems = aigaTestElemSV.getSubElemByIds(ids);
				constants = new SysConstant[aigaTestSubElems.length];
				for(int i=0,n=aigaTestSubElems.length;i<n;i++){
					SysConstant constant = new SysConstant();
					constant.setCategory("TEST_SUB_ELEM");
					constant.setShow(aigaTestSubElems[i].getElemValue());
					constant.setValue(aigaTestSubElems[i].getSubElemId());
					
					constants[i] = constant;
				}
			}
			JSONArray array = new JSONArray();
			for(int i=0,n=constants.length;i<n;i++){
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("text", constants[i].getShow());
				jsonObject.put("value", constants[i].getValue());
				array.add(jsonObject);
			}
			this.setPostInfo("data", array);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			e.printStackTrace();
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	@RequestMapping("/getAddReasonParam.do")
	public void getAddReasonParam(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONArray array = new JSONArray();
		JSONObject json = new JSONObject();
		try{
			SysConstant[] constants = null;
			constants = SysContentUtil.getSysContant("ADD_REASON_TYPE");
			for(int i=0,n=constants.length;i<n;i++){
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("text", constants[i].getShow());
				jsonObject.put("value", constants[i].getValue());
				array.add(jsonObject);
			}
			json.put("success", true);
			json.put("data", array);
		}catch (Exception e) {
			e.printStackTrace();
			json.put("success", false);
		}finally{
			ActionHelper.responseData4JSON(request, response, json);
		}
	}
	@RequestMapping("/getSysFolder.do")
	public void  getSysFolder(HttpServletRequest request, HttpServletResponse response) throws Exception {
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaSystemFolder.class);
		criteria.addOrder(Order.asc("sysId"));
		AigaSystemFolder[] sysFolders=aigaSystemFolderSV.getSystemFolder(criteria);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("success", true);
		map.put("data", sysFolders);
		ActionHelper.returnResponseJsonMap(request, response, map);
	}
	@RequestMapping("/getBaseBusiLabel.do")
	public void  getBaseFunLabel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaBaseBusi.class);
		criteria.addOrder(Order.asc("busiId"));
		AigaBaseBusi[] baseBusis=baseBusiSV.getAigaBaseBusi(criteria);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("success", true);
		map.put("data", baseBusis);
		ActionHelper.returnResponseJsonMap(request, response, map);
	}
	@RequestMapping("/getBusiLabel.do")
	public void  getBusiLabel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaBusi.class);
		AigaBusi[] baseBusis=aigaBusiSV.getAigaBusi(criteria);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("success", true);
		map.put("data", baseBusis);
		ActionHelper.returnResponseJsonMap(request, response, map);
	}
	
	@RequestMapping("/getAutotestParam.do")
	public void getAutotestParam(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			String caseId = request.getParameter("caseId");
			String node = request.getParameter("node");
			if(caseId==null||caseId.equals(""))
				throw new Exception("错误:缺少参数caseId");
			JSONArray jsonResult = aigaAutotestParamsSV.getAigaAutotestParamsByCaseId(Integer.valueOf(caseId),Integer.valueOf(node));
			this.setPostInfo("children", jsonResult);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
			e.printStackTrace();
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getInputValue.do")
	public void getInputValue(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			String caseId = request.getParameter("caseId");
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaAutotestParams.class);
			criteria.setProjection(Projections.distinct(Projections.property("paramName")));
			criteria.add(Restrictions.eq("caseId", Integer.valueOf(caseId)));
			criteria.add(Restrictions.eq("isleaf", "Y"));
			List aigaAutotestParams = aigaAutotestParamsSV.getAigaAutotestParamsByCriteria(criteria);
			JSONArray array = new JSONArray();
			for(Object aigaAutotestParam : aigaAutotestParams){
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("text", aigaAutotestParam.toString());
				jsonObject.put("value", aigaAutotestParam.toString());
				array.add(jsonObject);
			}
			this.setPostInfo("data", array);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			e.printStackTrace();
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/saveAutotestParam.do")
	public void saveAutotestParam(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			String saveData = request.getParameter("savedata");
			String deleteData = request.getParameter("deletedata");
			if (saveData != null && saveData.length() > 0)
			{
				String[] formats={"yyyy-MM-dd HH:mm:ss" };
				JSONUtils.getMorpherRegistry().registerMorpher(new JsonDateToObj(formats));  
			
				JSONArray jsonArr = JSONArray.fromObject(saveData);
				for (int i = 0, n = jsonArr.size(); i < n; i++)
				{
					JSONObject json = (JSONObject) jsonArr.get(i);
					AigaAutotestParams aValue = new AigaAutotestParams();
					aValue.setCaseId(json.getInt("caseId"));
					aValue.setIsleaf(json.getBoolean("leaf")==false?"N":"Y");
					aValue.setParamId(json.getString("paramId").equals("")?null:Integer.valueOf((json.getString("paramId"))));
					aValue.setParamName(json.getString("paramName"));
					aValue.setParamValue(json.getString("paramValue"));
					aValue.setParentId(json.getString("parentId").equals("")?null:Integer.valueOf((json.getString("parentId"))));
					aValue.setExeSql(json.getString("exeSql"));
					aValue.setParamDesc(json.getString("paramDesc"));
					aigaAutotestParamsSV.saveAigaAutotestParams(aValue);
				}
			}
			if (deleteData != null && deleteData.length() > 0)
			{
				String[] formats={"yyyy-MM-dd HH:mm:ss" };
				JSONUtils.getMorpherRegistry().registerMorpher(new JsonDateToObj(formats));  
			
				JSONArray jsonArr = JSONArray.fromObject(deleteData);
				for (int i = 0, n = jsonArr.size(); i < n; i++)
				{
					JSONObject json = (JSONObject) jsonArr.get(i);
					AigaAutotestParams aValue = new AigaAutotestParams();
					aValue.setCaseId(json.getInt("caseId"));
					aValue.setIsleaf(json.getBoolean("leaf")==false?"N":"Y");
					aValue.setParamId(json.getString("paramId").equals("")?null:Integer.valueOf((json.getString("paramId"))));
					aValue.setParamName(json.getString("paramName"));
					aValue.setParamValue(json.getString("paramValue"));
					aValue.setParentId(json.getString("parentId").equals("")?null:Integer.valueOf((json.getString("parentId"))));
					aigaAutotestParamsSV.deleteAigaAutotestParams(aValue);
				}
			}
			this.setPostInfo("success", true);
		}catch (Exception e) {
			e.printStackTrace();
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	
	@RequestMapping("/getComBoxForFunFolder.do")
	public void getComBoxForFunFolder(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysConstant[] sysConstants = SysContentUtil
		.getSysContant(AIGA_FUN_FOLDER,"fun_type");
		String queryFlag = request.getParameter("query");
		System.out.println(queryFlag);
		JSONArray jsonAry = new JSONArray();
		for (SysConstant sysConstant : sysConstants) {
			if (!sysConstant.getCategoryName().equals(queryFlag))
				continue;
			JSONObject json = new JSONObject();
			json.put("value", sysConstant.getValue());
			json.put("show", sysConstant.getShow());
			jsonAry.add(json);
		}
		JSONObject json = new JSONObject();
		
		json.put("success", true);
		json.put("data", jsonAry);
		
		ActionHelper.responseData4JSON(request, response, json);
	}
	
	@RequestMapping("/getComBoxForFirm.do")
	public void getComBoxForFirm(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysConstant[] sysConstants = SysContentUtil
		.getSysContant("AIGA_SYSTEM_FOLDER");
		String queryFlag = request.getParameter("query");
		System.out.println(queryFlag);
		JSONArray jsonAry = new JSONArray();
		for (SysConstant sysConstant : sysConstants) {
			if (!sysConstant.getCategoryName().equals(queryFlag))
				continue;
			JSONObject json = new JSONObject();
			json.put("value", sysConstant.getValue());
			json.put("show", sysConstant.getShow());
			jsonAry.add(json);
		}
		JSONObject json = new JSONObject();
		
		json.put("success", true);
		json.put("data", jsonAry);
		
		ActionHelper.responseData4JSON(request, response, json);
	}
	
	@RequestMapping("/getComBoxForSystemFolder.do")
	public void getComBoxForSystemFolder(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaSystemFolder.class);
		AigaSystemFolder[] aigaSystemFolders = aigaSystemFolderSV.getSystemFolder(criteria);
		JSONArray jsonAry = new JSONArray();
		for (AigaSystemFolder aigaSystemFolder : aigaSystemFolders) {
			JSONObject json = new JSONObject();
			json.put("value", aigaSystemFolder.getSysId());
			json.put("show", aigaSystemFolder.getSysName());
			jsonAry.add(json);
		}
		JSONObject json = new JSONObject();
		
		json.put("success", true);
		json.put("data", jsonAry);
		
		ActionHelper.responseData4JSON(request, response, json);
	}
	
	@RequestMapping("/getComBoxForSubSystemFolder.do")
	public void getComBoxForSubSystemFolder(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String sysId = request.getParameter("sysId");
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaSubSysFolder.class);
		if(sysId!=null&&!sysId.equals("")){
			criteria.add(Restrictions.eq("sysId", Integer.valueOf(sysId)));
		}
		AigaSubSysFolder[] aigaSystemFolders = aigaSubSystemFolderSV.getSubSysFolder(criteria);
		JSONArray jsonAry = new JSONArray();
		if(aigaSystemFolders.length==0){
			/*
			JSONObject json = new JSONObject();
			json.put("value", "");
			json.put("show", "--无相关子系统--");
			jsonAry.add(json);*/
		}else{
			for (AigaSubSysFolder aigaSystemFolder : aigaSystemFolders) {
				JSONObject json = new JSONObject();
				json.put("value", aigaSystemFolder.getSubsysId());
				json.put("show", aigaSystemFolder.getSysName());
				jsonAry.add(json);
			}
		}
		JSONObject json = new JSONObject();
		
		json.put("success", true);
		json.put("data", jsonAry);
		
		ActionHelper.responseData4JSON(request, response, json);
	}
		
	@RequestMapping("/getComBoxForBaseBusi.do")
	public void getComBoxForBaseBusi(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaBaseBusi.class);
		criteria.addOrder(Order.asc("busiName"));
		AigaBaseBusi[] aigaBaseBusis = aigaBaseBusiSV.getAigaBaseBusi(criteria);
		JSONArray jsonAry = new JSONArray();
		for (AigaBaseBusi aigaBaseBusi : aigaBaseBusis) {
			JSONObject json = new JSONObject();
			json.put("value", aigaBaseBusi.getBusiId().toString());
			json.put("show", aigaBaseBusi.getBusiName());
			jsonAry.add(json);
		}
		JSONObject json = new JSONObject();
		
		json.put("success", true);
		json.put("data", jsonAry);
		
		ActionHelper.responseData4JSON(request, response, json);
	}
		
	@RequestMapping("/getComBoxForBusi.do")
	public void getComBoxForBusi(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		DetachedCriteria criteria = DetachedCriteria.forClass(AigaBusi.class);
		criteria.addOrder(Order.asc("busiName"));
		AigaBusi[] aigaBusis = aigaBusiSV.getAigaBusi(criteria);
		JSONArray jsonAry = new JSONArray();
		for (AigaBusi aigaBusi : aigaBusis) {
			JSONObject json = new JSONObject();
			json.put("value", aigaBusi.getBusiId().toString());
			json.put("show", aigaBusi.getBusiName());
			jsonAry.add(json);
		}
		JSONObject json = new JSONObject();
		
		json.put("success", true);
		json.put("data", jsonAry);
		
		ActionHelper.responseData4JSON(request, response, json);
	}
	
	@RequestMapping("/saveFunFloderForm.do")
	public void saveFunPointForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		try{
			Object[] value = this.transFormToObj(request, new Class[]{AigaFunFolder.class});
			if(value!=null&&value.length==1)
				if(value[0] instanceof AigaFunFolder){
					AigaFunFolder aigaFunFolder = (AigaFunFolder)value[0];
					if(aigaFunFolder.getFunId()==null){//新增
						aigaFunFolder.setCreateTime(new Timestamp(System.currentTimeMillis()));
						aigaFunFolder.setUpdateTime(new Timestamp(System.currentTimeMillis()));
						aigaFunFolder.setCreatorId(aigaFunFolder.getOperatorId());
						aigaFunFolder.setCreatorName(aigaFunFolder.getOperatorName());
					}else{//修改
						aigaFunFolder.setUpdateTime(new Timestamp(System.currentTimeMillis()));
					}
					aigaFunFolderSV.saveAigaFunFolder(aigaFunFolder);
				}
			this.setPostInfo("success", true);
			this.setPostInfo("message", "功能点保存成功");
		}
		catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", "保存失败,原因:"+e.getMessage());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getFunFolderList.do")
	public void getFunFolderList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		JSONArray json = new JSONArray();
		String sysName = request.getParameter("sysName");
		String sysId = request.getParameter("sysId");
		String subSysId = request.getParameter("subSysId"); 
		String importantClass = request.getParameter("importantClass");
		String funType = request.getParameter("funType");
		StringBuffer conditionBuffer = new StringBuffer();
		Map map=this.paginationParams(request);
		int pageNo = Integer.parseInt(map.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(map.get(this.LIMIT_PARAM).toString());
		/*
		conditionBuffer.append((sysName!=null&&!sysName.equals(""))?" and sys_name like '"+this.decodeCN(sysName).trim()+"%'":"");//功能点名称
		conditionBuffer.append((sysId!=null&&!sysId.equals("")&&!sysId.equals("null")&&!sysId.equals("undefined"))?" and sys_id ='"+this.decodeCN(sysId).trim()+"'":"");//所属系统
		conditionBuffer.append((importantClass!=null&&!importantClass.equals("")&&!importantClass.equals("null")&&!importantClass.equals("undefined"))?" and important_class ='"+this.decodeCN(importantClass)+"'":"");//重要等级
		conditionBuffer.append((funType!=null&&!funType.equals("")&&!funType.equals("null")&&!funType.equals("undefined"))?" and fun_type ='"+this.decodeCN(funType)+"'":"");//功能点类型
		AigaFunFolder[] funFolders = aigaFunFolderSV.getAigaFunFolderBySql("select * from aiga_fun_folder where 1=1  and rowid in( select rid from(select rownum rn, rid from( select rowid rid, fun_id from aiga_fun_folder order by fun_id ) where rownum<100 ) where rn >96 ) "+conditionBuffer.toString()+" ORDER BY fun_id DESC");
		*/
		
		conditionBuffer.append((sysName!=null&&!sysName.equals(""))?" and a.sysName like '%"+this.decodeCN(sysName).trim()+"%'":"");//功能点名称
		conditionBuffer.append((sysId!=null&&!sysId.equals("")&&!sysId.equals("null")&&!sysId.equals("undefined"))?" and a.sysId ='"+this.decodeCN(sysId).trim()+"'":"");//所属系统
		conditionBuffer.append((subSysId!=null&&!subSysId.equals("")&&!subSysId.equals("null")&&!subSysId.equals("undefined"))?" and a.subSysId ='"+this.decodeCN(subSysId).trim()+"'":"");//所属子系统
		conditionBuffer.append((importantClass!=null&&!importantClass.equals("")&&!importantClass.equals("null")&&!importantClass.equals("undefined"))?" and a.importantClass ='"+this.decodeCN(importantClass)+"'":"");//重要等级
		conditionBuffer.append((funType!=null&&!funType.equals("")&&!funType.equals("null")&&!funType.equals("undefined"))?" and a.funType ='"+this.decodeCN(funType)+"'":"");//功能点类型
		conditionBuffer.append(" and a.isInvalid = 0 ");//只查未删除
		List<Object> list = commonPageinationSV.getObjectList(pageNo, pageSize, "from AigaFunFolder a where 1=1 "+conditionBuffer.toString());
		Iterator<Object> items = list.iterator();
		int i=0;
		AigaFunFolder[] funFolders=new AigaFunFolder[list.size()];
		while(items.hasNext()){
			funFolders[i++] = (AigaFunFolder)items.next();
		}
		//this.transferrLabel(funFolders,"IdToName");
		json = JSONArray.fromObject(funFolders, this.jsonConfig);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal("from AigaFunFolder a where 1=1 "+conditionBuffer.toString()));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
		
	}
	
	@RequestMapping("/getFunFolderByFunId.do")
	public void getFunFolderByFunId(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String funId = request.getParameter("funId");
		StringBuffer conditionBuffer = new StringBuffer();
		conditionBuffer.append((funId!=null&&!funId.equals(""))?" and a.funId = "+funId+"":"");//功能点ID
		AigaFunFolder[] funFolders =aigaFunFolderSV.getAigaFunFolderBySql("FROM AigaFunFolder a where 1=1 "+conditionBuffer.toString());
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		map.put("success", false);
		if (funFolders.length == 1) {
			JSON json =JSONObject.fromObject(funFolders[0], jsonConfig);
			map.put("data", json);
			map.put("success", true);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	
	//将关联的业务标签和基础业务标签的ID转义成标签名称
	private String transferrLabel(AigaFunFolder[] funFolders,String flag){
		String baseFunLabelBugs = "";//记录基础业务出错.
		String busiLabelBugs = "";//记录业务标签出错.
		for(AigaFunFolder funFolder : funFolders){
			String baseFunLabelFlag = funFolder.getBaseFunLabel();//查出关联的基础业务标签
			if(baseFunLabelFlag!=null&&!baseFunLabelFlag.equals("")){
				try{
					String[] baseFunLabels = baseFunLabelFlag.split(",");
					StringBuffer result = new StringBuffer();
					for(String baseFunLabel : baseFunLabels){
						String temp = null;
						if(flag.equals("IdToName")){
							temp = LabelMapUtil.getAigaBaseBusiName(baseFunLabel);
						}else if(flag.equals("NameToId")){
							temp = LabelMapUtil.getAigaBaseBusiId(baseFunLabel);
						}
						if(temp == null){
							baseFunLabelBugs="1";
							continue;
						}
						result.append(temp+",");
					}
					if(result.length()==0){
						result.append("数据错误");
						funFolder.setBaseFunLabel(result.toString());
					}else{
						funFolder.setBaseFunLabel(result.substring(0,result.length()-1));
					}
				}catch(Exception e){
					funFolder.setBaseFunLabel("未指定");
				}
			}
		}
		for(AigaFunFolder funFolder : funFolders){
			String busiLabelFlag = funFolder.getBusiLabel();//查出关联的业务标签
			if(busiLabelFlag!=null&&!busiLabelFlag.equals("")){
				try{
					String[] busiLabels = busiLabelFlag.split(",");
					StringBuffer result = new StringBuffer();
					for(String busiLabel : busiLabels){
						String temp = null;
						if(flag.equals("IdToName")){
							temp = LabelMapUtil.getAigaBusiName(busiLabel);
						}else if(flag.equals("NameToId")){
							temp = LabelMapUtil.getAigaBusiId(busiLabel);
						}
						if(temp == null){
							busiLabelBugs="2";
							continue;
						}
						result.append(temp+",");
					}
					if(result.length()==0){
						result.append("数据错误");
						funFolder.setBusiLabel(result.toString());
					}else{
						funFolder.setBusiLabel(result.substring(0,result.length()-1));
					}
				}catch(Exception e){
					funFolder.setBusiLabel("未指定");
				}
			}
		}
		return new String(baseFunLabelBugs+","+busiLabelBugs);
	}
	@RequestMapping("/caseCoverageCountChart.do")
	public void caseCoverageCountChart(HttpServletRequest request,HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		try {
			String json = aigaFunFolderSV.caseCoverageCountChart();
			map.put("data", json);
			map.put("success", true);
		} catch (Exception e) {
			this.setPostInfo("success", false);
		} finally {
			ActionHelper.returnResponseData(request, response, map);
		}
	}
	@RequestMapping("/getSysCoverage.do")
	public void getSysCoverage(HttpServletRequest request,HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		JSONArray jsonArray=new JSONArray();
		SysConstant[] sysContants = SysContentUtil.getSysContant("test_type");
		try {
			List<Map<String, Float[]>> list = aigaFunFolderSV.getSubSysCoverage();
			for(Map<String, Float[]> tempMap:list){
				JSONObject object=new JSONObject();
//				tempJSON
				tempMap.keySet();
				 for (Map.Entry<String, Float[]> entry : tempMap.entrySet()) {
					   object.put("sysName", entry.getKey());
					   Float[] floats=entry.getValue();
					   for(int i=0,n=sysContants.length;i<n;i++){
						   BigDecimal bg = new BigDecimal(floats[i]*100);
						     double floatValue = bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
						   object.put("sys"+sysContants[i].getConstantId(),floatValue+"%" );
					   }
					  }
				;
				jsonArray.add(object);
			}
			map.put("data", jsonArray);
			map.put("success", true);
		} catch (Exception e) {
			this.setPostInfo("success", false);
		} finally {
			ActionHelper.returnResponseData(request, response, map);
		}
	}
	
	@RequestMapping(value="/downloadTestReport.do")
	public void downloadTestReport(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String subTaskId =  request.getParameter("subTaskId");
		StringBuffer querySql = new StringBuffer("FROM AigaTestSubTask a where 1=1 ");
		Configuration freemarkerConfiguration = new Configuration();
		if(subTaskId != null && !subTaskId.equals("")) {
			querySql.append(" and a.subTaskId = " + subTaskId);
		}
		AigaTestSubTask[] subTasks = reqSV.getAigaTestSubTaskBySql(querySql.toString());
		if(subTasks.length == 1){//查询到相关的测试子任务(只有一个)
			/**
			 * 获取模版
			 */
			freemarkerConfiguration.setDefaultEncoding("UTF-8");
			String path=LuceneCommon.getProertiesValue("excel.exportPath", "excel.properties");
			File dir = new File(path);
			//File dir = new File("E:/");
			freemarkerConfiguration.setDirectoryForTemplateLoading(dir);
			Template template = null;
			try {
				template = freemarkerConfiguration.getTemplate("new_model.xml","UTF-8");
			} catch (IOException e) {
				e.printStackTrace();
			}
			//输出文档路径及名称
			//File outFile = new File("E:/result.doc");
			Writer out = null;
			/**
			 * 填充数据
			 */
			Map<String, Object> dataMap = new HashMap<String, Object>();
			/**
			 * 第一部分(基本信息)
			 */
			//任务信息
			if(subTasks[0].getTaskId()!=null){//防止脏数据的出现
				List<Object> list=testPlanSV.getObjectByHQL("FROM AigaTestTask a where 1=1 and a.taskId='"+subTasks[0].getTaskId()+"'");
				AigaTestTask aigaTestTask = new AigaTestTask();
				if(list.size()==1){
					try{
					aigaTestTask = (AigaTestTask) list.get(0);
					String planId = aigaTestTask.getPlanId().toString();
					if(planId!=null&&!planId.equals("")){
						AigaTestPlan[] aigaTestPlan = testPlanSV.getAigaTestPlanBySql("FROM AigaTestPlan a WHERE a.planId="+planId);
						if(aigaTestPlan.length==1){
							dataMap.put("factCompleteTime", aigaTestPlan[0].getFactCompleteTime());
						}
					}
					}catch (Exception e) {
						dataMap.put("factCompleteTime", "暂未关联计划");
					}
				}
				dataMap.put("testTask", aigaTestTask);
			}
			//子任务信息
			if(subTasks[0].getSubTaskName()!=null&&!subTasks[0].getSubTaskName().equals("")){
				try{subTasks[0].setSubTaskName(subTasks[0].getSubTaskName().replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));}catch(Exception e){}//子任务名称
				try{subTasks[0].setTestReply(subTasks[0].getTestReply().replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));}catch(Exception e){}//2.1.1测试依据/主要需求描述
				try{subTasks[0].setReqAnalysis(subTasks[0].getReqAnalysis().replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));}catch(Exception e){}//2.1.2需求分析
				try{subTasks[0].setNowTestInfo(subTasks[0].getNowTestInfo().replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));}catch(Exception e){}//2.1.3现状测试
			}
			dataMap.put("testSubTask", subTasks[0]);
			//是否重点需求
			String subTaskPriority = null;
			try{
				int priority = 0;
				priority = subTasks[0].getSubTaskPriority();
				if(priority == 1){
					subTaskPriority = "是";
				}else if(priority == 0){
					subTaskPriority = "否";
				}else{
					subTaskPriority = "未指定数据";
				}
			}catch(Exception e){
				subTaskPriority = "未指定数据";
			}
			dataMap.put("subTaskPriority", subTaskPriority);
			//取出测试环境下最新的测试任务
			AigaRunTask[] aigaRunTasks = aigaRunTaskSV.getAigaRunTask("FROM AigaRunTask b WHERE b.subTaskId="+subTasks[0].getSubTaskId()+" AND b.collectType=1 ORDER BY b.createTime DESC");
			if(aigaRunTasks.length>=1){
				//插入完成时间
				dataMap.put("updateTime", aigaRunTasks[0].getUpdateTime());
			}
			/**
			 * 第二部分[2.2部分]
			 */
			AigaTestResource[] results = resourceSV.getAigaResourcesBySql("FROM AigaTestResource WHERE sub_task_id=" + subTasks[0].getSubTaskId());
			if(results.length>=1){
				//获取资源类型
				SysConstant[] sysConstants = SysContentUtil.getSysContant("resource_type");
				Map<String, String> map = new HashMap<String, String>();
				for(SysConstant sysConstant:sysConstants){
					map.put(sysConstant.getValue().toString(), sysConstant.getShow());
				}
				List<Map> aigaTestResourceList = new LinkedList<Map>();
				for(AigaTestResource result:results){
					Map<String,Object> aigaTestResourceMap = new HashMap<String, Object>();
					//插入资源类型
					try{
						String resourceType = map.get(String.valueOf(result.getResourceType()));
						if(resourceType != null && !resourceType.equals("")){
							aigaTestResourceMap.put("resourceType", resourceType.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
						}else{
							aigaTestResourceMap.put("resourceType", "数据错误");
						}
					}catch(Exception e){
						aigaTestResourceMap.put("resourceType", "数据错误");
					}
					//插入资源描述
					try{
						String resourceDesc = result.getResourceDesc();
						if(resourceDesc != null && !resourceDesc.equals("")){
							aigaTestResourceMap.put("resourceDesc", resourceDesc.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
						}else{
							aigaTestResourceMap.put("resourceDesc", "未指定数据");
						}
					}catch(Exception e){
						aigaTestResourceMap.put("resourceDesc", "未指定数据");
					}
					aigaTestResourceList.add(aigaTestResourceMap);
				}
				dataMap.put("testResource", aigaTestResourceList);
			}
			/**
			 * 第二部分[2.3可测分析]
			 */
			AigaTestSubReason[] reasons = reqSV.getAigaTestSubReasonBySql("FROM AigaTestSubReason WHERE subTaskId=" + subTasks[0].getSubTaskId());
			if(reasons.length >=1){
				//获取不可测环境test_unable_reason reasonType
				SysConstant[] reasonEnvTypeSysConstants = SysContentUtil.getSysContant("test_unable_env");
				Map<String, String> reasonEnvTypeMap = new HashMap<String, String>();
				for(SysConstant sysConstant:reasonEnvTypeSysConstants){
					reasonEnvTypeMap.put(sysConstant.getValue().toString(), sysConstant.getShow());
				}
				//获取不可测类型
				SysConstant[] reasonTypeSysConstants = SysContentUtil.getSysContant("test_unable_reason");
				Map<String, String> reasonTypeMap = new HashMap<String, String>();
				for(SysConstant sysConstant:reasonTypeSysConstants){
					reasonTypeMap.put(sysConstant.getValue().toString(), sysConstant.getShow());
				}
				List<Map> aigaTestSubReasonList = new LinkedList<Map>();
				for(AigaTestSubReason reason:reasons){
					Map<String,Object> aigaTestSubReasonMap = new HashMap<String, Object>();
					//插入不可测环境
					try{
						String reasonEnvType = reasonEnvTypeMap.get(String.valueOf(reason.getReasonEnvType()));
						if(reasonEnvType != null && !reasonEnvType.equals("")){
							aigaTestSubReasonMap.put("reasonEnvType", reasonEnvType.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
						}else{
							aigaTestSubReasonMap.put("reasonEnvType", "数据错误");
						}
					}catch(Exception e){
						aigaTestSubReasonMap.put("reasonEnvType", "数据错误");
					}
					//插入不可测类型
					try{
						String reasonType = reasonTypeMap.get(String.valueOf(reason.getReasonType()));
						if(reasonType != null && !reasonType.equals("")){
							aigaTestSubReasonMap.put("reasonType", reasonType.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
						}else{
							aigaTestSubReasonMap.put("reasonType", "数据错误");
						}
					}catch(Exception e){
						aigaTestSubReasonMap.put("reasonType", "数据错误");
					}
					//插入资源描述
					try{
						String reasonDesc = reason.getReasonDesc();
						if(reasonDesc != null && !reasonDesc.equals("")){
							aigaTestSubReasonMap.put("reasonDesc", reasonDesc.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
						}else{
							aigaTestSubReasonMap.put("reasonDesc", "未指定数据");
						}
					}catch(Exception e){
						aigaTestSubReasonMap.put("reasonDesc", "未指定数据");
					}
					aigaTestSubReasonList.add(aigaTestSubReasonMap);
				}
				dataMap.put("testSubReason", aigaTestSubReasonList);
			}
			/**
			 * 第三部分[3.1用例集描述/3.2用例执行]
			 */
			int allCaseCount = 0; //测试环境下测试用例总数
			int passCount = 0; //测试环境下通过用例数
			int zallCaseCount = 0; //准发布环境下测试用例总数
			int zpassCount = 0; //准发布环境下通过用例数
			int sallCaseCount = 0; //生产环境下测试用例总数
			int spassCount = 0; //生产环境下通过用例数
			int caseOrder = 1; //用例编号
			AigaFunPoint[] aigaFunPoints = funPSV.getFunPointBySql("FROM AigaFunPoint a WHERE a.subTaskId=" + subTaskId);
			if(aigaFunPoints.length != 0){
				List<Map> aigaInstCaseList = new LinkedList<Map>();
				for(AigaFunPoint aigaFunPoint : aigaFunPoints){
					//插入用例集描述
					if(aigaFunPoint.getFunId()!=null&&!aigaFunPoint.getFunId().equals("")){
						AigaInstCase[] cases = aigaCaseSV.getInstCaseBySql("FROM AigaInstCase a WHERE a.caseId IN (SELECT b.caseId FROM AigaRFunCase b WHERE b.funId="+ aigaFunPoint.getFunId() +") and a.isDelete=0");
						if(cases.length >=1){
							for(AigaInstCase aigaInstCase:cases){
								Map<String,Object> aigaInstCaseMap = new HashMap<String, Object>();
								////////////////////////////////////////////////////////公共部分
								//插入用例名称
								try{
									String caseName = aigaInstCase.getCaseName();
									if(caseName != null && !caseName.equals("")){
										aigaInstCaseMap.put("caseName", caseName.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
									}else{
										aigaInstCaseMap.put("caseName", "未指定数据");
									}
								}catch(Exception e){
									aigaInstCaseMap.put("caseName", "未指定数据");
								}
								//插入是否自动化测试
								try{
									String hasTest = aigaInstCase.getHasTest().toString();
									if(hasTest != null && !hasTest.equals("")){
										if(hasTest.equals("1")){
											aigaInstCaseMap.put("hasTest", "是");
										}else{
											aigaInstCaseMap.put("hasTest", "否");
										}
									}else{
										aigaInstCaseMap.put("hasTest", "未指定数据");
									}
								}catch(Exception e){
									aigaInstCaseMap.put("hasTest", "数据错误");
								}
								////////////////////////////////////////////////////////3.1
								//插入用例描述
								try{
									String caseDesc = aigaInstCase.getCaseDesc();
									if(caseDesc != null && !caseDesc.equals("")){
										aigaInstCaseMap.put("caseDesc", caseDesc.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
									}else{
										aigaInstCaseMap.put("caseDesc", "未指定数据");
									}
								}catch(Exception e){
									aigaInstCaseMap.put("caseDesc", "未指定数据");
								}
								//插入创建时间
								try{
									Date data = aigaInstCase.getCreateTime();
									String createTime = "";
									if(data!=null){
										createTime = new SimpleDateFormat("yyyy-MM-dd").format(data).toString();
									}
									if(createTime != null && !createTime.equals("")){
										aigaInstCaseMap.put("createTime", createTime);
									}else{
										aigaInstCaseMap.put("createTime", "未指定数据");
									}
								}catch(Exception e){
									aigaInstCaseMap.put("createTime", "未指定数据");
								}
								//插入作者
								try{
									String author = aigaInstCase.getAuthor();
									if(author != null && !author.equals("")){
										aigaInstCaseMap.put("author", author.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
									}else{
										aigaInstCaseMap.put("author", "未指定数据");
									}
								}catch(Exception e){
									aigaInstCaseMap.put("author", "未指定数据");
								}
								//////////////////////////////////////////////////3.2
								//插入显示编号(3.2.x)
								aigaInstCaseMap.put("caseOrder", caseOrder++);
								//插入场景名称
								try{
									String secId = aigaInstCase.getSecId().toString();
									if(secId!=null&&!secId.equals("")){
										AigaSecene aigaSecene = aigaSeceneSV.getAigaSeceneById(Integer.parseInt(secId));
										String seceneName = aigaSecene.getSeceneName();
										if(seceneName != null && !seceneName.equals("")){
											aigaInstCaseMap.put("seceneName", seceneName.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
										}else{
											aigaInstCaseMap.put("seceneName", "未指定数据");
										}
									}else{
										aigaInstCaseMap.put("seceneName", "未指定数据");
									}
								}catch(Exception e){
									aigaInstCaseMap.put("seceneName", "未指定数据");
								}
								//插入前置条件
								try{
									String casePreCond = aigaInstCase.getCasePreCond();
									if(casePreCond != null && !casePreCond.equals("")){
										aigaInstCaseMap.put("casePreCond", casePreCond.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
									}else{
										aigaInstCaseMap.put("casePreCond", "未指定数据");
									}
								}catch(Exception e){
									aigaInstCaseMap.put("casePreCond", "未指定数据");
								}
								//插入用例执行情况
								try{
									//取出测试环境下最新的测试任务
									aigaRunTasks = aigaRunTaskSV.getAigaRunTask("FROM AigaRunTask b WHERE b.subTaskId="+subTasks[0].getSubTaskId()+" AND b.collectType=1 ORDER BY b.createTime DESC");
									if(aigaRunTasks.length>=1){
										AigaRunPlan[] aigaRunPlan = aigaRunPlanSV.getAigaRunPlanBySql("FROM AigaRunPlan a WHERE  a.caseId="+aigaInstCase.getCaseId()+" AND  a.taskId='"+aigaRunTasks[0].getTaskId()+"'");
										if(aigaRunPlan.length==1){
											allCaseCount++;//总用例数自增
											//获取执行结果类型
											SysConstant[] runResultSysConstants = SysContentUtil.getSysContant("runResult");
											Map<String, String> runResultMap = new HashMap<String, String>();
											for(SysConstant sysConstant:runResultSysConstants){
												runResultMap.put(sysConstant.getValue().toString(), sysConstant.getShow());
											}
											String runResult = aigaRunPlan[0].getRunResult();
											if(runResult != null && !runResult.equals("")){
												runResult = runResultMap.get(runResult);
												if(runResult!=null&&!runResult.equals("")){
													if(runResult.equals("成功"))passCount++;//成功计数器自增
													aigaInstCaseMap.put("runResult", runResult);
												}else{
													aigaInstCaseMap.put("runResult", "未指定数据");
												}
											}else{
												aigaInstCaseMap.put("runResult", "未指定数据");
											}
										}else{
											aigaInstCaseMap.put("runResult", "未使用该用例");
										}
									}else{
										aigaInstCaseMap.put("runResult", "未生成任务");
									}
								}catch(Exception e){
									aigaInstCaseMap.put("runResult", "未生成任务");
								}
								
								//统计准发布环境下信息
								try{
									//取出发布环境下最新的测试任务
									aigaRunTasks = aigaRunTaskSV.getAigaRunTask("FROM AigaRunTask b WHERE b.subTaskId="+subTasks[0].getSubTaskId()+" AND b.collectType=2 ORDER BY b.createTime DESC");
									if(aigaRunTasks.length>=1){
										AigaRunPlan[] aigaRunPlan = aigaRunPlanSV.getAigaRunPlanBySql("FROM AigaRunPlan a WHERE  a.caseId="+aigaInstCase.getCaseId()+" AND  a.taskId='"+aigaRunTasks[0].getTaskId()+"'");
										if(aigaRunPlan.length==1){
											zallCaseCount++;//总用例数自增
											//获取执行结果类型
											SysConstant[] runResultSysConstants = SysContentUtil.getSysContant("runResult");
											Map<String, String> runResultMap = new HashMap<String, String>();
											for(SysConstant sysConstant:runResultSysConstants){
												runResultMap.put(sysConstant.getValue().toString(), sysConstant.getShow());
											}
											String runResult = aigaRunPlan[0].getRunResult();
											if(runResult != null && !runResult.equals("")){
												runResult = runResultMap.get(runResult);
												if(runResult!=null&&!runResult.equals("")){
													if(runResult.equals("成功"))zpassCount++;//成功计数器自增
												}
											}
										}
									}
								}catch(Exception e){
								}
								//统计生产环境下信息
								try{
									//取出发布环境下最新的测试任务
									aigaRunTasks = aigaRunTaskSV.getAigaRunTask("FROM AigaRunTask b WHERE b.subTaskId="+subTasks[0].getSubTaskId()+" AND b.collectType=3 ORDER BY b.createTime DESC");
									if(aigaRunTasks.length>=1){
										AigaRunPlan[] aigaRunPlan = aigaRunPlanSV.getAigaRunPlanBySql("FROM AigaRunPlan a WHERE  a.caseId="+aigaInstCase.getCaseId()+" AND  a.taskId='"+aigaRunTasks[0].getTaskId()+"'");
										if(aigaRunPlan.length==1){
											sallCaseCount++;//总用例数自增
											//获取执行结果类型
											SysConstant[] runResultSysConstants = SysContentUtil.getSysContant("runResult");
											Map<String, String> runResultMap = new HashMap<String, String>();
											for(SysConstant sysConstant:runResultSysConstants){
												runResultMap.put(sysConstant.getValue().toString(), sysConstant.getShow());
											}
											String runResult = aigaRunPlan[0].getRunResult();
											if(runResult != null && !runResult.equals("")){
												runResult = runResultMap.get(runResult);
												if(runResult!=null&&!runResult.equals("")){
													if(runResult.equals("成功"))spassCount++;//成功计数器自增
												}
											}
										}
									}
								}catch(Exception e){
								}
								
								//插入执行步骤
								try{
									String caseOperateInst = aigaInstCase.getCaseOperateInst();
									if(caseOperateInst != null && !caseOperateInst.equals("")){
										aigaInstCaseMap.put("caseOperateInst", caseOperateInst.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
									}else{
										aigaInstCaseMap.put("caseOperateInst", "未指定数据");
									}
								}catch(Exception e){
									aigaInstCaseMap.put("caseOperateInst", "未指定数据");
								}
								//插入预期结果
								try{
									String preResult = aigaInstCase.getPreResult();
									if(preResult != null && !preResult.equals("")){
										aigaInstCaseMap.put("preResult", preResult.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
									}else{
										aigaInstCaseMap.put("preResult", "未指定数据");
									}
								}catch(Exception e){
									aigaInstCaseMap.put("preResult", "未指定数据");
								}
								aigaInstCaseList.add(aigaInstCaseMap);
							}
						}
					}
				}
				dataMap.put("aigaInstCase", aigaInstCaseList);
			}
			/**
			 * 第三部分[3.3执行结果]
			 */
			try{
				List<Map> aigaRunResultList = new LinkedList<Map>();
				//取出测试环境下最新的测试任务
				aigaRunTasks = aigaRunTaskSV.getAigaRunTask("FROM AigaRunTask b WHERE b.subTaskId="+subTasks[0].getSubTaskId()+" AND b.collectType=1 ORDER BY b.createTime DESC");
				if(aigaRunTasks.length>=1){
					Map<String, String> aigaRunResultMap = new HashMap<String, String>();
					//插入执行状态
					String taskStatus = aigaRunTasks[0].getTaskStatus();
					if(taskStatus!=null&&!taskStatus.equals("")){
						try{
							int temp = Integer.parseInt(taskStatus);
							switch(temp){
							case 1: aigaRunResultMap.put("taskStatus", "任务创建");break;
							case 2: aigaRunResultMap.put("taskStatus", "任务等待执行");break;
							case 21: aigaRunResultMap.put("taskStatus", "用例发送中");break;
							case 22: aigaRunResultMap.put("taskStatus", "用例发送成功");break;
							case 3: aigaRunResultMap.put("taskStatus", "执行完成");break;
							case 5: aigaRunResultMap.put("taskStatus", "执行失败");break;
							default : aigaRunResultMap.put("taskStatus", "未知状态");
							}
						}catch(Exception e){
							aigaRunResultMap.put("taskStatus", "未知状态");
						}
					}else{
						aigaRunResultMap.put("taskStatus", "未知状态");
					}
					//插入执行环境
					aigaRunResultMap.put("testEvn", "测试环境");
					//插入执行用例总数
					aigaRunResultMap.put("allCaseCount", String.valueOf(allCaseCount));
					//插入通过用例总数
					aigaRunResultMap.put("passCount", String.valueOf(passCount));
					//插入未通过用例总数和测试通过率
					if(allCaseCount!=0){
						aigaRunResultMap.put("unpassCount", String.valueOf((allCaseCount-passCount)));
						double passPercentCount = (passCount/(allCaseCount*1.0))*100;
						aigaRunResultMap.put("passPercentCount", String.valueOf(passPercentCount)+"%");
					}
					aigaRunResultList.add(aigaRunResultMap);
				}
				//取出准发布环境下最新的测试任务
				aigaRunTasks = aigaRunTaskSV.getAigaRunTask("FROM AigaRunTask b WHERE b.subTaskId="+subTasks[0].getSubTaskId()+" AND b.collectType=2 ORDER BY b.createTime DESC");
				if(aigaRunTasks.length>=1){
					Map<String, String> aigaRunResultMap = new HashMap<String, String>();
					//插入执行状态
					String taskStatus = aigaRunTasks[0].getTaskStatus();
					if(taskStatus!=null&&!taskStatus.equals("")){
						try{
							int temp = Integer.parseInt(taskStatus);
							switch(temp){
							case 1: aigaRunResultMap.put("taskStatus", "任务创建");break;
							case 2: aigaRunResultMap.put("taskStatus", "任务等待执行");break;
							case 21: aigaRunResultMap.put("taskStatus", "用例发送中");break;
							case 22: aigaRunResultMap.put("taskStatus", "用例发送成功");break;
							case 3: aigaRunResultMap.put("taskStatus", "执行完成");break;
							case 5: aigaRunResultMap.put("taskStatus", "执行失败");break;
							default : aigaRunResultMap.put("taskStatus", "未知状态");
							}
						}catch(Exception e){
							aigaRunResultMap.put("taskStatus", "未知状态");
						}
					}else{
						aigaRunResultMap.put("taskStatus", "未知状态");
					}
					//插入执行环境
					aigaRunResultMap.put("testEvn", "准发布环境");
					//插入执行用例总数
					aigaRunResultMap.put("allCaseCount", String.valueOf(zallCaseCount));
					//插入通过用例总数
					aigaRunResultMap.put("passCount", String.valueOf(zpassCount));
					//插入未通过用例总数和测试通过率
					if(zallCaseCount!=0){
						aigaRunResultMap.put("unpassCount", String.valueOf((zallCaseCount-zpassCount)));
						double zpassPercentCount = (zpassCount/(zallCaseCount*1.0))*100;
						aigaRunResultMap.put("passPercentCount", String.valueOf(zpassPercentCount)+"%");
					}
					aigaRunResultList.add(aigaRunResultMap);
				}
				//取出生产环境下最新的测试任务
				aigaRunTasks = aigaRunTaskSV.getAigaRunTask("FROM AigaRunTask b WHERE b.subTaskId="+subTasks[0].getSubTaskId()+" AND b.collectType=3 ORDER BY b.createTime DESC");
				if(aigaRunTasks.length>=1){
					Map<String, String>  aigaRunResultMap = new HashMap<String, String>();
					//插入执行状态
					String taskStatus = aigaRunTasks[0].getTaskStatus();
					if(taskStatus!=null&&!taskStatus.equals("")){
						try{
							int temp = Integer.parseInt(taskStatus);
								switch(temp){
								case 1: aigaRunResultMap.put("taskStatus", "任务创建");break;
								case 2: aigaRunResultMap.put("taskStatus", "任务等待执行");break;
								case 21: aigaRunResultMap.put("taskStatus", "用例发送中");break;
								case 22: aigaRunResultMap.put("taskStatus", "用例发送成功");break;
								case 3: aigaRunResultMap.put("taskStatus", "执行完成");break;
								case 5: aigaRunResultMap.put("taskStatus", "执行失败");break;
								default : aigaRunResultMap.put("taskStatus", "未知状态");
							}
						}catch(Exception e){
							aigaRunResultMap.put("taskStatus", "未知状态");
						}
					}else{
						aigaRunResultMap.put("taskStatus", "未知状态");
					}
					//插入执行环境
					aigaRunResultMap.put("testEvn", "生产环境");
					//插入执行用例总数
					aigaRunResultMap.put("allCaseCount", String.valueOf(sallCaseCount));
					//插入通过用例总数
					aigaRunResultMap.put("passCount", String.valueOf(spassCount));
					//插入未通过用例总数和测试通过率
					if(sallCaseCount!=0){
						aigaRunResultMap.put("unpassCount", String.valueOf((sallCaseCount-spassCount)));
						double spassPercentCount = (spassCount/(sallCaseCount*1.0))*100;
						aigaRunResultMap.put("passPercentCount", String.valueOf(spassPercentCount)+"%");
					}
					aigaRunResultList.add(aigaRunResultMap);
				}
				dataMap.put("aigaRunResult", aigaRunResultList);
			}catch(Exception e){
				//没有查询出数据时,表示没有在测试环境下创建任务.
				//此时不做任何处理.
			}
			
			
			// 告诉浏览器使用什么格式编译文件
			response.setContentType("application/octet-stream;charset=utf-8");
			// 在浏览器中弹出窗口，给文件名编码，防止中文乱码，火狐和非火狐浏览器其区别对待
			if (request.getHeader("USER-AGENT").toLowerCase().indexOf("firefox") != -1) {
				// 如果是火狐浏览器则使用下面的方式对excel文件名编码
				response.setHeader("Content-Disposition","attachment;filename="+ new String((subTasks[0].getSubTaskName()!=null?subTasks[0].getSubTaskName()+"需求测试报告.doc":"需求测试报告.doc").getBytes("utf-8"),"ISO-8859-1"));
			} else {
				// 非火狐浏览器使用下面的方式
				response.setHeader("Content-Disposition","attachment;filename="+ java.net.URLEncoder.encode(subTasks[0].getSubTaskName()!=null?subTasks[0].getSubTaskName()+"需求测试报告.doc":"需求测试报告.doc","utf-8"));
			}
			// 客户端不缓存
			// addHeader是增加头文件里没有的属性
			response.addHeader("Pragma", "no-cache");
			response.addHeader("Cache-Control", "no-cache");
			out = new BufferedWriter(new OutputStreamWriter(response.getOutputStream(),"UTF-8"));
	        try {
	        	template.process(dataMap, out);
	        	out.close();
			} catch (TemplateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	@RequestMapping(value="/getRSeceneCaseTable.do")
	public void getRSeceneCaseTable(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			JSONArray json = new JSONArray();
			String funId = request.getParameter("funId");
			String isQueryAll = request.getParameter("isQueryAll");
			//是否查询全部 1：是	 0：否
			if(StringUtils.isBlank(isQueryAll)){
				isQueryAll="0";
			}
			String subTaskTag = request.getParameter("subTaskTag");
			if(funId==null||funId.equals(""))
				funId = "0";
			
			AigaFunCaseRela[] aigaFunCaseRelas = aigaCaseSV.getFunCaseRelaByFunId(Integer.valueOf(funId),isQueryAll);
			if(aigaFunCaseRelas!=null && aigaFunCaseRelas.length>0){
				for(int i=0;i<aigaFunCaseRelas.length;i++){
					if(StringUtils.isNotBlank(String.valueOf(aigaFunCaseRelas[i].getCaseId()))){
						DetachedCriteria criteria = DetachedCriteria.forClass(AigaInstCase.class);
						criteria.add(Restrictions.eq("caseId", aigaFunCaseRelas[i].getCaseId()));
						criteria.addOrder(Order.asc("caseId"));
						AigaCase[] aigaCases = caseDAO.getAigaCaseByCriteria(criteria);
						if(aigaCases!=null && aigaCases.length>0){
							for(AigaCase aigaCase : aigaCases){
								JSONObject caseJSONOj=new JSONObject();
								criteria = DetachedCriteria.forClass(AigaHisCase.class);
								criteria.add(Restrictions.eq("subTaskTag", subTaskTag));
								criteria.add(Restrictions.eq("caseId", aigaCase.getCaseId()));
								criteria.addOrder(Order.desc("hisCaseId"));
								AigaHisCase[] historys = aigaCaseSV.getHisCaseByCriteria(criteria);
								
								if(historys.length>=1){
									String type = historys[0].getOperatorType();
 									if(type.equals("add")){
										caseJSONOj.put("operationType", "新增");
									}else if(type.equals("modify")){
										caseJSONOj.put("operationType", "修改");
									}else{
										continue;
									}
									caseJSONOj.put("isOwer", "本人");
								}else{
									caseJSONOj.put("operationType", "");
									caseJSONOj.put("isOwer", "系统");
									caseJSONOj.put("relaType", "");
								}
								
								caseJSONOj.put("caseId", aigaCase.getCaseId());
								caseJSONOj.put("caseName", aigaCase.getCaseName());
								caseJSONOj.put("secId", aigaCase.getSecId());
								caseJSONOj.put("casePreCond", aigaCase.getCasePreCond());
								caseJSONOj.put("caseOperateInst", aigaCase.getCaseOperateInst());
								caseJSONOj.put("preResult", aigaCase.getPreResult());

								if(StringUtils.isNotBlank(aigaFunCaseRelas[i].getRelaType())){
									if(aigaFunCaseRelas[i].getRelaType().equals("owner")){
										caseJSONOj.put("relaType", "非引用");
									}else if(aigaFunCaseRelas[i].getRelaType().equals("quote")){
										caseJSONOj.put("relaType", "引用");
									}
								}
								json.add(caseJSONOj,this.jsonConfig);
							}
						}
					}
				}
			}
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("data", json);
			jsonObj.put("success", true);
			ActionHelper.responseData4JSON(request, response, jsonObj);
		}catch (Exception e) {
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value="/getCaseTableForSeceneRela.do")
	public void getCaseTableForSeceneRela(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			String secId = request.getParameter("secId");
			if(secId==null||secId.equals(""))
				throw new Exception("缺少请求参数secId");
			AigaCase[] aigaCases = aigaCaseSV.getCaseBySecId(Integer.valueOf(secId));
			this.setTable(aigaCases);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value="/getCaseForAutoTest.do")
	public void getCaseForAutoTest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map map=this.paginationParams(request);
		int pageNo = Integer.parseInt(map.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(map.get(this.LIMIT_PARAM).toString());
		String caseName = this.decodeCN(request.getParameter("caseName"));
		String author = this.decodeCN(request.getParameter("author")); 
		String caseRegress = request.getParameter("caseRegress");
		String hasTest = request.getParameter("hasTest");		
		String caseStatus = request.getParameter("caseStatus");
		String querySql = "from AigaCase where 1=1 and caseId in (select distinct caseId from AigaHisCase) ";
		if(StringUtils.isNotBlank(caseName))querySql+=" and caseName like '%"+caseName+"%'";
		if(StringUtils.isNotBlank(author))querySql+=" and author like '%"+author+"%'";
		if(StringUtils.isNotBlank(caseRegress)){
			querySql+=("1".equals(caseRegress))?" and regressionTest="+caseRegress:" and regressionTest<>1 ";
		}
		if(StringUtils.isNotBlank(hasTest)){
			querySql+=("1".equals(hasTest))?" and hasTest="+hasTest:" and hasTest<>1 ";
		}
		if(StringUtils.isNotBlank(caseStatus)&&"add|modify|delete".contains(caseStatus)){
			querySql+=" and caseId in (select distinct caseId from AigaHisCase where operatorType='"+caseStatus+"')";
		}
		List<Object> aigaCases = commonPageinationSV.getObjectList(pageNo, pageSize, querySql);
		Object[] objects=new Object[aigaCases.size()];
		if(aigaCases.size()>0&&aigaCases.get(0)!=null){
			for(int i=0;i<aigaCases.size();i++){
				AigaCase aCase=(AigaCase)aigaCases.get(i);
				AigaHisCase[] aigaHisCase=aigaCaseSV.getHisCaseBySql("from AigaHisCase where caseId="+aCase.getCaseId()+" order by hisCaseId desc");
				if(aigaHisCase!=null&&aigaHisCase.length>0&&aigaHisCase[0]!=null){
					Object[] objs = new Object[] { aCase,aigaHisCase[0]};
					DynamicBean bean = new DynamicBean(objs);
					objects[i] = bean.getObject();
				}
			}
		}else{
			objects = new Object[] { "{}" };
		}
		
		JSONArray json = new JSONArray();
		json = JSONArray.fromObject(objects, this.jsonConfig);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal(querySql));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
		//this.setTable(aigaCases);
		//this.setPostInfo("success", true);
	}
	
	@RequestMapping(value="/saveCaseFormForNew.do")
	public void saveCaseFormForNew(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			String caseElemJson = request.getParameter("caseElem");
			if(caseElemJson==null)
				throw new Exception("缺少请求参数caseElem");
			Object[] objects = this.transFormToObj(request, new Class[]{AigaInstCase.class});
			if(objects.length==1){
				if(objects[0] instanceof AigaInstCase)
					aigaCaseSV.saveCaseFormForNew((AigaInstCase)objects[0], caseElemJson);
			}
			this.setPostInfo("success", true);
		}catch (Exception e) {
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value="/deleteCaseForNew.do")
	public void deleteCaseForNew(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			String caseId = request.getParameter("caseId");
			if(caseId==null||caseId.equals(""))
				throw new Exception("缺少请求参数caseId");
			aigaCaseSV.deleteCaseForNew(Integer.valueOf(caseId));
			this.setPostInfo("success", true);
		}catch (Exception e) {
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value="/getCaseByFunId.do")
	public void getCaseByFunId(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		getInstCaseBySql
		String funId = request.getParameter("funId");
		if(funId == null || "".equals(funId)) {
			funId = "0";
		}
		String relaId = request.getParameter("relaId");
		String querySql = "from AigaInstCase where caseId in(select caseId from AigaRFunCase where funId="+funId+")";
		AigaInstCase[] instCases = aigaCaseSV.getInstCaseBySql(querySql);
		//change by yinsx 直接从用例实例里面获取场景ID(SEC_ID)查询场景
		List<AigaCase> list = new ArrayList<AigaCase>();
		for(AigaInstCase aigaInstCase: instCases ){
			if(StringUtils.isNotBlank(aigaInstCase.getSecId().toString())){
				AigaSecene secene = aigaSeceneSV.getAigaSeceneById(aigaInstCase.getSecId());
				aigaInstCase.setOwnLabel(secene.getSeceneName());
				list.add(aigaInstCase);
			}
		}
		/*AigaCase[] aigaCases = aigaCaseSV.getCaseByFunId(Integer.valueOf(relaId));
		List<AigaCase> list = new ArrayList<AigaCase>();
		for(AigaCase aigaCase : aigaCases) {
			int s = aigaCase.getCaseId();
			for(AigaInstCase instCase : instCases) {
				int d = instCase.getCaseId();
				if(d == s) {
					AigaSecene secene = aigaSeceneSV.getAigaSeceneById(aigaCase.getSecId());
					aigaCase.setOwnLabel(secene.getSeceneName());
					list.add(aigaCase);
				}
			}
		}*/
		this.setTable(list.toArray(new AigaCase[0]));
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/deleteCaseByIdsForNew.do")
	public void deleteCaseByIdsForNew(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			String caseIds = request.getParameter("caseIds");
			if(caseIds==null||caseIds.equals(""))
				throw new Exception("缺少请求参数caseIds");
			aigaCaseSV.deleteCaseByIdsForNew(caseIds);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	//将关联的归属系统的ID和系统 名称相互转义
	private String transferrSys(AigaFunFolder[] funFolders,Map<String,String> map){
		String sysBugs = "";//记录归属系统出错.
		for(AigaFunFolder funFolder : funFolders){
			String sysId = funFolder.getSysIdTemp();
			if(sysId!=null&&!sysId.equals("")){
				try{	
						String temp="";
						temp = map.get(sysId);
						if(temp == null){
							sysBugs="1";
							continue;
						}
						if(temp.length()==0){
							funFolder.setSysId(null);
						}else{
							funFolder.setSysId(Integer.parseInt(temp));
						}
				}catch(Exception e){
					funFolder.setSysId(null);
				}
			}
		}
		return sysBugs;
	}
	
	//将关联的归属子系统的ID和子系统 名称相互转义
	private String transferrSubSys(AigaFunFolder[] funFolders,Map<String,AigaSubSysFolder[]> subNameToId){
		String sysBugs = "";//记录归属子系统出错.
		for(AigaFunFolder funFolder : funFolders){
			String sysId = funFolder.getSysId().toString();
			if(sysId!=null&&!sysId.equals("")){
				try{	
						AigaSubSysFolder[] aigaSubSysFolders = null;
						aigaSubSysFolders = subNameToId.get(sysId);
						if(aigaSubSysFolders == null){//归属系统下没有任何归属子系统
							sysBugs="1";
							continue;
						}
						int count = aigaSubSysFolders.length;
						boolean flag = true;
						for(AigaSubSysFolder aigaSubSysFolder:aigaSubSysFolders){
							if(aigaSubSysFolder.getSysName().equals(funFolder.getSubSysIdTemp())){
								funFolder.setSubSysId(aigaSubSysFolder.getSubsysId());
								flag = false;
							}
						}
						if(flag){//归属系统下没有指定的归属子系统
							sysBugs="1";
							continue;
						}
				}catch(Exception e){
					funFolder.setSubSysId(null);
				}
			}
		}
		return sysBugs;
	}

	@RequestMapping(value = "/uploadFunFolderExcel.do")
	public void dealFunFolderExcel(HttpServletRequest request,HttpServletResponse response) throws Exception {
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		Boolean success = false;
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (isMultipart) {
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			DetachedCriteria criteria = DetachedCriteria.forClass(AigaSystemFolder.class);
			AigaSystemFolder[] aigaSystemFolders = null;
			try {
				aigaSystemFolders = aigaSystemFolderSV.getSystemFolder(criteria);
			} catch (Exception e2) {
				aigaSystemFolders = new AigaSystemFolder[0];
				e2.printStackTrace();
			}
			Map<String,String> nameToIdMap = new HashMap<String, String>();
			AigaSubSysFolder[] aigaSubSysFolders = null;
			Map<String,AigaSubSysFolder[]> subNameToId = new HashMap<String, AigaSubSysFolder[]>();
			for (AigaSystemFolder aigaSystemFolder : aigaSystemFolders) {
				nameToIdMap.put(aigaSystemFolder.getSysName(), aigaSystemFolder.getSysId().toString());
				DetachedCriteria subcriteria = DetachedCriteria.forClass(AigaSubSysFolder.class);
				subcriteria.add(Restrictions.eq("sysId",aigaSystemFolder.getSysId()));
				aigaSubSysFolders = aigaSubSysFolderSV.getSubSysFolder(subcriteria);
				subNameToId.put(aigaSystemFolder.getSysId().toString(), aigaSubSysFolders);
			}
			try {
				List<FileItem> items = upload.parseRequest(request);
				for (FileItem item : items) {
					if (!item.isFormField()) {
						 String name = item.getName();
						 resultMap.put("fileName", name);
						// 获取上传文件
						Map[] fieldsToCells = new HashMap[1];
						Map<String,String> map1 = new HashMap<String,String>();
						map1.put("功能点名称", "sysName");
						map1.put("功能点类型", "funType");
					    map1.put("所属系统", "sysIdTemp");
					    map1.put("所属子系统", "subSysIdTemp");
						map1.put("重要级别", "importantClass");
						map1.put("业务标签", "busiLabel");
						map1.put("基础功能标签", "baseFunLabel");
						map1.put("菜单路径", "menuPath");
					    map1.put("功能点描述", "funDesc");
						map1.put("数据检查脚本", "dataCheckScript");
						map1.put("是否性能测试", "isEfficiencyTest");
					    map1.put("性能测试类型", "efficiencyTestType");
						map1.put("维护厂商", "devFirm");
						fieldsToCells[0] = map1;
						try {
							InputStream in = item.getInputStream();
							Object[] objs = XlsHelper.transXlsToObjs(in,fieldsToCells, new Class[] {AigaFunFolder.class});
							List funcList =null;
							funcList= (List) objs[0];
							List<AigaFunFolder> lastFunFolderObjList=new ArrayList<AigaFunFolder>();
							for (int j = 0, m = funcList.size(); j < m; j++) {
								AigaFunFolder funFolder = new AigaFunFolder();
								funFolder=funcList.get(j) instanceof AigaFunFolder?(AigaFunFolder)funcList.get(j):null;
								lastFunFolderObjList.add(funFolder);
							}
							int rowNum = 1;
							List<AigaFunFolder> successFunFolderObjList=new ArrayList<AigaFunFolder>();
							boolean errorFalg = true;
							for(AigaFunFolder tempFunc:lastFunFolderObjList){//首先检查数据的完整性
								AigaFunFolder[] aigaFunFolders = new AigaFunFolder[]{tempFunc};
								String dataError = this.transferrLabel(aigaFunFolders, "NameToId");
								if(aigaFunFolders[0].getIsEfficiencyTest()==1){
									try{
										if(aigaFunFolders[0].getEfficiencyTestType()==null){
											resultMap.put("msg", "第"+rowNum+"行的性能测试类型无数据");
											errorFalg = false;
											break;
										}
									}catch(Exception e){
										resultMap.put("msg", "第"+rowNum+"行的性能测试类型无数据");
										errorFalg = false;
										break;
									}
								}else{
									aigaFunFolders[0].setEfficiencyTestType(null);//没有必要插入数据库.
								}
								if(aigaFunFolders[0].getSysName().equals("")||aigaFunFolders[0].getSysName()==null||
										aigaFunFolders[0].getIsEfficiencyTest().equals("")||aigaFunFolders[0].getIsEfficiencyTest()==null||
										aigaFunFolders[0].getMenuPath().equals("")||aigaFunFolders[0].getMenuPath()==null||
										aigaFunFolders[0].getFunType().equals("")||aigaFunFolders[0].getFunType()==null||
										aigaFunFolders[0].getImportantClass().equals("")||aigaFunFolders[0].getImportantClass()==null||
										aigaFunFolders[0].getSysIdTemp().equals("")||aigaFunFolders[0].getSysIdTemp()==null||
										aigaFunFolders[0].getSubSysIdTemp().equals("")||aigaFunFolders[0].getSubSysIdTemp()==null){
									resultMap.put("msg", "请检查第"+rowNum+"行的必填数据是否完整,或者表格其他区域存在脏数据");
									errorFalg = false;
									break;
								}
								if(dataError.length()>1){//导入的标签出错情况的判断
									String[] flag = dataError.split(",");
									if(flag.length==1){//标签转换拋错
										if(flag[0].equals("1")){
											resultMap.put("msg", "第"+rowNum+"行基础业务标签数据错误");
										}else{
											resultMap.put("msg", "第"+rowNum+"行业务标签数据错误");
										}
									}else{
										resultMap.put("msg", "第"+rowNum+"行基础业务标签和业务标签数据错误");
									}
									errorFalg = false;
									break;
								}
								//检测归属系统
								String sysError = this.transferrSys(aigaFunFolders, nameToIdMap);
								if(sysError.equals("1")){
									resultMap.put("msg", "第"+rowNum+"行归属系统数据错误");
									errorFalg = false;
									break;
								}
								//检查归属子系统
								String subSysError = this.transferrSubSys(aigaFunFolders, subNameToId);
								if(subSysError.equals("1")){
									resultMap.put("msg", "第"+rowNum+"行归属子系统数据错误");
									errorFalg = false;
									break;
								}
								this.transferrLabel(aigaFunFolders, "IdToName");
								rowNum++;
							}
							if(errorFalg){//校验通过直接存储
								AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
								Timestamp time = new Timestamp(System.currentTimeMillis());
								for(AigaFunFolder tempFunc:lastFunFolderObjList){
									tempFunc.setCreateTime(time);
									tempFunc.setUpdateTime(time);
									tempFunc.setOperatorId(Integer.parseInt(String.valueOf(user.getUserId())));
									tempFunc.setOperatorName(user.getUserName());
									tempFunc.setCreatorId(Integer.parseInt(String.valueOf(user.getUserId())));
									tempFunc.setCreatorName(user.getUserName());
									AigaFunFolder[] aigaFunFolders = new AigaFunFolder[]{tempFunc};
									//this.transferrLabel(aigaFunFolders, "NameToId");
									aigaFunFolders[0].setIsInvalid((short)0);
									aigaFunFolderSV.saveAigaFunFolder(aigaFunFolders[0]);
									//this.transferrLabel(aigaFunFolders, "IdToName");
									successFunFolderObjList.add(tempFunc);
								}
							}
							if(errorFalg){
								resultMap.put("data", successFunFolderObjList);
								success = true;
							}else{
								resultMap.put("error", true);
							}
						} catch (Exception e) {
							if(e instanceof NullPointerException){
								e = new Exception("请重新下载模版规范操作!");
							}
							resultMap.put("msg", e.getMessage());
							resultMap.put("error", true);
						}finally{
						}

					}
				}
			} catch (Exception e) {
				logger.equals(e.getStackTrace());
				resultMap.put("msg", e.getMessage());
				resultMap.put("error", true);
			}
		}
		resultMap.put("success", success);
	
		ActionHelper.responseFileUpload(request, response, resultMap);

	}
	@RequestMapping("/saveAigaBusi.do")
	public void saveAigaBusi(HttpServletRequest request,HttpServletResponse response) throws Exception {
		try{
			Object[] value = this.transFormToObj(request, new Class[]{AigaBusi.class});
			if(value!=null&&value.length==1)
				if(value[0] instanceof AigaBusi){
					aigaBusiSV.saveAigaBusi((AigaBusi)value[0]);
				}
			this.setPostInfo("success", true);
			this.setPostInfo("message", "保存成功");
		}
		catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", "保存失败,原因:"+e.getMessage());
		}finally{
			this.postInfo(request, response);
		}
	}
	@RequestMapping("/getAigaBusiList.do")
	public void getAigaBusiList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		JSONArray json = new JSONArray();
		Map map=this.paginationParams(request);
		int pageNo = Integer.parseInt(map.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(map.get(this.LIMIT_PARAM).toString());
		String busiName = request.getParameter("busiName");
		StringBuffer querySql = new StringBuffer("FROM AigaBusi a WHERE 1=1 ");
		querySql.append((busiName!=null&&!busiName.equals("")&&!busiName.equals("null")&&!busiName.equals("undefined"))?" and a.busiName like '%"+this.decodeCN(busiName)+"%'":"");//kpi名称
		querySql.append("and a.isInvalid=0 ");
		List<Object> aigaBusiList= commonPageinationSV.getObjectList(pageNo, pageSize, querySql.toString());
		json = JSONArray.fromObject(aigaBusiList, this.jsonConfig);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal(querySql.toString()));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}
	@RequestMapping(value="/getAigaBusiByBusiId.do")
	public void getAigaBusiByBusiId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String busiId = request.getParameter("busiId");
		StringBuffer conditionBuffer = new StringBuffer();
		conditionBuffer.append((busiId!=null&&!busiId.equals(""))?" and a.busiId = "+busiId+"":"");//功能点ID
		AigaBusi[] aigaBusis =aigaBusiSV.getAigaBusi("FROM AigaBusi a where 1=1 "+conditionBuffer.toString());
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		map.put("success", false);
		if (aigaBusis.length == 1) {
			JSON json =JSONObject.fromObject(aigaBusis[0], jsonConfig);
			map.put("data", json);
			map.put("success", true);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/deleteAigaBusiByBusiId.do")
	public void deleteAigaBusiByBusiId(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String busiId = request.getParameter("busiId");
		StringBuffer conditionBuffer = new StringBuffer();
		conditionBuffer.append((busiId!=null&&!busiId.equals(""))?" and a.busiId = "+busiId+"":"");//功能点ID
		AigaBusi[] aigaBusis =aigaBusiSV.getAigaBusi("FROM AigaBusi a where 1=1 "+conditionBuffer.toString());
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		if(aigaBusis.length==1){
			aigaBusis[0].setIsInvalid((short)1);
			try{
				aigaBusiSV.saveAigaBusi(aigaBusis[0]);
				map.put("success", true);
			}
			catch(Exception e){
				map.put("success", false);
			}
		}else{
			map.put("success", false);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/saveAigaBaseBusi.do")
	public void saveAigaBaseBusi(HttpServletRequest request,HttpServletResponse response) throws Exception {
		try{
			Object[] value = this.transFormToObj(request, new Class[]{AigaBaseBusi.class});
			if(value!=null&&value.length==1)
				if(value[0] instanceof AigaBaseBusi){
					aigaBaseBusiSV.saveAigaBaseBusi((AigaBaseBusi)value[0]);
				}
			this.setPostInfo("success", true);
			this.setPostInfo("message", "保存成功");
		}
		catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", "保存失败,原因:"+e.getMessage());
		}finally{
			this.postInfo(request, response);
		}
	}
	@RequestMapping("/getAigaBaseBusiList.do")
	public void getAigaBaseBusiList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		JSONArray json = new JSONArray();
		Map map=this.paginationParams(request);
		int pageNo = Integer.parseInt(map.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(map.get(this.LIMIT_PARAM).toString());
		String busiName = request.getParameter("busiName");
		StringBuffer querySql = new StringBuffer("FROM AigaBaseBusi a WHERE 1=1 ");
		querySql.append((busiName!=null&&!busiName.equals("")&&!busiName.equals("null")&&!busiName.equals("undefined"))?" and a.busiName like '%"+this.decodeCN(busiName)+"%'":"");//kpi名称
		querySql.append("and a.isInvalid=0 ");
		List<Object> aigaBusiList= commonPageinationSV.getObjectList(pageNo, pageSize, querySql.toString());
		json = JSONArray.fromObject(aigaBusiList, this.jsonConfig);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal(querySql.toString()));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}
	@RequestMapping(value="/getAigaBaseBusiByBusiId.do")
	public void getAigaBaseBusiByBusiId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String busiId = request.getParameter("busiId");
		StringBuffer conditionBuffer = new StringBuffer();
		conditionBuffer.append((busiId!=null&&!busiId.equals(""))?" and a.busiId = "+busiId+"":"");//功能点ID
		AigaBaseBusi[] aigaBaseBusis =aigaBaseBusiSV.getAigaBaseBusi("FROM AigaBaseBusi a where 1=1 "+conditionBuffer.toString());
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		map.put("success", false);
		if (aigaBaseBusis.length == 1) {
			JSON json =JSONObject.fromObject(aigaBaseBusis[0], jsonConfig);
			map.put("data", json);
			map.put("success", true);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/deleteAigaBaseBusiByBusiId.do")
	public void deleteAigaBaseBusiByBusiId(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String busiId = request.getParameter("busiId");
		StringBuffer conditionBuffer = new StringBuffer();
		conditionBuffer.append((busiId!=null&&!busiId.equals(""))?" and a.busiId = "+busiId+"":"");//功能点ID
		AigaBaseBusi[] aigaBaseBusis =aigaBaseBusiSV.getAigaBaseBusi("FROM AigaBaseBusi a where 1=1 "+conditionBuffer.toString());
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		if(aigaBaseBusis.length==1){
			aigaBaseBusis[0].setIsInvalid((short)1);
			try{
				aigaBaseBusiSV.saveAigaBaseBusi(aigaBaseBusis[0]);
				map.put("success", true);
			}
			catch(Exception e){
				map.put("success", false);
			}
		}else{
			map.put("success", false);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping(value="/getHisCaseByCon.do")
	public void getHisCaseByCon(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map map=this.paginationParams(request);
		int pageNo = Integer.parseInt(map.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(map.get(this.LIMIT_PARAM).toString());
		String caseName = this.decodeCN(request.getParameter("caseName"));
		String operatorName = this.decodeCN(request.getParameter("operatorName")); 

		String querySql = "from AigaHisCase where hisCaseId in (select max(hisCaseId) from AigaHisCase group by caseId) and editType=3 ";
		if(StringUtils.isNotBlank(caseName))querySql+=" and caseName like '%"+caseName+"%'";
		if(StringUtils.isNotBlank(operatorName))querySql+=" and operatorName like '%"+operatorName+"%'";
		 
		List<Object> aigaHisCases = commonPageinationSV.getObjectList(pageNo, pageSize, querySql);
		Object[] objects=aigaHisCases.toArray();
		JSONArray json = new JSONArray();
		json = JSONArray.fromObject(objects, this.jsonConfig);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal(querySql));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}
	
	@RequestMapping(value="/getFunFoldersByLabel.do")
	public void getFunFoldersByLabel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String subTaskId = request.getParameter("subTaskId");
		String busiLabel = request.getParameter("busiLabel");
		String baseFunLabel = request.getParameter("baseFunLabel");
		if(busiLabel == null) {
			busiLabel = "";
		}
		if(baseFunLabel == null) {
			baseFunLabel = "";
		}
		busiLabel = new String(busiLabel.getBytes("ISO-8859-1"), "UTF-8");
		baseFunLabel = new String(baseFunLabel.getBytes("ISO-8859-1"), "UTF-8");
		String[] busiAry = busiLabel.split(",");
		String[] baseAry = baseFunLabel.split(",");
		String busiSql = "";
		String baseSql = "";
		boolean hasBusi = false;
		boolean hasBase = false;
		for(String busi : busiAry) {
			if(hasBusi) {
				busiSql += " or busiLabel like '%" + busi + "%'";
			} else {
				busiSql += " busiLabel like '%" + busi + "%'";
				hasBusi = true;
			}
		}
		if(busiAry.length == 1 && "".equals(busiAry[0])) {
			hasBusi = false;
		}
		for(String base : baseAry) {
			if(hasBase) {
				baseSql += " or baseFunLabel like '%" + base + "%'";
			} else {
				baseSql += " baseFunLabel like '%" + base + "%'";
				hasBase = true;
			}
		}
		if(baseAry.length == 1 && "".equals(baseAry[0])) {
			hasBase = false;
		}
		
		String querySql = "from AigaFunFolder where (" + 
			(hasBusi?busiSql:"busiLabel is not null") + " or" + (hasBase?baseSql:"  baseFunLabel is not null") +
			") and funId not in(select relaFolderId from AigaFunPoint where subTaskId="+ subTaskId + ")";
		AigaFunFolder[] funFolders = aigaFunFolderSV.getAigaFunFolderBySql(querySql);
		List<AigaFunFolder> result = new ArrayList<AigaFunFolder>();
		for(AigaFunFolder funFolder : funFolders) {
			boolean temp = false;
			if(!hasBusi && !hasBase) {
				result.add(funFolder);
				continue;
			}
			if(hasBusi) {
				for(String busi : busiAry) {
					if(inAry(busi, funFolder.getBusiLabel())) {
						result.add(funFolder);
						temp = true;
						break;
					}
				}
			}
			if(temp) {
				continue;
			}
			if(hasBase) {
				for(String base : baseAry) {
					if(inAry(base, funFolder.getBaseFunLabel())) {
						result.add(funFolder);
						break;
					}
				}
			}
		}
		
		this.setTable(result.toArray(new AigaFunFolder[0]));
		this.postInfo(request, response);
	}
	
	private boolean inAry(String val, String aryStr) throws Exception {
		boolean res = false;
		if(aryStr == null) {
			aryStr = "";
		}
		String[] ary = aryStr.split(",");
		for(String temp : ary) {
			if(temp.equals(val)) {
				res = true;
				break;
			}
		}
		return res;
	}
	
	@RequestMapping(value="/getRelaHisCase.do")
	public void getRelaHisCase(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String subTaskId = request.getParameter("subTaskId");
		String sql = "from AigaTestSubTask where sub_task_id=" + subTaskId;
		AigaTestSubTask subTasks = reqSV.getAigaTestSubTaskBySql(sql)[0];
		AigaHisFunCaseRela[] aigaHisFunCaseRelas = aigaFunCaseRelaSV.getHisAigaFunCaseRelaBySql(" from AigaHisFunCaseRela where subTaskTag='"+subTasks.getSubTaskTag()+"'");
		JSONArray json = new JSONArray();
		
		for(AigaHisFunCaseRela aigaHisFunCaseRela : aigaHisFunCaseRelas ){
			if(aigaHisFunCaseRela.getRelaType().equals("quote")){
				String querySql = "from AigaHisCase t where t.caseId ="+aigaHisFunCaseRela.getCaseId()+" order by t.caseId desc";
				AigaHisCase historys = aigaCaseSV.getHisCaseBySql(querySql)[0];
				JSONObject taskJSONOj=new JSONObject();
				Map map=new HashMap();
				map.put("caseName", historys.getCaseName());
				map.put("operatorType", historys.getOperatorType());
				map.put("operatorName", historys.getOperatorName());
				map.put("operateTime", historys.getOperateTime());
				taskJSONOj.putAll(map,jsonConfig);
				json.add(taskJSONOj);
			}else if(aigaHisFunCaseRela.getRelaType().equals("owner")){
				AigaCase aigaCase = aigaCaseSV.getAigaCaseById(aigaHisFunCaseRela.getCaseId(), AigaInstCase.class)[0];
				JSONObject taskJSONOj=new JSONObject();
				Map map=new HashMap();
				map.put("caseName", aigaCase.getCaseName());
				map.put("operatorType", aigaHisFunCaseRela.getOperateType());
				map.put("operatorName", aigaHisFunCaseRela.getLatestOperator());
				map.put("operateTime", aigaHisFunCaseRela.getOperateTime());
				taskJSONOj.putAll(map,jsonConfig);
				json.add(taskJSONOj);
			}
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}
	public static void main(String[] args) {
		List<Integer> list=new ArrayList<Integer>();
		list.add(1);
		System.out.println(list.contains(1));
	}
	
	@RequestMapping(value="/saveCaseFormForCaseRegress.do")
	public void saveCaseFormForCaseRegress(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			request.getSession().setAttribute("subTaskTag", "");
			request.getSession().setAttribute("normalMac", "");
			request.getSession().setAttribute("TemporaryTag", "");
			request.getSession().setAttribute("isCaseApproval", "Y");
			Object[] objects = this.transFormToObj(request, new Class[]{AigaInstCase.class});
			if(objects.length==1){
				if(objects[0] instanceof AigaInstCase)
					aigaCaseSV.saveAigaCase((AigaInstCase)objects[0]);
			}
			this.setPostInfo("success", true);
		}catch (Exception e) {
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	@RequestMapping(value="/startAutoTestCase.do")
	public void startAutoTestCase(HttpServletRequest request, HttpServletResponse response)throws Exception{
		String hisCaseId=request.getParameter("hisCaseId");
		String caseId=request.getParameter("caseId");
		AigaUser user=(AigaUser)request.getSession().getAttribute("aigaUser");
		String sql="insert into alm_workorder(order_id,workflow_id,parent_order_id,last_order_id,vm_task_id," +
				"parent_vm_task_id,last_vm_task_id,link_id,is_current_task,order_type,obj_id,obj_type," +
				"deal_type,is_lock,finish_print,exec_staff_id,exec_staff_no,status,opinion,create_time) " +
				"values(alm_workorder$seq.nextval,-1,-1,-1,-1,-1,-1,10001,'Y',2,"+caseId+
				",10,2,0,2,"+user.getUserId()+",'"+user.getUserAccount()+"',2,'启动自动化用例任务',sysdate)";
		System.out.println(sql);
		
		AigaHisCase[] aigaHisCases=aigaCaseSV.getHisCaseBySql("from AigaHisCase where caseId="+caseId+" order by hisCaseId desc");
		if(aigaHisCases==null||aigaHisCases.length==0||aigaHisCases[0]==null){
			//保存历史表 获得hisCaseId
			//aigaCaseSV.s
		}else{
			
		}
		//reqSV.updateBySQL(sql);
		//alm_workorder$seq.nextval
		//AUTOTESTCASE_FOLLOW
	}
	@RequestMapping(value="/getQuoteCase.do")
	public void getQuoteCase(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String querySql=getQuerySql(request);
		List objects=aigaFunCaseRelaSV.getObjectBySQL(querySql);
		JSONArray json = new JSONArray();
		for(int i=0;i<objects.size();i++){
			Object[] obj=(Object[])objects.get(i);
			JSONObject taskJSONOj=new JSONObject();
			Map map=new HashMap();
			map.put("sysName", obj[0]);
			map.put("sysId", obj[1]);
			map.put("caseName", obj[2]);
			map.put("relaId", obj[3]);
			map.put("parentFolderId", obj[4]);
			map.put("folderId", obj[5]);
			map.put("casePreCond",obj[6]);
			map.put("caseOperateInst", obj[7]);
			map.put("preResult", obj[8]);
			map.put("secId", obj[9]);
			map.put("relaType", obj[10]);
			map.put("hasTest", obj[11]);
			map.put("isFinishAuto", obj[12]);
			map.put("caseId", obj[13]);
			map.put("testType", obj[14]);
			taskJSONOj.putAll(map,jsonConfig);
			json.add(taskJSONOj);
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}
	
	public String getQuerySql(HttpServletRequest request)throws Exception{
		String funFolderId=request.getParameter("funFolderId");//当前功能点
		String queryType=request.getParameter("queryType");//0查询未引用 1查询已引用 2查询所有
		String caseName=BaseAction.decodeCN(request.getParameter("caseName")).toUpperCase();
		String funName=BaseAction.decodeCN(request.getParameter("funName")).toUpperCase();
		String sysId=request.getParameter("sysId");
		String baseQuerySql="select aff.sys_name,aff.sys_id, aic.case_name,afcr.rela_id,afcr.parent_folder_id," +
				"afcr.folder_id,aic.case_pre_cond,aic.case_operate_inst,aic.pre_result,aic.sec_id," +
				"afcr.rela_type,afcr.has_test,afcr.is_finish_auto,aic.case_id,afcr.test_type" +
				" from aiga_fun_folder aff,aiga_inst_case aic,aiga_fun_case_rela afcr " +
				" where afcr.parent_folder_id=aff.fun_id and afcr.case_id=aic.case_id and aff.is_invalid=0 and aic.is_delete<>1 ";
		if(StringUtils.isNotBlank(caseName)){baseQuerySql+=" and upper(aic.case_name) like '%"+caseName+"%' ";}
		if(StringUtils.isNotBlank(funName)){baseQuerySql+=" and upper(aff.sys_name) like '%"+funName+"%' ";}
		if(StringUtils.isNotBlank(sysId)){baseQuerySql+=" and aff.sys_Id="+sysId+" ";}
		queryType=(StringUtils.isBlank(queryType))?"2":queryType;
		if("0".equals(queryType)){
			baseQuerySql+=" and afcr.rela_type='owner' and afcr.case_id not in (select case_id from aiga_fun_case_rela where folder_id="+funFolderId+") ";
		}else if("1".equals(queryType)){
			baseQuerySql+=" and afcr.rela_type='quote' and afcr.folder_id="+funFolderId;
			baseQuerySql+=" order by rela_id";
		}else{
			if(StringUtils.isNotBlank(funFolderId)){baseQuerySql+=" and afcr.folder_id="+funFolderId;}
		}
		
		return baseQuerySql;
	}
	
	@RequestMapping("/quoteCaseByIds.do")
	public void quoteCaseByIds(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String funId = request.getParameter("funId");
			if(funId==null||funId.equals(""))
				throw new Exception("缺少请求参数funId");
			String caseIds = request.getParameter("caseIds");
			aigaFunCaseRelaSV.saveNewFunCaseRela(Integer.valueOf(funId), caseIds);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	@RequestMapping("/deleteQuoteByIds.do")
	public void deleteQuoteByIds(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String funId = request.getParameter("funId");
			if(funId==null||funId.equals(""))
				throw new Exception("缺少请求参数funId");
			String caseIds = request.getParameter("caseIds");
			aigaFunCaseRelaSV.deleteFunCaseRela(Integer.valueOf(funId), caseIds);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/checkQuote.do")
	public void checkQuote(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String funId = request.getParameter("funId");
			String caseIds = request.getParameter("caseIds");
			if(StringUtils.isBlank(funId)||StringUtils.isBlank(caseIds))
				throw new Exception("缺少请求参数");
			List objects=aigaFunCaseRelaSV.getObjectBySQL("select case_name from aiga_inst_case where case_id in " +
					"(select distinct case_id from aiga_fun_case_rela where rela_type='quote'" +
					" and  parent_folder_id="+funId+" and case_id in ("+caseIds+"))");
			StringBuffer isQuoteCase=new StringBuffer();
			for(Object object:objects){
				if(object instanceof Object[]){
					Object[] obj=(Object[])object;
					isQuoteCase.append((String)obj[0]+",");
				}else{
					isQuoteCase.append(object.toString()+",");
				}
			}
			isQuoteCase=(isQuoteCase.length()>0)?isQuoteCase.deleteCharAt(isQuoteCase.length()-1):isQuoteCase;
			this.setPostInfo("isQuoteCase",isQuoteCase.toString());
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	
	
	
	@RequestMapping("/changeTag.do")
	public void changeTag(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String subTasktag = request.getParameter("subTasktag");
			String caseIds = request.getParameter("caseIds");
			if(StringUtils.isBlank(subTasktag)||StringUtils.isBlank(caseIds))
				throw new Exception("缺少请求参数");
			AigaTestSubTask[] aigaTestSubTask=reqSV.getAigaTestSubTaskBySql("from AigaTestSubTask where subTaskTag=upper('"+subTasktag+"')");
			if(aigaTestSubTask!=null&&aigaTestSubTask.length>0&&aigaTestSubTask[0]!=null){
				reqSV.updateBySQL("update aiga_his_case set edit_type=1,sub_task_tag=upper('"+subTasktag+"') " +
						" where his_case_id in ("+caseIds+")");
				this.setPostInfo("isQuote",true);
			}else{
				this.setPostInfo("isQuote",false);
			}
			this.setPostInfo("success", true);
		}catch (Exception e) {
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
}
