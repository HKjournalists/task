package com.asiainfo.aiga.common.web;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.CommonUtil;
import com.asiainfo.aiga.common.WorkflowParam;
import com.asiainfo.aiga.common.helper.ActionHelper;
import com.asiainfo.aiga.common.security.user.bo.AigaUser;
import com.asiainfo.aiga.common.security.user.util.IUtil;
import com.asiainfo.aiga.common.workflowVo.Workflow;
import com.asiainfo.aiga.sysConstant.bo.SysConstant;
import com.asiainfo.aiga.sysConstant.util.SysContentUtil;
import com.asiainfo.lucene.LuceneEntities.properties.LuceneCommon;
@Controller
public class CommonUtilAction extends BaseAction {
	private static Logger logger = Logger.getLogger(CommonUtilAction.class);
	@RequestMapping(value="/refreshCache.do")
	public void refreshCache(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Map<String, Object> map =new HashMap<String, Object>();
		String flag=request.getParameter("flag");
		flag=this.NaNull(flag)?flag:"";
		String beanId=SysContentUtil.getSysConstant("AIGA_REFRESH_CACHE", flag).getMemo();
		if(!this.NaNull(beanId))throw new Exception("beanId未配置");
		try{
			ApplicationContext context = RequestContextUtils.getWebApplicationContext(request);
			((IUtil)context.getBean(beanId)).init();
			Thread.sleep(500);
			map.put("success", true);
			map.put("message", "刷新成功");
		}catch (Exception e) {
			map.put("success", false);
			map.put("message", e.getMessage());
		}finally{
			logger.info(map.get("message"));
			ActionHelper.returnResponseJsonMap(request, response, map);
		}
	}
	@RequestMapping("/refreshWorkflowParam.do")
	public void refreshWorkflowParam(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Map<String, Object> map =new HashMap<String, Object>();
		try{ApplicationContext applicationContext= RequestContextUtils.getWebApplicationContext(request);
		com.asiainfo.aiga.common.WorkflowParam  workflowParam = (com.asiainfo.aiga.common.WorkflowParam)applicationContext.getBean("workflowParam");
		workflowParam.initWorkflowParam();
		Thread.sleep(500);
		map.put("success", true);
		map.put("message", "刷新成功");
		}catch (Exception e) {
			map.put("success", false);
			map.put("message", e.getMessage());
		}finally{
			ActionHelper.returnResponseJsonMap(request, response, map);
		}
	}
	@RequestMapping(value = "/getSysConstantStore.do")
	public void getSysConstantStore(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String category=request.getParameter("category");
		String categoryName=request.getParameter("query");
		Map<String, Object> map=new HashMap<String, Object>();
		if(NaNull(category)){
			map.put("success", false);
			SysConstant[] sysContants=SysContentUtil.getSysContant(category);
			List<SysConstant> list=new ArrayList<SysConstant>();
			if(NaNull(categoryName)){
				for (SysConstant sysConstant : sysContants) {
					if (!sysConstant.getCategoryName().equals(categoryName))continue;
					list.add(sysConstant);
				}
				map.put("data", list);
			}else{
				map.put("data", sysContants);
			}
			
			if(sysContants==null)throw new Exception("请检查sys_constant是否有所对应的配置\n 或者未刷新 点击"+request.getContextPath()+"/refreshSysContent.do 刷新");
			map.put("success", true);
		
		}else{
			logger.error("category 为空。");
		}
		ActionHelper.returnResponseJsonMap(request, response, map);
	}
	@RequestMapping(value = "/getMultipleSysConstant.do")
	public void getMultipleSysConstant(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String categorys=request.getParameter("categorys");
		Map<String, Object> map=new HashMap<String, Object>();
		if(NaNull(categorys)){
			String[] categoryArray=categorys.split(",");
			map.put("success", false);
			SysConstant[] sysContants=SysContentUtil.getSysContant(categoryArray);
			if(sysContants==null)throw new Exception("请检查sys_constant是否有所对应的配置\n 或者未刷新 点击"+request.getContextPath()+"/refreshSysContent.do 刷新");
			map.put("success", true);
			map.put("data", sysContants);
		}else{
			logger.error("category 为空。");
		}
		ActionHelper.returnResponseJsonMap(request, response, map);
	}
	@RequestMapping("/getWorkflowParam.do")
	public void getWorkflowParam(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String queryFlag = request.getParameter("query");
		List<Workflow> workfowList=new ArrayList<Workflow>();
		JSONObject json = new JSONObject();
		String[] strTemplateIds=queryFlag.split(",");
		Long[] params=new Long[strTemplateIds.length];
		try{
		for(int i=0,n=params.length;i<n;i++)params[i]=Long.valueOf(strTemplateIds[i]);
		
		workfowList=WorkflowParam.getWorkflowsByTemplateIds(params);
		JSONArray jsonAry = new JSONArray();
		for (Workflow workfolw : workfowList) {
			JSONObject _json = new JSONObject();
			_json.put("linkId", workfolw.getLinkId());
			_json.put("phaseId", Integer.valueOf(workfolw.getPhaseId()));
			_json.put("phaseName", workfolw.getPhaseName());
			_json.put("vmTaskName", workfolw.getVmTaskName());
			_json.put("templateId", workfolw.getTemplateId());
			_json.put("vmTaskNo", workfolw.getVmTaskNo());
			_json.put("linkNo", workfolw.getLinkNo());
			jsonAry.add(_json);
		}
		json.put("success", true);
		json.put("data", jsonAry);
		System.out.println(json);
		}catch (Exception e) {
			e.getStackTrace();
		}
		ActionHelper.responseData4JSON(request, response, json);
	}
	@RequestMapping("/getWorkflowParamByCategorys.do")
	public void getWorkflowParamByCategory(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String categorys=request.getParameter("categorys");
		JSONArray jsonAry = new JSONArray();
		JSONObject json = new JSONObject();
		json.put("success", false);
		if(NaNull(categorys)){
			String[] categoryArray=categorys.split(",");
			SysConstant[] sysContants=SysContentUtil.getSysContant(categoryArray);
			if(sysContants==null)throw new Exception("请检查sys_constant是否有所对应的配置\n 或者未刷新 点击"+request.getContextPath()+"/refreshSysContent.do 刷新");
			else{
				List<Workflow> workfowList=new ArrayList<Workflow>();
				Long[] params=new Long[sysContants.length];
				for(int i=0,n=params.length;i<n;i++)params[i]=Long.valueOf(sysContants[i].getOther2());
				json.put("success", true);
				workfowList=WorkflowParam.getWorkflowsByTemplateIds(params);
		
				for (Workflow workfolw : workfowList) {
					JSONObject _json = new JSONObject();
					_json.put("linkId", workfolw.getLinkId());
					_json.put("phaseId", Integer.valueOf(workfolw.getPhaseId()));
					_json.put("phaseName", workfolw.getPhaseName());
					_json.put("vmTaskName", workfolw.getVmTaskName());
					_json.put("templateId", workfolw.getTemplateId());
					jsonAry.add(_json);
				}
			}
		}else{
			System.out.println("categorys 为空。");
		}
		json.put("data", jsonAry);
		System.out.println("============>"+json);
		ActionHelper.responseData4JSON(request, response, json);	
	}
	
	@RequestMapping(value="/getDomainJsonData.do")
	public void getDomainJsonData(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String urlJava = request.getParameter("urlJava");
		String action = request.getParameter("action");
		Enumeration pNames = request.getParameterNames();
		String workflowUrl = request.getSession().getAttribute("workflowUrl").toString();
		String urlStr = workflowUrl + urlJava + "?" + "action=" + action;
		while(pNames.hasMoreElements()) {
			String name = (String)pNames.nextElement();
			String value= request.getParameter(name);
			if(name.equalsIgnoreCase("action") || name.equalsIgnoreCase("urlJava")) {
				continue;
			}
			urlStr += "&" + name + "=" + URLEncoder.encode(value, "UTF-8");
		}
		String retStr = getUrlConStr(urlStr);
		response.setContentType("application/Json;charset=UTF-8");
		response.getWriter().write(retStr);
	}
	
	@RequestMapping(value="/getDomainJsonDataForQuery.do")
	public void getDomainJsonDataForQuery(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String urlJava = request.getParameter("urlJava");
		String action = request.getParameter("action");
		Enumeration pNames = request.getParameterNames();
		String workflowUrl = request.getSession().getAttribute("workflowUrl").toString();
		String urlStr = workflowUrl + urlJava + "?" + "action=" + action;
		while(pNames.hasMoreElements()) {
			String name = (String)pNames.nextElement();
			String value= request.getParameter(name);
//			System.out.println(name + " = " + value);
			if(name.equalsIgnoreCase("action") || name.equalsIgnoreCase("urlJava")) {
				continue;
			}
			urlStr += "&" + name + "=" + (URLDecoder.decode(value,"UTF-8"));
		}
		String retStr = getUrlConStr(urlStr);
		response.setContentType("application/Json;charset=UTF-8");
		response.getWriter().write(retStr);
	}
	
	@RequestMapping(value="/getWorkflowParamByUrl.do")
	public void getWorkflowParamByUrl(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String linkNo = request.getParameter("linkNo");
		String workflowUrl = request.getSession().getAttribute("workflowUrl").toString();
		String urlStr = workflowUrl + "/business/com.asiainfo.csc.common.web.WorkflowParamAction?action=getWorkflowParamByLinkNo&uid="
			 + "ADMINISTRATOR&linkNo=" + linkNo;
		String retStr = getUrlConStr(urlStr);
		response.setContentType("application/Json;charset=UTF-8");
		response.getWriter().write(retStr);
	}
	
	@RequestMapping(value="/getTreeStaffSelectForExt.do")
	public void getTreeStaffSelectForExt(HttpServletRequest request, HttpServletResponse response) throws Exception {
		AigaUser user = CommonUtil.getSessionUser(request);
		String roleCode = request.getParameter("roleCode");
		String projectCode = request.getParameter("projectCode");
		String parentOrgId = request.getParameter("parentOrgId");
		String roleOrgId = request.getParameter("roleOrgId");
		String workflowUrl = request.getSession().getAttribute("workflowUrl").toString();
		String urlStr = workflowUrl + "/business/com.asiainfo.csc.common.web.TreeStaffSelectForExt?action=getStaffTree&uid="
			 + user.getUserAccount() + "&cur_userId=" + user.getUserId() + "&roleCode=" + roleCode + "&projectCode="
			 + projectCode + "&parentOrgId=" + parentOrgId + "&roleOrgId=" + roleOrgId;
		String retStr = getUrlConStr(urlStr);
		response.setContentType("application/Json;charset=UTF-8");
		response.getWriter().write(retStr);
	}
	
	@RequestMapping(value="/queryStaffsByName.do")
	public void queryStaffsByName(HttpServletRequest request, HttpServletResponse response) throws Exception {
		AigaUser user = CommonUtil.getSessionUser(request);
		String roleCode = request.getParameter("roleCode");
		String staffIds = request.getParameter("staffIds");
		String workflowUrl = request.getSession().getAttribute("workflowUrl").toString();
		String urlStr = workflowUrl + "/business/com.asiainfo.csc.common.web.TreeStaffSelectForExt?action=queryStaffsByName&uid="
			 + user.getUserAccount() + "&staffIds=" + staffIds + "&roleCode=" + roleCode;
		String retStr = getUrlConStr(urlStr);
		response.setContentType("application/Json;charset=UTF-8");
		response.getWriter().write(retStr);
	}
	
	private String getUrlConStr(String urlStr) throws Exception {
		String retStr = "";
		URL url = new URL(urlStr);
		HttpURLConnection con = (HttpURLConnection)url.openConnection();
		con.setRequestMethod("GET");
		con.setReadTimeout(30*1000);
		con.setDoInput(true);
		con.setDoOutput(true);
		con.connect();
//		OutputStream out = con.getOutputStream();
//		out.flush();
//		out.close();
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
//		System.out.println(retStr);
		return retStr;
	}
	
	private static final char[] symbols = new char[36];

	static {
		for (int idx = 0; idx < 10; ++idx)
			symbols[idx] = (char) ('0' + idx);
		for (int idx = 10; idx < 36; ++idx)
			symbols[idx] = (char) ('a' + idx - 10);
	}

	public String nextString(int length) {
		char[] buf;
		buf = new char[length];
		Random random = new Random();
		for (int idx = 0; idx < buf.length; ++idx)
			buf[idx] = symbols[random.nextInt(symbols.length)];
		return new String(buf);
	}
	
	@RequestMapping(value="/uploadFile.do")
	public void uploadFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String urlJava = request.getParameter("urlJava");
		String action = request.getParameter("action");
		Enumeration pNames = request.getParameterNames();
		String workflowUrl = request.getSession().getAttribute("workflowUrl").toString();
		String urlStr = workflowUrl + urlJava + "?" + "action=" + action;
		while(pNames.hasMoreElements()) {
			String name = (String)pNames.nextElement();
			String value=request.getParameter(name);
//			System.out.println(name + " = " + value);
			if(name.equalsIgnoreCase("action") || name.equalsIgnoreCase("urlJava")) {
				continue;
			}
			urlStr += "&" + name + "=" + URLEncoder.encode(value, "UTF-8");
		}
		try {
			URL url = new URL(urlStr);
			String BOUNDARY = "---------"+this.nextString(11); // 定义数据分隔线
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			// 发送POST请求必须设置如下两行
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setUseCaches(false);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("Charsert", "UTF-8");
			conn.setRequestProperty("Content-Type",
					"multipart/form-data; boundary=" + BOUNDARY);

			OutputStream out = new DataOutputStream(conn.getOutputStream());
			byte[] end_data = ("\r\n--" + BOUNDARY + "--\r\n").getBytes();// 定义最后数据分隔线
			
			DiskFileItemFactory fac = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(fac);
			upload.setHeaderEncoding("UTF-8");
			List fileList = null;
			try {
				fileList = upload.parseRequest(request);
			} catch (FileUploadException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Iterator<FileItem> filePaths = fileList.iterator();
			FileItem uploadFile = null;
			String fileName = "";
			String attType = "";
			String submitTag = "";
			String objNo = "";
			String type = "";
			String linkNo = "";
			String orgName = "";
			while (filePaths.hasNext()) {
				FileItem filePath = filePaths.next();
				if (!filePath.isFormField()) {
					fileName = filePath.getName();
					uploadFile = filePath;
				}else{
					String name = filePath.getFieldName();
					if (name.equals("type"))
						type = filePath.getString("UTF-8");
					else if (name.equals("attType"))
						attType = filePath.getString("UTF-8");
					else if (name.equals("submitUser"))
						submitTag = filePath.getString("UTF-8");
					else if (name.equals("objNo"))
						objNo = filePath.getString("UTF-8");
					else if (name.equals("linkNo"))
						linkNo = filePath.getString("UTF-8");
					else if(name.equals("orgName"))
						orgName = filePath.getString("UTF-8");
				}
			}
			StringBuilder sb = new StringBuilder();
			sb.append("--");
			sb.append(BOUNDARY);
			sb.append("\r\n");
			sb.append("content-disposition:form-data;name=type");
			sb.append("\r\n\r\n");
			sb.append(type);
			sb.append("\r\n");
			sb.append("--");
			sb.append(BOUNDARY);
			sb.append("\r\n");
			
			sb.append("--");
			sb.append(BOUNDARY);
			sb.append("\r\n");
			sb.append("content-disposition:form-data;name=attType");
			sb.append("\r\n\r\n");
			sb.append(attType);
			sb.append("\r\n");
			sb.append("--");
			sb.append(BOUNDARY);
			sb.append("\r\n");
			
			sb.append("--");
			sb.append(BOUNDARY);
			sb.append("\r\n");
			sb.append("content-disposition:form-data;name=submitUser");
			sb.append("\r\n\r\n");
			sb.append(submitTag);
			sb.append("\r\n");
			sb.append("--");
			sb.append(BOUNDARY);
			sb.append("\r\n");
			
			sb.append("--");
			sb.append(BOUNDARY);
			sb.append("\r\n");
			sb.append("content-disposition:form-data;name=objNo");
			sb.append("\r\n\r\n");
			sb.append(objNo);
			sb.append("\r\n");
			sb.append("--");
			sb.append(BOUNDARY);
			sb.append("\r\n");
			
			sb.append("--");
			sb.append(BOUNDARY);
			sb.append("\r\n");
			sb.append("content-disposition:form-data;name=linkNo");
			sb.append("\r\n\r\n");
			sb.append(linkNo);
			sb.append("\r\n");
			sb.append("--");
			sb.append(BOUNDARY);
			sb.append("\r\n");
			
			sb.append("--");
			sb.append(BOUNDARY);
			sb.append("\r\n");
			sb.append("content-disposition:form-data;name=orgName");
			sb.append("\r\n\r\n");
			sb.append(orgName);
			sb.append("\r\n");
			sb.append("--");
			sb.append(BOUNDARY);
			sb.append("\r\n");
			
			sb.append("--");
			sb.append(BOUNDARY);
			sb.append("\r\n");
			sb.append("Content-Disposition: form-data;name=\"file" + fileName
					+ "\";filename=\"" + URLEncoder.encode(fileName, "UTF-8") + "\"\r\n");
			sb.append("Content-Type:application/octet-stream\r\n\r\n");
			byte[] data = sb.toString().getBytes();
			out.write(data);
			DataInputStream in = new DataInputStream(uploadFile.getInputStream());
			int bytes = 0;
			byte[] bufferOut = new byte[1024];
			while ((bytes = in.read(bufferOut)) != -1) {
				out.write(bufferOut, 0, bytes);
			}
			out.write("\r\n".getBytes());
			in.close();
			out.write(end_data);
			out.flush();
			out.close();

			BufferedReader reader = new BufferedReader(new InputStreamReader(
					conn.getInputStream()));
			String line = null;
			while ((line = reader.readLine()) != null) {
				System.out.println(line);
			}

		} catch (Exception e) {
			System.out.println("发送POST请求出现异常！" + e);
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/downloadFile.do")
	public void downloadFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String zipFileName = new String(request.getParameter("zipFileName").getBytes("ISO8859-1"),"UTF-8");
		InputStream inputStream = null;
		OutputStream o = null;
		try {
			Enumeration pNames = request.getParameterNames();
			String workflowUrl = request.getSession()
					.getAttribute("workflowUrl").toString();
			String urlStr = workflowUrl + "/fileDownload" + "?action=";
			while (pNames.hasMoreElements()) {
				String name = (String) pNames.nextElement();
				String value = new String(request.getParameter(name).getBytes("ISO8859-1"),"UTF-8");
				if (name.equalsIgnoreCase("action")
						|| name.equalsIgnoreCase("urlJava")) {
					continue;
				}
				urlStr += "&" + name + "=" + URLEncoder.encode(value, "UTF-8");
			}

			response.setHeader("Content-disposition", "attachment;filename="
		              + new String((zipFileName+".rar").getBytes("GBK"), "ISO-8859-1"));
			URL url = new URL(urlStr);
			HttpURLConnection httpConn = (HttpURLConnection) url
					.openConnection();
			httpConn.setRequestProperty("connection", "Keep-Alive");
			httpConn.setRequestProperty("Charsert", "UTF-8");
			inputStream = httpConn.getInputStream();
			o = response.getOutputStream();
			byte b[] = new byte[1024];
			int n = 0;
			while ((n = inputStream.read(b)) != -1) {
				o.write(b, 0, n);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			inputStream.close();
			o.close();
		}
	}
	@RequestMapping(value="/downloadTemplateExcel.do")
	public void downloadTemplateExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		   // 下载本地文件
		String fileName=request.getParameter("fileName");
		String templateFileName=request.getParameter("templateFileName");
		if(!NaNull(templateFileName))throw new Exception("文件名为空.");
		if(!NaNull(fileName))fileName=templateFileName;
        // 读到流中
    	String path = LuceneCommon.getProertiesValue("excel.exportPath","excel.properties");
        InputStream inStream = new FileInputStream(path+"/"+templateFileName);// 文件的存放路径
        // 设置输出的格式
        response.reset();
        response.setContentType("bin");
        response.addHeader("Content-Disposition", "attachment; filename="+new String(fileName.getBytes("GB2312"),"ISO-8859-1"));
        // 循环取出流中的数据
        byte[] b = new byte[100];
        int len;
        try {
            while ((len = inStream.read(b)) > 0)
                response.getOutputStream().write(b, 0, len);
            inStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
	}
	public static void main(String[] args) {
		String str = "AAA__A";
		if (str.matches(".*[a-z].*"))
		    System.out.println("此字符串包含小写字母。");
		else
		    System.out.println("此字符串不包含需小写字母。");
//		System.out.println(str.replaceAll("[A-Z]", "!"));  
	}
}
