package com.asiainfo.aiga.requisition.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.IObjectType;
import com.asiainfo.aiga.common.WorkflowParam;
import com.asiainfo.aiga.common.helper.ActionHelper;
import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.common.service.ICommonPageinationSV;
import com.asiainfo.aiga.common.workflowVo.Workflow;
import com.asiainfo.aiga.common.xls.ExcelVO;
import com.asiainfo.aiga.common.xls.XlsHelper;
import com.asiainfo.aiga.funPoint.bo.AigaFunPoint;
import com.asiainfo.aiga.funPoint.service.IAigaFunPointSV;
import com.asiainfo.aiga.requisition.bo.AigaAccountTest;
import com.asiainfo.aiga.requisition.bo.AigaAudit;
import com.asiainfo.aiga.requisition.bo.AigaPerfSubResult;
import com.asiainfo.aiga.requisition.bo.AigaPerformanceSubTask;
import com.asiainfo.aiga.requisition.bo.AigaQuestion;
import com.asiainfo.aiga.requisition.bo.AigaRequisition;
import com.asiainfo.aiga.requisition.bo.AigaSubTaskProblem;
import com.asiainfo.aiga.requisition.bo.AigaTestSubReason;
import com.asiainfo.aiga.requisition.bo.AigaTestSubTask;
import com.asiainfo.aiga.requisition.bo.SysOrganize;
import com.asiainfo.aiga.requisition.bo.SysStaffOrgRelat;
import com.asiainfo.aiga.requisition.service.IAigaRequisitionSV;
import com.asiainfo.aiga.solidTask.bo.AigaSolidTask;
import com.asiainfo.aiga.sysConstant.bo.SysConstant;
import com.asiainfo.aiga.sysConstant.util.SysContentUtil;
import com.asiainfo.aiga.testTask.bo.AigaTestTask;
import com.asiainfo.aiga.userCase.bo.AigaSecene;
import com.asiainfo.aiga.userCase.bo.extend.AigaInstCase;
import com.asiainfo.aiga.userCase.service.IAigaCaseSV;
import com.asiainfo.aiga.userCase.service.IAigaSeceneSV;

@Controller
public class AigaRequisitionAction extends BaseAction {
	
	private String downSubTaskSql="";
	@Resource(name="requisitionSV")
	private IAigaRequisitionSV reqSV;
	
	@Resource(name="commonPageinationSV")
	private ICommonPageinationSV commonPageinationSV;
	
	@Resource(name="testSeceneSV")
	private IAigaSeceneSV aigaSeceneSV;
	
	@Resource(name="funPointSV")
	private IAigaFunPointSV funPSV;
	
	@Resource(name="caseSV")
	private IAigaCaseSV aigaCaseSV;
	
	@RequestMapping(value="/getRequisition.do")
	public void getRequisition(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String reqId = request.getParameter("reqId");
		String querySql = "from AigaRequisition where req_id=" + reqId;
		AigaRequisition[] reqs = reqSV.getAigaRequisitionBySql(querySql);
		AigaRequisition retVal = null;
		if(reqs == null || reqs.length == 0) {
//			retVal = new AigaRequisition();
		} else {
			retVal = reqs[0];
		}
		this.setFormData(retVal);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/getRequisitionByNo.do")
	public void getRequisitionByNo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String reqNo = request.getParameter("reqNo");
		String querySql = "from AigaRequisition where req_no='" + reqNo + "'";
		AigaRequisition[] reqs = reqSV.getAigaRequisitionBySql(querySql);
		AigaRequisition retVal = null;
		if(reqs == null || reqs.length == 0) {
//			retVal = new AigaRequisition();
		} else {
			retVal = reqs[0];
		}
		this.setFormData(retVal);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/saveRequisition.do")
	public void saveRequisition(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Object[] results = this.transFormToObj(request, new Class[]{AigaRequisition.class});
		AigaRequisition req = new AigaRequisition();
		for(Object result : results){
			if(result instanceof AigaRequisition)
				req = (AigaRequisition)result;
		}
		if(req!=null&&results.length!=0)
			reqSV.saveAigaRequisition(req);
	}
	
	@RequestMapping(value="/getTestSubTaskById.do")
	public void getTestSubTaskById(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String subTaskId = request.getParameter("subTaskId");
		String querySql = "from AigaTestSubTask where sub_task_id=" + subTaskId;
		AigaTestSubTask[] subTasks = reqSV.getAigaTestSubTaskBySql(querySql);
		AigaTestSubTask subTask = null;
		if(subTasks != null && subTasks.length != 0) {
			subTask = subTasks[0];
		}
		this.setFormData(subTask);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/getAuditBySubTaskId.do")
	public void getAuditBySubTaskId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String subTaskId = request.getParameter("subTaskId");
		String querySql = "from AigaAudit where sub_task_id=" + subTaskId;
		AigaAudit[] audits = reqSV.getAigaAuditBySql(querySql);
		this.setTable(audits);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/getPerfSubResultBySubTaskId.do")
	public void getPerfSubResultBySubTaskId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String subTaskId = request.getParameter("subTaskId");
		String querySql = "from AigaPerfSubResult where sub_task_id=" + subTaskId;
		AigaPerfSubResult[] results = reqSV.getAigaPerfSubResultBySql(querySql);
		this.setTable(results);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/getSubTaskFunPointDetail.do")
	public void getSubTaskFunPointDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String subTaskId = request.getParameter("subTaskId");
		String querySql = "from AigaTestSubTask where sub_task_id=" + subTaskId;
		AigaTestSubTask[] subTasks = reqSV.getAigaTestSubTaskBySql(querySql);
		if(subTasks.length==1){
			request.setAttribute("aigaTestSubTask", subTasks[0]);//插入子任务信息
			AigaFunPoint[] aigaFunPoints = funPSV.getFunPointBySql("FROM AigaFunPoint a WHERE a.subTaskId=" + subTaskId);
			if(aigaFunPoints.length>=1){
				List<AigaFunPoint> aigaFunPointsList  = new ArrayList<AigaFunPoint>();
				Map<String,List<AigaInstCase>> casesMaps = new HashMap<String,List<AigaInstCase>>();
				Map<String,String> secenesMaps = new HashMap<String,String>();
				for(AigaFunPoint aigaFunPoint:aigaFunPoints){
					aigaFunPointsList.add(aigaFunPoint);
					if(aigaFunPoint.getFunId()!=null&&!aigaFunPoint.getFunId().equals("")){
						AigaInstCase[] cases = aigaCaseSV.getInstCaseBySql("FROM AigaInstCase a WHERE a.caseId IN (SELECT b.caseId FROM AigaRFunCase b WHERE b.funId="+ aigaFunPoint.getFunId() +") and a.isDelete=0");
						if(cases.length>=1){
							List<AigaInstCase> casesList = new ArrayList<AigaInstCase>();
							for(AigaInstCase instCase:cases){
								instCase.setCaseOperateInst(instCase.getCaseOperateInst().replaceAll("\n", "<br/>"));
								instCase.setPreResult(instCase.getPreResult().replaceAll("\n", "<br/>"));
								casesList.add(instCase);
								try{
									String secId = instCase.getSecId().toString();
									if(secId!=null&&!secId.equals("")){
										AigaSecene aigaSecene = aigaSeceneSV.getAigaSeceneById(Integer.parseInt(secId));
										if(aigaSecene!=null){
											secenesMaps.put(instCase.getSecId().toString(), aigaSecene.getSeceneName().replaceAll("<","&lt;").replaceAll(">","&gt;"));
										}
									}
								}catch(Exception e){
									secenesMaps.put(instCase.getSecId().toString(), "未关联场景");
								}
							}
							casesMaps.put(aigaFunPoint.getFunId().toString(),casesList);
						}
					}
				}
				request.setAttribute("secenesMaps", secenesMaps);//插入用例的场景信息
				request.setAttribute("casesMaps", casesMaps);//插入用例信息
				request.setAttribute("aigaFunPointsList", aigaFunPointsList);//插入功能点信息
			}
			//response.sendRedirect("aiga/workflow/subTaskFunPointDetail.jsp");
			request.getRequestDispatcher("aiga/workflow/subTaskFunPointDetail.jsp").forward(request, response);
		}else{
			//response.sendRedirect("aiga/workflow/subTaskFunPointDetail.jsp");
			request.getRequestDispatcher("aiga/workflow/subTaskFunPointDetail.jsp").forward(request, response);
		}
	}
	
	@RequestMapping(value="/getAccountTestBySubTaskId.do")
	public void getAccountTestBySubTaskId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String subTaskId = request.getParameter("subTaskId");
		String querySql = "from AigaAccountTest where sub_task_id=" + subTaskId;
		AigaAccountTest[] accounts = reqSV.getAigaAccountTestBySql(querySql);
		this.setTable(accounts);
		this.postInfo(request, response);
	}
	
	@RequestMapping("/saveAudits.do")
	public void saveAudits(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Object[] results = this.transTableToObj(request, AigaAudit.class);
		AigaAudit audit;
		List<AigaAudit> audits = new ArrayList<AigaAudit>();
		for(Object result : results){
			if(result instanceof AigaAudit) {
				audit = (AigaAudit)result;
				audits.add(audit);
			}
		}
		for(AigaAudit elem : audits) {
			reqSV.saveOrUpdate(elem);
		}
	}
	
	@RequestMapping("/saveAccountTests.do")
	public void saveAccountTests(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Object[] results = this.transTableToObj(request, AigaAccountTest.class);
		AigaAccountTest account;
		List<AigaAccountTest> accounts = new ArrayList<AigaAccountTest>();
		for(Object result : results){
			if(result instanceof AigaAccountTest) {
				account = (AigaAccountTest)result;
				accounts.add(account);
			}
		}
		for(AigaAccountTest elem : accounts) {
			reqSV.saveOrUpdate(elem);
		}
	}
	
	@RequestMapping(value="/getTestTaskByTag.do")
	public void getTestTaskByTag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String taskTag = request.getParameter("taskTag");
		String querySql = "from AigaTestTask where task_tag='" + taskTag + "'";
		AigaTestTask[] tasks = reqSV.getAigaTestTaskBySql(querySql);
		AigaTestTask task = null;
		if(tasks != null && tasks.length != 0) {
			task = tasks[0];
		}
		this.setFormData(task);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/getTestTaskByReqId.do")
	public void getTestTaskByReqId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String reqId = request.getParameter("reqId");
		if(reqId == null || "".equals(reqId)) {
			reqId = "0";
		}
		String querySql = "from AigaTestTask where req_id=" + reqId;
		AigaTestTask[] tasks = reqSV.getAigaTestTaskBySql(querySql);
		this.setTable(tasks);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/getTestTaskById.do")
	public void getTestTaskById(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String taskId = request.getParameter("taskId");
		String querySql = "from AigaTestTask where task_id=" + taskId;
		AigaTestTask[] tasks = reqSV.getAigaTestTaskBySql(querySql);
		AigaTestTask retVal = null;
		if(tasks != null && tasks.length != 0) {
			retVal = tasks[0];
		}
		this.setFormData(retVal);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/savePerSubTask.do")
	public void savePerSubTask(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Object[] results = this.transFormToObj(request, new Class[]{AigaPerformanceSubTask.class});
		AigaPerformanceSubTask perSubTask = new AigaPerformanceSubTask();
		for(Object result : results){
			if(result instanceof AigaPerformanceSubTask)
				perSubTask = (AigaPerformanceSubTask)result;
		}
		if(perSubTask!=null&&results.length!=0)
			reqSV.savePerSubTask(perSubTask);
	}
	
	@RequestMapping(value="/saveSubTaskProblem.do")
	public void saveSubTaskProblem(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			Object[] results = this.transFormToObj(request, new Class[]{AigaSubTaskProblem.class});
			AigaSubTaskProblem subTaskProblem = new AigaSubTaskProblem();
			for(Object result : results){
				if(result instanceof AigaSubTaskProblem)
					subTaskProblem = (AigaSubTaskProblem)result;
			}
			if(subTaskProblem!=null&&results.length!=0)
				reqSV.saveAigaSubTaskProblem(subTaskProblem);
			this.setPostInfo("success", true);
		}catch (Exception e) {
			// TODO: handle exception
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
		
	}
	
	@RequestMapping(value="/getSubRelaPerForm.do")
	public void getSubRelaPerForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String relaSubTaskId = request.getParameter("relaSubTaskId");
		String querySql = "from AigaPerformanceSubTask where relaSubTaskId=" + relaSubTaskId;
		
		AigaPerformanceSubTask[] perSubTasks = reqSV.getPerSubTaskBySql(querySql);
		AigaPerformanceSubTask perSubTask = null;
		if(perSubTasks!=null&&perSubTasks.length!=0) {
			perSubTask = perSubTasks[0];
		}
		this.setFormData(perSubTask);
		this.postInfo(request, response);
	}

	@RequestMapping(value="/getSubTaskListByTaskId.do")
	public void getSubTaskListByTaskId(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String taskId = request.getParameter("taskId");
		String querySql = "from AigaTestSubTask where taskId=" + taskId;
		AigaTestSubTask[] subTasks = reqSV.getAigaTestSubTaskBySql(querySql);
		this.setTable(subTasks);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/getReasons.do")
	public void getReasons(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String taskId = request.getParameter("subTaskId");
		String querySql = "from AigaTestSubReason where subTaskId=" + taskId;
		AigaTestSubReason[] reasons = reqSV.getAigaTestSubReasonBySql(querySql);
		this.setTable(reasons);
		this.postInfo(request, response);
	}
	
	@RequestMapping("/saveReasons.do")
	public void saveReasons(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String subTaskId = request.getParameter("subTaskId");
		String querySql = "from AigaTestSubTask where sub_task_id=" + subTaskId;
		AigaTestSubTask[] subTasks = reqSV.getAigaTestSubTaskBySql(querySql);
		AigaTestSubTask subTask = null;
		if(subTasks != null && subTasks.length != 0) {
			subTask = subTasks[0];
		}
		if(subTask == null) {
			throw new Exception("未发现主键为" + subTaskId + "的子任务");
		}
		Object[] results = this.transTableToObj(request, AigaTestSubReason.class);
		AigaTestSubReason reason;
		List<AigaTestSubReason> reasons = new ArrayList<AigaTestSubReason>();
		for(Object result : results){
			if(result instanceof AigaTestSubReason) {
				reason = (AigaTestSubReason)result;
				reasons.add(reason);
			}
		}
		int i=0;
		int j=0;
		for(AigaTestSubReason res : reasons) {
			if(res.getReasonEnvType()!=null){
			   if(res.getReasonEnvType()==2) {
				   subTask.setPossibleBack(3);
				   i=1;
			   }
			   if(res.getReasonEnvType()==3) {
				  subTask.setPossibleProduct(3);
				  j=1;
			   }
			}
			reqSV.saveOrUpdate(res);
		}
		if(i!=1){
			subTask.setPossibleBack(1);
		}
		if(j!=1){
			subTask.setPossibleProduct(1);
		}
		subTask.setPossibleTest(1);
		reqSV.saveOrUpdate(subTask);
	}
	
	@RequestMapping("/saveResultInfos.do")
	public void saveResultInfos(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Object[] results = this.transTableToObj(request, AigaPerfSubResult.class);
		AigaPerfSubResult reason;
		List<AigaPerfSubResult> reasons = new ArrayList<AigaPerfSubResult>();
		for(Object result : results){
			if(result instanceof AigaPerfSubResult) {
				reason = (AigaPerfSubResult)result;
				reasons.add(reason);
			}
		}
		for(AigaPerfSubResult res : reasons) {
			reqSV.saveOrUpdate(res);
		}
		this.setPostInfo("success", true);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/deleteReason.do")
	public void deleteReason(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String reasonId = request.getParameter("reasonId");
		String querySql = "from AigaTestSubReason where reasonId=" + reasonId;
		AigaTestSubReason[] reasons = reqSV.getAigaTestSubReasonBySql(querySql);
		for(AigaTestSubReason reason : reasons) {
			reqSV.delete(reason);
		}
		this.setPostInfo("success", true);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/deleteResultInfo.do")
	public void deleteResultInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String resultId = request.getParameter("resultId");
		String querySql = "from AigaPerfSubResult where resultId=" + resultId;
		AigaPerfSubResult[] results = reqSV.getAigaPerfSubResultBySql(querySql);
		for(AigaPerfSubResult result : results) {
			reqSV.delete(result);
		}
	}
	
//	@RequestMapping(value="/saveSubTaskList.do")
//	public void saveSubTaskList(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		Object[] results = this.transTableToObj(request, AigaTestSubTask.class);
//		AigaTestSubTask[] subTasks = null;
//		for(Object result : results){
//			if(result instanceof AigaTestSubTask)
//				subTasks = (AigaTestSubTask[])result;
//		}
//		for(AigaTestSubTask subTask : subTasks) {
//			reqSV.saveAigaTestSubTask(subTask);
//		}
//	}
	
	@RequestMapping(value="/saveSubTaskInfo.do")
	public void saveSubTaskInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Object[] results = this.transFormToObj(request, new Class[]{AigaTestSubTask.class});
		AigaTestSubTask subTask = null;
		for(Object result : results){
			if(result instanceof AigaTestSubTask)
				subTask = (AigaTestSubTask)result;
		}
		if(subTask != null && results.length!=0) {
			reqSV.saveAigaTestSubTask(subTask);
		}
		this.setPostInfo("success", true);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/saveReviewInfo.do")
	public void saveReviewInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map map=new HashMap();
		map.put("success", false);
		AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
		long userId=user.getUserId();
		String userName=user.getUserName();
		try {
			Object[] results = this.transTableToObj(request,AigaTestSubTask.class);
			AigaTestSubTask subTask = null;
			for (Object result : results) {
				if (result instanceof AigaTestSubTask)
					subTask = (AigaTestSubTask) result;
					subTask.setOperId(userId);
					subTask.setOperName(userName);
					Date date = new Date();
					subTask.setReviewTime(date);
				if (subTask != null && results.length != 0) {
					reqSV.saveAigaTestSubTask(subTask);
				}
			}
			map.put("success", true);
			map.put("message", "保存成功！是否刷新页面？");
		} catch (Exception e) {
			e.getStackTrace();
			map.put("success", false);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping(value="/delSubTaskInfoById.do")
	public void delSubTaskInfoById(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String subTaskId = request.getParameter("subTaskId");
		String querySql = "from AigaTestSubTask where sub_task_id=" + subTaskId;
		AigaTestSubTask[] subTasks = reqSV.getAigaTestSubTaskBySql(querySql);
		for(AigaTestSubTask subTask : subTasks){
			reqSV.deleteAigaTestSubTask(subTask);
		}
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/getTestSubTaskByCon.do")
	public void getTestSubTaskByCon(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String subTaskTag = this.decodeCN(request.getParameter("subTaskTag"));
		String subTaskName = this.decodeCN(request.getParameter("subTaskName")); 
		String subTaskStatus = this.decodeCN(request.getParameter("subTaskStatus"));
		String creator = this.decodeCN(request.getParameter("creator"));
		String subTaskType = request.getParameter("subTaskType");
		String taskId = request.getParameter("taskId");
		String beginDate = request.getParameter("beginDate");
		String endDate=request.getParameter("endDate");
		String isFlag=request.getParameter("isFlag");
		String flag=request.getParameter("flag");
		String isClose=request.getParameter("isClose");
		String testorId = this.decodeCN(request.getParameter("testorId"));
		String organizeId=request.getParameter("organizeId");
		String reviewResult=this.decodeCN(request.getParameter("reviewResult"));
		Map map=this.paginationParams(request);
		int pageNo = Integer.parseInt(map.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(map.get(this.LIMIT_PARAM).toString());
		String querySql = "from AigaTestSubTask a where 1=1";
		if(subTaskTag != null && !"".equals(subTaskTag)) {
			querySql += " and a.subTaskTag like '%" + subTaskTag + "%'";
		}
		if(subTaskName != null && !"".equals(subTaskName)) {
			querySql += " and a.subTaskName like '%" + subTaskName + "%'";
		}
		if(flag.equals("2")){
			querySql += " and a.subTaskStatus<>699 and a.subTaskStatus<>799 and a.subTaskStatus<>899 and a.subTaskStatus<>-1";
		}
		/*if(flag.equals("3")){
			querySql += " and a.subTaskStatus<>699 and a.subTaskStatus<>799 and a.subTaskStatus<>899 and a.subTaskStatus<>601 and a.subTaskStatus<>701 and a.subTaskStatus<>801 and a.subTaskStatus<>-1";
		}*/
	    if(subTaskStatus != null && !"".equals(subTaskStatus) && !subTaskStatus.equals("null")&& !subTaskStatus.equals("undefined")) {
		    querySql += " and a.subTaskStatus=" + subTaskStatus;
	    }
	    if(StringUtils.isNotBlank(isClose)&&"true".equals(isClose)){
	    	querySql += " and a.subTaskStatus<>-1 ";
	    }
		if(NaNull(creator)) {
			querySql += " and a.creator=" + creator;
		}
		if(subTaskType != null && !"".equals(subTaskType)) {
			querySql += " and a.subTaskType=" + subTaskType;
		}
		if(beginDate != null && !"".equals(beginDate) && !beginDate.equals("undefined") && !beginDate.equals("null")) {
			querySql += " and a.factCompleteTime >= to_date('" + beginDate.substring(0, 10) + "','yyyy-MM-dd')";
		}
		if(endDate != null && !"".equals(endDate) && !endDate.equals("undefined") && !endDate.equals("null")) {
			querySql += " and a.factCompleteTime <= to_date('" + endDate.substring(0, 10) + "','yyyy-MM-dd')";
		}
		if(NaNull(testorId)) {
			querySql += " and a.testorId="+testorId.trim()+" ";
		}
		if(taskId != null && !"".equals(taskId)) {
			querySql += " and a.taskId=" + taskId;
		}
		if(isFlag!=null && isFlag.equals("true")&& !isFlag.equals("null")){
			 querySql+=" and a.factCompleteTime is null";
		}
		if(StringUtils.isNotBlank(reviewResult)&&NaNull(reviewResult)){
			querySql += ("0".equals(reviewResult))?" and (a.reviewResult is null or a.reviewResult=0)":" and a.reviewResult=" + reviewResult;
		}
		if(organizeId != null && !"".equals(organizeId)&&!organizeId.equals("null")&&!organizeId.equals("undefined")) {
			String hql="from SysStaffOrgRelat a where a.organizeId='"+organizeId+"'";
			SysStaffOrgRelat[] sysStaffOrg=reqSV.getTestorIdByOrgId(hql);
			querySql+=" and (a.testorId="+sysStaffOrg[0].getStaffId();
			for(int i=1;i<sysStaffOrg.length;i++){
				querySql += " or a.testorId=" + sysStaffOrg[i].getStaffId();
			}
			querySql+=")";
		}
		
		if(flag.equals("4")){
			querySql+=" and a.testorId="+((AigaUser)request.getSession().getAttribute("aigaUser")).getUserId()+" and a.subTaskStatus<>-1";
		}
		querySql += " order by a.testorName,a.factCompleteTime DESC";
		downSubTaskSql=querySql;
		List<Object> subTasks = commonPageinationSV.getObjectList(pageNo, pageSize, querySql);
		JSONArray json = new JSONArray();
		json = JSONArray.fromObject(subTasks, this.jsonConfig);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal(querySql));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
		//this.setTable(subTasks);
		//this.postInfo(request, response);
	}
	@RequestMapping("/downloadSubTasks.do")
	public void downloadSubTasks(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ExcelVO excelVo=new ExcelVO();
		List<Object> list = commonPageinationSV.getObjectList(1, Integer.MAX_VALUE, downSubTaskSql);
		List<Map<String, Object>> objList=new ArrayList<Map<String, Object>>();

		//子任务状态常量
		Long[] params={40000L,50000L,60000L};
		List<Workflow> workfowList=workfowList=WorkflowParam.getWorkflowsByTemplateIds(params);
		Map<String,String> contentMap = new HashMap<String,String>();
		for (Workflow workfolw : workfowList) {
			contentMap.put(String.valueOf(workfolw.getLinkId()), workfolw.getVmTaskName());
		}
		contentMap.put("-1","关闭");
		//可测性常量
		Map<String,String> possibleResultMap = new HashMap<String,String>();
		SysConstant[] possibleRresults = SysContentUtil.getSysContant("possible");
		for (SysConstant t : possibleRresults) {
			possibleResultMap.put(String.valueOf(t.getValue()), t.getShow());
		}
		//评审结果常量
		Map<String,String> reviewResultMap = new HashMap<String,String>();
		SysConstant[] reviewResultResults = SysContentUtil.getSysContant("reviewResult");
		for (SysConstant t : reviewResultResults) {
			reviewResultMap.put(String.valueOf(t.getValue()), t.getShow());
		}
		//封装数据导出
		for(int i=0;i<list.size();i++){
			Map<String,Object> map = new HashMap<String,Object>();
			AigaTestSubTask obj=(AigaTestSubTask)list.get(i);
			map.put("reviewResult",reviewResultMap.get(NullValueFilter(obj.getReviewResult())));	
			map.put("subTaskName",NullValueFilter(obj.getSubTaskName()));
			map.put("taskTag",NullValueFilter(obj.getTaskTag()));
			map.put("reqTag",NullValueFilter(obj.getReqTag()));
			map.put("subTaskStatus",contentMap.get(NullValueFilter(obj.getSubTaskStatus())));
			map.put("createTime",NullValueFilter(obj.getCreateTime()));
			map.put("testorName",NullValueFilter(obj.getTestorName()));
			map.put("devWorkDay",NullValueFilter(obj.getDevWorkDay()));
			map.put("possibleProduct",possibleResultMap.get(NullValueFilter(obj.getPossibleProduct())));
			map.put("possibleBack",possibleResultMap.get(NullValueFilter(obj.getPossibleBack())));
			map.put("possibleTest",possibleResultMap.get(NullValueFilter(obj.getPossibleTest())));
			map.put("factCompleteTime",NullValueFilter(obj.getFactCompleteTime()));
			objList.add(map);
		}
		excelVo.setExportExcelName("测试子任务评审.xlsx");
		excelVo.setTemplateName("subTasks.xlsx");
		Map beans=new HashMap();
		beans.put("subTasks", objList);
		excelVo.setDataMap(beans);
		XlsHelper.export2Excel(request, response, excelVo);
	}
		
		
	@RequestMapping("/getAllStaffOrg.do")
	public void getAllStaffOrg(HttpServletRequest request,HttpServletResponse response)throws Exception {
		JSONObject json = new JSONObject();
		String HQL = "FROM SysOrganize where state=1";
		try{
		SysOrganize[] sysOrg = reqSV.getStaffOrgBySql(HQL);
		JSONArray jsonAry = new JSONArray();
		for (int i=0;i<sysOrg.length;i++) {
			JSONObject _json = new JSONObject();
			_json.put("organizeId", sysOrg[i].getOrganizeId());
			_json.put("organizeName", sysOrg[i].getOrganizeName());
			jsonAry.add(_json);
		}
		json.put("success", true);
		json.put("data", jsonAry);
		System.out.println(json);
		}catch (Exception e) {
			e.getStackTrace();
		}
		ActionHelper.responseData4JSON(request, response, json);
	}
	@RequestMapping(value="/getTestSubTaskParamsForCaseLib.do")
	public void getTestSubTaskParamsForCaseLib(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			AigaUser user = (AigaUser)request.getSession().getAttribute("aigaUser");
			if(user==null)
				throw new Exception("当前用户尚未登录");
			JSONArray array = reqSV.getSubTaskForCaseLib(user.getUserId());
			this.setPostInfo("data", array);
			this.setPostInfo("success", true);
		}catch(Exception e){
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value="/getSubTaskTestorForSearch.do")
	public void getSubTaskTestorForSearch(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try{
			JSONArray array = reqSV.getSubTaskTestorForSearch();
			this.setPostInfo("data", array);
			this.setPostInfo("success", true);
		}catch(Exception e){
			e.printStackTrace();
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	
	@RequestMapping(value="/getQuestionByReviewTag.do")
	public void getQuestionByReviewTag(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String reviewTag = request.getParameter("reviewTag");
		String querySql = "from AigaQuestion where aqReviewTag='" + reviewTag+"'";
		AigaQuestion[] problems = reqSV.getAigaQuestionBySql(querySql);
		this.setTable(problems);
		this.postInfo(request, response);
	}
	
	@RequestMapping("/deleteAigaQuestion.do")
	public void deleteAigaQuestion(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String aqId = request.getParameter("aqId");
		String querySql = "from AigaQuestion where aqId=" + aqId;
		AigaQuestion[] delVals = reqSV.getAigaQuestionBySql(querySql);
		for(AigaQuestion delVal : delVals) {
			reqSV.deleteAigaQuestionBySql(delVal);
		}
	}
	
	@RequestMapping("/saveAigaQuestion.do")
	public void saveAigaQuestion(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Object[] results = this.transTableToObj(request, AigaQuestion.class);
		AigaQuestion resource;
		List<AigaQuestion> resources = new ArrayList<AigaQuestion>();
		for(Object result : results){
			if(result instanceof AigaQuestion) {
				resource = (AigaQuestion)result;
				resources.add(resource);
			}
		}
		for(AigaQuestion res : resources) {
			reqSV.saveOrUpdateAigaQuestion(res);
		}
	}

	@RequestMapping(value="/closeSubTestTask.do")
	public void closeSubTestTask(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		try {
			Object[] objects=this.transTableToObj(request, AigaTestSubTask.class);
			String SQL="update aiga_test_sub_task set sub_task_status=-1 where sub_task_id in (";
			String workorderSQL="update alm_workorder set status='-1',opinion='强制关闭' where status='2'  and (";
			Map<Integer,String> typeValue=new HashMap<Integer,String>();
			String subTaskIds="";
			for(Object obj:objects){
				AigaTestSubTask aigaTestSubTask=(AigaTestSubTask)obj;
				subTaskIds+=aigaTestSubTask.getSubTaskId()+",";
				if(typeValue.get(aigaTestSubTask.getSubTaskType())==null){
					typeValue.put(aigaTestSubTask.getSubTaskType(),String.valueOf(aigaTestSubTask.getSubTaskId()));
				}else{
					typeValue.put(aigaTestSubTask.getSubTaskType(),typeValue.get(aigaTestSubTask.getSubTaskType())+","+String.valueOf(aigaTestSubTask.getSubTaskId()));
				}
			}
			subTaskIds=subTaskIds.substring(0,subTaskIds.length()-1);
			SQL+=subTaskIds+") ";
			for(Integer type:typeValue.keySet()){
				workorderSQL+=" (obj_id in ("+typeValue.get(type)+") and obj_type="+type+") or";
			}
			workorderSQL+=" (obj_id in (select id from aiga_subtask_problem where sub_task_id in("+subTaskIds+")) and obj_type="+IObjectType.PROBLEM_FOLLOW+"))";
			reqSV.updateBySQL(SQL);
			reqSV.updateBySQL(workorderSQL);
			map.put("success", true);
		} catch (RuntimeException e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("message", e.getCause());
		}finally{
			ActionHelper.returnResponseData(request, response, map);
		}
	}
	@RequestMapping(value="/closeTestTask.do")
	public void closeTestTask(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		try {
			Object[] objects=this.transTableToObj(request, AigaTestTask.class);
			String SQL="update aiga_test_task set CURRENT_STATUS=-1 where task_id in (";
			String workorderSQL="update alm_workorder set status='-1',opinion='强制关闭' where  status='2' and (";
			String taskIds="";
			Map<Integer,String> typeValue=new HashMap<Integer,String>();
			for(Object obj:objects){
				AigaTestTask aigaTestTask=(AigaTestTask)obj;
				taskIds+=aigaTestTask.getTaskId()+",";
				if(typeValue.get(aigaTestTask.getTestType())==null){
					typeValue.put(aigaTestTask.getTestType(),String.valueOf(aigaTestTask.getTaskId()));
				}else{
					typeValue.put(aigaTestTask.getTestType(),typeValue.get(aigaTestTask.getTestType())+","+String.valueOf(aigaTestTask.getTaskId()));
				}
			}
			taskIds=taskIds.substring(0,taskIds.length()-1);
			AigaTestSubTask[] aigaTestSubTask=reqSV.getAigaTestSubTaskBySql("from AigaTestSubTask where taskId in ("+taskIds+") and subTaskStatus<>-1");
			if(aigaTestSubTask.length==0||aigaTestSubTask[0]==null){
				//可关闭
				SQL+=taskIds+")";
				for(Integer type:typeValue.keySet()){
					workorderSQL+=" (obj_id in ("+typeValue.get(type)+") and obj_type="+((type==0)?3:(type==5)?7:9)+") or";
				}
				workorderSQL=workorderSQL.substring(0,workorderSQL.length()-2)+")";
				reqSV.updateBySQL(SQL);
				reqSV.updateBySQL(workorderSQL);
				map.put("success", true);
			}else{
				//所选任务包含未关闭的子任务，不能关闭
				map.put("success", false);
				map.put("msg", "所选任务包含未关闭的子任务，不能关闭");
			}
		} catch (RuntimeException e) {
			e.printStackTrace();
			map.put("failure", false);
			map.put("msg", e.getCause());
		}finally{
			ActionHelper.returnResponseData(request, response, map);
		}
	}
	
	
	@RequestMapping(value="/closeSolidTask.do")
	public void closeSolidTask(HttpServletRequest request, HttpServletResponse response)throws Exception{
		Map map=new HashMap();
		try {
			Object[] objects=this.transTableToObj(request, AigaSolidTask.class);
			String SQL="update aiga_solid_task set task_status=-1 where task_id in (";
			String workorderSQL="update alm_workorder set status='-1',opinion='强制关闭' where  status='2' and (";
			String taskIds="";
			Map<String,String> typeValue=new HashMap<String,String>();
			for(Object obj:objects){
				AigaSolidTask aigaSolidTask=(AigaSolidTask)obj;
				taskIds+=aigaSolidTask.getTaskId()+",";
				if(typeValue.get(aigaSolidTask.getTaskType())==null){
					typeValue.put(aigaSolidTask.getTaskType(),String.valueOf(aigaSolidTask.getTaskId()));
				}else{
					typeValue.put(aigaSolidTask.getTaskType(),typeValue.get(aigaSolidTask.getTaskType())+","+String.valueOf(aigaSolidTask.getTaskId()));
				}
			}
			taskIds=taskIds.substring(0,taskIds.length()-1);
			
			SQL+=taskIds+") ";
			for(String type:typeValue.keySet()){
				workorderSQL+=" (obj_id in ("+typeValue.get(type)+") and obj_type="+type+") or";
			}
			workorderSQL=workorderSQL.substring(0,workorderSQL.length()-2)+")";
			reqSV.updateBySQL(SQL);
			reqSV.updateBySQL(workorderSQL);
			map.put("success", true);
		} catch (RuntimeException e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("msg", e.getCause());
		}finally{
			ActionHelper.returnResponseData(request, response, map);
		}
	}
	
}
