package com.asiainfo.aiga.common.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.asiainfo.aiga.common.BaseAction;
import com.asiainfo.aiga.common.LoginFilter;
import com.asiainfo.aiga.qualityManage.bo.AigaQualityManage;
import com.asiainfo.aiga.qualityManage.service.IAigaQualityManageSV;

@Controller
public class TemplateFile extends BaseAction {

	@Resource(name="qualityManageSV")
	private IAigaQualityManageSV aigaQualityManageSV;
	
	@RequestMapping(value="/getTemplateFile.do")
	public void getTemplateFile(HttpServletRequest request,HttpServletResponse response) throws Exception {
		try{
			AigaQualityManage[] aigaQualityManages = aigaQualityManageSV.getAllQM();
			this.setTable(aigaQualityManages);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	@RequestMapping(value="/downTemplateFile.do")
	public void downTemplateFile(HttpServletRequest request,HttpServletResponse response) throws Exception {
		FileInputStream in = null;
		String fileName = this.decodeCN(request.getParameter("fileName"));
		String relationDoc = this.decodeCN(request.getParameter("relationDoc"));
//		fileName=URLEncoder.encode(URLEncoder.encode(fileName+"","UTF-8"),"UTF-8");
		String filePath = this.decodeCN(request.getParameter("filePath"));
		System.out.println(filePath+relationDoc);
		System.out.println(fileName);
		File fileLoad = new File(filePath+relationDoc);
		try {
			if(relationDoc==null||relationDoc.equals(""))throw new Exception("缺少请求参数relationDoc");
			if(fileName==null||fileName.equals(""))throw new Exception("缺少请求参数fileName");
			if(filePath==null||filePath.equals(""))throw new Exception("缺少请求参数filePath");
			if(fileLoad.exists()){
				OutputStream o = response.getOutputStream();
			    byte b[] = new byte[1024];
			    response.setHeader("Content-disposition", "attachment;filename="
			              + new String(fileName.getBytes("GBK"), "ISO-8859-1"));
			     
			    response.setContentType("application/octet-stream");
			    long fileLength = fileLoad.length();
			    String length = String.valueOf(fileLength);
			    response.setHeader("Content_Length", length);
			    in = new FileInputStream(fileLoad);
			    int n = 0;
			    while ((n = in.read(b)) != -1) {
			        o.write(b, 0, n);
			    }
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(in!=null)
				in.close();
		}
	}
	
	@RequestMapping(value="/getHomePageMsg.do")
	public void getHomePageMsg(HttpServletRequest request,HttpServletResponse response) throws Exception {
		try{
			InputStream in = LoginFilter.class.getClassLoader().getResourceAsStream("templateFile.properties");
			Properties p = new Properties();
			p.load(in);
			String homePageMsg = p.getProperty("homePageMsg");
			this.setPostInfo("data", homePageMsg);
			this.setPostInfo("success", true);
		}catch(Exception e){
			this.setPostInfo("success", false);
		}finally{
			this.postInfo(request, response);
		}
	}
	
	public static void main(String[] args) {
		try {
			System.out.println(URLEncoder.encode(URLEncoder.encode("【YL-KF-100】亚信联创浙江移动PSO-新业务上线准备、执行流程（V1.6）.doc","UTF-8"),"UTF-8"));
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
