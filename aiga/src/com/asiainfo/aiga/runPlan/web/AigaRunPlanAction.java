package com.asiainfo.aiga.runPlan.web;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.DynamicBean;
import com.asiainfo.aiga.common.aigaUrlConfig.AigaUrlConfigUtil;
import com.asiainfo.aiga.common.helper.ActionHelper;
import com.asiainfo.aiga.r_collect_case.bo.AigaRFunCase;
import com.asiainfo.aiga.requisition.bo.AigaTestSubTask;
import com.asiainfo.aiga.requisition.service.IAigaRequisitionSV;
import com.asiainfo.aiga.runPlan.bo.AigaRunPlan;
import com.asiainfo.aiga.runPlan.service.IAigaRunPlanSV;
import com.asiainfo.aiga.runPlan.service.impl.AigaRunResultTree;
import com.asiainfo.aiga.runTask.bo.AigaHisRunTaskResult;
import com.asiainfo.aiga.runTask.bo.AigaRunTask;
import com.asiainfo.aiga.runTask.service.IAigaRunTaskSV;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.bo.extend.AigaInstCase;
import com.asiainfo.aiga.userCase.service.IAigaCaseSV;

@Controller
public class AigaRunPlanAction extends BaseAction {
	private final static String CATEGORY="aiga_run_plan";
	@Resource(name="caseSV")
	private IAigaCaseSV aigaCaseSV;
	@Resource(name="requisitionSV")
	private IAigaRequisitionSV reqSV;
	@Resource(name="aigaRunPlanSV")
	private IAigaRunPlanSV aigaRunPlanSV;
	@Resource(name="aigaRunTaskSV")
	private IAigaRunTaskSV aigaRunTaskSV;
	
	@RequestMapping(value="/getRunResult.do")
	public void getRunResult(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String taskId = request.getParameter("taskId");
		String subTaskId = request.getParameter("subTaskId");
		JSONArray json = new JSONArray();
		Object[] objects = null;
		if (taskId != null && !taskId.equals("")&&subTaskId != null && !subTaskId.equals("")) {
			AigaRunPlan[] runPlans = aigaRunPlanSV.getAigaRunPlanBySql("from AigaRunPlan where taskId='"+taskId+"' and status='1'");
			int n = runPlans.length;
			objects = new Object[n];
			AigaTestSubTask[] aigaTestSubTasks = reqSV
					.getAigaTestSubTaskBySql("From AigaTestSubTask where subTaskId="
							+ subTaskId);
			if (aigaTestSubTasks.length != 1) {
				throw new Exception("测试子任务id不唯一或者找不到该测试子任务");
			}
			for (int i = 0; i < n; i++) {
				AigaRunPlan runPlan = runPlans[i];
				AigaCase[] aigaCases = aigaCaseSV.getAigaCaseById(
						runPlan.getCaseId(), AigaInstCase.class);
				//AigaLogTestCase[] testCases = aigaRunTaskSV.getAigaLogTestCaseByRunId(runPlan.getRunId());
				if(StringUtils.isBlank(runPlan.getRunResult())){
					runPlan.setRunResult("0");
				}
				// 暂时存储需求名称
				runPlan.setRunName(aigaTestSubTasks[0].getSubTaskName());
				Object[] objs = new Object[] { runPlan, aigaCases[0] };
				DynamicBean bean = new DynamicBean(objs);
				objects[i] = bean.getObject();
			}

		} else
			objects = new Object[] { "{}" };
		json = JSONArray.fromObject(objects, jsonConfig);
		System.out.println(json);
		ActionHelper.responseData4JSON(request, response, json);
	}
	
	@RequestMapping(value="/saveRunResult.do")
	public void saveRunResult(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			Object[] objects=this.transTableToObj(request, AigaRunPlan.class);
			for(Object obj:objects){
				AigaRunPlan runPlan=(AigaRunPlan)obj;
				runPlan.setRunTime(new Timestamp(new Date().getTime()));
				aigaRunPlanSV.saveOrUpdate(runPlan);
			}
			//设置aiga_run_task表task_status状态
			boolean flag=true;
			String taskId=((AigaRunPlan)objects[0]).getTaskId();
			AigaRunPlan[] runPlans = aigaRunPlanSV.getAigaRunPlanByTaskId(taskId);
			for(AigaRunPlan runPlan:runPlans){
				if(StringUtils.isBlank(runPlan.getRunResult())||!"1".equals(runPlan.getRunResult())){
					flag=false;
				}
				
			}
			AigaRunTask aigaRunTask=aigaRunTaskSV.getAigaRunTaskByTaskId(taskId);
			aigaRunTask.setUpdateTime(new Timestamp(new Date().getTime()));
			if(flag){
				aigaRunTask.setTaskStatus("3");
			}else{
				aigaRunTask.setTaskStatus("2");
			}
			aigaRunTaskSV.saveAigaRunTask(aigaRunTask);
			List<AigaHisRunTaskResult> list=new ArrayList<AigaHisRunTaskResult>();
			for(AigaRunPlan runplan:runPlans){
				AigaHisRunTaskResult result=new AigaHisRunTaskResult();
				result.setCaseId(runplan.getCaseId());
				result.setRunId(runplan.getRunId());
				result.setRunName(runplan.getRunName());
				result.setRunResult(runplan.getRunResult());
				result.setRunTime(runplan.getRunTime());
				result.setTaskId(runplan.getTaskId());
				result.setRelaResult(runplan.getRelaResult());
				result.setTaskStatus(aigaRunTask.getTaskStatus());
				result.setSubTaskId(aigaRunTask.getSubTaskId());
				result.setTaskTag(aigaRunTask.getTaskTag());
				result.setTaskName(aigaRunTask.getTaskName());
				result.setCollectType(aigaRunTask.getCollectType());
				result.setCreateTime(aigaRunTask.getCreateTime());
				list.add(result);
			}
			aigaRunTaskSV.saveAigaHisRunTaskResult(list.toArray(new AigaHisRunTaskResult[0]));
//			System.out.println(list.size());
			this.setPostInfo("success", true);
			
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value="/saveRunTask.do")
	public void saveRunTask(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			Object[] objects=this.transTableToObj(request, AigaRFunCase.class);
			String subTaskId=request.getParameter("subTaskId");
			String taskName =request.getParameter("taskName");
			aigaRunTaskSV.saveRunTask( subTaskId, taskName, objects);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value="/getRunTask.do")
	public void getRunTask(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String subTaskId = request.getParameter("subTaskId");
			if(subTaskId==null||subTaskId.equals(""))
				throw new Exception("缺少subTaskId参数");
			AigaRunTask[] aigaRunTasks = aigaRunTaskSV.getAigaRunTaskBySubTaskId(Integer.valueOf(subTaskId));
			this.setTable(aigaRunTasks);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value="/getTaskTree.do")
	public void getTaskTree(HttpServletRequest request, HttpServletResponse response)throws Exception{
		ApplicationContext context = RequestContextUtils.getWebApplicationContext(request);
		AigaRunResultTree aigaRunResultTree = (AigaRunResultTree)context.getBean("aigaRunResultTree");
		this.setTree(aigaRunResultTree,request);
		this.postInfo(request, response);
	}
	
	@RequestMapping(value="/startTask.do")
	public void startTask(HttpServletRequest request, HttpServletResponse response)throws Exception{
		try{
			String taskId = request.getParameter("taskId");
			aigaRunTaskSV.saveStartTask(taskId);
			String retStr = "";
			String urlStr = AigaUrlConfigUtil.getValue("sendCaseIdUrl")+"?caseId=1576&taskId="+taskId+"&caseName=passed.它营厅合约清单_正常_选择机型查询";
			System.out.println(urlStr);
			URL url = new URL(chineseToUnicode(urlStr));
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			con.setReadTimeout(30*1000);
			con.setDoInput(true);
			con.setDoOutput(true);
			con.connect();
			InputStream in = con.getInputStream();
			InputStreamReader reader = new InputStreamReader(in);
			BufferedReader buf = new BufferedReader(reader);
			retStr = buf.readLine();
			if(retStr == null) {
				retStr = "";
			}
			retStr = URLDecoder.decode(retStr,"UTF-8");
			reader.close();
			con.disconnect();
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
			this.setPostInfo("message", e.getCause());
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value="/deleteTask.do")
	public void deleteTask(HttpServletRequest request, HttpServletResponse response)throws Exception{
		String taskId = request.getParameter("taskId");
		if(taskId==null||taskId.equals(""))
			throw new Exception("缺少参数，taskId");
		aigaRunTaskSV.deleteAigaRunTask(taskId);
		AigaRunPlan[] aigaRunPlans=aigaRunPlanSV.getAigaRunPlanByTaskId(taskId);
		aigaRunPlanSV.deleteAll(Arrays.asList(aigaRunPlans));
	}
	
	public static String chineseToUnicode(String str) {
        String result = "";
        for (int i = 0; i < str.length(); i++) {
            int chr1 = (char) str.charAt(i);
            // [12288, 12351] : CJK Symbols and Punctuation
            // [19968, 171941] : CJK Unified Ideographs (including chinese)
            if ((chr1 >= 12288 && chr1 <= 12351) || (chr1 >= 19968 && chr1 <= 171941)) {
                result += "\\u" + Integer.toHexString(chr1);
            } else {
                result += str.charAt(i);
            }
        }
        return result;
    }
	 
}
