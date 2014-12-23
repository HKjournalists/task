package com.asiainfo.aiga.userCase.caseTrans;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;
import java.util.Date;

import net.sf.json.JSONArray;

import org.hibernate.criterion.DetachedCriteria;

import com.asiainfo.aiga.common.aigaUrlConfig.AigaUrlConfigUtil;
import com.asiainfo.aiga.runPlan.bo.AigaRunPlan;
import com.asiainfo.aiga.runPlan.dao.IAigaRunPlanDAO;
import com.asiainfo.aiga.runTask.bo.AigaRunTask;
import com.asiainfo.aiga.runTask.dao.IAigaRunTaskDAO;
import com.asiainfo.aiga.userCase.bo.AigaCase;
import com.asiainfo.aiga.userCase.bo.extend.AigaInstCase;
import com.asiainfo.aiga.userCase.service.IAigaCaseSV;

public class CaseHttpSend {

	private IAigaRunPlanDAO aigaRunPlanDAO;
	private IAigaRunTaskDAO aigaRunTaskDAO;
	private IAigaCaseSV aigaCaseSV;

	public void setAigaCaseSV(IAigaCaseSV aigaCaseSV) {
		this.aigaCaseSV = aigaCaseSV;
	}

	public void setAigaRunPlanDAO(IAigaRunPlanDAO aigaRunPlanDAO) {
		this.aigaRunPlanDAO = aigaRunPlanDAO;
	}

	public void setAigaRunTaskDAO(IAigaRunTaskDAO aigaRunTaskDAO) {
		this.aigaRunTaskDAO = aigaRunTaskDAO;
	}

	public void sendCase(String taskId) throws Exception {
		String caseIds = "";
		AigaRunPlan[] aigaRunPlans = aigaRunPlanDAO
				.getAigaRunPlanBySql("from AigaRunPlan where taskId='" + taskId
						+ "' order by caseOrder asc");
		if (aigaRunPlans == null || aigaRunPlans.length == 0)
			throw new Exception("未查找到相应的执行计划");
		for (int i = 0, n = aigaRunPlans.length; i < n; i++) {
			Integer caseId = aigaRunPlans[i].getCaseId();
			AigaCase[] aigaCases  = aigaCaseSV.getAigaCaseById(caseId, AigaInstCase.class);
			if(aigaCases.length!=1)
				throw new Exception("未查找到用例信息");
			if(!aigaCases[0].getHasTest().equals(0))
				continue;
			if (i == n - 1)
				caseIds += aigaRunPlans[i].getCaseId();
			else
				caseIds += aigaRunPlans[i].getCaseId() + ",";
		}
		AigaRunTask[] aigaRunTasks = aigaRunTaskDAO
				.getAigaRunTaskBySql("from AigaRunTask where task_id='"
						+ taskId + "'");
		if (aigaRunTasks == null || aigaRunTasks.length == 0)
			throw new Exception("未查找到相应的测试任务");
		aigaRunPlans[0].setRunTime(new Timestamp(new Date().getTime()));
		aigaRunPlans[0].setStatus("2");
		aigaRunPlanDAO.saveOrUpdate(aigaRunPlans[0]);
		aigaRunTasks[0].setTaskStatus("22");
		aigaRunTaskDAO.saveOrUpdate(aigaRunTasks[0]);
		this.sendMsg(caseIds, taskId);
	}

	public void sendMsg(String caseIds,String taskId)
			throws Exception {
		URL url = new URL(AigaUrlConfigUtil.getValue("sendCaseIdUrl")+"?taskId="+taskId+"&caseIds="+caseIds);
		HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
//		urlConn.setRequestProperty("caseIds", caseIds);
		urlConn.setRequestProperty("taskId", taskId);
		urlConn.setDoOutput(true);
		urlConn.setDoInput(true);
		urlConn.setRequestMethod("POST");
		/*new code start*/
//		JSONArray array = new JSONArray();
//		String[] caseId = caseIds.split(",");
//		for(String id : caseId){
//			array.add(id);
//		}
//		OutputStream out = new DataOutputStream(urlConn.getOutputStream());
//		out.write(array.toString().getBytes());
//		out.flush();
//		out.close();
		/*new code end*/
		BufferedReader reader = null;
		InputStream in = null;
		try {
			if (urlConn.getResponseCode() == 200) {
				in = urlConn.getInputStream();
				reader = new BufferedReader(new InputStreamReader(in));
				String temp = "";
				while ((temp = reader.readLine()) != null) {
					System.out.println("server response:" + temp);
				}
			} else
				throw new Exception("请求执行用例失败");
		} finally {
			if(reader!=null)
				reader.close();
			if(in!=null)
				in.close();
			urlConn.disconnect();
		}
	}
	
	public String chinaToUnicode(String str) {
		String result = "";
		for (int i = 0; i < str.length(); i++) {
			int chr1 = (char) str.charAt(i);
			if ((chr1 >=12288 && chr1 <=12351) || (chr1 >= 19968 && chr1 <= 171941)) {
				result += "\\u" + Integer.toHexString(chr1);
			} else {
				result += str.charAt(i);
			}
		}
		return result;
	}
}
