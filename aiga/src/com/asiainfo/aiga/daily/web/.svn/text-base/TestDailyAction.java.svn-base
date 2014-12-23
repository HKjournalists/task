package com.asiainfo.aiga.daily.web;

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

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.DynamicBean;
import com.asiainfo.aiga.common.WorkflowParam;
import com.asiainfo.aiga.common.helper.ActionHelper;
import com.asiainfo.aiga.common.helper.CommonHelper;
import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.common.workflowVo.Workflow;
import com.asiainfo.aiga.common.xls.ExcelVO;
import com.asiainfo.aiga.common.xls.XlsHelper;
import com.asiainfo.aiga.daily.bo.AigaTestDaily;
import com.asiainfo.aiga.requisition.bo.AigaTestSubTask;
import com.asiainfo.aiga.requisition.bo.SysOrganize;
import com.asiainfo.aiga.requisition.bo.SysStaffOrgRelat;
import com.asiainfo.aiga.requisition.service.IAigaRequisitionSV;
import com.asiainfo.aiga.sysConstant.bo.SysConstant;
import com.asiainfo.aiga.sysConstant.util.SysContentUtil;
import com.asiainfo.aiga.testPlan.bo.AigaTestPlan;
import com.asiainfo.aiga.testPlan.service.IAigaTestPlanSV;

@Controller
public class TestDailyAction extends BaseAction {
	private String downloadDailySql = "";
	private String AIGA_TEST_PLAN = "AIGA_TEST_PLAN";
	@Resource(name = "testPlanSV")
	private IAigaTestPlanSV testPlanSV;
	@Resource(name="requisitionSV")
	private IAigaRequisitionSV reqSV;
	@RequestMapping("/saveTestDailyForm.do")
	public void saveTestDailyForm(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Object[] objs = this.transFormToObj(request, new Class[] {AigaTestDaily.class });
		Boolean result = false;
		Map map = new HashMap();
		if(objs!=null && objs.length==1){
			if (objs[0] instanceof AigaTestDaily) {
				try {
					AigaTestDaily testDaily=(AigaTestDaily)objs[0];
					if(testDaily.getDailyId()==null){//新增
						testDaily.setCommitTime(new Timestamp(System.currentTimeMillis()));
						testPlanSV.saveAigaTestObj(testDaily);
						result = true;
						map.put("success", result);
					}else{//修改
						java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
						String commitTime = sdf.format(testDaily.getCommitTime());
						Date currentTime = new Date();
						SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
						String dateString = formatter.format(currentTime);
						if(commitTime.equals(dateString)){
							testPlanSV.saveAigaTestObj(testDaily);
							result = true;
							map.put("success", result);
						}else{
							result = false;
							map.put("success", result);
							map.put("msg", "对不起过期的日志无法修改!");
						}
					}
				} catch (Exception e) {
					map.put("msg", "保存数据失败!");
					result = false;
					map.put("success", result);
				}	
			}
		}
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping("/checkTestDailyWriteable.do")
	public void checkTestDailyWriteable(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String msg = "今天已经填写该任务的日报,如需修改请规范操作!";
		Map map = new HashMap();
		try {
			Date currentTime = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			String dateString = formatter.format(currentTime);
			String HQL="FROM AigaTestDaily WHERE 1=1 and to_char(commitTime,'yyyy-MM-dd')='"+dateString+"' and staffId ="+
			request.getParameter("staffId")+" and subTaskId="+request.getParameter("subTaskId");
			List testDailyList=testPlanSV.getObjectByHQL(HQL);
			if(testDailyList.size()>=1){//已经填写
				AigaTestDaily daily = (AigaTestDaily)testDailyList.get(0);
				map.put("msg", daily.getDailyId());
				map.put("success", true);
			}else{//没有填写
				map.put("success", false);
			}
		} catch (Exception e) {
			map.put("msg", "访问数据失败!");
			map.put("success", false);
		}	
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping("/getEnableEditDaily.do")
	public void getEnableEditDaily(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String staffId=request.getParameter("staffId");
		String dailyId=request.getParameter("dailyId");
		String commitTime=request.getParameter("commitTime");
		String HQL="FROM AigaTestDaily  where 1=1 ";
		if(staffId!=null && !staffId.equals(""))HQL+=" and staffId="+staffId;
			//else throw new Exception("staffId不能为空");
		if(dailyId!=null && !dailyId.equals(""))HQL+=" and dailyId="+dailyId;
		if(commitTime!=null && !commitTime.equals(""))
			HQL+=" and to_char(commitTime,'yyyy-mm-dd')='"+commitTime+"'";
		List testDailyList=testPlanSV.getObjectByHQL(HQL);
		Map map = new HashMap();
		if(staffId!=null && !staffId.equals("")&&testDailyList!=null&&testDailyList.size()==1)
			map.put("data", testDailyList.get(0));
		else
			map.put("data", testDailyList);
		map.put("success", true);
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping("/getTestDailyList.do")
	public void getTestDailyList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String staffId=request.getParameter("staffId");
		String dailyId=request.getParameter("dailyId");
		String commitTime=request.getParameter("commitTime");
		String HQL="FROM AigaTestDaily  where 1=1 ";
		if(staffId!=null && !staffId.equals(""))HQL+=" and staffId="+staffId;
			//else throw new Exception("staffId不能为空");
		if(dailyId!=null && !dailyId.equals(""))HQL+=" and dailyId="+dailyId;
		if(commitTime!=null && !commitTime.equals(""))
			HQL+=" and to_char(commitTime,'yyyy-mm-dd')='"+commitTime+"'";
		else{
			Date currentTime = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			String dateString = formatter.format(currentTime);
			HQL+=" and to_char(commitTime,'yyyy-mm-dd')='"+dateString+"'";
		}
		List testDailyList=testPlanSV.getObjectByHQL(HQL);
		Map map = new HashMap();
		if(testDailyList!=null&&testDailyList.size()==1)
			map.put("data", testDailyList.get(0));
		else
			map.put("data", testDailyList);
		map.put("success", true);
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/getTimer.do")
	public void getTimer(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String timer=SysContentUtil.getSysConstantShowByValue("TIMER", "1");
		String MessageFormat=SysContentUtil.getSysConstantShowByValue("TIMER", "2");
		String[] timers=timer.split(",");
		Map map=new HashMap();
		map.put("timer", timers);
		map.put("message", MessageFormat);
		ActionHelper.returnResponseData(request, response, map);
	}
	@RequestMapping("/getSubTaskList.do")
	public void getSubTaskList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String staffId=request.getParameter("staffId");
		String subTaskTag=request.getParameter("subTaskTag");
		String staffName=request.getParameter("staffName");
		String subTaskName=request.getParameter("subTaskName");
		String searchStaffId= request.getParameter("searchStaffId");
		//子任务类型
		String subTaskType= request.getParameter("subTaskType");
		//子任务状态
		String subTaskStatus= request.getParameter("subTaskStatus");
		StringBuffer HQL=new StringBuffer("FROM AigaTestSubTask a WHERE 1=1 ");
		/**
		 * 此处的逻辑是:
		 *             1  当用户没有选择测试人时,默认查询当前登录人相关的子任务,如果选择了测试人,则按照测试人进行查找.
		 *             2 子任务名称的查询条件,受选不选测试人条件的约束.
		 */
		if(searchStaffId!=null&&!searchStaffId.equals("")){
			HQL.append(" and a.testorId = "+searchStaffId);
		}else{
			HQL.append(" and a.testorId = "+staffId);
		}
		//测试子任务名称过滤
		if(subTaskName!=null&&!this.decodeCN(subTaskName).equals("")&&!this.decodeCN(subTaskName).equals("undefined")){
			HQL.append(" and a.subTaskName like '%"+this.decodeCN(subTaskName)+"%' ");
		}
		//测试子任务编号过滤
		if(subTaskTag!=null&&!this.decodeCN(subTaskTag).equals("")&&!this.decodeCN(subTaskTag).equals("undefined")){
			HQL.append(" and a.subTaskTag like '%"+this.decodeCN(subTaskTag)+"%' ");
		}
		/**
		 *  此处的逻辑是:
		 *  		1、如果只选择子任务类型，则查询该来下下的所有状态的子任务
		 *  		2、如果选择了特点的子任务状态，则查询该类型下的该状态的子任务
		 *  		3、页面初始化，或者不选择子任务类型和状态，则 默认剔除子任务状态为：子任务结束的子任务
		 */
		if(StringUtils.isNotBlank(subTaskType)){
			if(StringUtils.isNotBlank(subTaskStatus)){
				HQL.append(" and a.subTaskStatus = "+subTaskStatus);
			}else{
				List<Workflow> workfowList=new ArrayList<Workflow>();
				Long[] params = new Long[1];
				params[0]=Long.parseLong(subTaskType);
				workfowList=WorkflowParam.getWorkflowsByTemplateIds(params);
				if(workfowList.size()!=0){
					HQL.append(" and ( ");
					for (Workflow workfolw : workfowList) {
						HQL.append("a.subTaskStatus =").append(workfolw.getLinkId()).append(" or ");
					}
					HQL.deleteCharAt(HQL.length() - 1).deleteCharAt(HQL.length() - 1).deleteCharAt(HQL.length() - 1);
					HQL.append(" ) ");
				}
			}
		}else{
			HQL.append(" and a.subTaskStatus<>699 and a.subTaskStatus<>799 and a.subTaskStatus<>899 ) ");
		}
		List testSubTaskList=testPlanSV.getObjectByHQL(HQL.toString());
		Map map = new HashMap();
		map.put("data", testSubTaskList);
		ActionHelper.returnResponseData(request, response, map);
	}
	
	@RequestMapping("/getTestDailyReportList.do")
	public void getTestTaskList(HttpServletRequest request,HttpServletResponse response) throws Exception {
		JSONObject jsonObj = new JSONObject();
		//获取前台参数值
		String searchStaffId= request.getParameter("searchStaffId");
		String beginCommitTime=request.getParameter("beginDate");
		String endCommitTime=request.getParameter("endDate");
		String testOrderlistStatus = request.getParameter("testOrderlistStatus");
		String mainProcessIsPass = request.getParameter("mainProcessIsPass");
		String isRecentQuery = request.getParameter("isRecentQuery");
		String organizeId = request.getParameter("organizeId");
		String factCompleteTime = request.getParameter("factCompleteTime");
		String bigType = request.getParameter("bigType");
		//拼装查询条件
		StringBuffer conditionBuf = new StringBuffer();
		//组织部门
		if(organizeId != null && !"".equals(organizeId)&&!organizeId.equals("null")&&!organizeId.equals("undefined")) {
			String hql="from SysStaffOrgRelat a where a.organizeId='"+organizeId+"'";
			SysStaffOrgRelat[] sysStaffOrg=reqSV.getTestorIdByOrgId(hql);
			conditionBuf.append(" and (TASK.testor_Id="+sysStaffOrg[0].getStaffId());
			for(int i=1;i<sysStaffOrg.length;i++){
				conditionBuf.append(" or TASK.testor_Id=" + sysStaffOrg[i].getStaffId());
			}
			conditionBuf.append(")");
		}
		//测试人员
		if(searchStaffId!=null&&!searchStaffId.equals("")){
			conditionBuf.append(" AND TASK.TESTOR_ID = "+searchStaffId);
		}
		//测试工单状态
		if(testOrderlistStatus!=null&&!testOrderlistStatus.equals("")){
			conditionBuf.append(" AND DAILY.TEST_ORDERLIST_STATUS = "+testOrderlistStatus);
		}
		//测试主流程是否通过
		if(mainProcessIsPass!=null&&!mainProcessIsPass.equals("")){
					conditionBuf.append(" AND DAILY.MAIN_PROCESS_IS_PASS = "+mainProcessIsPass);
		}
		//系统大类
		if(bigType!=null&&!bigType.equals("")&&!bigType.equals("undefined")&&!bigType.equals("0")){
			conditionBuf.append(" AND TASK.BIG_TYPE = "+bigType);
		}	
		//上线时间【必填】
		if(factCompleteTime!=null&&!factCompleteTime.equals("")){
			conditionBuf.append(" AND TO_DATE(TO_CHAR(TASK.FACT_COMPLETE_TIME,'YYYY-MM-DD'),'YYYY-MM-DD') = TO_DATE('"+factCompleteTime.substring(0, 10)+"','YYYY-MM-DD') ");
		}else{
			throw new Exception("上线时间为空");
		}
		//填写时间
		if(beginCommitTime!=null&&!beginCommitTime.equals("")){
			conditionBuf.append(" AND TO_DATE(TO_CHAR(DAILY.COMMIT_TIME,'YYYY-MM-DD'),'YYYY-MM-DD') >= TO_DATE('"+beginCommitTime.substring(0, 10)+"','YYYY-MM-DD') ");
		}
		if(endCommitTime!=null&&!endCommitTime.equals("")){
			conditionBuf.append(" AND TO_DATE(TO_CHAR(DAILY.COMMIT_TIME,'YYYY-MM-DD'),'YYYY-MM-DD') <= TO_DATE('"+endCommitTime.substring(0, 10)+"','YYYY-MM-DD') ");
		}
		//是否查询最新记录
		if(StringUtils.isNotBlank(isRecentQuery) && isRecentQuery.trim().equals("true")){
			conditionBuf.append(" AND  NOT EXISTS (SELECT 1 FROM AIGA_TEST_DAILY A WHERE A.COMMIT_TIME > DAILY.COMMIT_TIME ")
					.append(" AND A.SUB_TASK_TAG = DAILY.SUB_TASK_TAG ) ");
		}
		//前台分页参数
		Map<String,Integer> paginationParams=this.paginationParams(request);
		Integer page=paginationParams.get(this.PAGE_PARAM);
		Integer limit=paginationParams.get(this.LIMIT_PARAM);
		//拼装查询SQL，查询数据
		String BatchTaskCountSQL=
			"SELECT * FROM (" +
			" SELECT TASK.SUB_TASK_ID,"+ 
			" AIGA_TASK.DEV_TAG," +
			" TASK.SUB_TASK_TAG," +
			" TASK.SUB_TASK_NAME," +
			" TASK.TESTOR_NAME," +
			" TO_CHAR(TASK.FACT_COMPLETE_TIME,'YYYY-MM-DD') AS FACT_COMPLETE_TIME," +
			" DAILY.PASS_CASE_NUMBER," +
			" DAILY.SUM_CASE_NUMBER," +
			" DECODE(DAILY.SUM_CASE_NUMBER,0,0,ROUND((DAILY.PASS_CASE_NUMBER/DAILY.SUM_CASE_NUMBER)*100,2))||'%' AS PASS_PERCENT," +
			" (SELECT EMPLOYEE.EMPLOYEE_NAME FROM SYS_EMPLOYEE EMPLOYEE WHERE EMPLOYEE.EMPLOYEE_ID = (SELECT STAFF.EMPLOYEE_ID FROM SYS_STAFF STAFF WHERE STAFF.STAFF_ID = DAILY.EDIT_STAFF_ID)) AS EDIT_STAFF_NAME," +
			" DAILY.DEFFECT_SUM_NUMBER," +
			" DAILY.DEFFECT_UNFINISHEND_NUMBER," +
			" DAILY.TEST_ORDERLIST_STATUS," +
			" DAILY.MAIN_PROCESS_IS_PASS," +
			" (SELECT  T.SHOW  FROM  SYS_CONSTANT T  WHERE  CATEGORY = 'reviewResult'  AND T.VALUE=TASK.REVIEW_RESULT) AS REVIEW_RESULT," +
			" TO_CHAR(DAILY.COMMIT_TIME,'YYYY-MM-DD') AS COMMIT_TIME," +
			" ROWNUM RN " +
			" FROM AIGA_TEST_SUB_TASK TASK, AIGA_TEST_DAILY DAILY,AIGA_TEST_TASK AIGA_TASK " +
			" WHERE TASK.TASK_ID = AIGA_TASK.TASK_ID AND TASK.SUB_TASK_ID = DAILY.SUB_TASK_ID(+) " +conditionBuf.toString();
		//截取分页前的数据查询SQL，用于导出全部数据到EXCEL
		downloadDailySql = BatchTaskCountSQL+")";
		//继续拼装分页查询Sql
		BatchTaskCountSQL=BatchTaskCountSQL+
				" AND ROWNUM <= " +(page*limit)+
				" ORDER BY DAILY.COMMIT_TIME DESC NULLS LAST)" +
				" WHERE RN > "+(page-1)*limit;
		System.out.println("^^^^^^^^^^"+BatchTaskCountSQL);
		List list=testPlanSV.getObjectBySQL(BatchTaskCountSQL);
		//拼装返回JSON数据
		JSONArray json = new JSONArray();
		System.out.println("QQ->"+BatchTaskCountSQL);
		for(int i=0,n=list.size();i<n;i++){
			Object objs=list.get(i);
			Object[] obj=(Object[])objs;
			JSONObject dailyJSONOj=new JSONObject();
			dailyJSONOj.put("subTaskId", obj[0]);
			dailyJSONOj.put("devTag", obj[1]);
			dailyJSONOj.put("subTaskTag",obj[2]);
			dailyJSONOj.put("subTaskName", obj[3]);
			dailyJSONOj.put("testorName", obj[4]);
			dailyJSONOj.put("factCompleteTime", obj[5]);
			dailyJSONOj.put("passCaseNumber", obj[6]);
			dailyJSONOj.put("sumCaseNumber", obj[7]);
			dailyJSONOj.put("passPercent", obj[8].equals("%")?"":obj[8]);
			dailyJSONOj.put("editStaffName", obj[9]);
			dailyJSONOj.put("deffectSumNumber", obj[10]);
			dailyJSONOj.put("deffectUnfinishendNumber", obj[11]);
			dailyJSONOj.put("testOrderlistStatus", obj[12]);
			dailyJSONOj.put("mainProcessIsPass", obj[13]);
			dailyJSONOj.put("reviewResult", obj[14]);
			dailyJSONOj.put("commitTime", obj[15]);
			json.add(dailyJSONOj,this.jsonConfig);
		}
		jsonObj.put("total",testPlanSV.getObjectBySQL("SELECT count(TASK.SUB_TASK_ID) FROM AIGA_TEST_SUB_TASK TASK, AIGA_TEST_DAILY DAILY  WHERE TASK.SUB_TASK_ID = DAILY.SUB_TASK_ID(+) "+conditionBuf.toString()));
		jsonObj.put("data", json);
		ActionHelper.responseData4JSON(request, response, jsonObj);
	}
					  
	@RequestMapping("/downloadDailyStatistics.do")
	public void downloadDailyStatistics(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ExcelVO excelVo=new ExcelVO();
		
		List list = testPlanSV.getObjectBySQL(downloadDailySql);
		System.out.println(downloadDailySql);
		List<Map<String, Object>> objList=new ArrayList<Map<String, Object>>();
		for(Object objs:list){
			Map<String,Object> map = new HashMap<String,Object>();
			Object[] obj=(Object[])objs;
			map.put("dev_tag",NullValueFilter(obj[1]));
			map.put("sub_task_tag",NullValueFilter(obj[2]));
			map.put("sub_task_name",NullValueFilter(obj[3]));
			map.put("testor_name",NullValueFilter(obj[4]));
			map.put("fact_complete_time",NullValueFilter(obj[5]));
			map.put("pass_case_number",NullValueFilter(obj[6]));
			map.put("sum_case_number",NullValueFilter(obj[7]));
			map.put("pass_percent",obj[8].equals("%")?"":obj[8]);
			map.put("edit_staff_name",NullValueFilter(obj[9]));
			map.put("deffect_sum_number",NullValueFilter(obj[10]));
			map.put("deffect_unfinishend_number",NullValueFilter(obj[11]));
			map.put("test_orderlist_status",NullValueFilter(obj[12]));
			map.put("main_process_is_pass",NullValueFilter(obj[13]));
			map.put("review_result",NullValueFilter(obj[14]));
			map.put("commit_time",NullValueFilter(obj[15]));
			objList.add(map);
		}
		excelVo.setExportExcelName("测试日报集.xlsx");
		excelVo.setTemplateName("dailyStatistics.xlsx");
		Map beans=new HashMap();
		beans.put("dailyStatisticList", objList);
		excelVo.setDataMap(beans);
		XlsHelper.export2Excel(request, response, excelVo);
	}
	
}
