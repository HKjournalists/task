package com.asiainfo.csc.attach.web;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.web.CustomProperty;
import com.ai.appframe2.web.HttpUtil;
import com.ai.appframe2.web.action.BaseAction;
import com.asiainfo.csc.attach.ivalues.IBOQueryAttPackValue;
import com.asiainfo.csc.attach.service.interfaces.IAttachService;
import com.asiainfo.csc.attach.service.interfaces.IFileFtpTransSV;
import com.asiainfo.csc.attach.service.interfaces.IFileSFtpTransSV;
import com.asiainfo.csc.attach.vo.QueryAttPackValue;
import com.inprise.security.CORBAsec.REQUEST;

public class FileUpAction extends BaseAction {

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
	
	public void uploadFile(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		DiskFileItemFactory fac = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(fac);
		upload.setHeaderEncoding("UTF-8");
		List fileList = null;
		try {
			fileList = upload.parseRequest(req);
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			initial();
			if(SYS_ATTACH_FTP_TYPE.equals("ftp")){
				IFileFtpTransSV ftpTransSV = (IFileFtpTransSV)ServiceFactory.getService(IFileFtpTransSV.class);
				ftpTransSV.saveAttach(fileList);
			}else if(SYS_ATTACH_FTP_TYPE.equals("sftp")){
				IFileSFtpTransSV sftpTransSV = (IFileSFtpTransSV)ServiceFactory.getService(IFileSFtpTransSV.class);
				sftpTransSV.saveAttach(fileList);
			}else{
				throw new Exception("ftp类型配置错误");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void checkFileRepeat(HttpServletRequest req, HttpServletResponse resp)throws Exception{
		JSONObject cp = new JSONObject();
		try {
			String objNo = req.getParameter("objNo");
			String type = req.getParameter("type");
			String submitTag = req.getParameter("submitTag");
			String attName = new String(req.getParameter("attName").getBytes("iso8859-1"),"utf-8");
			IAttachService attachService = (IAttachService)ServiceFactory.getService(IAttachService.class);
			Map<String, String> trv = attachService.checkHasFile(objNo, type, submitTag, attName);
			cp.put("isRepeat", trv.get("isRepeat"));
			cp.put("success", true);
		}catch (Exception e) {
			e.printStackTrace();
			cp.put("success", false);
			cp.put("message", e.getCause());
		} finally {
			resp.setContentType("application/Json;charset=UTF-8");
			resp.getWriter().write(URLEncoder.encode(cp.toString(),"UTF-8"));
		}
	}
	
	public void queryQueryAttPackNew(HttpServletRequest req, HttpServletResponse resp)throws Exception{
		String objNo = req.getParameter("objNo");
		String type = req.getParameter("type");
		IAttachService attachService = (IAttachService) ServiceFactory
				.getService(IAttachService.class);
		IBOQueryAttPackValue[] attPackValues = attachService
				.queryQueryAttPackNew(objNo, type);
		List<QueryAttPackValue> packValues = new ArrayList<QueryAttPackValue>();
		for (IBOQueryAttPackValue attPackValue : attPackValues) {
			QueryAttPackValue packValue = new QueryAttPackValue();
			packValue.setAttDesc(attPackValue.getAttDesc());
			packValue.setAttId(attPackValue.getAttId());
			packValue.setAttName(attPackValue.getAttName());
			packValue.setAttPackDesc(attPackValue.getAttPackDesc());
			packValue.setAttPackId(attPackValue.getAttPackId());
			packValue.setAttPath(attPackValue.getAttPath());
			packValue.setAttType(attPackValue.getAttType());
			packValue.setAttTypeName(attPackValue.getAttTypeName());
			packValue.setEmployeeName(attPackValue.getEmployeeName());
			packValue.setObjId(attPackValue.getObjId());
			packValue.setObjNo(attPackValue.getObjNo());
			packValue.setObjType(attPackValue.getObjType());
			packValue.setStatus(attPackValue.getStatus());
			packValue.setSubmitLink(attPackValue.getSubmitLink());
			packValue.setSubmitterTag(attPackValue.getSubmitterTag());
			if (attPackValue.getSubmitTime() != null)
				packValue.setSubmitTime(new SimpleDateFormat(
						"yyyy-MM-dd HH:mm:ss").format(attPackValue
						.getSubmitTime()));
			packValue.setWoId(attPackValue.getWoId());

			packValues.add(packValue);
		}
		JSONArray object = JSONArray.fromArray(packValues.toArray());
		resp.setContentType("application/Json;charset=UTF-8");
		System.out.println(object.toString());
		resp.getWriter().write(URLEncoder.encode(object.toString(),"UTF-8"));
	}
}
