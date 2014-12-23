package com.asiainfo.aiga.userCase.caseTrans;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.InetSocketAddress;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.aigaUrlConfig.AigaUrlConfigUtil;
import com.asiainfo.aiga.userCase.service.IAigaCaseSV;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.spi.HttpServerProvider;

public class CaseHttpTrans {

	private IAigaCaseSV aigaCaseSV;
	
	public void setAigaCaseSV(IAigaCaseSV aigaCaseSV) {
		this.aigaCaseSV = aigaCaseSV;
	}
	private static HttpServer httpserver = null;
	public void startService() throws IOException {
		String config = AigaUrlConfigUtil.getValue("recieveCaseId");
		String port = config.split(",")[0].split(":")[1];
		String url = config.split(",")[1].split(":")[1];
		HttpServerProvider provider = HttpServerProvider.provider();
		httpserver = provider.createHttpServer(
				new InetSocketAddress(Integer.valueOf(port)), 1);
		httpserver.createContext(url, new caseHttpHandle());
		httpserver.setExecutor(null);
		httpserver.start();
		System.out.println("************************server started***************************");
	}
	
	public void stopService() throws Exception{
		httpserver.stop(0);
		System.out.println("************************stop server***************************");
	}

	class caseHttpHandle implements HttpHandler {
		public void handle(HttpExchange httpExchange) throws IOException {
			String responseMsg = "";
			List<String> caseIds = httpExchange.getRequestHeaders().get("caseId");
			List<String> taskIds = httpExchange.getRequestHeaders().get("taskId");
			if(caseIds.size()!=1)
				throw new IOException("接收信息中未查找到caseid");
			if(taskIds.size()!=1)
				throw new IOException("接收信息中未查找到taskIds");
			System.out.println("caseId:"+caseIds.get(0)+",runId:"+taskIds.get(0));
			try {
				responseMsg = aigaCaseSV.getAigaCompByCaseId(caseIds.get(0),taskIds.get(0));
				System.out.println(responseMsg);
				responseMsg = this.chinaToUnicode(responseMsg);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				responseMsg = "N";
			}
			System.out.println(responseMsg);
			httpExchange.sendResponseHeaders(200, responseMsg.getBytes().length);
			OutputStream out = httpExchange.getResponseBody(); 
			out.write(responseMsg.getBytes());
			out.flush();
			httpExchange.close();
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
	
	public static void main(String args[])throws Exception{
		
		ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
		IAigaCaseSV aigaCaseSV = (IAigaCaseSV)applicationContext.getBean("caseSV");
		System.out.println(aigaCaseSV.getAigaCompByCaseId("1353","4028a18a4786384a0147863b81420004"));
	}
}
