package com.asiainfo.aiga.testPlan.web;

import java.io.InputStream;
import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.DynamicBean;
import com.asiainfo.aiga.common.helper.ActionHelper;
import com.asiainfo.aiga.common.helper.CommonHelper;
import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.common.security.user.util.StaffUtil;
import com.asiainfo.aiga.common.service.ICommonPageinationSV;
import com.asiainfo.aiga.common.xls.XlsHelper;
import com.asiainfo.aiga.requisition.bo.AigaTestSubTask;
import com.asiainfo.aiga.sysConstant.bo.SysConstant;
import com.asiainfo.aiga.sysConstant.util.SysContentUtil;
import com.asiainfo.aiga.testPlan.bo.AigaTestPlan;
import com.asiainfo.aiga.testPlan.service.IAigaTestPlanSV;
import com.asiainfo.aiga.testTask.bo.AigaTestTask;
import com.asiainfo.aiga.testTask.bo.AigaTestTaskChange;
import com.asiainfo.aiga.testTask.service.IAigaTestTaskSV;

@Controller
//@Scope(value="prototype")
public class AigaTestPlanAction extends BaseAction implements TestPlanConstant {
	
	private static Logger logger = Logger.getLogger(AigaTestPlanAction.class);
	@Resource(name = "testPlanSV")
	private IAigaTestPlanSV testPlanSV;
	@Resource(name = "testTaskSV")
	private IAigaTestTaskSV testTaskSV;
	

	@Resource(name="commonPageinationSV")
	private ICommonPageinationSV commonPageinationSV;

	@RequestMapping("/saveTestPlanForm.do")
	public void saveTestPlanForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Object[] objs = this.transFormToObj(request, new Class[] {
				AigaTestPlan.class});
		AigaTestPlan testPlan = null;
		int n = objs.length;
		if (n >= 1) {
			for (int i = 0; i < n; i++) {
				if (objs[i] instanceof AigaTestPlan)
					testPlan = (AigaTestPlan) objs[i];
			}

		}
		Boolean result = false;
		try {
			testPlanSV.saveAigaTestPlan(testPlan);
//			设置所有该tag 的任务的id
			if(testPlan.getPlanId()!=null && testPlan.getPlanTag()!=null){
			testPlanSV.updateBySQL("update aiga_test_task set plan_id ="+testPlan.getPlanId()+" where PLAN_TAG='"+testPlan.getPlanTag()+"' ");
			result = true;
			}
		} catch (Exception e) {
			result = false;
		}
		Map<String, Serializable> map = new HashMap<String, Serializable>();
		map.put("success", result);
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping("/getAutoOpinion.do")
	public void getAutoOpinion(HttpServletRequest request,HttpServletResponse response)throws Exception {
		SysConstant[] sysConstants = SysContentUtil.getSysContant(AUTO_OPINION);
		JSONArray jsonAry = new JSONArray();
		for (SysConstant sysConstant : sysConstants) {
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

	@RequestMapping("/getAllTestTask.do")
	public void getAllTestTask(HttpServletRequest request,HttpServletResponse response)throws Exception {
		JSONObject jsonObj = new JSONObject();
		JSONArray json = new JSONArray();
		String HQL = "FROM AigaTestTask a  where 1=1 ORDER BY a.createTime DESC";
		
		List<Object> list = testPlanSV.getObjectByHQL(HQL);
		json = JSONArray.fromObject(list, this.jsonConfig);
		jsonObj.put("total", commonPageinationSV.getTotal(HQL));
		jsonObj.put("data", json);
		logger.info(json);
		jsonObj.put("success", true);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}
	
	@RequestMapping("/getTestTaskListForClose.do")
	public void getTestTaskListForClose(HttpServletRequest request,HttpServletResponse response) throws Exception {
		JSONObject jsonObj = new JSONObject();
		AigaUser user=( AigaUser)request.getSession().getAttribute( "aigaUser");
		String taskTag = request.getParameter("taskTag");
		String taskName = request.getParameter("taskName");
		String testType = request.getParameter("testType");	
		String beginDate = request.getParameter("beginDate");
		String endDate = request.getParameter("endDate");
		String bigType = request.getParameter("bigType");
		String subType = request.getParameter("subType");
		Map map=this.paginationParams(request);
		int pageNo = Integer.parseInt(map.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(map.get(this.LIMIT_PARAM).toString());
		JSONArray json = new JSONArray();
		String HQL ="FROM AigaTestTask a where 1=1 and current_status<>-1 and a.distributeStaffid="+user.getUserId();
		if(StringUtils.isNotBlank(taskTag))HQL+=" and a.taskTag like '%"+taskTag+"%'";
		if(StringUtils.isNotBlank(taskName))HQL+=" and a.taskName like '%"+decodeCN(taskName)+"%'";
		if(StringUtils.isNotBlank(testType)&&!testType.equals("undefined"))HQL+=" and a.testType ="+testType;
		if(StringUtils.isNotBlank(bigType))HQL+=" and a.bigType ="+bigType;
		if(StringUtils.isNotBlank(subType))HQL+=" and a.subType ="+subType;
		if(StringUtils.isNotBlank(beginDate)){
			HQL+=" and a.factCompleteTime>=to_date('"+beginDate.substring(0,10)+"','yyyy-MM-dd')";
		}
		if(StringUtils.isNotBlank(endDate)){
			HQL+=(" and  a.factCompleteTime<=to_date('"+endDate.substring(0,10)+"','yyyy-MM-dd') ");
		}
		HQL+=" order by a.taskId desc";
		List<Object> list=commonPageinationSV.getObjectList(pageNo, pageSize, HQL);
		json = JSONArray.fromObject(list, this.jsonConfig);
		jsonObj.put("total", commonPageinationSV.getTotal(HQL));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response,jsonObj);
	}
	
	@RequestMapping("/getTestTaskList.do")
	public void getTestTaskList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		JSONObject jsonObj = new JSONObject();
		 AigaUser user=( AigaUser)request.getSession().getAttribute( "aigaUser");
		String planId = request.getParameter("planId");	
		String tbarIsRel = request.getParameter("tbarIsRel");
		String tbarIsBatch = request.getParameter("tbarIsBatch");
		String tbarSubType = request.getParameter("tbarSubType");
		String tbarBigType = request.getParameter("tbarBigType");
		String tbarSearchTime = request.getParameter("tbarSearchTime");
		String tbarTaskTag = request.getParameter("tbarTaskTag");
		String dateTime=request.getParameter("dateTime");
		String tbarTaskName = request.getParameter("tbarTaskName");
		String tbarDistributeStaffnametext=request.getParameter("tbarDistributeStaffnametext");
		String tbarTestTypex=request.getParameter("tbarTestTypex");
		String tbarTestTypeStatus=request.getParameter("tbarTestTypeStatus");
		String tbarJoinTest=request.getParameter("tbarJoinTest");
		String tbarnotJoinTest=request.getParameter("tbarnotJoinTest");
//		System.out.println("获得的tbarTestTypex值："+tbarTestTypex+"tbarTestTypeStatus"+tbarTestTypeStatus);
		String tbarTaskStatus = request.getParameter("tbarTaskStatus");
		String requestURL=request.getHeader("Referer");
		String planTag=request.getParameter("planTag");
		String planFlag=request.getParameter("planFlag");
		String taskFlag=request.getParameter("taskFlag");
		String queryFlag = request.getParameter("queryFlag");
		String isOperated = request.getParameter("isOperated");
		String beginDate = request.getParameter("beginDate");
		String endDate = request.getParameter("endDate");
		if(tbarTaskName!=null&&!tbarTaskName.equals(""))tbarTaskName=decodeCN(decodeCN(tbarTaskName));
		if(tbarDistributeStaffnametext!=null&&!tbarDistributeStaffnametext.equals(""))tbarDistributeStaffnametext=decodeCN(decodeCN(tbarDistributeStaffnametext));
		if(!NaNull(tbarDistributeStaffnametext))tbarDistributeStaffnametext=new String();
		Map map=this.paginationParams(request);
		int pageNo = Integer.parseInt(map.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(map.get(this.LIMIT_PARAM).toString());
		String tbarDistributeStaffId=request.getParameter("tbarDistributeStaffId");//测试组长
		if(!NaNull(tbarDistributeStaffId))tbarDistributeStaffId=new String();
		JSONArray json = new JSONArray();
		logger.info("planFlag======"+planFlag+"      planTag======"+planTag);
		//planTag  0 创建  1查看  2编辑
		if(planFlag!=null&&!planFlag.equals("")){
			// 创建 关联 删除 等等
			if (planTag != null&& !planTag.equals("")) {
				String HQL = "FROM AigaTestTask a  where 1=1  ";
				HQL += " and a.planTag='" + planTag + "'" + " and a.currentStatus<>-1 ORDER BY a.createTime DESC";
				List<Object> list = testPlanSV.getObjectByHQL(HQL);
				json = JSONArray.fromObject(list, this.jsonConfig);
			}
		}else if (taskFlag != null && taskFlag.equals("0")) {
				// 0 查看未关联的所有任务 planId and planTag!=null
				String HQL = "FROM AigaTestTask a where 1=1 and a.planId is null  and a.currentStatus<>-1 ";
				if(planTag!=null && !planTag.equals(""))HQL+=" and a.planTag <>'"+planTag+"' OR a.planTag  IS NULL  ORDER BY a.createTime DESC";
				List<Object> list = testPlanSV.getObjectByHQL(HQL);
				json = JSONArray.fromObject(list, this.jsonConfig);
			}
		
//		工具栏筛选 taskFlag=5
//		测试任务查询页面
		 if(taskFlag!=null&&taskFlag.equals("5")){
//			 getObjectBySQL
			StringBuffer conditionBuf = new StringBuffer();
			//来自BatchTaskAllot.jsp页面代表是测试任务分派
			if(queryFlag!=null && queryFlag.equals("1")){
				conditionBuf.append(" and (ATT.current_Status=102 or ATT.current_Status=103) ");
				conditionBuf.append(" AND ATT.DISTRIBUTE_STAFFID="+user.getUserId() +conditionBuf);
				}
			if(tbarSearchTime!=null&&!tbarSearchTime.equals(""))conditionBuf.append(" and  ATT.fact_complete_time=to_date('"+tbarSearchTime.substring(0,10)+"','YYYY-MM-dd')");
			if(tbarSubType!=null&&!tbarSubType.equals(""))conditionBuf.append(" and  ATT.sub_Type="+tbarSubType);
			if(tbarDistributeStaffId!=null&&!tbarDistributeStaffId.equals("")){conditionBuf.append(" and ATT.distribute_staffId like '%"+this.decodeCN(tbarDistributeStaffId).trim()+"%'");}
			if(tbarBigType!=null&&!tbarBigType.equals(""))conditionBuf.append(" and  ATT.big_Type="+tbarBigType);
			if(tbarTestTypex!=null&&!tbarTestTypex.equals(""))conditionBuf.append(" and ATT.test_Type="+tbarTestTypex);
			
			if(tbarTestTypeStatus!=null&&!tbarTestTypeStatus.equals(""))conditionBuf.append(" and ATT.current_Status="+tbarTestTypeStatus);
			if(tbarTaskName!=null&&!tbarTaskName.equals(""))conditionBuf.append(" and  ATT.task_Name like '%"+this.decodeCN(tbarTaskName)+"%'");
			if(tbarTaskTag!=null&&!tbarTaskTag.equals(""))conditionBuf.append(" and ATT.task_Tag like '%"+tbarTaskTag+"%'");
			if(tbarIsBatch!=null&&!tbarIsBatch.equals("false"))conditionBuf.append(" AND ATT.TASK_ID IN (SELECT ATST.TASK_ID FROM AIGA_TEST_SUB_TASK ATST WHERE ATST.TASK_ID IS NOT NULL GROUP BY ATST.TASK_ID) ");
			if(isOperated!=null&&!isOperated.equals("")){
					if("0".equals(isOperated)){//已创建
						conditionBuf.append(" and ATT.uet_task_id is not null and ATT.uet_task_id<>0");
					}else if("1".equals(isOperated)){//未创建
						conditionBuf.append(" and (ATT.uet_task_id is null or ATT.uet_task_id=0)");
					}
					
			}
			if(tbarIsRel!=null&&tbarIsRel.equals("true")){
				conditionBuf.append(" and ATT.PLAN_ID is not null ");
			}
			if(StringUtils.isNotBlank(beginDate)){
				conditionBuf.append(" and  ATT.fact_complete_time>=to_date('"+beginDate.substring(0,10)+"','yyyy-MM-dd') ");
			}
			if(StringUtils.isNotBlank(endDate)){
				conditionBuf.append(" and  ATT.fact_complete_time<=to_date('"+endDate.substring(0,10)+"','yyyy-MM-dd') ");
			}
			Map<String,Integer> paginationParams=this.paginationParams(request);
			Integer page=paginationParams.get(this.PAGE_PARAM);
			Integer limit=paginationParams.get(this.LIMIT_PARAM);
			String BatchTaskCountSQL="SELECT count(ATT.TASK_ID) "+
			" FROM AIGA_TEST_TASK ATT "+
			 " WHERE 1=1 "+conditionBuf;
			 ;
			String BatchTaskSQL="SELECT * FROM (SELECT " +
				"ATT.TASK_ID,"+
               "ATT.TASK_TAG,"+
               "ATT.TASK_NAME,"+
               "ATT.DISTRIBUTE_STAFFID,"+
               "ATT.DISTRIBUTE_STAFFNAME,"+
               "ATT.PLAN_ID,"+
               "ATP.PLAN_TAG,"+
               "ATP.PLAN_NAME,"+
               "ATP.FACT_COMPLETE_TIME,"+
           	"ATT.req_Id,"+
           	"ATT.current_Status,"+
           	"ATT.priority,"+
           	"ATT.req_Tag,"+
           	"ATT.dev_Work_Day,"+
           	"ATT.test_Work_Day,"+
           	"ATT.create_Time,"+
           	"ATT.big_Type,"+
           	"ATT.is_Performance_Test,"+
           	"ATT.is_Joint_Test,"+
           	"ATT.is_Cross_Cycle,"+
           	"ATT.is_Point2point_Test,"+
           	"ATT.run_Persion,"+
           	"ATT.distribute_Time,"+
           	"ATT.sub_Type,"+
           	"ATT.dev_Tag,"+
           	"ATT.test_Type,"+
           	"ATT.test_Firm,"+
           	"ATT.dev_Firm,"+
           	"ATT.is_Importance_Req,"+
           	"ATT.test_Persion_Opinion,"+
           	"ATT.req_Persion,"+
           	"ATT.test_Progress,"+
           	"ATT.test_Situation,"+
           	"ATT.defect_Number,"+
           	"ATT.initial_Situation,"+
           	"ATT.test_Group,"+
           	"ATT.dev_Persion,"+
           	"ATT.dev_Admin,"+
           	"ATT.on_Line_Time,"+
           	"ATT.task_Phase,"+
            //" (SELECT TO_CHAR(wm_concat(ATST.TESTOR_NAME)) FROM AIGA_TEST_SUB_TASK ATST WHERE ATST.TASK_ID = ATT.TASK_ID), "+
           	//端到端测试
            "(SELECT t.task_id  FROM aiga_test_task t WHERE t.test_type =5 and t.req_tag=ATT.Req_Tag and t.fact_complete_time=att.fact_complete_time and t.current_status<>-1 and rownum=1),"+
           	//性能测试
            " (SELECT t.task_id  FROM aiga_test_task t WHERE t.test_type =9 and t.req_tag=ATT.Req_Tag and t.fact_complete_time=att.fact_complete_time and t.current_status<>-1 and rownum=1),"+
               "ROWNUM RN "+
               "FROM AIGA_TEST_TASK ATT, AIGA_TEST_PLAN ATP  "+
               " WHERE ATT.PLAN_ID = ATP.PLAN_ID(+) "+
               " AND ROWNUM <= "+(page*limit)+ 
               conditionBuf+
               " ORDER BY ATT.task_id desc) "+
               "WHERE RN > "+(page-1)*limit;
			List list=testPlanSV.getObjectBySQL(BatchTaskSQL);
			String[] taskIds=new String[list.size()];
			for(int i=0,n=list.size();i<n;i++){
				Object objs=list.get(i);
				Object[] obj=(Object[])objs;
				taskIds[i]=new String();
				JSONObject taskJSONOj=new JSONObject();
				taskJSONOj.put("taskId", obj[0]);
				BigDecimal bg=(BigDecimal)obj[0];
				taskIds[i]=""+bg.intValue();
				taskJSONOj.put("taskTag", obj[1]);
				taskJSONOj.put("taskName", obj[2]);
				taskJSONOj.put("distributeStaffId", obj[3]);
				taskJSONOj.put("distributeStaffname", obj[4]);
				taskJSONOj.put("planId", obj[5]);
				taskJSONOj.put("planTag", obj[6]);
				taskJSONOj.put("planName", obj[7]);
				 taskJSONOj.put("faceCompleteTime", obj[8]);
		           	taskJSONOj.put("reqId", obj[9]);
		           	taskJSONOj.put("currentStatus", obj[10]);
		           	taskJSONOj.put("priority", obj[11]);
		           	taskJSONOj.put("reqTag", obj[12]);
		           	taskJSONOj.put("devWorkDay", obj[13]);
		           	taskJSONOj.put("testWorkDay", obj[14]);
		           	taskJSONOj.put("createTime", CommonHelper.dateToString(obj[15], "yyyy-MM-dd HH:mm:SS"));
		           	taskJSONOj.put("bigType", obj[16]);
		           	taskJSONOj.put("isPerformanceTest", obj[17]);
		           	taskJSONOj.put("isJointTest", obj[18]);
		           	taskJSONOj.put("isCrossCycle", obj[19]);
		           	taskJSONOj.put("isPoint2pointTest", obj[20]);
		           	taskJSONOj.put("runPersion", obj[21]);
		           	taskJSONOj.put("distributeTime", CommonHelper.dateToString(obj[22], "yyyy-MM-dd  HH:mm:SS"));
		           	taskJSONOj.put("subType", obj[23]);
		           	taskJSONOj.put("devTag", obj[24]);
		           	taskJSONOj.put("testType", obj[25]);
		           	taskJSONOj.put("testFirm", obj[26]);
		           	taskJSONOj.put("devFirm", obj[27]);
		           	taskJSONOj.put("isImportanceReq", obj[28]);
		           	taskJSONOj.put("testPersionOpinion", obj[29]);
		           	taskJSONOj.put("reqPersion", obj[30]);
		           	taskJSONOj.put("testProgress", obj[31]);
		           	taskJSONOj.put("testSituation", obj[32]);
		           	taskJSONOj.put("defectNumber", obj[33]);
		           	taskJSONOj.put("initialSituation", obj[34]);
		           	taskJSONOj.put("testGroup", obj[35]);
		           	taskJSONOj.put("devPersion", obj[36]);
		           	taskJSONOj.put("devAdmin", obj[37]);
		           	taskJSONOj.put("onLineTime", CommonHelper.dateToString(obj[38], "yyyy-MM-dd "));
		           	taskJSONOj.put("taskPhase", obj[39]);
		        	taskJSONOj.put("uetTaskId", obj[40]);
		        	taskJSONOj.put("perfTaskId", obj[41]);
//		        	taskJSONOj.put("subTaskTestorName", obj[40]);
				if(obj[8]!=null){
					Date date=(Timestamp)obj[8];
					taskJSONOj.put("factCompleteTime", CommonHelper.dateToString(date, "yyyy-MM-dd"));
				}
				json.add(taskJSONOj,this.jsonConfig);
			}
			if(taskIds!=null&&taskIds.length!=0){
				String testSubTaskSQL="From AigaTestSubTask where taskId in ("+CommonHelper.array2String(taskIds,",")+")";
				List<AigaTestSubTask> subTaskList=testPlanSV.getObjectByHQL(testSubTaskSQL);
				for(int i=0,n=json.size();i<n;i++){
					List<String> subTaskStaffName=new ArrayList();
					JSONObject taskJSONOj=(JSONObject)json.get(i);
					BigDecimal bg=(BigDecimal)taskJSONOj.get("taskId");
					String taskId=bg.intValue()+"";
					for(AigaTestSubTask subTask:subTaskList){
						if(taskId.equals(""+subTask.getTaskId())){
							subTaskStaffName.add(subTask.getTestorName());
						}
					}
					taskJSONOj.put("subTaskTestorName", CommonHelper.array2String(subTaskStaffName.toArray(new String[0])));
				}
			}
			jsonObj.put("total",testPlanSV.getObjectBySQL(BatchTaskCountSQL));
			jsonObj.put("data", json);
			logger.info(json);
		 }else if((taskFlag!=null&&taskFlag.equals("6")&&planId!=null&&!planId.equals(""))||(planFlag!=null&&planFlag.equals("2"))||(planFlag!=null&&planFlag.equals("1"))){
			 String HQL="FROM AigaTestTask a where 1=1  and a.planId="+planId +"  and a.currentStatus<>-1 ORDER BY a.createTime DESC";
			 List<Object> list=testPlanSV.getObjectByHQL(HQL);
				json = JSONArray.fromObject(list, this.jsonConfig);
		 }else if(taskFlag!=null && taskFlag.equals("7")){
			 //测试任务排期
			 String HQL ="FROM AigaTestTask a where 1=1 and a.planId is null and a.distributeStaffid="+user.getUserId()+"  and a.currentStatus<>-1 ";
			 logger.info(tbarIsBatch);
			 List<String> subTaskList=new ArrayList<String>();
			if(tbarSubType!=null&&!tbarSubType.equals(""))HQL+=" and a.subType="+tbarSubType;
			if(tbarBigType!=null&&!tbarBigType.equals(""))HQL+=" and a.bigType='"+tbarBigType+"'";
			if(tbarTaskTag!=null&&!tbarTaskTag.equals(""))HQL+=" and a.taskTag like '%"+tbarTaskTag+"%'";
			if(tbarTaskName!=null&&!tbarTaskName.equals(""))HQL+=" and a.taskName like '%"+tbarTaskName+"%'";
			if(tbarTaskStatus!=null&&!tbarTaskStatus.equals(""))HQL+=" and a.currentStatus="+tbarTaskStatus;
			if(tbarDistributeStaffId!=null&&!tbarDistributeStaffId.equals(""))HQL+=" and a.distributeStaffId = '"+this.decodeCN(tbarDistributeStaffId)+"'";
			HQL+=" order by a.taskId desc";
			List<Object> list=commonPageinationSV.getObjectList(pageNo, pageSize, HQL);
			json = JSONArray.fromObject(list, this.jsonConfig);
			jsonObj.put("total", commonPageinationSV.getTotal(HQL));
			jsonObj.put("data", json);
		 }else if(taskFlag!=null && taskFlag.equals("8")){
			 String HQL ="FROM AigaTestTask a, AigaTestPlan b where a.planId=b.planId   and a.currentStatus<>-1 and a.currentStatus <>199 and a.distributeStaffid="+user.getUserId()+" ";
			 logger.info(tbarIsBatch);
			 List<String> subTaskList=new ArrayList<String>();
			if(tbarSubType!=null&&!tbarSubType.equals(""))HQL+=" and a.subType="+tbarSubType;
			if(tbarBigType!=null&&!tbarBigType.equals(""))HQL+=" and a.bigType='"+tbarBigType+"'";
			if(tbarTaskTag!=null&&!tbarTaskTag.equals(""))HQL+=" and a.taskTag like '%"+tbarTaskTag+"%'";
			if(tbarTaskName!=null&&!tbarTaskName.equals(""))HQL+=" and a.taskName like '%"+tbarTaskName+"%'";
			if(tbarTaskStatus!=null&&!tbarTaskStatus.equals(""))HQL+=" and a.currentStatus="+tbarTaskStatus;
			if(tbarDistributeStaffId!=null&&!tbarDistributeStaffId.equals(""))HQL+=" and a.distributeStaffId = '"+this.decodeCN(tbarDistributeStaffId)+"'";
			HQL+=" order by a.taskId desc";
			List<Object> list=commonPageinationSV.getObjectList(pageNo, pageSize, HQL);
			List<Object> resultList=new ArrayList<Object>();
			for(Object objs:list){
				Object[] obj=(Object[])objs;
				Map objMap=new HashMap();
				AigaTestPlan testPlan=(AigaTestPlan)obj[1];
				objMap.put("planName", testPlan.getPlanName());
				objMap.put("planTag", testPlan.getPlanTag());
				objMap.put("factCompleteTime", testPlan.getFactCompleteTime());
				DynamicBean bean=new DynamicBean(obj[0],objMap);
				resultList.add(bean.getObject());
			}
			json = JSONArray.fromObject(resultList, this.jsonConfig);
			jsonObj.put("total", commonPageinationSV.getTotal(HQL));
			jsonObj.put("data", json);
		 }else if(taskFlag!=null && taskFlag.equals("9")){
			 String HQL ="FROM AigaTestTask a where 1=1  and a.currentStatus<>-1 ";
			 List<String> subTaskList=new ArrayList<String>();
			if(tbarSubType!=null&&!tbarSubType.equals(""))HQL+=" and a.subType="+tbarSubType;
			if(tbarBigType!=null&&!tbarBigType.equals(""))HQL+=" and a.bigType='"+tbarBigType+"'";
			if(tbarTaskTag!=null&&!tbarTaskTag.equals(""))HQL+=" and a.taskTag like '%"+tbarTaskTag+"%'";
			if(dateTime!=null&&!dateTime.equals(""))HQL+=(" and a.factCompleteTime=to_date('"+dateTime.substring(0, 10)+"','YYYY-MM-dd')");
			if(tbarTaskName!=null&&!tbarTaskName.equals(""))HQL+=" and a.taskName like '%"+tbarTaskName+"%'";
			if(tbarDistributeStaffnametext!=null&&!tbarDistributeStaffnametext.equals(""))HQL+=" and a.distributeStaffid = '"+this.decodeCN(tbarDistributeStaffnametext)+"'";
			if(tbarJoinTest.equals("true"))HQL+=" and a.isJointTest=1 ";
			if(tbarnotJoinTest.equals("true"))HQL+=" and (a.isJointTest<>1 or isJointTest is null) ";
			if(tbarDistributeStaffId!=null&&!tbarDistributeStaffId.equals(""))HQL+=(" and a.distribute_staffId = '"+this.decodeCN(tbarDistributeStaffId).trim()+"'");
			if(tbarTaskStatus!=null&&!tbarTaskStatus.equals(""))HQL+=" and a.currentStatus="+tbarTaskStatus;
			if(tbarDistributeStaffId!=null&&!tbarDistributeStaffId.equals(""))HQL+=" and a.distributeStaffId = '"+this.decodeCN(tbarDistributeStaffId)+"'";
			HQL+=" order by a.taskId desc";
			List<Object> list=commonPageinationSV.getObjectList(pageNo, pageSize, HQL);
			json = JSONArray.fromObject(list, this.jsonConfig);
			jsonObj.put("total", commonPageinationSV.getTotal(HQL));
			jsonObj.put("data", json);
		 }
		 if(taskFlag!=null&&(taskFlag.equals("5")||taskFlag.equals("7")||taskFlag.equals("8")||taskFlag.equals("9"))){
			 ActionHelper.responseData4JSON(request, response, jsonObj);
		 }else{
			ActionHelper.responseData4JSON(request, response,json);
		 }
	}
	
	@RequestMapping("/getTestPlanList.do")
	public void getTestPlanList(HttpServletRequest request,HttpServletResponse response) throws Exception {
	
		JSONArray json = new JSONArray();
		String planFlag = request.getParameter("planFlag");//1(查询) 2(变更) 3(启动)
		String onLineTime=request.getParameter("onLineTime");
		String planTag=request.getParameter("planTag");
		String bigType=request.getParameter("bigType");
		String planType=request.getParameter("planType");
		String planName=request.getParameter("planName");
		String taskFlag=request.getParameter("taskFlag");
		String planStatus=request.getParameter("planStatus");
		Map map=this.paginationParams(request);
		int pageNo = Integer.parseInt(map.get(this.PAGE_PARAM).toString());
		int pageSize = Integer.parseInt(map.get(this.LIMIT_PARAM).toString());
		StringBuffer conditionBuffer = new StringBuffer();
		conditionBuffer.append((onLineTime!=null&&!onLineTime.equals(""))?" and a.factCompleteTime between trunc(to_date('"+ onLineTime +"','YYYY-MM'),'mm') and add_months(trunc(to_date('"+ onLineTime +"','YYYY-MM'),'mm'),1)":"");//上线时间
		conditionBuffer.append((planTag!=null&&!planTag.equals(""))?" and a.planTag like '%"+this.decodeCN(planTag).trim()+"%'":"");//计划编号
		conditionBuffer.append((bigType!=null&&!bigType.equals("")&&!bigType.equals("null")&&!bigType.equals("undefined"))?" and a.bigType='"+this.decodeCN(bigType)+"'":"");//系统大类
		conditionBuffer.append((planType!=null&&!planType.equals("")&&!planType.equals("null")&&!planType.equals("undefined"))?" and a.onLineType='"+this.decodeCN(planType)+"'":"");//上线类型
		conditionBuffer.append((planStatus!=null&&!planStatus.equals("")&&!planStatus.equals("null")&&!planStatus.equals("undefined"))?" and a.planStatus="+this.decodeCN(planStatus):"");//计划状态
		conditionBuffer.append((planName!=null&&!planName.equals(""))?" and a.planName like '%"+this.decodeCN(planName).trim()+"%'":"");//计划名称
		conditionBuffer.append((taskFlag!=null&&taskFlag.equals("7"))?" and a.planStatus <> -1":"");
		logger.info(conditionBuffer.toString());
		String querySql = null;
		String orderSQL=" ORDER BY a.createTime DESC nulls last";
		if(planFlag!=null){
			if(planFlag.equals("3")){//启动  状态为1 或 NULL
				querySql="FROM AigaTestPlan a where (a.planStatus=99999 or a.planStatus ="+TEST_PLAN_BEGIN_STATUS+") and startMark is null";
			}else if(planFlag.equals("2")){//变更 状态不为 (1  99  99999)
				querySql="FROM AigaTestPlan a where (a.planStatus !="+TEST_PLAN_END_STATUS+"  and a.planStatus!=99999 and a.planStatus !="+TEST_PLAN_BEGIN_STATUS+") ";
			}else{//查询   所有状态
				querySql="FROM AigaTestPlan a where 1=1 ";
			} 
		}else{ //防止没有数据传入, 导致查询出错.
			querySql="FROM AigaTestPlan a where 1=1 ";
			if(taskFlag!=null&&(taskFlag.equals("7")||taskFlag.equals("8"))){
				querySql+=" and (a.planStatus =2 or a.planStatus =3 or a.planStatus =4 ) ";
				orderSQL="order by a.factCompleteTime desc";
			}
		}
		//AigaTestPlan[] plans=testPlanSV.getAigaTestPlanBySql(querySql+conditionBuffer.toString()+" ORDER BY a.createTime DESC nulls last");
		//List<Object> plans = testPlanSV.getAigaTestPlanBySqlForQuery(pageNo, pageSize, querySql+conditionBuffer.toString()+" ORDER BY a.createTime DESC nulls last");
		List<Object> plans = commonPageinationSV.getObjectList(pageNo, pageSize,  querySql+conditionBuffer.toString()+orderSQL);
		json = JSONArray.fromObject(plans, this.jsonConfig);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total", commonPageinationSV.getTotal( querySql+conditionBuffer.toString()+" ORDER BY a.createTime DESC nulls last"));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}
	
	@RequestMapping("/delTestPlan.do")
	public void delTestPlan(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String planId=request.getParameter("planId");
		Boolean success=false;
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		if(planId!=null&&!planId.equals("")){
		String SQL="update aiga_test_plan set plan_status = -1 where plan_id ="+planId;
		success=testPlanSV.updateBySQL(SQL);
		map.put("message", "");
		}
	
		map.put("success", success);
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/saveTestTaskForm.do")
	public void saveTestTaskForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String planId = request.getParameter("planId");
		String planTag = request.getParameter("planTag");
		Object[] objs = this.transFormToObj(request,new Class[] { AigaTestTask.class });
		AigaTestTask testTask = null;
		if (objs.length == 1) {
			testTask = (AigaTestTask) objs[0];
			try {
				if(planId!=null&&!planId.equals("")&&!planId.equals("null"))testTask.setPlanId(Integer.valueOf(planId));
				if(planTag!=null&&!planTag.equals("")&&!planTag.equals("null"))testTask.setPlanTag(planTag);
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		Boolean result = false;
		try {
			testPlanSV.saveAigaTestObj(testTask);
			result = true;
		} catch (Exception e) {
			result = false;
		}
		Map<String, Serializable> map = new HashMap<String, Serializable>();
		map.put("success", result);
		ActionHelper.returnResponseData(request, response, map);
	}
	

	@RequestMapping("/getComBox.do")
	public void getComBox(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysConstant[] sysConstants = SysContentUtil
				.getSysContant(AIGA_TEST_PLAN);
		String queryFlag = request.getParameter("query");
		logger.info(queryFlag);
		JSONArray jsonAry = new JSONArray();
		for (SysConstant sysConstant : sysConstants) {
			if (!sysConstant.getCategoryName().equals(queryFlag))
				continue;
			JSONObject json = new JSONObject();
			json.put("value", sysConstant.getValue());
			json.put("show", sysConstant.getShow());
			json.put("other2", sysConstant.getOther2());
			jsonAry.add(json);
		}
		JSONObject json = new JSONObject();
		
		json.put("success", true);
		json.put("data", jsonAry);

		ActionHelper.responseData4JSON(request, response, json);
	}
	@RequestMapping("/getComBoxx.do")
	public void getComBoxx(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysConstant[] sysConstants = SysContentUtil
				.getSysContant(AIGA_TEST_PLAN);
		String queryFlag = request.getParameter("query");
		logger.info(queryFlag);
		JSONArray jsonAry = new JSONArray();
		for (SysConstant sysConstant : sysConstants) {
			if (!sysConstant.getCategoryName().equals(queryFlag))
				continue;
			JSONObject json = new JSONObject();
			json.put("value", String.valueOf(sysConstant.getValue()));
			json.put("show", sysConstant.getShow());
			json.put("other2", sysConstant.getOther2());
			jsonAry.add(json);
		}
		JSONObject json = new JSONObject();
		
		json.put("success", true);
		json.put("data", jsonAry);

		ActionHelper.responseData4JSON(request, response, json);
	}
	
	
	@RequestMapping("/getComBoxForSubClass.do")
	public void getComBoxForSubClass(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysConstant[] sysConstants = SysContentUtil
				.getSysContant("SUB_TASK_PROBLEM");
		String queryFlag = request.getParameter("query");
		logger.info(queryFlag);
		JSONArray jsonAry = new JSONArray();
		for (SysConstant sysConstant : sysConstants) {
//			if (!sysConstant.getCategoryName().equals(queryFlag))
//				continue;
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
	
	@RequestMapping("/getComBoxLink.do")
	public void getComBoxLink(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysConstant[] sysConstants = SysContentUtil
				.getSysContant("SUB_TASK_PROBLEM");
		String queryFlag = request.getParameter("query");
		String querylink = request.getParameter("other2");
		logger.info(queryFlag);
		logger.info(querylink);
		JSONArray jsonAry = new JSONArray();
		for (SysConstant sysConstant : sysConstants) {
			if (!sysConstant.getCategoryName().equals(queryFlag))
				continue;
			if (sysConstant.getOther2()==null)
				continue;
			if (!sysConstant.getOther2().equals(querylink))
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
	
	@RequestMapping("/getComBoxMap.do")
	public void getComBoxMap(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysConstant[] sysConstants = SysContentUtil
				.getSysContant(AIGA_TEST_PLAN);
		JSONArray jsonAry = new JSONArray();
		jsonAry = JSONArray.fromObject(sysConstants, jsonConfig);
		JSONObject json = new JSONObject();
		json.put("success", true);
		json.put("data", jsonAry);

		ActionHelper.responseData4JSON(request, response, json);
	}

	@RequestMapping("/relTaskList.do")
	public void relTaskList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String[] taskIdArray = request.getParameterValues("taskIdArray[]");
		String planId = request.getParameter("planId");
		String planTag = request.getParameter("planTag");
		Map<String, Serializable> map = new HashMap<String, Serializable>();
		map.put("success",testPlanSV.createRel4PlanAndTask(planId, planTag,taskIdArray));
		ActionHelper.returnResponseData(request, response, map);
	}

	@RequestMapping("/delRelTaskList.do")
	public void delRelTaskList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String taskId = request.getParameter("taskId");
		String planId = request.getParameter("planId");
		Map<String, Serializable> map = new HashMap<String, Serializable>();
		map.put("success", testPlanSV.delRel4PlanAndTask(planId, taskId));
		ActionHelper.returnResponseData(request, response, map);
	}

	@RequestMapping("/getTestPlanForm.do")
	public void getTestPlanForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String planId = request.getParameter("planId");
		//清空数据
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		if (planId != null && !planId.equals("")){
			
		List<Object> testPlanList = testPlanSV.getObjectByHQL("FROM AigaTestPlan where planId="+ planId + " ORDER BY createTime DESC");
		
		map.put("success", false);
		if (testPlanList.size() == 1) {
			JSON json=JSONObject.fromObject(testPlanList.get(0), jsonConfig);
			logger.info(json);
			map.put("data", json);
			map.put("success", true);
		}
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping("/getSubTaskProblemForm.do")
	public void getSubTaskProblemForm(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		//清空数据
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		if (id != null && !id.equals(""))
		{
			List<Object> subTaskProblem = testPlanSV.getObjectByHQL("FROM AigaSubTaskProblem where subTaskId="+ id );
			map.put("success", false);
			if (subTaskProblem.size() > 0 ) {
				JSON json=JSONObject.fromObject(subTaskProblem.get(0), jsonConfig);
				logger.info(json);
				map.put("data", json);
				map.put("success", true);
				this.setFormData(subTaskProblem.get(0));
			}else {
				this.setFormData(null);
			}
		}
//		ActionHelper.returnResponseData(request, response, map);
		this.postInfo(request, response);
	}
	
	@RequestMapping("/getSubTaskProblemFormById.do")
	public void getSubTaskProblemFormById(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		//清空数据
		Map<String, Serializable> map=new HashMap<String, Serializable>();
		if (id != null && !id.equals(""))
		{
			List<Object> subTaskProblem = testPlanSV.getObjectByHQL("FROM AigaSubTaskProblem where id="+ id );
			map.put("success", false);
			if (subTaskProblem.size() > 0 ) {
				JSON json=JSONObject.fromObject(subTaskProblem.get(0), jsonConfig);
				logger.info(json);
				map.put("data", json);
				map.put("success", true);
				this.setFormData(subTaskProblem.get(0));
			}else {
				this.setFormData(null);
			}
		}
//		ActionHelper.returnResponseData(request, response, map);
		
		
		this.postInfo(request, response);
	}
	
	// 执行计划
	@RequestMapping("/runTestPlanForm.do")
	public void runTestPlanForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Object[] objs = this.transFormToObj(request,
				new Class[] { AigaTestPlan.class });
		AigaTestPlan testPlan = null;
		int n = objs.length;
		if (n >= 1) {
			for (int i = 0; i < n; i++) {
				if (objs[i] instanceof AigaTestPlan)
					testPlan = (AigaTestPlan) objs[i];
			}

		}

		// 安全测试0、代码扫描1、性能回归2、功能回归3；
		Boolean result = false;
		Map<String, Serializable> map = new HashMap<String, Serializable>();
		AigaTestTask aigaTestTask = new AigaTestTask();
		try {
			if (testPlan.getPlanStatus() >= 2)
				throw new Exception("计划已经执行过了");
			testPlan.setPlanStatus(2);
			testPlanSV.saveAigaTestObj(testPlan);
			aigaTestTask.setBigType(testPlan.getBigType());
			aigaTestTask.setPlanId(testPlan.getPlanId());

			if (testPlan.getIsSecurityTest().equals(0)) {
				aigaTestTask.setTaskId(null);
				aigaTestTask.setTaskTag("GT安全测试" + testPlan.getPlanTag());
				aigaTestTask.setTaskName("GT安全测试");
				aigaTestTask.setCreateTime(new Timestamp(System.currentTimeMillis()));
				aigaTestTask.setTestType(0);
				aigaTestTask.setDevTag(aigaTestTask.getTaskTag());
				testPlanSV.saveAigaTestObj(aigaTestTask);

			}
			if (testPlan.getIsCodeScan().equals(0)) {
				aigaTestTask.setTaskId(null);
				aigaTestTask.setTaskTag("GT代码扫描" + testPlan.getPlanTag());
				aigaTestTask.setTaskName("GT代码扫描");
				aigaTestTask.setCreateTime(new Timestamp(System.currentTimeMillis()));
				aigaTestTask.setTestType(1);
				aigaTestTask.setDevTag(aigaTestTask.getTaskTag());
				testPlanSV.saveAigaTestObj(aigaTestTask);
			}
			if (testPlan.getIsPerformanceTest().equals(0)) {
				aigaTestTask.setTaskId(null);
				aigaTestTask.setTaskTag("GT性能测试" + testPlan.getPlanTag());
				aigaTestTask.setTaskName("GT性能测试");
				aigaTestTask.setCreateTime(new Timestamp(System.currentTimeMillis()));
				aigaTestTask.setTestType(2);
				aigaTestTask.setDevTag(aigaTestTask.getTaskTag());
				testPlanSV.saveAigaTestObj(aigaTestTask);
			}
			if (testPlan.getIsRegressionTest().equals(0)) {
				aigaTestTask.setTaskId(null);
				aigaTestTask.setTaskTag("GT功能回归" + testPlan.getPlanTag());
				aigaTestTask.setTaskName("GT性能回归");
				aigaTestTask.setCreateTime(new Timestamp(System.currentTimeMillis()));
				aigaTestTask.setTestType(3);
				aigaTestTask.setDevTag(aigaTestTask.getTaskTag());
				testPlanSV.saveAigaTestObj(aigaTestTask);
			}

			result = true;
		} catch (Exception e) {
			result = false;
			logger.info(e.getMessage());
			e.getStackTrace();
			map.put("message", e.getMessage());
		}

		map.put("success", result);
		ActionHelper.returnResponseData(request, response, map);
	}

	@RequestMapping("/getTaskForm.do")
	public void getTaskForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String taskId = request.getParameter("taskId");
		AigaTestTask task = new AigaTestTask();
		if (taskId != null && !taskId.equals("")) {
			List<Object> taskList = testPlanSV.getObjectByHQL("FROM AigaTestTask WHERE taskId=" + taskId +" ORDER BY createTime DESC");
			if (taskList.size() == 1) {
				task = (AigaTestTask) taskList.get(0);

			}
		}
		this.setFormData(task);
		this.postInfo(request, response);
	}

	@RequestMapping(value = "/uploadTeskTaskExcel.do")
	public void dealStaffExcel(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String planId=request.getParameter("planId");
		String planTag=request.getParameter("planTag");
		String factCompleteTime=request.getParameter("factCompleteTime");
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		String callBackMsg = "";
		Boolean success = false;
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (isMultipart) {
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			try {
				List<FileItem> items = upload.parseRequest(request);
				for (FileItem item : items) {
					if (!item.isFormField()) {
						 String name = item.getName();
						 resultMap.put("fileName", name);
						// 获取上传文件
						Map[] fieldsToCells = new HashMap[2];
						Map<String,String> map1 = new HashMap<String,String>();
//						Map<String, String> map2 = new HashMap<String, String>();
						Map<String, String> map3 = new HashMap<String, String>();
						
					
						 /** 测试进度 测试情况 测试人员 测试管理员 缺陷数量**/ 
//						map1.put("测试进度", "testProgress");
//						map1.put("测试情况", "testSituation");
//						map1.put("测试人员", "testPersion");
						map1.put("测试组长", "distributeStaffname");
//						map1.put("缺陷数量", "defectNumber");
						/**需求级别 需求优先级 集团考核 需求分类 需求类型 需求变更类型 变更时间 变更原因 初排时间 终排时间**/
//						map2.put("需求级别", "reqGrade");
						map1.put("任务优先级", "priority");
//						map1.put("集团考核", "testGroup");
//						map1.put("需求分类", "reqClass");
//						map2.put("需求变更类型", "reqModifyType");
//						map2.put("变更时间", "reqModifyTime");
//						map2.put("变更原因", "reqModifyReason");
//						map2.put("初排时间", "createTime");
//						map2.put("终排时间", "reqEndTime");
						/** 上线时间 开发任务编号 开发任务名称 任务状态 是否重点需求 系统大类 系统子类 归属测试组 开发人员**/
//						map1.put("上线时间", "onLineTime");
						map1.put("开发任务编号", "devTag");
//						map1.put("开发任务编号", "taskTag");
						map1.put("开发任务名称", "taskName");
//						map1.put("任务状态", "currentStatus");
						map1.put("是否重点需求", "isImportanceReq");
						map1.put("系统大类", "bigType");
						map1.put("系统子类", "subType");
//						map1.put("归属测试组", "testGroup");
						map1.put("需求编号", "reqTag");
						map1.put("需求类型", "reqType");
//						map1.put("开发人员", "devPersion");
						 /** 开发管理员 需求管理员 需求申请人 备注 工作量评估 初步情况分析**/
//						map1.put("开发管理员", "devaAdmin");
						map1.put("需求管理员", "reqPersion");
//						map1.put("工作量评估", "devWorkDay");
//						map1.put("备注", "devWorkDay");
						map1.put("任务单说明", "initialSituation");
						map1.put("开发厂商", "devFirm");
						map1.put("测试厂商", "testFirm");
						map1.put("开发工作量", "devWorkDay");
//						map1.put("测试工作量", "testWorkDay");
						/**需求提出时间 软件需求编号 软件需求名称 需求来源*/
//						map2.put("软件需求编号", "reqTag");
//						map2.put("软件需求名称", "reqName");
//						map2.put("需求提出时间", "createTime");
//						map2.put("需求来源", "reqSource");
						
						map3.put("测试组长工号", "userAccount");
						fieldsToCells[0] = map1;
						fieldsToCells[1] = map3;
						List retTask=new ArrayList();
						try {
							InputStream in = item.getInputStream();
							String checkStaffErr="";
							Object[] objs = XlsHelper.transXlsToObjs(in,fieldsToCells, new Class[] {AigaTestTask.class,AigaUser.class});
							List taskList =null;
							List userList =null;
							String checkSQL="SELECT DISTINCT t.dev_tag FROM aiga_test_task t where t.dev_Tag in ('111111111111111111111111111'";
							taskList= (List) objs[0];
//							reqList=(List) objs[1];
							userList=(List) objs[1];
							List<AigaTestTask> lastTaskObjList=new ArrayList<AigaTestTask>();
//								if(taskList.size())throw new Exception("导入失败");
								for (int j = 0, m = taskList.size(); j < m; j++) {
									AigaTestTask task = new AigaTestTask();
									task=taskList.get(j) instanceof AigaTestTask?(AigaTestTask)taskList.get(j):null;
//									AigaRequisition req = new AigaRequisition();
//									req=reqList.get(j) instanceof AigaRequisition?(AigaRequisition)reqList.get(j):null;
									AigaUser user =new AigaUser();
								if (userList.get(j) instanceof AigaUser) {
									user = (AigaUser) userList.get(j);
									user = StaffUtil.getUserByAccount(user.getUserAccount().toUpperCase());
									try {
										task.setDistributeStaffid(String.valueOf(user.getUserId()));
										task.setDistributeStaffname(user.getUserName());
									} catch (Exception e) {
										e.getStackTrace();
										checkStaffErr+=(j+1)+"  ";
										continue;
//										throw new Exception("导入异常,空值异常,在"+(j+1)+"行");
									}

								} else {
									throw new Exception("导入异常，用户类型错误");
								}
//									task.setReqId(req.getReqId());
									task.setCurrentStatus(101);
									task.setTaskPhase(1);
									String dateFormat = CommonHelper.dateToString(new Date(), "yyyyMMddHHmmss");
						            String taskTag = "TT" + dateFormat;
						            String tagLast3Char="";
						            if(j<10)tagLast3Char="00"+j;
						            else if(j<100)tagLast3Char="0"+j;
						            else tagLast3Char=""+j;
						            task.setTaskTag(taskTag+tagLast3Char);
									if (planId != null && !planId.equals(""))task.setPlanId(Integer.valueOf(planId));
									if (planTag != null && !planTag.equals(""))task.setPlanTag(planTag);
									if (factCompleteTime != null && !factCompleteTime.equals("")){
										Date date=CommonHelper.stringToDate(factCompleteTime,"yyyy-MM-dd");
										SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
										String time = formatter.format(date);
										Timestamp timestamp = Timestamp.valueOf(time);
										task.setFactCompleteTime(timestamp);
									}
									checkSQL+=",'"+task.getDevTag()+"'";
									lastTaskObjList.add(task);
								}
								checkSQL+=")";
								List<String> checkTask=testPlanSV.getObjectBySQL(checkSQL);
								String checkDevTag="";
								String repeatDevTag="";
								String checkDevName="";
								String DevLenCheck="";
								String reqLenCheck="";
								String DevWorkDay="";
								if(checkTask!=null&&checkTask.size()!=0){
									checkDevTag=CommonHelper.array2String(checkTask.toArray(new String[0]),",");
								}
								for(AigaTestTask tempTask:lastTaskObjList){
									AigaUser user=( AigaUser)request.getSession().getAttribute( "aigaUser"); 
									tempTask.setSubmitStaffId((int)user.getUserId());
									tempTask.setSubmitStaffName(user.getUserName());
									SysConstant[] ss=SysContentUtil.getSysContant("AigaTestTask_import");
									tempTask.setTestType(0);
									if(checkDevTag.indexOf(tempTask.getDevTag())!=-1){
										repeatDevTag+=tempTask.getDevTag()+"  ";
										continue;
									}
									if(tempTask.getTaskName()==null ||tempTask.getTaskName().length()==0){
										checkDevName+=tempTask.getDevTag()+" ";
										continue;
									}
//									if(ss.length==1&&ss[0].getValue().equals(0)){
										tempTask.setCreateTime(new Timestamp(System.currentTimeMillis()));
//									}
									 try{
									  if(tempTask.getDevWorkDay()==null||tempTask.getDevWorkDay().length()==0 ){
										  DevWorkDay+=tempTask.getDevTag()+" ";
										  continue;
									  }
							            float devWorkDay=Float.valueOf(tempTask.getDevWorkDay());
							            tempTask.setTestWorkDay(String.valueOf(Math.ceil(devWorkDay*0.6)));
									  }catch (Exception e) {
										  DevWorkDay+=tempTask.getDevTag()+" ";
										  continue;
									}finally{
										
									}
									retTask.add(tempTask);
//									testPlanSV.saveAigaTestObj(tempTask);
									//当前导入任务单列表开发编号不能重复
									checkDevTag+=tempTask.getDevTag()+",";
								}
							resultMap.put("data", retTask);
							String checkMsg="";
							if(NaNull(repeatDevTag.trim()))checkMsg+=" 开发任务编号为【"+repeatDevTag+"】的任务唯一性校验失败\n\n";
							if(NaNull(reqLenCheck.trim()))checkMsg+="  开发任务编号为【"+reqLenCheck+"】的任务需求编号长度校验失败\n\n";
							if(NaNull(DevLenCheck.trim()))checkMsg+="  开发任务编号为【"+DevLenCheck+"】的任务开发编号长度校验失败\n\n";
							if(NaNull(checkDevName.trim()))checkMsg+=" 开发任务编号为【"+checkDevName+"】的任务名称校验失败\n\n";
							if(NaNull(DevWorkDay.trim()))checkMsg+="   开发任务编号为【"+DevWorkDay+"】开发任务工时校验失败\n\n";
							if(NaNull(checkStaffErr.trim()))checkMsg+="  第【"+checkStaffErr+"】行工号校验失败\n\n";
								
							resultMap.put("checkMsg", checkMsg);
							System.out.println(checkMsg);
							System.out.println(checkMsg.length());
							success = true;
							if(checkMsg.trim().length()==0){
								for(Object obj:retTask){
									AigaTestTask testTask=(AigaTestTask)obj;
									testPlanSV.saveAigaTestObj(testTask);
									if(testTask.getPlanTag()!=null&&!testTask.getPlanTag().equals("")){
										AigaUser aigaUser=(AigaUser)request.getSession().getAttribute("aigaUser");
										AigaTestTaskChange aigaTestTaskChange=new AigaTestTaskChange();
										aigaTestTaskChange.setChangeTaskId(testTask.getTaskId());
										aigaTestTaskChange.setChangeTaskTag(testTask.getTaskTag());
										aigaTestTaskChange.setChangeReson("单个任务排期");
										aigaTestTaskChange.setCreateTime(new Timestamp(System.currentTimeMillis()));
										aigaTestTaskChange.setChangeStaffId((int)aigaUser.getUserId());
										aigaTestTaskChange.setChangeStaffName(aigaUser.getUserName());
										aigaTestTaskChange.setPlanIdn(testTask.getPlanId());
										aigaTestTaskChange.setOnlineTimen(testTask.getFactCompleteTime());
										testPlanSV.saveAigaTestObj(aigaTestTaskChange);
									}
								}
							}
						} catch (Exception e) {
							e.printStackTrace();
							resultMap.put("msg", e.getMessage());
							resultMap.put("error", "true");
						}finally{
							
						}

					}
				}
			} catch (Exception e) {
				logger.equals(e.getStackTrace());
				resultMap.put("msg", e.getMessage());
				resultMap.put("error", "true");
			}
		}
		resultMap.put("success", success);
	
		ActionHelper.responseFileUpload(request, response, resultMap);

	}
	@RequestMapping("/saveTestTaskList.do")
	public void saveTestTaskList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Object[] objs=this.transTableToObj(request,  AigaTestTask.class);
		Map map=new HashMap();
		map.put("success", false);
		
		try{
			for(Object obj:objs){
				AigaTestTask testTask=(AigaTestTask)obj;
				testPlanSV.saveAigaTestObj(testTask);
				System.out.println(testTask.getTaskId());
				System.out.println(testTask.getFactCompleteTime());
				Date date=testTask.getFactCompleteTime();
				if(testTask.getTaskTag()!=null&&!testTask.getTaskTag().equals("")){
					AigaUser aigaUser=(AigaUser)request.getSession().getAttribute("aigaUser");
					AigaTestTaskChange aigaTestTaskChange=new AigaTestTaskChange();
					aigaTestTaskChange.setChangeTaskId(testTask.getTaskId());
					aigaTestTaskChange.setChangeTaskTag(testTask.getTaskTag());
					aigaTestTaskChange.setChangeReson("单个任务排期");
					aigaTestTaskChange.setCreateTime(new Timestamp(System.currentTimeMillis()));
					aigaTestTaskChange.setChangeStaffId((int)aigaUser.getUserId());
					aigaTestTaskChange.setChangeStaffName(aigaUser.getUserName());
					aigaTestTaskChange.setPlanIdn(testTask.getPlanId());
					aigaTestTaskChange.setOnlineTimen(testTask.getFactCompleteTime());
					testPlanSV.saveAigaTestObj(aigaTestTaskChange);
				}
				String updateSQL="UPDATE aiga_test_sub_task atst SET atst.FACT_COMPLETE_TIME=to_date('"+CommonHelper.dateToString(date, "yyyy-MM-dd")+"','yyyy-MM-dd') WHERE atst.task_id ='"+testTask.getTaskId()+"'";
				testPlanSV.updateBySQL(updateSQL);
				}
			map.put("success", true);
			map.put("message", "排期成功！是否刷新页面？");
		}catch (Exception e) {
			e.getStackTrace();
			map.put("success", false);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping("/changeTestTaskList.do")
	public void changeTestTaskList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Object[] objs=this.transTableToObj(request,  AigaTestTask.class);
		String staffIdString = request.getParameter("staffId");
		String staffNameString = request.getParameter("staffName");
		
		Map map=new HashMap();
		boolean mark = true;
		try{
			for(Object obj:objs){
				AigaTestTask testTask=(AigaTestTask)obj;
				mark = testTaskSV.changeAigaTestTask(testTask,staffIdString,staffNameString);
				if(!mark){
					mark = false;
					break;
				}
			}
			if(mark){
				map.put("success", true);
				map.put("message", "变更成功！是否刷新页面？");
			}else {
				map.put("success", false);
				map.put("message", "变更失败");
			}
		}catch (Exception e) {
			e.getStackTrace();
			map.put("success", false);
			map.put("message", "排期失败"+e);
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping(value = "/checkReqHasP2PTestTask.do")
	public void checkReqHasP2PTestTask(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String reqTag=request.getParameter("reqTag");
		String SQL="SELECT t.task_name,t.task_id  FROM aiga_test_task t WHERE t.test_type ="+SysContentUtil.getSysConstant("AIGA_TEST_PLAN", "27").getValue()+" and t.req_tag='"+reqTag+"'";
		List list=testPlanSV.getObjectBySQL(SQL);
		JSONObject json=new JSONObject();
		if(list.size()>0){
			json.put("success", false);
			for(Object objs:list){
				Object[] obj=(Object[])objs;
				if(obj.length!=2)throw new Exception("数据长度有误");
				json.put("message", "需求编号为"+reqTag+"的需求已经创建了任务名为【"+obj[0]+"】的用户体验测试任务！");
			}
		}else{
			json.put("success", true);
			}
		ActionHelper.returnResponseData(request, response, json);
	}
	
	@RequestMapping(value = "/checkReqHasPerfTestTask.do")
	public void checkReqHasPerfTestTask(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String reqTag=request.getParameter("reqTag");
		String SQL="SELECT t.task_name,t.task_id  FROM aiga_test_task t WHERE t.test_type ="+SysContentUtil.getSysConstant("AIGA_TEST_PLAN", "23").getValue()+" and t.req_tag='"+reqTag+"'";
		List list=testPlanSV.getObjectBySQL(SQL);
		JSONObject json=new JSONObject();
		if(list.size()>0){
			json.put("success", false);
			for(Object objs:list){
				Object[] obj=(Object[])objs;
				if(obj.length!=2)throw new Exception("数据长度有误");
				json.put("message", "需求编号为"+reqTag+"的需求已经创建了任务名为【"+obj[0]+"】的性能测试任务！");
			}
		}else{
			json.put("success", true);
			}
		ActionHelper.returnResponseData(request, response, json);
	}
	
	@RequestMapping(value = "/jointTestTaskByTasks.do")
	public void jointTestTaskByTasks(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String[] tasksTrue=request.getParameterValues("taskTrueArrays");
		String[] tasksFalse=request.getParameterValues("taskFalseArrays");
		Map map =new HashMap();
		map.put("success", false);
		map.put("message", "更新成功");
		try{
			if(tasksTrue!=null&&tasksTrue.length!=0){
				String jointTestTrueSQL="UPDATE aiga_test_task att  SET att.is_joint_test =1 WHERE att.task_id IN ("+CommonHelper.array2String(tasksTrue, ",")+")";
				String jointTestSubTaskTrueSQL="UPDATE aiga_test_sub_task atst  SET atst.is_joint_debug =1 WHERE atst.task_id IN ("+CommonHelper.array2String(tasksTrue, ",")+")";
				testPlanSV.updateBySQL(jointTestTrueSQL);
				testPlanSV.updateBySQL(jointTestSubTaskTrueSQL);
				map.put("success", true);
				
			}
			if(tasksFalse!=null&&tasksFalse.length!=0){
				String jointTestFalseSQL="UPDATE aiga_test_task att  SET att.is_joint_test =null WHERE att.task_id IN ("+CommonHelper.array2String(tasksFalse, ",")+")";
				String jointTestSubTaskFlaseSQL="UPDATE aiga_test_sub_task atst  SET atst.is_joint_debug =null WHERE atst.task_id IN ("+CommonHelper.array2String(tasksFalse, ",")+")";
				testPlanSV.updateBySQL(jointTestFalseSQL);
				testPlanSV.updateBySQL(jointTestSubTaskFlaseSQL);
				map.put("success", true);
			}
		}catch (Exception e) {
			e.printStackTrace();
			map.put("message", e.getMessage());
		}
		
		
		ActionHelper.returnResponseData(request, response, map);
	}
	public static void main(String[] args) {
		System.out.println("SR201409181801".length());
	}
}
