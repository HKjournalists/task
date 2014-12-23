package com.asiainfo.aiga.common.security.user;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;

public class URLConnectUtil {
	
	public static String getMenuXml(String code, String urlStr) throws Exception {
		String menuXml = "<menu id1='1' caption='亚信固网运营支撑系统' img='' url=''>" +
				"<menu id1='27' caption='我的工作区' img='null' url='null'>" +
					"<menu id1='37' caption='测试子任务分析' img='/css/images/menu_icons/ic20.gif' url='/aiga/workflow/subTaskAnalysis.jsp?subTaskId=1'></menu>" +
					"<menu id1='38' caption='标签管理' img='/css/images/menu_icons/ic22.gif' url='/aiga/label/label.jsp'></menu>" +
					"<menu id1='39' caption='运行结果' img='/css/images/menu_icons/ic35.gif' url='/aiga/userCase/runResult.jsp?subTaskId=1'></menu>" +
					"<menu id1='40' caption='用例库管理' img='/css/images/menu_icons/ic19.gif' url='/aiga/userCase/caseLib.jsp'></menu>" +
					"<menu id1='41' caption='组件库管理' img='/css/images/menu_icons/ic18.gif' url='/aiga/component/compLib.jsp'></menu>" +
					"<menu id1='42' caption='控件库管理' img='/css/images/menu_icons/ic25.gif' url='/aiga/component/guiLib.jsp'></menu>" +
				"</menu></menu>";
		try {
			URL url = new URL(urlStr+"&uid=" + code);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			con.setReadTimeout(30*1000);
			con.setDoInput(true);
			con.setDoOutput(true);
			con.connect();
//			OutputStream out = con.getOutputStream();
//			out.flush();
//			out.close();
			InputStream in = con.getInputStream();
			InputStreamReader reader = new InputStreamReader(in);
			BufferedReader buf = new BufferedReader(reader);
			menuXml = buf.readLine();
			menuXml = URLDecoder.decode(menuXml,"UTF-8");
			System.out.println(menuXml);
			reader.close();
			con.disconnect();
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("获取菜单失败。。。。。。");
		}
		
		return menuXml;
	}
	
	public static String getStaffOrg(String code, String urlStr) throws Exception {
		String orgName = "";
		try {
			URL url = new URL(urlStr+"&uid=" + code);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			con.setReadTimeout(30*1000);
			con.setDoInput(true);
			con.setDoOutput(true);
			con.connect();
//			OutputStream out = con.getOutputStream();
//			out.flush();
//			out.close();
			InputStream in = con.getInputStream();
			InputStreamReader reader = new InputStreamReader(in);
			BufferedReader buf = new BufferedReader(reader);
			orgName = buf.readLine();
			orgName = URLDecoder.decode(orgName,"UTF-8");
			reader.close();
			con.disconnect();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return orgName;
	}
	
	public static void main(String[] args) throws Exception {
		String urlStr = "http://127.0.0.1:8080/aigaWorkflow/business/com.asiainfo.csc.common.web.WorkflowParamAction?action=getWorkflowParam";
		//String menuXml = getMenuXml("ADMINISTRATOR", urlStr);
		String menuXml = getStaffOrg("ADMINISTRATOR", urlStr);
		System.out.println(menuXml);
	}

}
