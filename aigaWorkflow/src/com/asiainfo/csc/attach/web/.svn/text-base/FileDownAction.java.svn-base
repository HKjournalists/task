package com.asiainfo.csc.attach.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import com.ai.appframe2.service.ServiceFactory;
import com.asiainfo.csc.attach.ivalues.IBOAttachValue;
import com.asiainfo.csc.attach.service.interfaces.IAttachService;
import com.asiainfo.csc.attach.service.interfaces.IFileFtpTransSV;
import com.asiainfo.csc.attach.service.interfaces.IFileSFtpTransSV;

public class FileDownAction extends HttpServlet {

	private static String ATTACH_CONFIG = "AttachConfig.xml";
	private static String SYS_ATTACH_FTP_TYPE;// ftp类型
	
	private static void initial() throws Exception {

		SAXBuilder builder = new SAXBuilder(false);
		Document doc = null;

		try {
			doc = builder.build(Thread.currentThread().getContextClassLoader()
					.getResourceAsStream(ATTACH_CONFIG));
		} catch (Exception e) {
			throw new Exception(
					"没有找到文件上传的配置文件，请确认配置文件AttachConfig.xml是否在config根目录下！");
		}
		Element root = doc.getRootElement();

		List childList = root.getChildren();
		for (int i = 0; i < childList.size(); ++i) {
			Element childItem = (Element) childList.get(i);
			String name = childItem.getAttributeValue("name");
			String value = childItem.getTextTrim();

			if ("SYS_ATTACH_FTP_TYPE".equals(name)) {
				SYS_ATTACH_FTP_TYPE = value;
			} 

		}

	}
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private File fileLoad;
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(req, resp);
	}

	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		FileInputStream in = null;
		try {
			String fileName;
			String zipFileName = new String(req.getParameter("zipFileName").getBytes("ISO8859-1"),"UTF-8");
			String attIds = req.getParameter("attIds");
			IAttachService attSV = (IAttachService) ServiceFactory.getService(IAttachService.class);
			IBOAttachValue[] attachs = attSV.queryBOAttachByIds(attIds);
			String[] filePaths = new String[attachs.length];
			for(int i=0;attachs!=null&&i<attachs.length;i++){
				filePaths[i] = attachs[i].getAttPath()+attachs[i].getAttName();
			}
			initial();
			if(SYS_ATTACH_FTP_TYPE.equals("ftp")){
				IFileFtpTransSV ftpTransSV = (IFileFtpTransSV)ServiceFactory.getService(IFileFtpTransSV.class);
				fileLoad = ftpTransSV.downloadFile(Arrays.asList(filePaths));
			}else if(SYS_ATTACH_FTP_TYPE.equals("sftp")){
				IFileSFtpTransSV sftpTransSV = (IFileSFtpTransSV)ServiceFactory.getService(IFileSFtpTransSV.class);
				fileLoad = sftpTransSV.downloadFile(Arrays.asList(filePaths));
			}else{
				throw new Exception("ftp类型配置错误");
			}
			
			OutputStream o = resp.getOutputStream();
		    byte b[] = new byte[1024];
		    fileName = zipFileName+".rar";
		    resp.setHeader("Content-disposition", "attachment;filename="
		              + new String(fileName.getBytes("GBK"), "ISO-8859-1"));
		     
		    resp.setContentType("application/octet-stream");
		    long fileLength = fileLoad.length();
		    String length = String.valueOf(fileLength);
		    resp.setHeader("Content_Length", length);
		    in = new FileInputStream(fileLoad);
		    int n = 0;
		    while ((n = in.read(b)) != -1) {
		        o.write(b, 0, n);
		    }
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			in.close();
			fileLoad.delete();
		}
	}

}
