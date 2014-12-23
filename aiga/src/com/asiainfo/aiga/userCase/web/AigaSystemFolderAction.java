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
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

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
import com.asiainfo.aiga.userCase.bo.AigaRElemSec;
import com.asiainfo.aiga.userCase.bo.AigaSecene;
import com.asiainfo.aiga.userCase.bo.AigaSubSysFolder;
import com.asiainfo.aiga.userCase.bo.AigaSystemFolder;
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
import com.asiainfo.aiga.userCase.service.impl.AigaSubSysFolderSVImpl;
import com.asiainfo.lucene.LuceneEntities.properties.LuceneCommon;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;



/**
 * Created on 2014-6-23
 * <p>Description: [功能点归属系统Action]</p>
*/

@Controller
public class AigaSystemFolderAction extends BaseAction
{
	private static final String CREATE_CASE_PAGE_URL="case/createCase.jsp";
	private static final String MANAGE_CASE_PAGE_URL="case/manageCase.jsp";
	private static final String EDIT_CASE_PAGE_URL="case/editCase.jsp";
	private static final String MANAGE_COLLECT_PAGE_URL="case/coolectionManage.jsp";
	private List<Map<String, Object>> objList=new ArrayList<Map<String, Object>>();
	private static final String AIGA_FUN_FOLDER="AIGA_FUN_FOLDER";
	private static final String AIGA_SYSTEM_FOLDER="AIGA_SYSTEM_FOLDER";
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
	
	@RequestMapping("/getComBoxForSysFolder.do")
	public void getComBoxForSysFolder(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysConstant[] sysConstants = SysContentUtil
		.getSysContant(AIGA_SYSTEM_FOLDER);
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
	
	@RequestMapping("/getSysFolderList.do")
	public void getSysFolderList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		JSONArray json = new JSONArray();
		String sysName = request.getParameter("sysName");
		String sysOfDomain = request.getParameter("sysOfDomain");
		String importantClass = request.getParameter("importantClass");
		StringBuffer conditionBuffer = new StringBuffer();
		Map map=this.paginationParams(request);
		int pageNo = Integer.parseInt(map.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(map.get(this.LIMIT_PARAM).toString());
		
		conditionBuffer.append((sysName!=null&&!sysName.equals(""))?" and a.sysName like '%"+this.decodeCN(sysName).trim()+"%'":"");//功能点名称
		conditionBuffer.append((importantClass!=null&&!importantClass.equals("")&&!importantClass.equals("null")&&!importantClass.equals("undefined"))?" and a.importantClass ='"+this.decodeCN(importantClass)+"'":"");//重要等级
		conditionBuffer.append((sysOfDomain!=null&&!sysOfDomain.equals("")&&!sysOfDomain.equals("null")&&!sysOfDomain.equals("undefined"))?" and a.sysOfDomain ='"+this.decodeCN(sysOfDomain)+"'":"");//功能点类型
		List<Object> list = commonPageinationSV.getObjectList(pageNo, pageSize, "from AigaSystemFolder a where 1=1 "+conditionBuffer.toString());
		
		json = JSONArray.fromObject(list, this.jsonConfig);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal("from AigaSystemFolder a where 1=1 "+conditionBuffer.toString()));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}
	
	@RequestMapping("/getSysFolderBySysId.do")
	public void getSysFolderBySysId(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String sysId = request.getParameter("sysId");
		StringBuffer conditionBuffer = new StringBuffer();
		conditionBuffer.append((sysId!=null&&!sysId.equals(""))?" and a.sysId = "+sysId+"":"");//功能点ID
		AigaSystemFolder[] sysFolders =aigaSystemFolderSV.getSystemFolder("FROM AigaSystemFolder a where 1=1 "+conditionBuffer.toString());
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		map.put("success", false);
		if (sysFolders.length == 1) {
			JSON json =JSONObject.fromObject(sysFolders[0], jsonConfig);
			map.put("data", json);
			map.put("success", true);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping("/saveSystemFolderForm.do")
	public void saveSystemFolderForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		try{
			Object[] value = this.transFormToObj(request, new Class[]{AigaSystemFolder.class});
			if(value!=null&&value.length==1){
				if(value[0] instanceof AigaSystemFolder){
					AigaSystemFolder aigaSystemFolder = (AigaSystemFolder)value[0];
					try{
						String sysName = aigaSystemFolder.getSysName();
						if(aigaSystemFolder.getSysId()==null){//新增
							AigaSystemFolder[] sysFolders = aigaSystemFolderSV.getSystemFolder("FROM AigaSystemFolder");
							for(AigaSystemFolder sysFolder: sysFolders){
								if(sysFolder.getSysName().equals(sysName)){
									throw new Exception("新增的系统与原有的系统重名!");
								}
							}
							aigaSystemFolder.setCreateTime(new Timestamp(System.currentTimeMillis()));
							aigaSystemFolder.setUpdateTime(new Timestamp(System.currentTimeMillis()));
						}else{//修改
							AigaSystemFolder[] sysFolders = aigaSystemFolderSV.getSystemFolder("FROM AigaSystemFolder");
							for(AigaSystemFolder sysFolder: sysFolders){
								if(sysFolder.getSysName().equals(sysName)&&!(aigaSystemFolder.getSysId().toString().equals(sysFolder.getSysId().toString()))){
									throw new Exception("修改后的系统名称与原有的系统重名!");
								}
							}
							aigaSystemFolder.setUpdateTime(new Timestamp(System.currentTimeMillis()));
						}
					}catch(Exception e){
						if(e.getMessage().equals("新增的系统与原有的系统重名!")||e.getMessage().equals("修改后的系统名称与原有的系统重名!")){
							throw e;
						}
						aigaSystemFolder.setCreateTime(new Timestamp(System.currentTimeMillis()));
						aigaSystemFolder.setUpdateTime(new Timestamp(System.currentTimeMillis()));
					}
					aigaSystemFolderSV.saveAigaSystemFolder(aigaSystemFolder);
					this.setPostInfo("success", true);
					this.setPostInfo("message", "系统保存成功");
				}
			}
		}
		catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", "保存失败,原因:"+e.getMessage());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/deleteSystemFolders.do")
	private void deleteSystemFolders(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String sysIds = request.getParameter("sysIds");
			if(sysIds==null||sysIds.equals(""))
				throw new Exception("未从界面获取到sysId参数");
			String[] ids = sysIds.split(",");
			for(String id : ids){
				AigaSubSysFolder[] aigaSubSysFolder = aigaSubSysFolderSV.getSubSysFolder("FROM AigaSubSysFolder a where 1=1 and a.sysId="+id);
				if(aigaSubSysFolder.length>=1){
					throw new Exception("本次未删除的系统,需要清空对应的子系统才可以删除!");
				}
				AigaSystemFolder[] sysFolders = aigaSystemFolderSV.getSystemFolder("FROM AigaSystemFolder a where 1=1 and a.sysId = "+id);
				if(sysFolders.length==1){
					aigaSystemFolderSV.deleteAigaSystemFolder(sysFolders[0]);
				}else{
					throw new Exception("对不起,该系统已经删除!");
				}
			}
			//aigaFunFolderSV.deleteAigaFunFolder(sysIds);
			this.setPostInfo("success", true);
			this.setPostInfo("message", "系统删除成功");
		}catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getMessage());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getSubSysFolderList.do")
	public void getSubSysFolderList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		JSONArray json = new JSONArray();
		String sysName = request.getParameter("sysName");
		String sysId = request.getParameter("sysId");
		StringBuffer conditionBuffer = new StringBuffer();
		Map map=this.paginationParams(request);
		int pageNo = Integer.parseInt(map.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(map.get(this.LIMIT_PARAM).toString());
		
		conditionBuffer.append((sysName!=null&&!sysName.equals(""))?" and a.sysName like '%"+this.decodeCN(sysName).trim()+"%'":"");//子系统名称
		conditionBuffer.append((sysId!=null&&!sysId.equals("")&&!sysId.equals("null")&&!sysId.equals("undefined"))?" and a.sysId ='"+this.decodeCN(sysId)+"'":"");//归属系统
		List<Object> list = commonPageinationSV.getObjectList(pageNo, pageSize, "from AigaSubSysFolder a where 1=1 "+conditionBuffer.toString());
		
		json = JSONArray.fromObject(list, this.jsonConfig);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal("from AigaSubSysFolder a where 1=1 "+conditionBuffer.toString()));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}
	
	@RequestMapping("/saveSubSysFolderForm.do")
	public void saveSubSysFolderForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		try{
			Object[] value = this.transFormToObj(request, new Class[]{AigaSubSysFolder.class});
			if(value!=null&&value.length==1){
				if(value[0] instanceof AigaSubSysFolder){
					AigaSubSysFolder aigaSubSysFolder = (AigaSubSysFolder)value[0];
					try{
						String sysName = aigaSubSysFolder.getSysName();
						if(aigaSubSysFolder.getSubsysId()==null){//新增
							AigaSubSysFolder[] subsysFolders = aigaSubSysFolderSV.getSubSysFolder("FROM AigaSubSysFolder a where a.sysId="+aigaSubSysFolder.getSysId());
							for(AigaSubSysFolder subsysFolder: subsysFolders){
								if(subsysFolder.getSysName().equals(sysName)){
									throw new Exception("同一系统下,不能出现重名的子系统!");
								}
							}
							aigaSubSysFolder.setCreateTime(new Timestamp(System.currentTimeMillis()));
							aigaSubSysFolder.setUpdateTime(new Timestamp(System.currentTimeMillis()));
						}else{//修改
							AigaSubSysFolder[] subsysFolders = aigaSubSysFolderSV.getSubSysFolder("FROM AigaSubSysFolder a where a.sysId="+aigaSubSysFolder.getSysId());
							for(AigaSubSysFolder subsysFolder: subsysFolders){
								if(subsysFolder.getSysName().equals(sysName)&&!(aigaSubSysFolder.getSubsysId().toString().equals(subsysFolder.getSubsysId().toString()))){
									throw new Exception("同一系统下,不能出现重名的子系统!");
								}
							}
							aigaSubSysFolder.setUpdateTime(new Timestamp(System.currentTimeMillis()));
						}
					}catch(Exception e){
						if(e.getMessage().equals("同一系统下,不能出现重名的子系统!")){
							throw e;
						}
						aigaSubSysFolder.setCreateTime(new Timestamp(System.currentTimeMillis()));
						aigaSubSysFolder.setUpdateTime(new Timestamp(System.currentTimeMillis()));
					}
					aigaSubSysFolderSV.saveAigaSubSysFolder(aigaSubSysFolder);
					this.setPostInfo("success", true);
					this.setPostInfo("message", "子系统保存成功");
				}
			}
		}
		catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", "保存失败,原因:"+e.getMessage());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping("/getSubSysFolderBySubSysId.do")
	public void getSubSysFolderBySubSysId(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String subsysId = request.getParameter("subsysId");
		StringBuffer conditionBuffer = new StringBuffer();
		conditionBuffer.append((subsysId!=null&&!subsysId.equals(""))?" and a.subsysId = "+subsysId+"":"");//功能点ID
		AigaSubSysFolder[] subsysFolders =aigaSubSysFolderSV.getSubSysFolder("FROM AigaSubSysFolder a where 1=1 "+conditionBuffer.toString());
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		map.put("success", false);
		if (subsysFolders.length == 1) {
			JSON json =JSONObject.fromObject(subsysFolders[0], jsonConfig);
			map.put("data", json);
			map.put("success", true);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	
	
	@RequestMapping("/deleteSubSysFolders.do")
	private void deleteSubSysFolders(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String subsysIds = request.getParameter("subsysIds");
			if(subsysIds==null||subsysIds.equals(""))
				throw new Exception("未从界面获取到subsysId参数");
			String[] ids = subsysIds.split(",");
			for(String id : ids){
				AigaFunFolder[] AigaFunFolders = aigaFunFolderSV.getAigaFunFolderBySql("FROM AigaFunFolder a where 1=1 and a.isInvalid=0 and a.subSysId="+id);
				if(AigaFunFolders.length>=1){
					throw new Exception("本次未删除的子系统,需要清空对应的功能点才可以删除!");
				}
				AigaSubSysFolder[] subsysFolders = aigaSubSysFolderSV.getSubSysFolder("FROM AigaSubSysFolder a where 1=1 and a.subsysId = "+id);
				if(subsysFolders.length==1){
					aigaSubSysFolderSV.deleteAigaSubSysFolder(subsysFolders[0]);
				}else{
					throw new Exception("对不起,该子系统已经删除!");
				}
			}
			//aigaFunFolderSV.deleteAigaFunFolder(sysIds);
			this.setPostInfo("success", true);
			this.setPostInfo("message", "子系统删除成功");
		}catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getMessage());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value="/getReasonByTaskEnv.do")
	public void getReasonByTaskEnv(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String taskId = request.getParameter("subTaskId");
		String reasonEnvType = request.getParameter("reasonEnvType");
		String querySql = "from AigaTestSubReason where subTaskId=" + taskId + " and reasonEnvType=" + reasonEnvType;
		AigaTestSubReason[] reasons = reqSV.getAigaTestSubReasonBySql(querySql);
		AigaTestSubReason result = new AigaTestSubReason();
		if(reasons != null && reasons.length != 0 && reasons[0] != null) {
			result = reasons[0];
		}
		this.setFormData(result);
		this.setPostInfo("success", true);
		this.postInfo(request, response);
	}
}
