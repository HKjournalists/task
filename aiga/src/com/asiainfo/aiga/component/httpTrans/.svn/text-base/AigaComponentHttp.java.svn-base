package com.asiainfo.aiga.component.httpTrans;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.URLDecoder;

import com.asiainfo.aiga.component.service.IAigaComponentSV;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.spi.HttpServerProvider;


public class AigaComponentHttp {
	
	private IAigaComponentSV aigaComponentSV;
	
	public void setAigaComponentSV(IAigaComponentSV aigaComponentSV) {
		this.aigaComponentSV = aigaComponentSV;
	}
	
	private static HttpServer httpserver = null;
	public void startService() throws IOException {
		HttpServerProvider provider = HttpServerProvider.provider();
		httpserver = provider.createHttpServer(
				new InetSocketAddress(9999), 1);
		httpserver.createContext("/sendComp", new CompHttpHandle());
		httpserver.setExecutor(null);
		httpserver.start();
		System.out.println("************************server started***************************");
	}
	
	public void stopService() throws Exception{
		httpserver.stop(0);
		System.out.println("************************stop server***************************");
	}

	class CompHttpHandle implements HttpHandler {
		public void handle(HttpExchange httpExchange) throws IOException {
			String responseMsg = "";
			InputStream in = httpExchange.getRequestBody();
			BufferedReader reader = new BufferedReader(
					new InputStreamReader(in));
			String temp = null;
			String msg = "";
			URLDecoder decoder = new URLDecoder();
			while ((temp = reader.readLine()) != null) {
				msg += temp;
			}
			msg = decoder.decode(msg, "UTF-8");
			System.out.println("message:"+msg);
			try {
				aigaComponentSV.saveTransCompJson(msg);
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