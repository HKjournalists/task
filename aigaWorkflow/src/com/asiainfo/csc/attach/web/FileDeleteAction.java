package com.asiainfo.csc.attach.web;


import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.web.CustomProperty;
import com.ai.appframe2.web.HttpUtil;
import com.ai.appframe2.web.action.BaseAction;
import com.asiainfo.csc.attach.service.interfaces.IFileFtpTransSV;
import com.asiainfo.csc.attach.service.interfaces.IFileSFtpTransSV;

public class FileDeleteAction extends BaseAction {

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
	
	public void deleteFile(HttpServletRequest req, HttpServletResponse resp)
			throws Exception {
		JSONObject cp = new JSONObject();
		String attPackId = req.getParameter("attPackId");
		try {
			initial();
			if(SYS_ATTACH_FTP_TYPE.equals("ftp")){
				IFileFtpTransSV ftpTransSV = (IFileFtpTransSV) ServiceFactory
						.getService(IFileFtpTransSV.class);
				ftpTransSV.deleteAttach(attPackId);
			}else if(SYS_ATTACH_FTP_TYPE.equals("sftp")){
				IFileSFtpTransSV sftpTransSV = (IFileSFtpTransSV) ServiceFactory
				.getService(IFileSFtpTransSV.class);
				sftpTransSV.deleteAttach(attPackId);
			}else{
				throw new Exception("ftp类型配置错误");
			}
			cp.put("msg", "附件删除成功");
			cp.put("success", true);
		} catch (Exception e) {
			cp.put("msg", "附件删除失败");
			cp.put("success", false);
		} finally {
			resp.setContentType("application/Json;charset=UTF-8");
			resp.getWriter().write(URLEncoder.encode(cp.toString(),"UTF-8"));
		}
	}
}
