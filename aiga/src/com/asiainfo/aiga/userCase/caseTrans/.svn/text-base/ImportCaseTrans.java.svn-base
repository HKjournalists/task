package com.asiainfo.aiga.userCase.caseTrans;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.URLDecoder;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.aigaUrlConfig.AigaUrlConfigUtil;
import com.asiainfo.aiga.userCase.service.IAigaCaseSV;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.spi.HttpServerProvider;

public class ImportCaseTrans {
	private IAigaCaseSV aigaCaseSV;
	
	public void setAigaCaseSV(IAigaCaseSV aigaCaseSV) {
		this.aigaCaseSV = aigaCaseSV;
	}

	private static HttpServer httpserver = null;
	public void startService() throws IOException {
		String config = AigaUrlConfigUtil.getValue("recieveCaseUrl");
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
			try {
				InputStream in = httpExchange.getRequestBody();
				BufferedReader reader = new BufferedReader(
						new InputStreamReader(in));
				String temp = null;
				String msg = "";
				URLDecoder decoder = new URLDecoder();
				while ((temp = reader.readLine()) != null) {
					msg += temp;
				}
				aigaCaseSV.saveImportCase(new BaseAction().unicodeToString(msg));
				System.out.println(responseMsg);
				responseMsg = "Y";
			} catch (Exception e) {
				// TODO Auto-generated catch block
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
