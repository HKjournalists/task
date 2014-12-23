package com.asiainfo.aiga.web;

import javax.servlet.RequestDispatcher;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sun.print.resources.serviceui;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.ai.appframe2.web.CustomProperty;
import com.ai.appframe2.web.HttpUtil;
import com.ai.appframe2.web.action.BaseAction;
import com.asiainfo.aiga.bo.BOAigaSolidTaskBean;
import com.asiainfo.aiga.bo.BOAigaSubTaskProblemBean;
import com.asiainfo.aiga.bo.BOAigaTestPlanBean;
import com.asiainfo.aiga.bo.BOAigaTestSubTaskBean;
import com.asiainfo.aiga.bo.BOAigaTestTaskBean;
import com.asiainfo.aiga.ivalues.IBOAigaSolidTaskValue;
import com.asiainfo.aiga.ivalues.IBOAigaSubTaskProblemValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestPlanValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestSubTaskValue;
import com.asiainfo.aiga.ivalues.IBOAigaTestTaskValue;
import com.asiainfo.aiga.service.interfaces.IAigaPublicSV;
import com.asiainfo.aiga.service.interfaces.IAigaSolidTaskSV;
import com.asiainfo.aiga.service.interfaces.IAigaTestPlanSV;
import com.asiainfo.aiga.service.interfaces.IAigaTestSubTaskSV;
import com.asiainfo.aiga.service.interfaces.IAigaTestTaskSV;
import com.asiainfo.csc.common.define.IMessageConsts;
import com.asiainfo.csc.matrix.bo.BOAlmStakeholderBean;
import com.asiainfo.csc.matrix.bo.BOAlmWorkorderBean;
import com.asiainfo.csc.matrix.ivalues.IBOAlmStakeholderValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkflowValue;
import com.asiainfo.csc.matrix.ivalues.IBOAlmWorkorderValue;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkflowSV;
import com.asiainfo.csc.matrix.service.interfaces.IAlmWorkorderSV;

public class TestPlanAction extends BaseAction {
	
	//公共获取工单连接函数
	public void requestDispatcher(HttpServletRequest request,HttpServletResponse response) throws Exception 
	{
		try {
			String linkNo = request.getParameter("linkNo");
			String funcPId = request.getParameter("objId");
			String orderId = request.getParameter("orderId");
			String objType = request.getParameter("objType");
			String objName = request.getParameter("objName");
			
			request.setAttribute("orderId", orderId);
			request.setAttribute("objId", funcPId);
			request.setAttribute("objType", objType);
			request.setAttribute("objName", objName);
			
			IAlmWorkflowSV iWfSV = (IAlmWorkflowSV)ServiceFactory.getService(IAlmWorkflowSV.class);
			Criteria sql = new Criteria();
			//sql.addEqual(IBOWorkflowValue.S_TemplateId, 300);//150就是funcPoint流程
			sql.addEqual(IBOAlmWorkflowValue.S_LinkNo, linkNo);
			IBOAlmWorkflowValue[] WfValue = (IBOAlmWorkflowValue[]) iWfSV.getAlmWorkflowByCondition(sql.toString(), sql.getParameters());
			
			if (WfValue.length != 1)
				throw new Exception("在动态跳转页面时，查询到的url不唯一，查询个数为："+WfValue.length+"个");
			
			String linkUrl = WfValue[0].getLinkUrl();
			
			RequestDispatcher rd = null;
			System.out.println("============\n" + linkUrl);
			rd = request.getRequestDispatcher(linkUrl);
			rd.forward(request, response);		
		}catch(Exception e)
		{
			e.printStackTrace();
			HttpUtil.showInfo(response, "页面动态跳转失败");
		}
	}
	
	//通用解析函数
	public void getDatasFromRequestInputstream(String jsonObjectString,
			List<IBOAigaTestPlanValue> atps, List<IBOAlmStakeholderValue> stds,
			List<IBOAlmWorkorderValue> orders,List<IBOAigaTestTaskValue> attasks,
			List<IBOAigaSolidTaskValue> astasks,List<IBOAigaTestSubTaskValue> atstvs)
			throws Exception {
		try 
		{       
			IAlmWorkorderSV iAlmWorkorderSV = (IAlmWorkorderSV)ServiceFactory.getService(IAlmWorkorderSV.class);
			IAigaTestPlanSV iAigaTestPlanSV = (IAigaTestPlanSV)ServiceFactory.getService(IAigaTestPlanSV.class);
			IAigaTestTaskSV iAigaTestTaskSV = (IAigaTestTaskSV)ServiceFactory.getService(IAigaTestTaskSV.class);
			IAigaTestSubTaskSV iAigaTestSubTaskSV = (IAigaTestSubTaskSV)ServiceFactory.getService(IAigaTestSubTaskSV.class);
		
			JSONObject result = JSONObject.fromObject(jsonObjectString); //转换为JSONObject              
			int num = result.length();  
			if(result != null && num>0)
			{
				JSONArray stakeholders = null;
				JSONObject orderDetail = null;
				JSONObject testPlan = null;
				JSONObject testTask = null;
				JSONObject perfSubTask = null;
				Object testTaskIds = null;
				Object subTaskIds = null;
				if(result.has("stakeholder"))
					stakeholders = result.getJSONArray("stakeholder");//获取干系人JSONArray 
				if(result.has("orderDetail"))
					orderDetail = result.getJSONObject("orderDetail");//获取工单信息  
				if(result.has("testPlan"))
					testPlan = result.getJSONObject("testPlan");//获取测试计划信息  
				if(result.has("testTask"))
					testTask = result.getJSONObject("testTask");//获取测试任务信息  
				if(result.has("perfSubTask"))
					perfSubTask = result.getJSONObject("perfSubTask");//获取性能测试子任务信息  
				if(result.has("testTaskIds"))
					testTaskIds = result.get("testTaskIds");//获取测试任务id序列信息 
				if(result.has("subTaskIds"))
					subTaskIds = result.get("subTaskIds");//获取测试子任务id序列信息  
				
				if(stakeholders != null && stakeholders.length()>0)//遍历干系人JSONArray
				{
					int length = stakeholders.length();
					for(int i = 0; i < length; i++)
					{
						JSONObject std = stakeholders.getJSONObject(i);  
						IBOAlmStakeholderValue approvalStakeholder = new BOAlmStakeholderBean();
						if(std.has("linkId"))
							approvalStakeholder.setLinkId(Long.valueOf(std.getString("linkId")));
						if(std.has("linkNo"))
							approvalStakeholder.setLinkNo(std.getString("linkNo"));
						if(std.has("templateId"))
							approvalStakeholder.setTemplateId(Long.valueOf(std.getString("templateId")));
						if(std.has("stdholderStaffId"))
							approvalStakeholder.setStdholderStaffId(Long.valueOf(std.getString("stdholderStaffId")));
						if(std.has("stdholderStaffNo"))
							approvalStakeholder.setStdholderStaffNo(std.getString("stdholderStaffNo"));
						if(std.has("stdholderStaffName"))
							approvalStakeholder.setStdholderStaffName(std.getString("stdholderStaffName"));
						if(std.has("stdholdeType"))
							approvalStakeholder.setStdholdeType(std.getString("stdholdeType"));
						stds.add(approvalStakeholder);
					}  
				}
				
				if(orderDetail != null)//遍历工单信息JSONObject
				{
					String orderId = "0";
					if(orderDetail.has("orderId"))
						orderId = orderDetail.getString("orderId");
					IBOAlmWorkorderValue iAlmWorkorderValue = new BOAlmWorkorderBean();
					if(orderId == null || orderId.equals("0") || orderId.equals("") || orderId.equals("null"))
					{
						iAlmWorkorderValue.setOrderId(Long.valueOf(orderId));
						if(orderDetail.has("conds"))
							iAlmWorkorderValue.setCond(orderDetail.getString("conds"));
						if(orderDetail.has("result"))
							iAlmWorkorderValue.setResult(orderDetail.getString("result"));
						if(orderDetail.has("opinion"))
							iAlmWorkorderValue.setOpinion(orderDetail.getString("opinion"));
					}else
					{
						iAlmWorkorderValue = iAlmWorkorderSV.queryWorkOrderById(orderId);
						if(orderDetail.has("conds"))
							iAlmWorkorderValue.setCond(orderDetail.getString("conds"));
						if(orderDetail.has("result"))
							iAlmWorkorderValue.setResult(orderDetail.getString("result"));
						if(orderDetail.has("opinion"))
							iAlmWorkorderValue.setOpinion(orderDetail.getString("opinion"));
					}
					orders.add(iAlmWorkorderValue);
				}
				
				if(testPlan != null)//遍历测试计划JSONObject
				{
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
					String planId = "";
					if(testPlan.has("planId"))
						planId = testPlan.getString("planId");
					IBOAigaTestPlanValue iBOAigaTestPlanValue = new BOAigaTestPlanBean();
					if(planId == null || planId.equals(0) || planId.equals("") || planId.equals("null"))
					{
						if(testPlan.has("planTag"))
							iBOAigaTestPlanValue.setPlanTag(testPlan.getString("planTag"));
						iBOAigaTestPlanValue.setCreateTime(ServiceManager.getOpDateTime());
						if(testPlan.has("beginTime"))
						{
							if( testPlan.getString("beginTime") != null && !testPlan.getString("beginTime").equals("null") && !testPlan.getString("beginTime").equals(""))
							{
								Date date;
								date = formatter1.parse(testPlan.getString("beginTime")); 
								String time = formatter.format(date);
								Timestamp begindate = Timestamp.valueOf(time);
								iBOAigaTestPlanValue.setBeginTime(begindate);
							}
						}
						if(testPlan.has("plCompleteTime"))
						{
							if(testPlan.getString("plCompleteTime") != null && !testPlan.getString("plCompleteTime").equals("null") && !testPlan.getString("plCompleteTime").equals(""))
							{
								Date date;
								date = formatter1.parse(testPlan.getString("plCompleteTime").toString()); 
								String time = formatter.format(date);
								Timestamp plCompleteTime = Timestamp.valueOf(time);
								iBOAigaTestPlanValue.setPlCompleteTime(plCompleteTime);
							}
						}
						if(testPlan.has("factCompleteTime"))
						{
							if(testPlan.getString("factCompleteTime") != null && !testPlan.getString("factCompleteTime").equals("null") && !testPlan.getString("factCompleteTime").equals(""))
							{
								Date date;
								date = formatter1.parse(testPlan.getString("factCompleteTime")); 
								String time = formatter.format(date);
								Timestamp factCompleteTime = Timestamp.valueOf(time);
								iBOAigaTestPlanValue.setFactCompleteTime(factCompleteTime);
							}
						}
						if(testPlan.has("codeCommitDate"))
						{
							if( testPlan.getString("codeCommitDate") != null && !testPlan.getString("codeCommitDate").equals("null") && !testPlan.getString("codeCommitDate").equals(""))
							{
								Date date;
								date = formatter1.parse(testPlan.getString("codeCommitDate")); 
								String time = formatter.format(date);
								Timestamp codeCommitDate = Timestamp.valueOf(time);
								iBOAigaTestPlanValue.setCodeCommitDate(codeCommitDate);
							}
						}
						
						if(testPlan.has("reqTime"))
						{
							if(testPlan.getString("reqTime") != null && !testPlan.getString("reqTime").equals("null") && !testPlan.getString("reqTime").equals(""))
							{
								Date date;
								date = formatter1.parse(testPlan.getString("reqTime")); 
								String time = formatter.format(date);
								Timestamp reqTime = Timestamp.valueOf(time);
								iBOAigaTestPlanValue.setReqTime(reqTime);
							}
						}
						
						if(testPlan.has("bigType"))
							if(testPlan.has("bigType") && testPlan.getString("bigType") != null && !testPlan.getString("bigType").equals("null") && !testPlan.getString("bigType").equals(""))
								iBOAigaTestPlanValue.setBigType(Long.valueOf(testPlan.getString("bigType")));

						if(testPlan.has("isSecurityTest"))
						{
							if(testPlan.getString("isSecurityTest")==null||testPlan.getString("isSecurityTest").equals("")||testPlan.getString("isSecurityTest").equals("false"))
								iBOAigaTestPlanValue.setIsSecurityTest(0);
							else if(testPlan.getString("isSecurityTest").equals("true"))
								iBOAigaTestPlanValue.setIsSecurityTest(1);
						}
						if(testPlan.has("isCodeScan"))
						{
							if(testPlan.getString("isCodeScan")==null||testPlan.getString("isCodeScan").equals("")||testPlan.getString("isCodeScan").equals("false"))
								iBOAigaTestPlanValue.setIsCodeScan(0);
							else if(testPlan.getString("isCodeScan").equals("true"))
								iBOAigaTestPlanValue.setIsCodeScan(1);
						}
						if(testPlan.has("isRegressionTest"))
						{
							if(testPlan.getString("isRegressionTest")==null||testPlan.getString("isRegressionTest").equals("")||testPlan.getString("isRegressionTest").equals("false"))
								iBOAigaTestPlanValue.setIsRegressionTest(0);
							else if(testPlan.getString("isRegressionTest").equals("true"))
								iBOAigaTestPlanValue.setIsRegressionTest(1);
						}
						
						if(testPlan.has("isHwergressionTest"))
						{
							if(testPlan.getString("isHwergressionTest")==null||testPlan.getString("isHwergressionTest").equals("")||testPlan.getString("isHwergressionTest").equals("false"))
								iBOAigaTestPlanValue.setIsHwregressionTest(0);
							else if(testPlan.getString("isHwergressionTest").equals("true"))
								iBOAigaTestPlanValue.setIsHwregressionTest(1);
						}
						
						if(testPlan.has("isPerformanceTest"))
						{
							if(testPlan.getString("isPerformanceTest")==null||testPlan.getString("isPerformanceTest").equals("") ||testPlan.getString("isPerformanceTest").equals("false"))
								iBOAigaTestPlanValue.setIsPerformanceTest(0);
							else if(testPlan.getString("isPerformanceTest").equals("true"))
								iBOAigaTestPlanValue.setIsPerformanceTest(1);
						}
						
						if(testPlan.has("versionContent"))
							if(testPlan.has("versionContent") && testPlan.getString("versionContent") != null && !testPlan.getString("versionContent").equals("null") && !testPlan.getString("versionContent").equals(""))
								iBOAigaTestPlanValue.setVersionContent(Long.valueOf(testPlan.getString("versionContent")));
						
						if(testPlan.has("planStatus"))
							if(testPlan.has("planStatus") && testPlan.getString("planStatus") != null && !testPlan.getString("planStatus").equals("null") && !testPlan.getString("planStatus").equals(""))
								iBOAigaTestPlanValue.setPlanStatus(Long.valueOf(testPlan.getString("planStatus")));
						if(testPlan.has("planPhase"))
							if(testPlan.has("planPhase") && testPlan.getString("planPhase") != null && !testPlan.getString("planPhase").equals("null") && !testPlan.getString("planPhase").equals(""))
								iBOAigaTestPlanValue.setPlanPhase(Long.valueOf(testPlan.getString("planStatus")));
						if(testPlan.has("onLineType"))
							if(testPlan.has("onLineType") && testPlan.getString("onLineType") != null && !testPlan.getString("onLineType").equals("null") && !testPlan.getString("onLineType").equals(""))
								iBOAigaTestPlanValue.setOnLineType(Long.valueOf(testPlan.getString("onLineType")));
						
						
						if(testPlan.has("planName"))
							iBOAigaTestPlanValue.setPlanName(testPlan.getString("planName"));
						if(testPlan.has("planDscr"))
							iBOAigaTestPlanValue.setPlanDscr(testPlan.getString("planDscr"));
						if(testPlan.has("changeReason"))
							iBOAigaTestPlanValue.setChangeReason(testPlan.getString("changeReason"));

						if(testPlan.has("submitStaffId"))
							iBOAigaTestPlanValue.setSubmitStaffId(Long.valueOf(testPlan.getString("submitStaffId")));
						if(testPlan.has("submitStaffName"))
							iBOAigaTestPlanValue.setSubmitStaffName(testPlan.getString("submitStaffName"));			
					}else
					{
						iBOAigaTestPlanValue = iAigaTestPlanSV.getAigaTestPlanByPlanId(planId);
						
						
						if(testPlan.has("beginTime"))
						{
							if( testPlan.getString("beginTime") != null && !testPlan.getString("beginTime").equals("null") && !testPlan.getString("beginTime").equals(""))
							{
								Date date;
								date = formatter1.parse(testPlan.getString("beginTime")); 
								String time = formatter.format(date);
								Timestamp begindate = Timestamp.valueOf(time);
								iBOAigaTestPlanValue.setBeginTime(begindate);
							}
						}
						if(testPlan.has("plCompleteTime"))
						{
							if(testPlan.getString("plCompleteTime") != null && !testPlan.getString("plCompleteTime").equals("null") && !testPlan.getString("plCompleteTime").equals(""))
							{
								Date date;
								date = formatter1.parse(testPlan.getString("plCompleteTime").toString()); 
								String time = formatter.format(date);
								Timestamp plCompleteTime = Timestamp.valueOf(time);
								iBOAigaTestPlanValue.setPlCompleteTime(plCompleteTime);
							}
						}
						if(testPlan.has("factCompleteTime"))
						{
							if(testPlan.getString("factCompleteTime") != null && !testPlan.getString("factCompleteTime").equals("null") && !testPlan.getString("factCompleteTime").equals(""))
							{
								Date date;
								date = formatter1.parse(testPlan.getString("factCompleteTime")); 
								String time = formatter.format(date);
								Timestamp factCompleteTime = Timestamp.valueOf(time);
								iBOAigaTestPlanValue.setFactCompleteTime(factCompleteTime);
							}
						}
						if(testPlan.has("codeCommitDate"))
						{
							if( testPlan.getString("codeCommitDate") != null && !testPlan.getString("codeCommitDate").equals("null") && !testPlan.getString("codeCommitDate").equals(""))
							{
								Date date;
								date = formatter1.parse(testPlan.getString("codeCommitDate")); 
								String time = formatter.format(date);
								Timestamp codeCommitDate = Timestamp.valueOf(time);
								iBOAigaTestPlanValue.setCodeCommitDate(codeCommitDate);
							}
						}
						
						if(testPlan.has("reqTime"))
						{
							if(testPlan.getString("reqTime") != null && !testPlan.getString("reqTime").equals("null") && !testPlan.getString("reqTime").equals(""))
							{
								Date date;
								date = formatter1.parse(testPlan.getString("reqTime")); 
								String time = formatter.format(date);
								Timestamp reqTime = Timestamp.valueOf(time);
								iBOAigaTestPlanValue.setReqTime(reqTime);
							}
						}
						
						if(testPlan.has("bigType"))
							if(testPlan.has("bigType") && testPlan.getString("bigType") != null && !testPlan.getString("bigType").equals("null") && !testPlan.getString("bigType").equals(""))
								iBOAigaTestPlanValue.setBigType(Long.valueOf(testPlan.getString("bigType")));

						if(testPlan.has("isSecurityTest"))
						{
							if(testPlan.getString("isSecurityTest")==null||testPlan.getString("isSecurityTest").equals("")||testPlan.getString("isSecurityTest").equals("false"))
								iBOAigaTestPlanValue.setIsSecurityTest(0);
							else if(testPlan.getString("isSecurityTest").equals("true"))
								iBOAigaTestPlanValue.setIsSecurityTest(1);
						}
						if(testPlan.has("isCodeScan"))
						{
							if(testPlan.getString("isCodeScan")==null||testPlan.getString("isCodeScan").equals("")||testPlan.getString("isCodeScan").equals("false"))
								iBOAigaTestPlanValue.setIsCodeScan(0);
							else if(testPlan.getString("isCodeScan").equals("true"))
								iBOAigaTestPlanValue.setIsCodeScan(1);
						}
						if(testPlan.has("isRegressionTest"))
						{
							if(testPlan.getString("isRegressionTest")==null||testPlan.getString("isRegressionTest").equals("")||testPlan.getString("isRegressionTest").equals("false"))
								iBOAigaTestPlanValue.setIsRegressionTest(0);
							else if(testPlan.getString("isRegressionTest").equals("true"))
								iBOAigaTestPlanValue.setIsRegressionTest(1);
						}
						
						if(testPlan.has("isHwergressionTest"))
						{
							if(testPlan.getString("isHwergressionTest")==null||testPlan.getString("isHwergressionTest").equals("")||testPlan.getString("isHwergressionTest").equals("false"))
								iBOAigaTestPlanValue.setIsHwregressionTest(0);
							else if(testPlan.getString("isHwergressionTest").equals("true"))
								iBOAigaTestPlanValue.setIsHwregressionTest(1);
						}
						
						if(testPlan.has("isPerformanceTest"))
						{
							if(testPlan.getString("isPerformanceTest")==null||testPlan.getString("isPerformanceTest").equals("") ||testPlan.getString("isPerformanceTest").equals("false"))
								iBOAigaTestPlanValue.setIsPerformanceTest(0);
							else if(testPlan.getString("isPerformanceTest").equals("true"))
								iBOAigaTestPlanValue.setIsPerformanceTest(1);
						}
						
						if(testPlan.has("versionContent"))
							if(testPlan.has("versionContent") && testPlan.getString("versionContent") != null && !testPlan.getString("versionContent").equals("null") && !testPlan.getString("versionContent").equals(""))
								iBOAigaTestPlanValue.setVersionContent(Long.valueOf(testPlan.getString("versionContent")));
						
						if(testPlan.has("planStatus"))
							if(testPlan.has("planStatus") && testPlan.getString("planStatus") != null && !testPlan.getString("planStatus").equals("null") && !testPlan.getString("planStatus").equals(""))
								iBOAigaTestPlanValue.setPlanStatus(Long.valueOf(testPlan.getString("planStatus")));
						if(testPlan.has("planPhase"))
							if(testPlan.has("planPhase") && testPlan.getString("planPhase") != null && !testPlan.getString("planPhase").equals("null") && !testPlan.getString("planPhase").equals(""))
								iBOAigaTestPlanValue.setPlanPhase(Long.valueOf(testPlan.getString("planStatus")));
						if(testPlan.has("onLineType"))
							if(testPlan.has("onLineType") && testPlan.getString("onLineType") != null && !testPlan.getString("onLineType").equals("null") && !testPlan.getString("onLineType").equals(""))
								iBOAigaTestPlanValue.setOnLineType(Long.valueOf(testPlan.getString("onLineType")));
						
						
						if(testPlan.has("planName"))
							iBOAigaTestPlanValue.setPlanName(testPlan.getString("planName"));
						if(testPlan.has("planDscr"))
							iBOAigaTestPlanValue.setPlanDscr(testPlan.getString("planDscr"));
						if(testPlan.has("changeReason"))
							iBOAigaTestPlanValue.setChangeReason(testPlan.getString("changeReason"));

						if(testPlan.has("submitStaffId"))
							iBOAigaTestPlanValue.setSubmitStaffId(Long.valueOf(testPlan.getString("submitStaffId")));
						if(testPlan.has("submitStaffName"))
							iBOAigaTestPlanValue.setSubmitStaffName(testPlan.getString("submitStaffName"));	
					}
					atps.add(iBOAigaTestPlanValue);
				}
				
				if(testTask != null)//遍历测试任务JSONObject
				{
					String taskId = "";
					if(testTask.has("taskId"))
						taskId = testTask.getString("taskId");
					IBOAigaTestTaskValue iBOAigaTestTaskValue = new BOAigaTestTaskBean();
					
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
					
					if(taskId == null || taskId.equals(0) || taskId.equals("") || taskId.equals("null"))
					{
						if(testTask.has("taskTag"))
							iBOAigaTestTaskValue.setTaskTag(testTask.getString("taskTag"));
						iBOAigaTestTaskValue.setCreateTime(ServiceManager.getOpDateTime());

						if(testTask.has("taskName"))
							if(testTask.has("taskName") && testTask.getString("taskName") != null && !testTask.getString("taskName").equals("null") && !testTask.getString("taskName").equals(""))
								iBOAigaTestTaskValue.setTaskName(testTask.getString("taskName"));
						
						if(testTask.has("testType"))
							if(testTask.has("testType") && testTask.getString("testType") != null && !testTask.getString("testType").equals("null") && !testTask.getString("testType").equals(""))
								iBOAigaTestTaskValue.setTestType(Long.valueOf(testTask.getString("testType")));
						
						if(testTask.has("planId"))
							if(testTask.has("planId") && testTask.getString("planId") != null && !testTask.getString("planId").equals("null") && !testTask.getString("planId").equals(""))
								iBOAigaTestTaskValue.setPlanId(Long.valueOf(testTask.getString("planId")));
						if(testTask.has("planTag"))
							if(testTask.has("planTag") && testTask.getString("planTag") != null && !testTask.getString("planTag").equals("null") && !testTask.getString("planTag").equals(""))
								iBOAigaTestTaskValue.setPlanTag(testTask.getString("planTag"));
						
						if(testTask.has("taskPhase"))
							if(testTask.has("taskPhase") && testTask.getString("taskPhase") != null && !testTask.getString("taskPhase").equals("null") && !testTask.getString("taskPhase").equals(""))
								iBOAigaTestTaskValue.setTaskPhase(Long.valueOf(testTask.getString("taskPhase")));
						
						if(testTask.has("currentStatus"))
							if(testTask.has("currentStatus") && testTask.getString("currentStatus") != null && !testTask.getString("currentStatus").equals("null") && !testTask.getString("currentStatus").equals(""))
								iBOAigaTestTaskValue.setCurrentStatus(Long.valueOf(testTask.getString("currentStatus")));
						
						if(testTask.has("priority"))
							if(testTask.has("priority") && testTask.getString("priority") != null && !testTask.getString("priority").equals("null") && !testTask.getString("priority").equals(""))
								iBOAigaTestTaskValue.setPriority(Long.valueOf(testTask.getString("priority")));
						
						if(testTask.has("reqTag"))
							if(testTask.has("reqTag") && testTask.getString("reqTag") != null && !testTask.getString("reqTag").equals("null") && !testTask.getString("reqTag").equals(""))
								iBOAigaTestTaskValue.setReqTag(testTask.getString("reqTag"));
						
						if(testTask.has("devTag"))
							if(testTask.has("devTag") && testTask.getString("devTag") != null && !testTask.getString("devTag").equals("null") && !testTask.getString("devTag").equals(""))
								iBOAigaTestTaskValue.setDevTag(testTask.getString("devTag"));
						

						if(testTask.has("reqPersion"))
							if(testTask.has("reqPersion") && testTask.getString("reqPersion") != null && !testTask.getString("reqPersion").equals("null") && !testTask.getString("reqPersion").equals(""))
								iBOAigaTestTaskValue.setReqPersion(testTask.getString("reqPersion"));
						
						
						if(testTask.has("distributeStaffid"))
							if(testTask.has("distributeStaffid") && testTask.getString("distributeStaffid") != null && !testTask.getString("distributeStaffid").equals("null") && !testTask.getString("distributeStaffid").equals(""))
								iBOAigaTestTaskValue.setDistributeStaffid(testTask.getString("distributeStaffid"));
						
						if(testTask.has("distributeStaffname"))
							if(testTask.has("distributeStaffname") && testTask.getString("distributeStaffname") != null && !testTask.getString("distributeStaffname").equals("null") && !testTask.getString("distributeStaffname").equals(""))
								iBOAigaTestTaskValue.setDistributeStaffname(testTask.getString("distributeStaffname"));
						
						if(testTask.has("isImportanceReq"))
						{
							if(testTask.getString("isImportanceReq")==null||testTask.getString("isImportanceReq").equals("")||testTask.getString("isImportanceReq").equals("false"))
								iBOAigaTestTaskValue.setIsImportanceReq(0);
							else if(testTask.getString("isImportanceReq").equals("true"))
								iBOAigaTestTaskValue.setIsImportanceReq(1);
						}
						
						if(testTask.has("subType"))
							if(testTask.has("subType") && testTask.getString("subType") != null && !testTask.getString("subType").equals("null") && !testTask.getString("subType").equals(""))
								iBOAigaTestTaskValue.setSubType(Long.valueOf(testTask.getString("subType")));
						
						if(testTask.has("bigType"))
							if(testTask.has("bigType") && testTask.getString("bigType") != null && !testTask.getString("bigType").equals("null") && !testTask.getString("bigType").equals(""))
								iBOAigaTestTaskValue.setBigType(Long.valueOf(testTask.getString("bigType")));

						if(testTask.has("devWorkDay"))
							if(testTask.has("devWorkDay") && testTask.getString("devWorkDay") != null && !testTask.getString("devWorkDay").equals("null") && !testTask.getString("devWorkDay").equals(""))
								iBOAigaTestTaskValue.setDevWorkDay(testTask.getString("devWorkDay"));
						
						if(testTask.has("testWorkDay"))
							if(testTask.has("testWorkDay") && testTask.getString("testWorkDay") != null && !testTask.getString("testWorkDay").equals("null") && !testTask.getString("testWorkDay").equals(""))
								iBOAigaTestTaskValue.setTestWorkDay(testTask.getString("testWorkDay"));
						
						if(testTask.has("devFirm"))
							if(testTask.has("devFirm") && testTask.getString("devFirm") != null && !testTask.getString("devFirm").equals("null") && !testTask.getString("devFirm").equals(""))
								iBOAigaTestTaskValue.setDevFirm(Long.valueOf(testTask.getString("devFirm")));
						
						if(testTask.has("testFirm"))
							if(testTask.has("testFirm") && testTask.getString("testFirm") != null && !testTask.getString("testFirm").equals("null") && !testTask.getString("testFirm").equals(""))
								iBOAigaTestTaskValue.setTestFirm(Long.valueOf(testTask.getString("testFirm")));

						if(testTask.has("initialSituation"))
							if(testTask.has("initialSituation") && testTask.getString("initialSituation") != null && !testTask.getString("initialSituation").equals("null") && !testTask.getString("initialSituation").equals(""))
								iBOAigaTestTaskValue.setInitialSituation(testTask.getString("initialSituation"));
						if(testTask.has("factCompleteTime"))
						{
							if( testTask.getString("factCompleteTime") != null && !testTask.getString("factCompleteTime").equals("null") && !testTask.getString("factCompleteTime").equals(""))
							{
								Timestamp ts = new Timestamp(System.currentTimeMillis());   
								String tsStr = testTask.getString("factCompleteTime") + " 00:00:00"; 
								ts = Timestamp.valueOf(tsStr);   
								iBOAigaTestTaskValue.setFactCompleteTime(ts);
							}
						}
						if(testTask.has("submitStaffId"))
							if(testTask.has("submitStaffId") && testTask.getString("submitStaffId") != null && !testTask.getString("submitStaffId").equals("null") && !testTask.getString("submitStaffId").equals(""))
								iBOAigaTestTaskValue.setSubmitStaffId(Long.valueOf(testTask.getString("submitStaffId")));
						
						if(testTask.has("submitStaffName"))
							if(testTask.has("submitStaffName") && testTask.getString("submitStaffName") != null && !testTask.getString("submitStaffName").equals("null") && !testTask.getString("submitStaffName").equals(""))
								iBOAigaTestTaskValue.setSubmitStaffName(testTask.getString("submitStaffName"));
						if(testTask.has("reqType"))
							if(testTask.has("reqType") && testTask.getString("reqType") != null && !testTask.getString("reqType").equals("null") && !testTask.getString("reqType").equals(""))
								iBOAigaTestTaskValue.setReqType(testTask.getString("reqType"));
						
					}else
					{
						iBOAigaTestTaskValue = iAigaTestTaskSV.getAigaTestTaskByTaskId(taskId);

						if(testTask.has("taskTag"))
							iBOAigaTestTaskValue.setTaskTag(testTask.getString("taskTag"));
						iBOAigaTestTaskValue.setCreateTime(ServiceManager.getOpDateTime());

						if(testTask.has("taskName"))
							if(testTask.has("taskName") && testTask.getString("taskName") != null && !testTask.getString("taskName").equals("null") && !testTask.getString("taskName").equals(""))
								iBOAigaTestTaskValue.setTaskName(testTask.getString("taskName"));
						
						if(testTask.has("testType"))
							if(testTask.has("testType") && testTask.getString("testType") != null && !testTask.getString("testType").equals("null") && !testTask.getString("testType").equals(""))
								iBOAigaTestTaskValue.setTestType(Long.valueOf(testTask.getString("testType")));
						
						if(testTask.has("planId"))
							if(testTask.has("planId") && testTask.getString("planId") != null && !testTask.getString("planId").equals("null") && !testTask.getString("planId").equals(""))
								iBOAigaTestTaskValue.setPlanId(Long.valueOf(testTask.getString("planId")));
						if(testTask.has("planTag"))
							if(testTask.has("planTag") && testTask.getString("planTag") != null && !testTask.getString("planTag").equals("null") && !testTask.getString("planTag").equals(""))
								iBOAigaTestTaskValue.setPlanTag(testTask.getString("planTag"));
						
						
						if(testTask.has("taskPhase"))
							if(testTask.has("taskPhase") && testTask.getString("taskPhase") != null && !testTask.getString("taskPhase").equals("null") && !testTask.getString("taskPhase").equals(""))
								iBOAigaTestTaskValue.setTaskPhase(Long.valueOf(testTask.getString("taskPhase")));
						
						if(testTask.has("currentStatus"))
							if(testTask.has("currentStatus") && testTask.getString("currentStatus") != null && !testTask.getString("currentStatus").equals("null") && !testTask.getString("currentStatus").equals(""))
								iBOAigaTestTaskValue.setCurrentStatus(Long.valueOf(testTask.getString("currentStatus")));
						
						if(testTask.has("priority"))
							if(testTask.has("priority") && testTask.getString("priority") != null && !testTask.getString("priority").equals("null") && !testTask.getString("priority").equals(""))
								iBOAigaTestTaskValue.setPriority(Long.valueOf(testTask.getString("priority")));
						
						if(testTask.has("reqTag"))
							if(testTask.has("reqTag") && testTask.getString("reqTag") != null && !testTask.getString("reqTag").equals("null") && !testTask.getString("reqTag").equals(""))
								iBOAigaTestTaskValue.setReqTag(testTask.getString("reqTag"));
						
						if(testTask.has("devTag"))
							if(testTask.has("devTag") && testTask.getString("devTag") != null && !testTask.getString("devTag").equals("null") && !testTask.getString("devTag").equals(""))
								iBOAigaTestTaskValue.setDevTag(testTask.getString("devTag"));
						

						if(testTask.has("reqPersion"))
							if(testTask.has("reqPersion") && testTask.getString("reqPersion") != null && !testTask.getString("reqPersion").equals("null") && !testTask.getString("reqPersion").equals(""))
								iBOAigaTestTaskValue.setReqPersion(testTask.getString("reqPersion"));
						
						
						if(testTask.has("distributeStaffid"))
							if(testTask.has("distributeStaffid") && testTask.getString("distributeStaffid") != null && !testTask.getString("distributeStaffid").equals("null") && !testTask.getString("distributeStaffid").equals(""))
								iBOAigaTestTaskValue.setDistributeStaffid(testTask.getString("distributeStaffid"));
						
						if(testTask.has("distributeStaffname"))
							if(testTask.has("distributeStaffname") && testTask.getString("distributeStaffname") != null && !testTask.getString("distributeStaffname").equals("null") && !testTask.getString("distributeStaffname").equals(""))
								iBOAigaTestTaskValue.setDistributeStaffid(testTask.getString("distributeStaffname"));
						
						if(testTask.has("importanceReq"))
						{
							if(testTask.getString("importanceReq")==null||testTask.getString("importanceReq").equals("")||testTask.getString("importanceReq").equals("false"))
								iBOAigaTestTaskValue.setIsImportanceReq(0);
							else if(testTask.getString("importanceReq").equals("true"))
								iBOAigaTestTaskValue.setIsImportanceReq(1);
						}
						
						if(testTask.has("bigType"))
							if(testTask.has("bigType") && testTask.getString("bigType") != null && !testTask.getString("bigType").equals("null") && !testTask.getString("bigType").equals(""))
								iBOAigaTestTaskValue.setBigType(Long.valueOf(testTask.getString("bigType")));

						if(testTask.has("devWorkDay"))
							if(testTask.has("devWorkDay") && testTask.getString("devWorkDay") != null && !testTask.getString("devWorkDay").equals("null") && !testTask.getString("devWorkDay").equals(""))
								iBOAigaTestTaskValue.setDevWorkDay(testTask.getString("devWorkDay"));
						
						if(testTask.has("testWorkDay"))
							if(testTask.has("testWorkDay") && testTask.getString("testWorkDay") != null && !testTask.getString("testWorkDay").equals("null") && !testTask.getString("testWorkDay").equals(""))
								iBOAigaTestTaskValue.setTestWorkDay(testTask.getString("testWorkDay"));
						
						if(testTask.has("devFirm"))
							if(testTask.has("devFirm") && testTask.getString("devFirm") != null && !testTask.getString("devFirm").equals("null") && !testTask.getString("devFirm").equals(""))
								iBOAigaTestTaskValue.setDevFirm(Long.valueOf(testTask.getString("devFirm")));
						
						if(testTask.has("testFirm"))
							if(testTask.has("testFirm") && testTask.getString("testFirm") != null && !testTask.getString("testFirm").equals("null") && !testTask.getString("testFirm").equals(""))
								iBOAigaTestTaskValue.setTestFirm(Long.valueOf(testTask.getString("testFirm")));

						if(testTask.has("initialSituation"))
							if(testTask.has("initialSituation") && testTask.getString("initialSituation") != null && !testTask.getString("initialSituation").equals("null") && !testTask.getString("initialSituation").equals(""))
								iBOAigaTestTaskValue.setInitialSituation(testTask.getString("initialSituation"));
					
						if(testTask.has("factCompleteTime"))
						{
							if( testTask.getString("factCompleteTime") != null && !testTask.getString("factCompleteTime").equals("null") && !testTask.getString("factCompleteTime").equals(""))
							{
								Timestamp ts = new Timestamp(System.currentTimeMillis());   
								String tsStr = testTask.getString("factCompleteTime") + " 00:00:00"; 
								ts = Timestamp.valueOf(tsStr);   
								iBOAigaTestTaskValue.setFactCompleteTime(ts);
							}
						}
						if(testTask.has("submitStaffId"))
							if(testTask.has("submitStaffId") && testTask.getString("submitStaffId") != null && !testTask.getString("submitStaffId").equals("null") && !testTask.getString("submitStaffId").equals(""))
								iBOAigaTestTaskValue.setSubmitStaffId(Long.valueOf(testTask.getString("submitStaffId")));
						if(testTask.has("reqType"))
							if(testTask.has("reqType") && testTask.getString("reqType") != null && !testTask.getString("reqType").equals("null") && !testTask.getString("reqType").equals(""))
								iBOAigaTestTaskValue.setReqType(testTask.getString("reqType"));
						if(testTask.has("submitStaffName"))
							if(testTask.has("submitStaffName") && testTask.getString("submitStaffName") != null && !testTask.getString("submitStaffName").equals("null") && !testTask.getString("submitStaffName").equals(""))
								iBOAigaTestTaskValue.setSubmitStaffName(testTask.getString("submitStaffName"));
					}
					attasks.add(iBOAigaTestTaskValue);
				}
				
				if(perfSubTask != null)//遍历性能测试子任务JSONObject
				{
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
					String subTaskId = "";
					if(perfSubTask.has("subTaskId"))
						subTaskId = perfSubTask.getString("subTaskId");
					IBOAigaTestSubTaskValue iBOAigaTestSubTaskValue = new BOAigaTestSubTaskBean();
					if(subTaskId == null || subTaskId.equals(0) || subTaskId.equals("") || subTaskId.equals("null"))
					{
						if(perfSubTask.has("subTaskTag"))
							iBOAigaTestSubTaskValue.setSubTaskTag(testTask.getString("subTaskTag"));
						iBOAigaTestSubTaskValue.setCreateTime(ServiceManager.getOpDateTime());

						if(perfSubTask.has("subTaskName"))
							if(perfSubTask.has("subTaskName") && perfSubTask.getString("subTaskName") != null && !perfSubTask.getString("subTaskName").equals("null") && !perfSubTask.getString("subTaskName").equals(""))
								iBOAigaTestSubTaskValue.setSubTaskName(testTask.getString("subTaskName"));

						if(perfSubTask.has("taskId"))
							if(perfSubTask.has("taskId") && perfSubTask.getString("taskId") != null && !perfSubTask.getString("taskId").equals("null") && !perfSubTask.getString("taskId").equals(""))
								iBOAigaTestSubTaskValue.setTaskId(Long.valueOf(perfSubTask.getString("taskId")));
						
						if(perfSubTask.has("reqTag"))
							if(perfSubTask.has("reqTag") && perfSubTask.getString("reqTag") != null && !perfSubTask.getString("reqTag").equals("null") && !perfSubTask.getString("reqTag").equals(""))
								iBOAigaTestSubTaskValue.setReqTag(perfSubTask.getString("reqTag"));
						
						if(perfSubTask.has("submitStaffId"))
							if(perfSubTask.has("submitStaffId") && perfSubTask.getString("submitStaffId") != null && !perfSubTask.getString("submitStaffId").equals("null") && !perfSubTask.getString("submitStaffId").equals(""))
								iBOAigaTestSubTaskValue.setSubmitStaffId(Long.valueOf(perfSubTask.getString("submitStaffId")));
						
						if(perfSubTask.has("submitStaffName"))
							if(perfSubTask.has("submitStaffName") && perfSubTask.getString("submitStaffName") != null && !perfSubTask.getString("submitStaffName").equals("null") && !perfSubTask.getString("submitStaffName").equals(""))
								iBOAigaTestSubTaskValue.setSubmitStaffName(perfSubTask.getString("submitStaffName"));

						if(perfSubTask.has("factCompleteTime"))
						{
							if(perfSubTask.getString("factCompleteTime") != null && !perfSubTask.getString("factCompleteTime").equals("null") && !perfSubTask.getString("factCompleteTime").equals(""))
							{
								Date date;
								date = formatter1.parse(perfSubTask.getString("factCompleteTime")); 
								String time = formatter.format(date);
								Timestamp factCompleteTime = Timestamp.valueOf(time);
								iBOAigaTestSubTaskValue.setFactCompleteTime(factCompleteTime);
							}
						}
						
						if(perfSubTask.has("plCompleteTime"))
						{
							if(perfSubTask.getString("plCompleteTime") != null && !perfSubTask.getString("plCompleteTime").equals("null") && !perfSubTask.getString("plCompleteTime").equals(""))
							{
								Date date;
								date = formatter1.parse(perfSubTask.getString("plCompleteTime")); 
								String time = formatter.format(date);
								Timestamp factCompleteTime = Timestamp.valueOf(time);
								iBOAigaTestSubTaskValue.setPlCompleteTime(factCompleteTime);
							}
						}
						
//						if(perfSubTask.has("subTaskType"))
//							if(perfSubTask.has("subTaskType") && perfSubTask.getString("subTaskType") != null && !perfSubTask.getString("subTaskType").equals("null") && !perfSubTask.getString("subTaskType").equals(""))
//								iBOAigaTestSubTaskValue.setSubTaskType(Integer.valueOf(perfSubTask.getString("subTaskType")));
						iBOAigaTestSubTaskValue.setSubTaskType(6);
						if(perfSubTask.has("curPhase"))
							if(perfSubTask.has("curPhase") && perfSubTask.getString("curPhase") != null && !perfSubTask.getString("curPhase").equals("null") && !perfSubTask.getString("curPhase").equals(""))
								iBOAigaTestSubTaskValue.setCurPhase(Integer.valueOf(perfSubTask.getString("curPhase")));
						if(perfSubTask.has("subTaskStatus"))
							if(perfSubTask.has("subTaskStatus") && perfSubTask.getString("subTaskStatus") != null && !perfSubTask.getString("subTaskStatus").equals("null") && !perfSubTask.getString("subTaskStatus").equals(""))
								iBOAigaTestSubTaskValue.setSubTaskStatus(Integer.valueOf(perfSubTask.getString("subTaskStatus")));
						if(perfSubTask.has("subTaskPriority"))
							if(perfSubTask.has("subTaskPriority") && perfSubTask.getString("subTaskPriority") != null && !perfSubTask.getString("subTaskPriority").equals("null") && !perfSubTask.getString("subTaskPriority").equals(""))
								iBOAigaTestSubTaskValue.setSubTaskPriority(Integer.valueOf(perfSubTask.getString("subTaskPriority")));
						
						if(perfSubTask.has("creatorStaff"))
							if(perfSubTask.has("creatorStaff") && perfSubTask.getString("creatorStaff") != null && !perfSubTask.getString("creatorStaff").equals("null") && !perfSubTask.getString("creatorStaff").equals(""))
								iBOAigaTestSubTaskValue.setCreatorStaff(perfSubTask.getString("creatorStaff"));
						if(perfSubTask.has("creator"))
							if(perfSubTask.has("creator") && perfSubTask.getString("creator") != null && !perfSubTask.getString("creator").equals("null") && !perfSubTask.getString("creator").equals(""))
								iBOAigaTestSubTaskValue.setCreator(perfSubTask.getString("creator"));
						
						if(perfSubTask.has("testorId"))
							if(perfSubTask.has("testorId") && perfSubTask.getString("testorId") != null && !perfSubTask.getString("testorId").equals("null") && !perfSubTask.getString("testorId").equals(""))
								iBOAigaTestSubTaskValue.setTestorId(Long.valueOf(perfSubTask.getString("testorId")));
						if(perfSubTask.has("testorName"))
							if(perfSubTask.has("testorName") && perfSubTask.getString("testorName") != null && !perfSubTask.getString("testorName").equals("null") && !perfSubTask.getString("testorName").equals(""))
								iBOAigaTestSubTaskValue.setTestorName(perfSubTask.getString("testorName"));
						
						if(perfSubTask.has("isPerformance"))
						{
							if(perfSubTask.getString("isPerformance")==null||perfSubTask.getString("isPerformance").equals("")||perfSubTask.getString("isPerformance").equals("false"))
								iBOAigaTestSubTaskValue.setIsPerformance(0);
							else if(perfSubTask.getString("isImportanceReq").equals("true"))
								iBOAigaTestSubTaskValue.setIsPerformance(1);
						}
						
						if(perfSubTask.has("possibleProduct"))
							if(perfSubTask.has("possibleProduct") && perfSubTask.getString("possibleProduct") != null && !perfSubTask.getString("possibleProduct").equals("null") && !perfSubTask.getString("possibleProduct").equals(""))
								iBOAigaTestSubTaskValue.setPossibleProduct(Integer.valueOf(perfSubTask.getString("possibleProduct")));
						if(perfSubTask.has("possibleBack"))
							if(perfSubTask.has("possibleBack") && perfSubTask.getString("possibleBack") != null && !perfSubTask.getString("possibleBack").equals("null") && !perfSubTask.getString("possibleBack").equals(""))
								iBOAigaTestSubTaskValue.setPossibleBack(Integer.valueOf(perfSubTask.getString("possibleBack")));
						
						if(perfSubTask.has("possibleTest"))
							if(perfSubTask.has("possibleTest") && perfSubTask.getString("possibleTest") != null && !perfSubTask.getString("possibleTest").equals("null") && !perfSubTask.getString("possibleTest").equals(""))
								iBOAigaTestSubTaskValue.setPossibleTest(Integer.valueOf(perfSubTask.getString("possibleTest")));
						
						if(perfSubTask.has("devWorkDay"))
							if(perfSubTask.has("devWorkDay") && perfSubTask.getString("devWorkDay") != null && !perfSubTask.getString("devWorkDay").equals("null") && !perfSubTask.getString("devWorkDay").equals(""))
								iBOAigaTestSubTaskValue.setDevWorkDay(perfSubTask.getString("devWorkDay"));
						
						if(perfSubTask.has("testWorkDay"))
							if(perfSubTask.has("testWorkDay") && perfSubTask.getString("testWorkDay") != null && !perfSubTask.getString("testWorkDay").equals("null") && !perfSubTask.getString("testWorkDay").equals(""))
								iBOAigaTestSubTaskValue.setTestWorkDay(perfSubTask.getString("testWorkDay"));
						
						if(perfSubTask.has("possibleProductReason"))
							if(perfSubTask.has("possibleProductReason") && perfSubTask.getString("possibleProductReason") != null && !perfSubTask.getString("possibleProductReason").equals("null") && !perfSubTask.getString("possibleProductReason").equals(""))
								iBOAigaTestSubTaskValue.setPossibleProductReason(perfSubTask.getString("possibleProductReason"));
						
						if(perfSubTask.has("possibleBackReason"))
							if(perfSubTask.has("possibleBackReason") && perfSubTask.getString("possibleBackReason") != null && !perfSubTask.getString("possibleBackReason").equals("null") && !perfSubTask.getString("possibleBackReason").equals(""))
								iBOAigaTestSubTaskValue.setPossibleBackReason(perfSubTask.getString("possibleBackReason"));
						
						if(perfSubTask.has("possibleTestReason"))
							if(perfSubTask.has("possibleTestReason") && perfSubTask.getString("possibleTestReason") != null && !perfSubTask.getString("possibleTestReason").equals("null") && !perfSubTask.getString("possibleTestReason").equals(""))
								iBOAigaTestSubTaskValue.setPossibleTestReason(perfSubTask.getString("possibleTestReason"));
								
					}else
					{
						iBOAigaTestSubTaskValue = iAigaTestSubTaskSV.getAigaTestSubTaskBySubTaskId(subTaskId);

						if(perfSubTask.has("subTaskTag"))
							iBOAigaTestSubTaskValue.setSubTaskTag(testTask.getString("subTaskTag"));
						iBOAigaTestSubTaskValue.setCreateTime(ServiceManager.getOpDateTime());

						if(perfSubTask.has("subTaskName"))
							if(perfSubTask.has("subTaskName") && perfSubTask.getString("subTaskName") != null && !perfSubTask.getString("subTaskName").equals("null") && !perfSubTask.getString("subTaskName").equals(""))
								iBOAigaTestSubTaskValue.setSubTaskName(testTask.getString("subTaskName"));

						if(perfSubTask.has("taskId"))
							if(perfSubTask.has("taskId") && perfSubTask.getString("taskId") != null && !perfSubTask.getString("taskId").equals("null") && !perfSubTask.getString("taskId").equals(""))
								iBOAigaTestSubTaskValue.setTaskId(Long.valueOf(perfSubTask.getString("taskId")));
						
						if(perfSubTask.has("reqTag"))
							if(perfSubTask.has("reqTag") && perfSubTask.getString("reqTag") != null && !perfSubTask.getString("reqTag").equals("null") && !perfSubTask.getString("reqTag").equals(""))
								iBOAigaTestSubTaskValue.setReqTag(perfSubTask.getString("reqTag"));
						
						if(perfSubTask.has("submitStaffId"))
							if(perfSubTask.has("submitStaffId") && perfSubTask.getString("submitStaffId") != null && !perfSubTask.getString("submitStaffId").equals("null") && !perfSubTask.getString("submitStaffId").equals(""))
								iBOAigaTestSubTaskValue.setSubmitStaffId(Long.valueOf(perfSubTask.getString("submitStaffId")));
						
						if(perfSubTask.has("submitStaffName"))
							if(perfSubTask.has("submitStaffName") && perfSubTask.getString("submitStaffName") != null && !perfSubTask.getString("submitStaffName").equals("null") && !perfSubTask.getString("submitStaffName").equals(""))
								iBOAigaTestSubTaskValue.setSubmitStaffName(perfSubTask.getString("submitStaffName"));

						if(perfSubTask.has("factCompleteTime"))
						{
							if(perfSubTask.getString("factCompleteTime") != null && !perfSubTask.getString("factCompleteTime").equals("null") && !perfSubTask.getString("factCompleteTime").equals(""))
							{
								Date date;
								date = formatter1.parse(perfSubTask.getString("factCompleteTime")); 
								String time = formatter.format(date);
								Timestamp factCompleteTime = Timestamp.valueOf(time);
								iBOAigaTestSubTaskValue.setFactCompleteTime(factCompleteTime);
							}
						}
						
						if(perfSubTask.has("plCompleteTime"))
						{
							if(perfSubTask.getString("plCompleteTime") != null && !perfSubTask.getString("plCompleteTime").equals("null") && !perfSubTask.getString("plCompleteTime").equals(""))
							{
								Date date;
								date = formatter1.parse(perfSubTask.getString("plCompleteTime")); 
								String time = formatter.format(date);
								Timestamp factCompleteTime = Timestamp.valueOf(time);
								iBOAigaTestSubTaskValue.setPlCompleteTime(factCompleteTime);
							}
						}
						
						if(perfSubTask.has("subTaskType"))
							if(perfSubTask.has("subTaskType") && perfSubTask.getString("subTaskType") != null && !perfSubTask.getString("subTaskType").equals("null") && !perfSubTask.getString("subTaskType").equals(""))
								iBOAigaTestSubTaskValue.setSubTaskType(Integer.valueOf(perfSubTask.getString("subTaskType")));
						
						if(perfSubTask.has("curPhase"))
							if(perfSubTask.has("curPhase") && perfSubTask.getString("curPhase") != null && !perfSubTask.getString("curPhase").equals("null") && !perfSubTask.getString("curPhase").equals(""))
								iBOAigaTestSubTaskValue.setCurPhase(Integer.valueOf(perfSubTask.getString("curPhase")));
						if(perfSubTask.has("subTaskStatus"))
							if(perfSubTask.has("subTaskStatus") && perfSubTask.getString("subTaskStatus") != null && !perfSubTask.getString("subTaskStatus").equals("null") && !perfSubTask.getString("subTaskStatus").equals(""))
								iBOAigaTestSubTaskValue.setSubTaskStatus(Integer.valueOf(perfSubTask.getString("subTaskStatus")));
						if(perfSubTask.has("subTaskPriority"))
							if(perfSubTask.has("subTaskPriority") && perfSubTask.getString("subTaskPriority") != null && !perfSubTask.getString("subTaskPriority").equals("null") && !perfSubTask.getString("subTaskPriority").equals(""))
								iBOAigaTestSubTaskValue.setSubTaskPriority(Integer.valueOf(perfSubTask.getString("subTaskPriority")));
						
						if(perfSubTask.has("creatorStaff"))
							if(perfSubTask.has("creatorStaff") && perfSubTask.getString("creatorStaff") != null && !perfSubTask.getString("creatorStaff").equals("null") && !perfSubTask.getString("creatorStaff").equals(""))
								iBOAigaTestSubTaskValue.setCreatorStaff(perfSubTask.getString("creatorStaff"));
						if(perfSubTask.has("creator"))
							if(perfSubTask.has("creator") && perfSubTask.getString("creator") != null && !perfSubTask.getString("creator").equals("null") && !perfSubTask.getString("creator").equals(""))
								iBOAigaTestSubTaskValue.setCreator(perfSubTask.getString("creator"));
						
						if(perfSubTask.has("testorId"))
							if(perfSubTask.has("testorId") && perfSubTask.getString("testorId") != null && !perfSubTask.getString("testorId").equals("null") && !perfSubTask.getString("testorId").equals(""))
								iBOAigaTestSubTaskValue.setTestorId(Long.valueOf(perfSubTask.getString("testorId")));
						if(perfSubTask.has("testorName"))
							if(perfSubTask.has("testorName") && perfSubTask.getString("testorName") != null && !perfSubTask.getString("testorName").equals("null") && !perfSubTask.getString("testorName").equals(""))
								iBOAigaTestSubTaskValue.setTestorName(perfSubTask.getString("testorName"));
						
						if(perfSubTask.has("isPerformance"))
						{
							if(perfSubTask.getString("isPerformance")==null||perfSubTask.getString("isPerformance").equals("")||perfSubTask.getString("isPerformance").equals("false"))
								iBOAigaTestSubTaskValue.setIsPerformance(0);
							else if(perfSubTask.getString("isImportanceReq").equals("true"))
								iBOAigaTestSubTaskValue.setIsPerformance(1);
						}
						
						if(perfSubTask.has("possibleProduct"))
							if(perfSubTask.has("possibleProduct") && perfSubTask.getString("possibleProduct") != null && !perfSubTask.getString("possibleProduct").equals("null") && !perfSubTask.getString("possibleProduct").equals(""))
								iBOAigaTestSubTaskValue.setPossibleProduct(Integer.valueOf(perfSubTask.getString("possibleProduct")));
						if(perfSubTask.has("possibleBack"))
							if(perfSubTask.has("possibleBack") && perfSubTask.getString("possibleBack") != null && !perfSubTask.getString("possibleBack").equals("null") && !perfSubTask.getString("possibleBack").equals(""))
								iBOAigaTestSubTaskValue.setPossibleBack(Integer.valueOf(perfSubTask.getString("possibleBack")));
						
						if(perfSubTask.has("possibleTest"))
							if(perfSubTask.has("possibleTest") && perfSubTask.getString("possibleTest") != null && !perfSubTask.getString("possibleTest").equals("null") && !perfSubTask.getString("possibleTest").equals(""))
								iBOAigaTestSubTaskValue.setPossibleTest(Integer.valueOf(perfSubTask.getString("possibleTest")));
						
						if(perfSubTask.has("devWorkDay"))
							if(perfSubTask.has("devWorkDay") && perfSubTask.getString("devWorkDay") != null && !perfSubTask.getString("devWorkDay").equals("null") && !perfSubTask.getString("devWorkDay").equals(""))
								iBOAigaTestSubTaskValue.setDevWorkDay(perfSubTask.getString("devWorkDay"));
						
						if(perfSubTask.has("testWorkDay"))
							if(perfSubTask.has("testWorkDay") && perfSubTask.getString("testWorkDay") != null && !perfSubTask.getString("testWorkDay").equals("null") && !perfSubTask.getString("testWorkDay").equals(""))
								iBOAigaTestSubTaskValue.setTestWorkDay(perfSubTask.getString("testWorkDay"));
						
						if(perfSubTask.has("possibleProductReason"))
							if(perfSubTask.has("possibleProductReason") && perfSubTask.getString("possibleProductReason") != null && !perfSubTask.getString("possibleProductReason").equals("null") && !perfSubTask.getString("possibleProductReason").equals(""))
								iBOAigaTestSubTaskValue.setPossibleProductReason(perfSubTask.getString("possibleProductReason"));
						
						if(perfSubTask.has("possibleBackReason"))
							if(perfSubTask.has("possibleBackReason") && perfSubTask.getString("possibleBackReason") != null && !perfSubTask.getString("possibleBackReason").equals("null") && !perfSubTask.getString("possibleBackReason").equals(""))
								iBOAigaTestSubTaskValue.setPossibleBackReason(perfSubTask.getString("possibleBackReason"));
						
						if(perfSubTask.has("possibleTestReason"))
							if(perfSubTask.has("possibleTestReason") && perfSubTask.getString("possibleTestReason") != null && !perfSubTask.getString("possibleTestReason").equals("null") && !perfSubTask.getString("possibleTestReason").equals(""))
								iBOAigaTestSubTaskValue.setPossibleTestReason(perfSubTask.getString("possibleTestReason"));
							
					}
					atstvs.add(iBOAigaTestSubTaskValue);
				}
				
				
				if(testTaskIds != null && !testTaskIds.equals(""))//遍历测试任务JSONObject
				{
					String testTasks = testTaskIds.toString();
					String[] taskIds = testTasks.split(","); 
					for(int i = 0; i<taskIds.length; i++)
					{
						IBOAigaTestTaskValue iBOAigaTestTaskValue = iAigaTestTaskSV.getAigaTestTaskByTaskId(taskIds[i]);
						attasks.add(iBOAigaTestTaskValue);
					}
				}
				
				if(subTaskIds != null && !subTaskIds.equals(""))//遍历测试子任务JSONObject
				{
					String subTaskIdsString = subTaskIds.toString();
					String[] subTaskId = subTaskIdsString.split(","); 
					for(int i = 0; i<subTaskId.length; i++)
					{
						IBOAigaTestSubTaskValue iBOAigaTestTaskValue = iAigaTestSubTaskSV.getAigaTestSubTaskBySubTaskId(subTaskId[i]);
						atstvs.add(iBOAigaTestTaskValue);
					}
				}
			}
		} catch (JSONException e) 
		{              
			throw new RuntimeException(e);          
		}  
	}
	
	//保存测试计划
	
	//启动测试计划流程
	public void startTPWorkflow(HttpServletRequest request,HttpServletResponse response)throws Exception{
		List<IBOAigaTestPlanValue> iBOAigaTestPlanList = new ArrayList<IBOAigaTestPlanValue>();
		List<IBOAlmStakeholderValue> iBOAlmStakeholderList = new ArrayList<IBOAlmStakeholderValue>();
		List<IBOAlmWorkorderValue> iBOAlmWorkorderList = new ArrayList<IBOAlmWorkorderValue>();
		List<IBOAigaTestTaskValue> iBOAigaTestTaskList = new ArrayList<IBOAigaTestTaskValue>();
		List<IBOAigaSolidTaskValue> iBOAigaSolidTaskList = new ArrayList<IBOAigaSolidTaskValue>();
		List<IBOAigaTestSubTaskValue> iBOAigaTestSubTaskList = new ArrayList<IBOAigaTestSubTaskValue>();
		JSONObject jsonObject = new JSONObject();
		try{
			String jsonObjectString = request.getParameter("jsonInfo");
			jsonObjectString = new String(request.getParameter("jsonInfo").getBytes("ISO-8859-1"),"GBK").toString();
			
			//将页面元素值JSON串解析为LIST，包括工单，多个干系人、测试计划对象、测试任务，固化任务
			getDatasFromRequestInputstream(jsonObjectString, iBOAigaTestPlanList, iBOAlmStakeholderList, iBOAlmWorkorderList, 
					iBOAigaTestTaskList, iBOAigaSolidTaskList,iBOAigaTestSubTaskList);
			
			//调用启动流程SV
			IAigaTestPlanSV aigaTestPlanSV = (IAigaTestPlanSV)ServiceFactory.getService(IAigaTestPlanSV.class);
			aigaTestPlanSV.startTestPlanWorkflow(iBOAigaTestPlanList, iBOAlmStakeholderList, iBOAlmWorkorderList, 
					iBOAigaTestTaskList, iBOAigaSolidTaskList);
			jsonObject.put("flag", "success");
		}catch(Exception e){
			jsonObject.put("flag", "'"+e.getMessage()+"'");
		}finally{
			response.setContentType("application/json;charset=gbk");
			response.getWriter().write(jsonObject.toString());
		}
	}
	
	//保存测试计划
	public void saveTestPlanFirstOrder(HttpServletRequest request,HttpServletResponse response)throws Exception{
		List<IBOAigaTestPlanValue> iBOAigaTestPlanList = new ArrayList<IBOAigaTestPlanValue>();
		List<IBOAlmStakeholderValue> iBOAlmStakeholderList = new ArrayList<IBOAlmStakeholderValue>();
		List<IBOAlmWorkorderValue> iBOAlmWorkorderList = new ArrayList<IBOAlmWorkorderValue>();
		List<IBOAigaTestTaskValue> iBOAigaTestTaskList = new ArrayList<IBOAigaTestTaskValue>();
		List<IBOAigaSolidTaskValue> iBOAigaSolidTaskList = new ArrayList<IBOAigaSolidTaskValue>();
		List<IBOAigaTestSubTaskValue> iBOAigaTestSubTaskList = new ArrayList<IBOAigaTestSubTaskValue>();
		JSONObject jsonObject = new JSONObject();
		try{
			String jsonObjectString = request.getParameter("jsonInfo");
			jsonObjectString = new String(request.getParameter("jsonInfo").getBytes("ISO-8859-1"),"GBK").toString();
			
			//将页面元素值JSON串解析为LIST，包括工单，多个干系人、测试计划对象、测试任务，固化任务
			getDatasFromRequestInputstream(jsonObjectString, iBOAigaTestPlanList, iBOAlmStakeholderList, iBOAlmWorkorderList, 
					iBOAigaTestTaskList, iBOAigaSolidTaskList,iBOAigaTestSubTaskList);
			
			//调用启动流程SV
			IAigaTestPlanSV aigaTestPlanSV = (IAigaTestPlanSV)ServiceFactory.getService(IAigaTestPlanSV.class);
			aigaTestPlanSV.saveTestPlanFirstOrder(iBOAigaTestPlanList, iBOAlmStakeholderList, 
					iBOAlmWorkorderList.get(0),iBOAigaTestTaskList);
			jsonObject.put("flag", "success");
		}catch(Exception e){
			jsonObject.put("flag", "'"+e.getMessage()+"'");
		}finally{
			response.setContentType("application/json;charset=gbk");
			response.getWriter().write(jsonObject.toString());
		}
	}
	
	//通用提交工单解析函数
	public static void getDatasFromRequestInputstreamForOrderSubmit(String jsonObjectString,
			List<IBOAlmStakeholderValue> stds,List<IBOAlmWorkorderValue> orders,
			List<IBOAigaTestPlanValue> atps, List<IBOAigaTestTaskValue> attasks,
			List<IBOAigaSolidTaskValue> astasks, List<IBOAigaTestSubTaskValue> atsts,
			List<IBOAigaSubTaskProblemValue> astps)
			throws Exception {
		try 
		{       
			IAigaSolidTaskSV iAigaSolidTaskSV = (IAigaSolidTaskSV)ServiceFactory.getService(IAigaSolidTaskSV.class);
			IAlmWorkorderSV iAlmWorkorderSV = (IAlmWorkorderSV)ServiceFactory.getService(IAlmWorkorderSV.class);
			IAigaTestPlanSV iAigaTestPlanSV = (IAigaTestPlanSV)ServiceFactory.getService(IAigaTestPlanSV.class);
			IAigaTestTaskSV iAigaTestTaskSV = (IAigaTestTaskSV)ServiceFactory.getService(IAigaTestTaskSV.class);
			IAigaTestSubTaskSV iAigaTestSubTaskSV = (IAigaTestSubTaskSV)ServiceFactory.getService(IAigaTestSubTaskSV.class);
			
			JSONObject result = JSONObject.fromObject(jsonObjectString); //转换为JSONObject              
			int num = result.length();  
			if(result != null && num>0)
			{
				JSONArray stakeholders = null;
				JSONObject orderDetail = null;
				Object testPlanId = null;
				Object solidTaskId = null;
				Object testTaskId = null;
				Object subTaskId = null;
				Object subTaskProblemId = null;
				
				if(result.has("stakeholder"))
					stakeholders = result.getJSONArray("stakeholder");//获取干系人JSONArray 
				if(result.has("orderDetail"))
					orderDetail = result.getJSONObject("orderDetail");//获取工单信息  
				
				if(result.has("testPlanId"))
					testPlanId = result.get("testPlanId");//获取测试计划id信息 
				if(result.has("solidTaskId"))
					solidTaskId = result.get("solidTaskId");//获取固化任务id信息   
				if(result.has("testTaskId"))
					testTaskId = result.get("testTaskId");//获取测试任务id信息 
				if(result.has("subTaskId"))
					subTaskId = result.get("subTaskId");//获取测试子任务id信息 
				if(result.has("subTaskProblemId"))
					subTaskProblemId = result.get("subTaskProblemId");//获取问题跟踪流程ID信息 
				
				if(stakeholders != null && stakeholders.length()>0)//遍历干系人JSONArray
				{
					int length = stakeholders.length();
					for(int i = 0; i < length; i++)
					{
						JSONObject std = stakeholders.getJSONObject(i);  
						IBOAlmStakeholderValue approvalStakeholder = new BOAlmStakeholderBean();
						if(std.has("linkId") && std.getString("linkId") != null && !std.getString("linkId").equals("0")&& !std.getString("linkId").equals(""))
							approvalStakeholder.setLinkId(Long.valueOf(std.getString("linkId")));
						else {
							continue;
						}
						if(std.has("linkNo"))
							approvalStakeholder.setLinkNo(std.getString("linkNo"));
						else {
							continue;
						}
						if(std.has("templateId") && std.getString("templateId") != null && !std.getString("templateId").equals("0") && !std.getString("templateId").equals(""))
							approvalStakeholder.setTemplateId(Long.valueOf(std.getString("templateId")));
						if(std.has("stdholderStaffId") && (std.getString("stdholderStaffId") ==null || std.getString("stdholderStaffId").equals("0")))
							continue;
						approvalStakeholder.setStdholderStaffId(Long.valueOf(std.getString("stdholderStaffId")));
						if(std.has("stdholderStaffNo"))
							approvalStakeholder.setStdholderStaffNo(std.getString("stdholderStaffNo"));
						if(std.has("stdholderStaffName"))
							approvalStakeholder.setStdholderStaffName(std.getString("stdholderStaffName"));
						if(std.has("stdholdeType"))
							approvalStakeholder.setStdholdeType(std.getString("stdholdeType"));
						stds.add(approvalStakeholder);
					}  
				}
				
				if(orderDetail != null)//遍历工单信息JSONObject
				{
					String orderId = "0";
					if(orderDetail.has("orderId"))
						orderId = orderDetail.getString("orderId");
					IBOAlmWorkorderValue iAlmWorkorderValue = new BOAlmWorkorderBean();
					if(orderId == null || orderId.equals(0) || orderId.equals("") || orderId.equals("null"))
					{
						iAlmWorkorderValue.setOrderId(Long.valueOf(orderId));
						if(orderDetail.has("conds"))
							iAlmWorkorderValue.setCond(orderDetail.getString("conds"));
						if(orderDetail.has("result"))
							iAlmWorkorderValue.setResult(orderDetail.getString("result"));
						if(orderDetail.has("opinion"))
							iAlmWorkorderValue.setOpinion(orderDetail.getString("opinion"));
					}else
					{
						iAlmWorkorderValue = iAlmWorkorderSV.queryWorkOrderById(orderId);
						if(orderDetail.has("conds"))
							iAlmWorkorderValue.setCond(orderDetail.getString("conds"));
						if(orderDetail.has("result"))
							iAlmWorkorderValue.setResult(orderDetail.getString("result"));
						if(orderDetail.has("opinion"))
							iAlmWorkorderValue.setOpinion(orderDetail.getString("opinion"));
					}
					orders.add(iAlmWorkorderValue);
				}
				
				if(testPlanId != null)//获取测试计划
				{
					String PlanId = testPlanId.toString();
					IBOAigaTestPlanValue iBOAigaTestPlanValue = iAigaTestPlanSV.getAigaTestPlanByPlanId(PlanId);
					if(iBOAigaTestPlanValue != null)
						atps.add(iBOAigaTestPlanValue);
				}
				
				if(solidTaskId != null)//获取固化任务
				{
					String taskId = solidTaskId.toString();
					IBOAigaSolidTaskValue iasTaskValue = iAigaSolidTaskSV.getAigaSolidTaskByTaskId(taskId);
					if(iasTaskValue != null)
						astasks.add(iasTaskValue);
				}

				if(testTaskId != null)//获取测试任务
				{
					String taskId = testTaskId.toString();
					IBOAigaTestTaskValue iBOAigaTestTaskValue = iAigaTestTaskSV.getAigaTestTaskByTaskId(taskId);
					if(iBOAigaTestTaskValue != null)
						attasks.add(iBOAigaTestTaskValue);
				}
				
				if(subTaskId != null)//获取子任务
				{
					String subTask = subTaskId.toString();
					IBOAigaTestSubTaskValue iAigaTestSubTaskValue = iAigaTestSubTaskSV.getAigaTestSubTaskBySubTaskId(subTask);
					if(iAigaTestSubTaskValue != null)
						atsts.add(iAigaTestSubTaskValue);
				}
				if(subTaskProblemId != null)//获取子任务
				{
					String problemId = subTaskProblemId.toString();
					Criteria sqlCriteria = new Criteria();
					sqlCriteria.addEqual(IBOAigaSubTaskProblemValue.S_Id, problemId);
					IBOAigaSubTaskProblemValue[] aigaSubTaskProblemValues = iAigaTestSubTaskSV.getAigaSubTaskProblems(sqlCriteria.toString(), sqlCriteria.getParameters());
					if(aigaSubTaskProblemValues != null && aigaSubTaskProblemValues.length>0)
					{
						for(IBOAigaSubTaskProblemValue value : aigaSubTaskProblemValues)
							astps.add(value);
					}
						
				}
				
			}
		} catch (JSONException e) 
		{              
			throw new RuntimeException(e);          
		}  
	}


	//性能测试任务经理提交函数
	public void perfSubTaskFunctionSub(HttpServletRequest request,HttpServletResponse response) throws Exception {
		List<IBOAlmStakeholderValue> iBOAlmStakeholderList = new ArrayList<IBOAlmStakeholderValue>();
		List<IBOAlmWorkorderValue> iBOAlmWorkorderList = new ArrayList<IBOAlmWorkorderValue>();
		List<IBOAigaTestPlanValue> iBOAigaTestPlanList = new ArrayList<IBOAigaTestPlanValue>();
		List<IBOAigaTestTaskValue> iBOAigaTestTaskList = new ArrayList<IBOAigaTestTaskValue>();
		List<IBOAigaSolidTaskValue> iBOAigaSolidTaskList = new ArrayList<IBOAigaSolidTaskValue>();
		List<IBOAigaTestSubTaskValue> iBOAigaTestSubTaskValue = new ArrayList<IBOAigaTestSubTaskValue>();
		List<IBOAigaSubTaskProblemValue> iBOAigaSubTaskProblemValue = new ArrayList<IBOAigaSubTaskProblemValue>();
		JSONObject jsonObject = new JSONObject();
		try{
			String jsonObjectString = request.getParameter("jsonInfo");
			jsonObjectString = new String(request.getParameter("jsonInfo").getBytes("ISO-8859-1"),"GBK").toString();
			
			//将页面元素值JSON串解析为LIST，包括工单，多个干系人、测试计划对象、测试任务，固化任务
			getDatasFromRequestInputstreamForOrderSubmit(jsonObjectString, iBOAlmStakeholderList,iBOAlmWorkorderList,
					iBOAigaTestPlanList,  iBOAigaTestTaskList, 
					iBOAigaSolidTaskList,iBOAigaTestSubTaskValue,iBOAigaSubTaskProblemValue);
			
			JSONObject result = JSONObject.fromObject(jsonObjectString); //转换为JSONObject  
			Object objType = result.get("objType");//获取任务类型
			String objTypeString = objType.toString();
			
			JSONObject distribute = null;
			if(result.has("distribute")){
				distribute = result.getJSONObject("distribute");//获取工单信息  
				iBOAigaTestTaskList.get(0).setDistributeStaffid(distribute.getString("distributeStaffId"));
				iBOAigaTestTaskList.get(0).setDistributeStaffname(distribute.getString("distributeStaffName"));
				IAigaTestTaskSV iAigaTestTaskSV = (IAigaTestTaskSV)ServiceFactory.getService(IAigaTestTaskSV.class);
				iAigaTestTaskSV.saveAigaTestTask(iBOAigaTestTaskList.get(0));
			}	
			//调用公共SV
			IAigaPublicSV iAigaPublicSV = (IAigaPublicSV)ServiceFactory.getService(IAigaPublicSV.class);
			iAigaPublicSV.orderSubmitPublicFun(iBOAlmStakeholderList, iBOAlmWorkorderList, iBOAigaTestPlanList, 
					iBOAigaTestTaskList, iBOAigaSolidTaskList,iBOAigaTestSubTaskValue,
					iBOAigaSubTaskProblemValue,objTypeString);
			jsonObject.put("flag", "success");
		}catch(Exception e){
			jsonObject.put("flag", "'"+e.getMessage()+"'");
		}finally{
			response.setContentType("application/json;charset=gbk");
			response.getWriter().write(jsonObject.toString());
		}
	}
	
	
	//工单提交公共函数
	public void orderSubmitPublicFun(HttpServletRequest request,HttpServletResponse response) throws Exception {
		List<IBOAlmStakeholderValue> iBOAlmStakeholderList = new ArrayList<IBOAlmStakeholderValue>();
		List<IBOAlmWorkorderValue> iBOAlmWorkorderList = new ArrayList<IBOAlmWorkorderValue>();
		List<IBOAigaTestPlanValue> iBOAigaTestPlanList = new ArrayList<IBOAigaTestPlanValue>();
		List<IBOAigaTestTaskValue> iBOAigaTestTaskList = new ArrayList<IBOAigaTestTaskValue>();
		List<IBOAigaSolidTaskValue> iBOAigaSolidTaskList = new ArrayList<IBOAigaSolidTaskValue>();
		List<IBOAigaTestSubTaskValue> iBOAigaTestSubTaskValue = new ArrayList<IBOAigaTestSubTaskValue>();
		List<IBOAigaSubTaskProblemValue> iBOAigaSubTaskProblemValue = new ArrayList<IBOAigaSubTaskProblemValue>();
		JSONObject jsonObject = new JSONObject();
		try{
			String jsonObjectString = request.getParameter("jsonInfo");
			jsonObjectString = new String(request.getParameter("jsonInfo").getBytes("ISO-8859-1"),"GBK").toString();
			
			//将页面元素值JSON串解析为LIST，包括工单，多个干系人、测试计划对象、测试任务，固化任务
			getDatasFromRequestInputstreamForOrderSubmit(jsonObjectString, iBOAlmStakeholderList,iBOAlmWorkorderList,
					iBOAigaTestPlanList,  iBOAigaTestTaskList, 
					iBOAigaSolidTaskList,iBOAigaTestSubTaskValue,iBOAigaSubTaskProblemValue);
			
			JSONObject result = JSONObject.fromObject(jsonObjectString); //转换为JSONObject  
			Object objType = result.get("objType");//获取任务类型
			String objTypeString = objType.toString();
					
			//调用公共SV
			IAigaPublicSV iAigaPublicSV = (IAigaPublicSV)ServiceFactory.getService(IAigaPublicSV.class);
			iAigaPublicSV.orderSubmitPublicFun(iBOAlmStakeholderList, iBOAlmWorkorderList, iBOAigaTestPlanList, 
					iBOAigaTestTaskList, iBOAigaSolidTaskList,iBOAigaTestSubTaskValue,
					iBOAigaSubTaskProblemValue,objTypeString);
			jsonObject.put("flag", "success");
		}catch(Exception e){
			jsonObject.put("flag", "'"+e.getMessage()+"'");
		}finally{
			response.setContentType("application/json;charset=gbk");
			response.getWriter().write(jsonObject.toString());
		}
	}
	

	//拆分测试子任务
	public void splitTestTaskToSubTask(HttpServletRequest request,HttpServletResponse response)throws Exception{
		List<IBOAigaTestPlanValue> iBOAigaTestPlanList = new ArrayList<IBOAigaTestPlanValue>();
		List<IBOAlmStakeholderValue> iBOAlmStakeholderList = new ArrayList<IBOAlmStakeholderValue>();
		List<IBOAlmWorkorderValue> iBOAlmWorkorderList = new ArrayList<IBOAlmWorkorderValue>();
		List<IBOAigaTestTaskValue> iBOAigaTestTaskList = new ArrayList<IBOAigaTestTaskValue>();
		List<IBOAigaSolidTaskValue> iBOAigaSolidTaskList = new ArrayList<IBOAigaSolidTaskValue>();
		List<IBOAigaTestSubTaskValue> iBOAigaTestSubTaskList = new ArrayList<IBOAigaTestSubTaskValue>();
		
		JSONObject jsonObject = new JSONObject();
		try{
			String jsonObjectString = request.getParameter("jsonInfo");
			jsonObjectString = new String(request.getParameter("jsonInfo").getBytes("ISO-8859-1"),"GBK").toString();
			
			//将页面元素值JSON串解析为LIST，包括工单，多个干系人、测试计划对象、测试任务，固化任务，子任务
			getDatasFromRequestInputstream(jsonObjectString, iBOAigaTestPlanList, iBOAlmStakeholderList, iBOAlmWorkorderList, 
					iBOAigaTestTaskList, iBOAigaSolidTaskList,iBOAigaTestSubTaskList);
			
			
			//解析子任务分配人
			JSONObject result = JSONObject.fromObject(jsonObjectString); //转换为JSONObject              
			int num = result.length(); 
			JSONArray subTaskStaffs = null;
			if(result != null && num>0)
			{
				if(result.has("subTaskStaffs"))
					subTaskStaffs = result.getJSONArray("subTaskStaffs");//获取子任务分配人JSONArray 
			}
			//调用启动流程SV
			IAigaTestTaskSV iAigaTestTaskSV = (IAigaTestTaskSV)ServiceFactory.getService(IAigaTestTaskSV.class);
			iAigaTestTaskSV.splitAigaTestTask(iBOAlmStakeholderList, iBOAlmWorkorderList,
					iBOAigaTestTaskList, subTaskStaffs);
			jsonObject.put("flag", "success");
		}catch(Exception e){
			jsonObject.put("flag", "'"+e.getMessage()+"'");
		}finally{
			response.setContentType("application/json;charset=gbk");
			response.getWriter().write(jsonObject.toString());
		}
	}
	
	//测试计划变更
	public void testPlanChange(HttpServletRequest request,HttpServletResponse response)throws Exception{
		JSONObject jsonObject = new JSONObject();
		try{
			String jsonObjectString = request.getParameter("jsonInfo");
			jsonObjectString = new String(request.getParameter("jsonInfo").getBytes("ISO-8859-1"),"GBK").toString();
			
			//获取json
			JSONObject result = JSONObject.fromObject(jsonObjectString); //转换为JSONObject              
			int num = result.length(); 
			JSONObject testPlanChange = null;
			if(result != null && num>0)
			{
				if(result.has("testPlanChange"))
				{
					testPlanChange = result.getJSONObject("testPlanChange");//获取测试计划变更信息  
					//调用SV
					IAigaTestPlanSV aigaTestPlanSV = (IAigaTestPlanSV)ServiceFactory.getService(IAigaTestPlanSV.class);
					aigaTestPlanSV.testPlanChange(testPlanChange);
				}
			}
			jsonObject.put("flag", "success");
		}catch(Exception e){
			jsonObject.put("flag", "'"+e.getMessage()+"'");
		}finally{
			response.setContentType("application/json;charset=gbk");
			response.getWriter().write(jsonObject.toString());
		}
		
	}
	
	//批量任务分配
	public void batchAllotTestTaskToSubTask(HttpServletRequest request,HttpServletResponse response)throws Exception{
		List<IBOAigaTestPlanValue> iBOAigaTestPlanList = new ArrayList<IBOAigaTestPlanValue>();
		List<IBOAlmStakeholderValue> iBOAlmStakeholderList = new ArrayList<IBOAlmStakeholderValue>();
		List<IBOAlmWorkorderValue> iBOAlmWorkorderList = new ArrayList<IBOAlmWorkorderValue>();
		List<IBOAigaTestTaskValue> iBOAigaTestTaskList = new ArrayList<IBOAigaTestTaskValue>();
		List<IBOAigaSolidTaskValue> iBOAigaSolidTaskList = new ArrayList<IBOAigaSolidTaskValue>();
		List<IBOAigaTestSubTaskValue> iBOAigaTestSubTaskList = new ArrayList<IBOAigaTestSubTaskValue>();
		JSONObject jsonObject = new JSONObject();
		try{
			String jsonObjectString = request.getParameter("jsonInfo");
			jsonObjectString = new String(request.getParameter("jsonInfo").getBytes("ISO-8859-1"),"GBK").toString();
			
			//解析子任务分配人
			JSONObject result = JSONObject.fromObject(jsonObjectString); //转换为JSONObject              
			int num = result.length(); 
			JSONArray subTaskStaffs = null;
			if(result != null && num>0)
			{
				if(result.has("subTaskStaffs"))
					subTaskStaffs = result.getJSONArray("subTaskStaffs");//获取子任务分配人JSONArray 
			}
			//调用启动流程SV
			IAigaTestTaskSV iAigaTestTaskSV = (IAigaTestTaskSV)ServiceFactory.getService(IAigaTestTaskSV.class);
			iAigaTestTaskSV.batchAllotTestTaskToSubTask(subTaskStaffs);
			jsonObject.put("flag", "success");
		}catch(Exception e){
			jsonObject.put("flag", "'"+e.getMessage()+"'");
		}finally{
			response.setContentType("application/json;charset=gbk");
			response.getWriter().write(jsonObject.toString());
		}
	}
	
	
	//启动测试任务流程
	public void startTestTaskWorkflow(HttpServletRequest request,HttpServletResponse response)throws Exception{
		List<IBOAigaTestPlanValue> iBOAigaTestPlanList = new ArrayList<IBOAigaTestPlanValue>();
		List<IBOAlmStakeholderValue> iBOAlmStakeholderList = new ArrayList<IBOAlmStakeholderValue>();
		List<IBOAlmWorkorderValue> iBOAlmWorkorderList = new ArrayList<IBOAlmWorkorderValue>();
		List<IBOAigaTestTaskValue> iBOAigaTestTaskList = new ArrayList<IBOAigaTestTaskValue>();
		List<IBOAigaSolidTaskValue> iBOAigaSolidTaskList = new ArrayList<IBOAigaSolidTaskValue>();
		List<IBOAigaTestSubTaskValue> iBOAigaTestSubTaskList = new ArrayList<IBOAigaTestSubTaskValue>();
		
		String jsonObjectString = request.getParameter("jsonInfo");
		
		JSONObject jsonObject = new JSONObject();
		try{
			jsonObjectString = new String(request.getParameter("jsonInfo").getBytes("ISO-8859-1"),"GBK").toString();
			
			//将页面元素值JSON串解析为LIST，包括工单，多个干系人、测试计划对象、测试任务，固化任务
			getDatasFromRequestInputstream(jsonObjectString, iBOAigaTestPlanList, iBOAlmStakeholderList, iBOAlmWorkorderList, 
					iBOAigaTestTaskList, iBOAigaSolidTaskList,iBOAigaTestSubTaskList);
			
			//调用启动流程SV
			IAigaTestTaskSV iAigaTestTaskSV = (IAigaTestTaskSV)ServiceFactory.getService(IAigaTestTaskSV.class);
			iAigaTestTaskSV.startAigaTestTaskListWorkflowWithoutTestPlan(iBOAigaTestTaskList);
			jsonObject.put("flag", "success");
		}catch(Exception e){
			jsonObject.put("flag", "'"+e.getMessage()+"'");
		}finally{
			response.setContentType("application/json;charset=gbk");
			response.getWriter().write(jsonObject.toString());
		}
		
	}
	
	//批量启动测试任务流程
	public void batchStartTestTaskWorkflow(HttpServletRequest request,HttpServletResponse response)throws Exception{
		List<IBOAigaTestPlanValue> iBOAigaTestPlanList = new ArrayList<IBOAigaTestPlanValue>();
		List<IBOAlmStakeholderValue> iBOAlmStakeholderList = new ArrayList<IBOAlmStakeholderValue>();
		List<IBOAlmWorkorderValue> iBOAlmWorkorderList = new ArrayList<IBOAlmWorkorderValue>();
		List<IBOAigaTestTaskValue> iBOAigaTestTaskList = new ArrayList<IBOAigaTestTaskValue>();
		List<IBOAigaSolidTaskValue> iBOAigaSolidTaskList = new ArrayList<IBOAigaSolidTaskValue>();
		List<IBOAigaTestSubTaskValue> iBOAigaTestSubTaskList = new ArrayList<IBOAigaTestSubTaskValue>();
		
		String jsonObjectString = request.getParameter("jsonInfo");
		
		JSONObject jsonObject = new JSONObject();
		try{
			jsonObjectString = new String(request.getParameter("jsonInfo").getBytes("ISO-8859-1"),"GBK").toString();
			
			//将页面元素值JSON串解析为LIST，包括工单，多个干系人、测试计划对象、测试任务，固化任务
			getDatasFromRequestInputstream(jsonObjectString, iBOAigaTestPlanList, iBOAlmStakeholderList, iBOAlmWorkorderList, 
					iBOAigaTestTaskList, iBOAigaSolidTaskList,iBOAigaTestSubTaskList);
			
			//解析排期信息
			JSONObject result = JSONObject.fromObject(jsonObjectString); //转换为JSONObject              
			int num = result.length(); 
			JSONObject testPlanInfo = null;
			if(result != null && num>0)
			{
				if(result.has("testPlanInfo"))
				{
					String planId = "";
					testPlanInfo = result.getJSONObject("testPlanInfo");//获取测试计划信息JSONArray 
					for(IBOAigaTestTaskValue value : iBOAigaTestTaskList)
					{
						if(testPlanInfo.has("planId"))
						{
							planId = testPlanInfo.getString("planId");
							if(planId == null || planId.equals(0) || planId.equals("0") || planId.equals("") || planId.equals("null"))
							{
								break;
							}else {
								value.setPlanId(Long.valueOf(planId));
								value.setPlanTag(testPlanInfo.getString("planTag"));
//								value.setBigType(Long.valueOf(testPlanInfo.getString("bigType")));
								Timestamp ts = new Timestamp(System.currentTimeMillis());   
								String tsStr = testPlanInfo.getString("factCompleteTime") + " 00:00:00"; 
								ts = Timestamp.valueOf(tsStr);   
								value.setFactCompleteTime(ts);
							}
						}else {
							break;
						}
					}
				}	
			}
			//调用启动流程SV
			IAigaTestTaskSV iAigaTestTaskSV = (IAigaTestTaskSV)ServiceFactory.getService(IAigaTestTaskSV.class);
			iAigaTestTaskSV.startAigaTestTaskListWorkflowWithoutTestPlan(iBOAigaTestTaskList);
			jsonObject.put("flag", "success");
		}catch(Exception e){
			jsonObject.put("flag", "'"+e.getMessage()+"'");
		}finally{
			response.setContentType("application/json;charset=gbk");
			response.getWriter().write(jsonObject.toString());
		}
		
	}
	
	//启动用户体验测试任务流程，需要启动用户体验测试任务流程和自动拆分用户体验测试子流程
	public void startUETTaskWorkflow(HttpServletRequest request,HttpServletResponse response)throws Exception{
		List<IBOAigaTestPlanValue> iBOAigaTestPlanList = new ArrayList<IBOAigaTestPlanValue>();
		List<IBOAlmStakeholderValue> iBOAlmStakeholderList = new ArrayList<IBOAlmStakeholderValue>();
		List<IBOAlmWorkorderValue> iBOAlmWorkorderList = new ArrayList<IBOAlmWorkorderValue>();
		List<IBOAigaTestTaskValue> iBOAigaTestTaskList = new ArrayList<IBOAigaTestTaskValue>();
		List<IBOAigaSolidTaskValue> iBOAigaSolidTaskList = new ArrayList<IBOAigaSolidTaskValue>();
		List<IBOAigaTestSubTaskValue> iBOAigaTestSubTaskList = new ArrayList<IBOAigaTestSubTaskValue>();
		
		String jsonObjectString = request.getParameter("jsonInfo");
		
		JSONObject jsonObject = new JSONObject();
		try{
			jsonObjectString = new String(request.getParameter("jsonInfo").getBytes("ISO-8859-1"),"GBK").toString();
			
			//将页面元素值JSON串解析为LIST，包括工单，多个干系人、测试计划对象、测试任务，固化任务
			getDatasFromRequestInputstream(jsonObjectString, iBOAigaTestPlanList, iBOAlmStakeholderList, iBOAlmWorkorderList, 
					iBOAigaTestTaskList, iBOAigaSolidTaskList,iBOAigaTestSubTaskList);
			
			//解析普通任务ID
			JSONObject result = JSONObject.fromObject(jsonObjectString); //转换为JSONObject              
			int num = result.length(); 
			Object taskId = null;
			
			String taskIdString = "";
			if(result != null && num>0)
			{
				if(result.has("startTaskId")){
					taskId = result.get("startTaskId");
					taskIdString = taskId.toString();
				}
			}
			
			//调用启动流程SV
			IAigaTestTaskSV iAigaTestTaskSV = (IAigaTestTaskSV)ServiceFactory.getService(IAigaTestTaskSV.class);
			iAigaTestTaskSV.startAigaUETTaskListWorkflow(iBOAigaTestTaskList,iBOAlmStakeholderList,taskIdString);
			jsonObject.put("flag", "success");
		}catch(Exception e){
			jsonObject.put("flag", "'"+e.getMessage()+"'");
		}finally{
			response.setContentType("application/json;charset=gbk");
			response.getWriter().write(jsonObject.toString());
		}
		
	}
	
	
	//启动性能子测试任务流程
	public void startPerfTaskWorkflow(HttpServletRequest request,HttpServletResponse response)throws Exception{
		JSONObject jsonObject = new JSONObject();
		try{
			List<IBOAigaTestPlanValue> iBOAigaTestPlanList = new ArrayList<IBOAigaTestPlanValue>();
			List<IBOAlmStakeholderValue> iBOAlmStakeholderList = new ArrayList<IBOAlmStakeholderValue>();
			List<IBOAlmWorkorderValue> iBOAlmWorkorderList = new ArrayList<IBOAlmWorkorderValue>();
			List<IBOAigaTestTaskValue> iBOAigaTestTaskList = new ArrayList<IBOAigaTestTaskValue>();
			List<IBOAigaSolidTaskValue> iBOAigaSolidTaskList = new ArrayList<IBOAigaSolidTaskValue>();
			List<IBOAigaTestSubTaskValue> iBOAigaTestSubTaskList = new ArrayList<IBOAigaTestSubTaskValue>();
			
			String jsonObjectString = request.getParameter("jsonInfo");
			jsonObjectString = new String(request.getParameter("jsonInfo").getBytes("ISO-8859-1"),"GBK").toString();
			
			//将页面元素值JSON串解析为LIST，包括工单，多个干系人、测试计划对象、测试任务，固化任务
			getDatasFromRequestInputstream(jsonObjectString, iBOAigaTestPlanList, iBOAlmStakeholderList, iBOAlmWorkorderList, 
					iBOAigaTestTaskList, iBOAigaSolidTaskList,iBOAigaTestSubTaskList);
			
			//调用启动流程SV
			IAigaTestSubTaskSV iAigaTestSubTaskSV = (IAigaTestSubTaskSV)ServiceFactory.getService(IAigaTestSubTaskSV.class);
			iAigaTestSubTaskSV.startAigaPerfSubTaskWorkflow(iBOAigaTestSubTaskList.get(0),iBOAlmStakeholderList,iBOAlmWorkorderList);
			jsonObject.put("flag", "success");
		}catch(Exception e){
			jsonObject.put("flag", "'"+e.getMessage()+"'");
		}finally{
			response.setContentType("application/json;charset=gbk");
			response.getWriter().write(jsonObject.toString());
		}
	}
	
	
	//批量子任务改派
	public void batchSubTaskTestorChange(HttpServletRequest request,HttpServletResponse response)throws Exception{
		JSONObject jsonObject = new JSONObject();
		try{
			String jsonObjectString = request.getParameter("jsonInfo");
			jsonObjectString = new String(request.getParameter("jsonInfo").getBytes("ISO-8859-1"),"GBK").toString();
			
			//解析子任务分配人
			JSONObject result = JSONObject.fromObject(jsonObjectString); //转换为JSONObject              
			int num = result.length(); 
			JSONArray subTaskChangeStaffs = null;
			if(result != null && num>0)
			{
				if(result.has("subTaskChangeStaffs"))
					subTaskChangeStaffs = result.getJSONArray("subTaskChangeStaffs");//获取子任务分配人JSONArray 
			}
			//调用启动流程SV
			IAigaTestTaskSV iAigaTestTaskSV = (IAigaTestTaskSV)ServiceFactory.getService(IAigaTestTaskSV.class);
			iAigaTestTaskSV.batchSubTaskTestorChange(subTaskChangeStaffs);
			jsonObject.put("flag", "success");
		}catch(Exception e){
			jsonObject.put("flag", "'"+e.getMessage()+"'");
		}finally{
			response.setContentType("application/json;charset=gbk");
			response.getWriter().write(jsonObject.toString());
		}
		
	}
	
	//批量子任务评审
	public void batchSubTaskReview(HttpServletRequest request,HttpServletResponse response)throws Exception{
		JSONObject jsonObject = new JSONObject();
		try{
			String jsonObjectString = request.getParameter("jsonInfo");
			jsonObjectString = new String(request.getParameter("jsonInfo").getBytes("ISO-8859-1"),"GBK").toString();
			
			//解析子任务分配人
			JSONObject result = JSONObject.fromObject(jsonObjectString); //转换为JSONObject              
			int num = result.length(); 
			JSONArray subTasks = null;
			JSONObject problemStaff = null;
			
			String problemStaffId = "";
			String problemStaffName = "";
	
			if(result != null && num>0)
			{
				if(result.has("subTasks"))
					subTasks = result.getJSONArray("subTasks");//获取评审过子任务信息
				if(result.has("problemStaff")){
					problemStaff = result.getJSONObject("problemStaff");//获取发起问题人员信息 
					problemStaffId = problemStaff.getString("problemStaffId");
					problemStaffName = problemStaff.getString("problemStaffName");
				}
			}
			//调用启动流程SV
			IAigaTestSubTaskSV iAigaTestSubTaskSV = (IAigaTestSubTaskSV)ServiceFactory.getService(IAigaTestSubTaskSV.class);
			iAigaTestSubTaskSV.batchSubTaskReview(subTasks,problemStaffId,problemStaffName);
			jsonObject.put("flag", "success");
		}catch(Exception e){
			jsonObject.put("flag", "'"+e.getMessage()+"'");
		}finally{
			response.setContentType("application/json;charset=gbk");
			response.getWriter().write(jsonObject.toString());
		}
	}
	
	
	//启动问题跟踪流程
	public void startProblemWF(HttpServletRequest request,HttpServletResponse response)throws Exception{
		JSONObject jsonObject = new JSONObject();
		try{
			String jsonObjectString = request.getParameter("jsonInfo");
			jsonObjectString = new String(request.getParameter("jsonInfo").getBytes("ISO-8859-1"),"GBK").toString();
			
			//解析子任务分配人
			JSONObject result = JSONObject.fromObject(jsonObjectString); //转换为JSONObject              
			int num = result.length(); 
			JSONObject problemInfo = null;
			JSONObject subTaskProblemForm = null;
			
			String problemStaffId = "";
			String problemStaffName = "";
			String subTask = "";
			String problemTag = "";
			
			IBOAigaSubTaskProblemValue aigaSubTaskProblemValue = new BOAigaSubTaskProblemBean();
			IAigaTestSubTaskSV iAigaTestSubTaskSV = (IAigaTestSubTaskSV)ServiceFactory.getService(IAigaTestSubTaskSV.class);
			if(result != null && num>0)//转换为JSONObject      
			{
				if(result.has("problemInfo")){
					problemInfo = result.getJSONObject("problemInfo");//获取发起问题信息 
					problemStaffId = problemInfo.getString("problemStaffId");
					problemStaffName = problemInfo.getString("problemStaffName");
					subTask = problemInfo.getString("subTask");
					problemTag = problemInfo.getString("problemTag");
				}
				if(result.has("subTaskProblemForm"))
					subTaskProblemForm = result.getJSONObject("subTaskProblemForm");//获取问题信息 
				
				if(subTaskProblemForm != null)//遍历问题信息JSONObject
				{
					String id = "";
					if(subTaskProblemForm.has("id"))
						id = subTaskProblemForm.getString("id");
					
					if(id == null || id.equals(0) || id.equals("") || id.equals("null"))
					{
						if(subTaskProblemForm.has("stpTag"))
							aigaSubTaskProblemValue.setStpTag(subTaskProblemForm.getString("stpTag"));
	
						aigaSubTaskProblemValue.setCreateTime(ServiceManager.getOpDateTime());
						if(subTaskProblemForm.has("stpName"))
							aigaSubTaskProblemValue.setStpName(subTaskProblemForm.getString("stpName"));
						if(subTaskProblemForm.has("stpStatus"))
							if(subTaskProblemForm.has("stpStatus") && subTaskProblemForm.getString("stpStatus") != null && !subTaskProblemForm.getString("stpStatus").equals("null") && !subTaskProblemForm.getString("stpStatus").equals(""))
								aigaSubTaskProblemValue.setStpStatus(Long.valueOf(subTaskProblemForm.getString("stpStatus")));
						if(subTaskProblemForm.has("stpPhsse"))
							if(subTaskProblemForm.has("stpPhsse") && subTaskProblemForm.getString("stpPhsse") != null && !subTaskProblemForm.getString("stpPhsse").equals("null") && !subTaskProblemForm.getString("stpPhsse").equals(""))
								aigaSubTaskProblemValue.setStpPhase(Long.valueOf(subTaskProblemForm.getString("stpPhsse")));
						
						if(subTaskProblemForm.has("subTaskId"))
							if(subTaskProblemForm.has("subTaskId") && subTaskProblemForm.getString("subTaskId") != null && !subTaskProblemForm.getString("subTaskId").equals("null") && !subTaskProblemForm.getString("subTaskId").equals(""))
								aigaSubTaskProblemValue.setSubTaskId(Long.valueOf(subTaskProblemForm.getString("subTaskId")));
						if(subTaskProblemForm.has("subTaskType"))
							if(subTaskProblemForm.has("subTaskType") && subTaskProblemForm.getString("subTaskType") != null && !subTaskProblemForm.getString("subTaskType").equals("null") && !subTaskProblemForm.getString("subTaskType").equals(""))
								aigaSubTaskProblemValue.setSubTaskType(Long.valueOf(subTaskProblemForm.getString("subTaskType")));
						if(subTaskProblemForm.has("subTaskTag"))
							aigaSubTaskProblemValue.setSubTaskTag(subTaskProblemForm.getString("subTaskTag"));
						if(subTaskProblemForm.has("subTaskName"))
							aigaSubTaskProblemValue.setSubTaskName(subTaskProblemForm.getString("subTaskName"));
						if(subTaskProblemForm.has("createStaffName"))
							aigaSubTaskProblemValue.setCreateStaffName(subTaskProblemForm.getString("createStaffName"));
						if(subTaskProblemForm.has("createStaffId"))
							if(subTaskProblemForm.has("createStaffId") && subTaskProblemForm.getString("createStaffId") != null && !subTaskProblemForm.getString("createStaffId").equals("null") && !subTaskProblemForm.getString("createStaffId").equals(""))
								aigaSubTaskProblemValue.setCreateStaffId(Long.valueOf(subTaskProblemForm.getString("createStaffId")));
						if(subTaskProblemForm.has("startMark"))
							if(subTaskProblemForm.has("startMark") && subTaskProblemForm.getString("startMark") != null && !subTaskProblemForm.getString("startMark").equals("null") && !subTaskProblemForm.getString("startMark").equals(""))
								aigaSubTaskProblemValue.setStartMark(Long.valueOf(subTaskProblemForm.getString("startMark")));
					}else {
						aigaSubTaskProblemValue = iAigaTestSubTaskSV.getAigaSubTaskProblemById(id);
					}
				}
				
			}
			//调用启动流程SV
			iAigaTestSubTaskSV.startProblemWF(aigaSubTaskProblemValue,subTask,problemTag,problemStaffId,problemStaffName);
			jsonObject.put("flag", "success");
		}catch(Exception e){
			jsonObject.put("flag", "'"+e.getMessage()+"'");
		}finally{
			response.setContentType("application/json;charset=gbk");
			response.getWriter().write(jsonObject.toString());
		}
	}
	
	
	//启动性能测试任务流程
	public void startPerfTestTaskWorkflow(HttpServletRequest request,HttpServletResponse response)throws Exception{
		List<IBOAigaTestPlanValue> iBOAigaTestPlanList = new ArrayList<IBOAigaTestPlanValue>();
		List<IBOAlmStakeholderValue> iBOAlmStakeholderList = new ArrayList<IBOAlmStakeholderValue>();
		List<IBOAlmWorkorderValue> iBOAlmWorkorderList = new ArrayList<IBOAlmWorkorderValue>();
		List<IBOAigaTestTaskValue> iBOAigaTestTaskList = new ArrayList<IBOAigaTestTaskValue>();
		List<IBOAigaSolidTaskValue> iBOAigaSolidTaskList = new ArrayList<IBOAigaSolidTaskValue>();
		List<IBOAigaTestSubTaskValue> iBOAigaTestSubTaskList = new ArrayList<IBOAigaTestSubTaskValue>();
		
		String jsonObjectString = request.getParameter("jsonInfo");
		
		JSONObject jsonObject = new JSONObject();
		try{
			jsonObjectString = new String(request.getParameter("jsonInfo").getBytes("ISO-8859-1"),"GBK").toString();
			
			//将页面元素值JSON串解析为LIST，包括工单，多个干系人、测试计划对象、测试任务，固化任务
			getDatasFromRequestInputstream(jsonObjectString, iBOAigaTestPlanList, iBOAlmStakeholderList, iBOAlmWorkorderList, 
					iBOAigaTestTaskList, iBOAigaSolidTaskList,iBOAigaTestSubTaskList);
			
			//解析普通任务ID
			JSONObject result = JSONObject.fromObject(jsonObjectString); //转换为JSONObject              
			int num = result.length(); 
			Object taskId = null;
			
			String taskIdString = "";
			if(result != null && num>0)
			{
				if(result.has("startTaskId")){
					taskId = result.get("startTaskId");
					taskIdString = taskId.toString();
				}
			}
			
			//调用启动流程SV
			IAigaTestTaskSV iAigaTestTaskSV = (IAigaTestTaskSV)ServiceFactory.getService(IAigaTestTaskSV.class);
			iAigaTestTaskSV.startPerfTestTaskWorkflow(iBOAigaTestTaskList.get(0),iBOAlmStakeholderList,iBOAlmWorkorderList.get(0),taskIdString);
			jsonObject.put("flag", "success");
		}catch(Exception e){
			jsonObject.put("flag", "'"+e.getMessage()+"'");
		}finally{
			response.setContentType("application/json;charset=gbk");
			response.getWriter().write(jsonObject.toString());
		}
		
	}
	
	//保存性能测试任务
	public void savePerfTestTaskWorkflow(HttpServletRequest request,HttpServletResponse response)throws Exception{
		List<IBOAigaTestPlanValue> iBOAigaTestPlanList = new ArrayList<IBOAigaTestPlanValue>();
		List<IBOAlmStakeholderValue> iBOAlmStakeholderList = new ArrayList<IBOAlmStakeholderValue>();
		List<IBOAlmWorkorderValue> iBOAlmWorkorderList = new ArrayList<IBOAlmWorkorderValue>();
		List<IBOAigaTestTaskValue> iBOAigaTestTaskList = new ArrayList<IBOAigaTestTaskValue>();
		List<IBOAigaSolidTaskValue> iBOAigaSolidTaskList = new ArrayList<IBOAigaSolidTaskValue>();
		List<IBOAigaTestSubTaskValue> iBOAigaTestSubTaskList = new ArrayList<IBOAigaTestSubTaskValue>();
		
		String jsonObjectString = request.getParameter("jsonInfo");
		
		JSONObject jsonObject = new JSONObject();
		try{
			jsonObjectString = new String(request.getParameter("jsonInfo").getBytes("ISO-8859-1"),"GBK").toString();
			
			//将页面元素值JSON串解析为LIST，包括工单，多个干系人、测试计划对象、测试任务，固化任务
			getDatasFromRequestInputstream(jsonObjectString, iBOAigaTestPlanList, iBOAlmStakeholderList, iBOAlmWorkorderList, 
					iBOAigaTestTaskList, iBOAigaSolidTaskList,iBOAigaTestSubTaskList);
			
			//调用启动流程SV
			IAigaTestTaskSV iAigaTestTaskSV = (IAigaTestTaskSV)ServiceFactory.getService(IAigaTestTaskSV.class);
			iAigaTestTaskSV.savePerfTestTaskWorkflow(iBOAigaTestTaskList.get(0));
			jsonObject.put("flag", "success");
		}catch(Exception e){
			jsonObject.put("flag", "'"+e.getMessage()+"'");
		}finally{
			response.setContentType("application/json;charset=gbk");
			response.getWriter().write(jsonObject.toString());
		}
		
	}
	
	//子任务转派
	public void subTaskRegn(HttpServletRequest request,HttpServletResponse response)throws Exception{
		List<IBOAlmStakeholderValue> iBOAlmStakeholderList = new ArrayList<IBOAlmStakeholderValue>();
		List<IBOAlmWorkorderValue> iBOAlmWorkorderList = new ArrayList<IBOAlmWorkorderValue>();
		List<IBOAigaTestPlanValue> iBOAigaTestPlanList = new ArrayList<IBOAigaTestPlanValue>();
		List<IBOAigaTestTaskValue> iBOAigaTestTaskList = new ArrayList<IBOAigaTestTaskValue>();
		List<IBOAigaSolidTaskValue> iBOAigaSolidTaskList = new ArrayList<IBOAigaSolidTaskValue>();
		List<IBOAigaTestSubTaskValue> iBOAigaTestSubTaskValue = new ArrayList<IBOAigaTestSubTaskValue>();
		List<IBOAigaSubTaskProblemValue> iBOAigaSubTaskProblemValue = new ArrayList<IBOAigaSubTaskProblemValue>();
		
		String jsonObjectString = request.getParameter("jsonInfo");
		JSONObject jsonObject = new JSONObject();
		try{
			//将页面元素值JSON串解析为LIST，包括工单，多个干系人、测试计划对象、测试任务，固化任务
			getDatasFromRequestInputstreamForOrderSubmit(jsonObjectString, iBOAlmStakeholderList,iBOAlmWorkorderList,
					iBOAigaTestPlanList,  iBOAigaTestTaskList, 
					iBOAigaSolidTaskList,iBOAigaTestSubTaskValue,iBOAigaSubTaskProblemValue);
			
			jsonObjectString = new String(request.getParameter("jsonInfo").getBytes("ISO-8859-1"),"GBK").toString();
			JSONObject result = JSONObject.fromObject(jsonObjectString); //转换为JSONObject 
			Object objType = null;
			String objTypeString = "";
			int num = result.length();  
			JSONObject subTaskRegnInfo = null;
			if(result != null && num>0)
			{
				if(result.has("subTaskRegnInfo"))
					subTaskRegnInfo = result.getJSONObject("subTaskRegnInfo");
				if(result.has("objType")){
					objType = result.get("objType");//获取任务类型
					objTypeString = objType.toString();
				}
			}
			//调用启动流程SV
			IAigaTestTaskSV iAigaTestTaskSV = (IAigaTestTaskSV)ServiceFactory.getService(IAigaTestTaskSV.class);
			iAigaTestTaskSV.subTaskRegn(iBOAlmStakeholderList, iBOAlmWorkorderList, iBOAigaTestPlanList, 
					iBOAigaTestTaskList, iBOAigaSolidTaskList,iBOAigaTestSubTaskValue,
					iBOAigaSubTaskProblemValue,objTypeString,subTaskRegnInfo);
			jsonObject.put("flag", "success");
		}catch(Exception e){
			jsonObject.put("flag", "'"+e.getMessage()+"'");
		}finally{
			response.setContentType("application/json;charset=gbk");
			response.getWriter().write(jsonObject.toString());
		}
		
	}
	
	
//	public static void main(String[] args) throws Exception
//	{
//		getDatasFromRequestInputstreamForOrderSubmit("", null, null, null, null, null, null);
//	}
}


