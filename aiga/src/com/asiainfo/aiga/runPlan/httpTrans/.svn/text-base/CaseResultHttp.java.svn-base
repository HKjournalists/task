package com.asiainfo.aiga.runPlan.httpTrans;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jgroups.tests.adaptjms.Request;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.aigaUrlConfig.AigaUrlConfigUtil;
import com.asiainfo.aiga.common.helper.XMLHelper;
import com.asiainfo.aiga.log.bo.AigaLogTestCase;
import com.asiainfo.aiga.log.dao.IAigaLogDao;
import com.asiainfo.aiga.runPlan.bo.AigaRunPlan;
import com.asiainfo.aiga.runPlan.service.IAigaRunPlanSV;
import com.asiainfo.aiga.runTask.bo.AigaRunTask;
import com.asiainfo.aiga.runTask.dao.IAigaRunTaskDAO;
import com.asiainfo.aiga.runTask.service.IAigaRunTaskSV;
import com.asiainfo.aiga.userCase.service.IAigaCaseSV;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.spi.HttpServerProvider;

public class CaseResultHttp {

	private IAigaRunPlanSV aigaRunPlanSV;
	private IAigaRunTaskDAO aigaRunTaskDAO;
	private static HttpServer httpserver = null;
	private IAigaLogDao aigaLogDao;
	public void setAigaLogDao(IAigaLogDao aigaLogDao) {
		this.aigaLogDao = aigaLogDao;
	}
	
	public void setAigaRunPlanSV(IAigaRunPlanSV aigaRunPlanSV) {
		this.aigaRunPlanSV = aigaRunPlanSV;
	}

	public void setAigaRunTaskDAO(IAigaRunTaskDAO aigaRunTaskDAO) {
		this.aigaRunTaskDAO = aigaRunTaskDAO;
	}

	public void startService() throws IOException {
		String config = AigaUrlConfigUtil.getValue("recieveLogUrl");
		String port = config.split(",")[0].split(":")[1];
		String url = config.split(",")[1].split(":")[1];
		HttpServerProvider provider = HttpServerProvider.provider();
		httpserver = provider.createHttpServer(
				new InetSocketAddress(Integer.valueOf(port)), 1);
		httpserver.createContext(url, new CaseResultHttpHandle());
		httpserver.setExecutor(null);
		httpserver.start();
		System.out.println("************************server started***************************");
	}
	
	public void stopService() throws Exception{
		httpserver.stop(0);
		System.out.println("************************stop server***************************");
	}

	class CaseResultHttpHandle implements HttpHandler {
		public void handle(HttpExchange httpExchange) throws IOException {
//			List<String> taskIds = httpExchange.getRequestHeaders().get("taskId");
//			List<String> caseIds = httpExchange.getRequestHeaders().get("caseId");
			String query = httpExchange.getRequestURI().getQuery();
			String[] querys = query.split("&");
			Map<String,String> queryMap = new HashMap<String, String>();
			for(String quy : querys){
				String[] params = quy.split("=");
				queryMap.put(params[0], params[1]);
			}
			String caseId = queryMap.get("caseId");
			String taskId = queryMap.get("taskId");
//			if(taskIds.size()!=1)
//				throw new IOException("接收信息中未查找到taskId");
//			if(caseIds.size()!=1)
//				throw new IOException("接收信息中未查找到caseId");
			String responseMsg = "";
			InputStream in = httpExchange.getRequestBody();
			BufferedReader reader = new BufferedReader(
					new InputStreamReader(in));
			String temp = null;
			String msg = "";
			while ((temp = reader.readLine()) != null) {
				msg += temp;
			}
			try {
				System.out.println("message1:"+msg);
				msg = new BaseAction().unicodeToString(msg);
				System.out.println("message2:"+msg);
				AigaRunPlan[] aigaRunPlans = aigaRunPlanSV.getAigaRunPlanBySql("from AigaRunPlan where caseId="+caseId+" and taskId='"+taskId+"'");
				if(aigaRunPlans.length!=1)
					throw new Exception("未查找到相应的执行及计划");
				aigaRunPlans[0].setStatus("3");
				aigaRunPlanSV.saveOrUpdate(aigaRunPlans[0]);
				AigaLogTestCase aigaLogTestCase = XMLHelper.getTestCase4XML(msg,caseId);
				aigaLogTestCase.setRunId(Integer.valueOf(aigaRunPlans[0].getRunId()));
				aigaLogTestCase.setCaseType(1);
				aigaLogDao.saveLog(aigaLogTestCase);
				aigaRunPlans = aigaRunPlanSV.getAigaRunPlanBySql("from AigaRunPlan where taskId='"+caseId+"' and status=1");
				if(aigaRunPlans.length==0){
					AigaRunTask[] aigaRunTask = aigaRunTaskDAO.getAigaRunTaskBySql("from AigaRunTask where taskId='"+taskId+"'");
					if(aigaRunTask.length!=1)
						throw new Exception("查找到的执行任务不唯一");
					aigaRunTask[0].setTaskStatus("3");
					aigaRunTaskDAO.saveOrUpdate(aigaRunTask[0]);
				}
				responseMsg = "Y";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				AigaRunPlan[] aigaRunPlans;
				try {
					aigaRunPlans = aigaRunPlanSV.getAigaRunPlanBySql("from AigaRunPlan where caseId="+caseId+" and taskId='"+taskId+"'");
					if(aigaRunPlans.length!=1)
						throw new Exception("查找到的执行任务不唯一");
					aigaRunPlans[0].setStatus("5");
					aigaRunPlanSV.saveOrUpdate(aigaRunPlans[0]);
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				e.printStackTrace();
				responseMsg = "N";
			}
			httpExchange.sendResponseHeaders(200, responseMsg.getBytes().length);
			OutputStream out = httpExchange.getResponseBody(); 
			out.write(responseMsg.getBytes());
			out.flush();
			httpExchange.close();
		}
	}
}
