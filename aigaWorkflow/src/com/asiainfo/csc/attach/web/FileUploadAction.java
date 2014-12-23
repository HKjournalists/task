package com.asiainfo.csc.attach.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.web.action.BaseAction;
import com.asiainfo.csc.attach.bo.BOAttachBean;
import com.asiainfo.csc.attach.bo.BOAttachEngine;
import com.asiainfo.csc.attach.bo.BOPackageBean;
import com.asiainfo.csc.attach.bo.BOPackageEngine;
import com.asiainfo.csc.attach.dao.FTPAgent;
import com.asiainfo.csc.attach.ivalues.IBOAttachValue;
import com.asiainfo.csc.attach.ivalues.IBOPackageValue;
import com.asiainfo.csc.attach.service.interfaces.IAttachService;

public class FileUploadAction extends BaseAction{
	private final static transient Log log = LogFactory.getLog(FileUploadAction.class);
	private IAttachService attacheSV = (IAttachService) ServiceFactory.getService(IAttachService.class);
	private static boolean bInitial = false;
	private static String ATTACH_CONFIG = "AttachConfig.xml";
	private static String SYS_ATTACH_FTP_IP = null;
	private static int SYS_ATTACH_FTP_PORT = 21;
	private static String SYS_ATTACH_FTP_USERNAME = null;
	private static String SYS_ATTACH_FTP_PSW = null;
	private static String SYS_ATTACH_FTP_ROOT = null;
	private static String SYS_ATTACH_FORBID_TYPE = null;
	
	private String fileSizeLimit;
	
	/**
	 * 初始化FTP参数
	 * 
	 * @throws Exception
	 */
	public static void initial() throws Exception {

		if (bInitial) {
			return;
		}

		bInitial = true;

		SAXBuilder builder = new SAXBuilder(false);
		Document doc = null;

		try {
			doc = builder.build(Thread.currentThread().getContextClassLoader()
					.getResourceAsStream(ATTACH_CONFIG));
		} catch (Exception e) {
			bInitial = false;
			throw new Exception(
					"没有找到文件上传的配置文件，请确认配置文件AttachConfig.xml是否在config根目录下！");
		}
		Element root = doc.getRootElement();

		List childList = root.getChildren();
		for (int i = 0; i < childList.size(); ++i) {
			Element childItem = (Element) childList.get(i);
			String name = childItem.getAttributeValue("name");
			String value = childItem.getTextTrim();

			if ("SYS_ATTACH_FTP_PORT".equals(name)) {
				if (value != null) {
					SYS_ATTACH_FTP_PORT = Integer.parseInt(value);
				}
			} else if ("SYS_ATTACH_FTP_ROOT".equals(name)) {
				SYS_ATTACH_FTP_ROOT = value;
			} else if ("SYS_ATTACH_FTP_IP".equals(name)) {
				SYS_ATTACH_FTP_IP = value;
			} else if ("SYS_ATTACH_FORBID_TYPE".equals(name)) {
				SYS_ATTACH_FORBID_TYPE = value;
			} else if ("SYS_ATTACH_FTP_USERNAME".equals(name)) {
				SYS_ATTACH_FTP_USERNAME = value;
			} else {
				if ((!"SYS_ATTACH_FTP_PSW".equals(name)) || (value == null)) {
					continue;
				}
				SYS_ATTACH_FTP_PSW = value;
			}

		}

	}
	
	public String getPath() throws Exception{
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
			if ("SYS_ATTACH_FTP_ROOT".equals(name)) {
				return value;
			}
		}
		return null;
	}
	
	
	public void fileUpload(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		try {
			
			initial();
			
			request.setCharacterEncoding("UTF-8"); // 设置编码
			String encoding = request.getCharacterEncoding();

			// 获得磁盘文件条目工厂
			
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// 高水平的API文件上传处理
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setHeaderEncoding(encoding);
			
		
			// 可以上传多个文件
			List<FileItem> list = (List<FileItem>) upload.parseRequest(request);
			
			//DiskFileItemFactory factory = new DiskFileItemFactory();
			// 获取文件需要上传到的路径
			//String path = request.getRealPath("/upload");
			String path_name = "";
			for (FileItem item : list) {
				// 获取表单的属性名字
				String name = item.getFieldName();
				if(name.equals("ATT_PATH")){
					path_name = item.getString(encoding);
				}
			}
			
			//String path = this.getPath() + File.separatorChar + path_name;
			//(new File(path)).mkdirs();
			//log.info(path);

			// 如果没以下两行设置的话，上传大的 文件 会占用 很多内存，
			// 设置暂时存放的 存储室 , 这个存储室，可以和 最终存储文件 的目录不同
			/**
			 * 原理 它是先存到 暂时存储室，然后在真正写到 对应目录的硬盘上， 按理来说 当上传一个文件时，其实是上传了两份，第一个是以
			 * .tem 格式的 然后再将其真正写到 对应目录的硬盘上
			 */
			//factory.setRepository(new File(path));
			
			// 设置 缓存的大小，当上传文件的容量超过该缓存时，直接放到 暂时存储室
			factory.setSizeThreshold(1024 * 1024);


			HashMap<String, String> attributes = new HashMap<String, String>();
			ArrayList<String> filenames = new ArrayList<String>();
			for (FileItem item : list) {
				// 获取表单的属性名字
				String name = item.getFieldName();

				// 如果获取的 表单信息是普通的 文本 信息
				if (item.isFormField()) {
					// 获取用户具体输入的字符串 ，名字起得挺好，因为表单提交过来的是 字符串类型的
					String value = item.getString(encoding);
					request.setAttribute(name, value);
					attributes.put(name, value);
					log.debug(name + " = " + value);
				}
				// 对传入的非 简单的字符串进行处理 ，比如说二进制的 图片，电影这些
				else {
					/**
					 * 以下三步，主要获取 上传文件的名字
					 */
					// 获取路径名
					String value = item.getName();
					// 索引到最后一个反斜杠
					int start = value.lastIndexOf("\\");
					// 截取 上传文件的 字符串名字，加1是 去掉反斜杠，
					String filename = value.substring(start + 1);
					request.setAttribute(name, filename);

					// 真正写到磁盘上
					// 它抛出的异常 用exception 捕捉

					// item.write( new File(path,filename) );//第三方提供的

					
					
					
					// 手动写的
					
//					OutputStream out = new FileOutputStream(new File(path,
//							filename));
//					InputStream in = item.getInputStream();
//					int length = 0;
//					byte[] buf = new byte[1024];
//					//System.out.println("上传文件名为：" + item.getName());
//					System.out.println("获取上传文件的总共的容量：" + item.getSize());
//					// in.read(buf) 每次读到的数据存放在 buf 数组中
//					while ((length = in.read(buf)) != -1) {
//						// 在 buf 数组中 取出数据 写到 （输出流）磁盘上
//						out.write(buf, 0, length);
//					}
//
//					in.close();
//					out.close();
					
					//上传FTP
					log.debug(SYS_ATTACH_FTP_ROOT + "/" + path_name + "/" + item.getName());
					//FTPAgent ftpagent = new FTPAgent(SYS_ATTACH_FTP_IP,
					//		SYS_ATTACH_FTP_PORT, SYS_ATTACH_FTP_USERNAME,
					//		SYS_ATTACH_FTP_PSW);
					//log.info(ftpagent.getFiles(SYS_ATTACH_FTP_ROOT + "/" + path_name , item.getName()));
					//ftpagent.deleteFile(SYS_ATTACH_FTP_ROOT + "/" + path_name + "/" + item.getName());
					//ftpagent.upload(SYS_ATTACH_FTP_ROOT + "/" + path_name + "/" + item.getName(), item.getInputStream());// -------------------------
					//ftpagent.closeServer();
					
					//log.debug(item.getName());
					filenames.add(item.getName());
					//item.delete();
					
				}
			}
			// save database
			for(String filename : filenames){
				
				IBOAttachValue attach = new BOAttachBean();
				attach.setAttName(filename);
				attach.setAttPath(attributes.get("ATT_PATH"));
				attach.setSubmitLink(attributes.get("SUBMIT_LINK"));
				attach.setSubmitterTag(attributes.get("SUBMITTER_TAG"));
				if(attributes.containsKey("ATT_TYPE")){
					attach.setAttType(attributes.get("ATT_TYPE"));
				}
				attach.setSubmitTime(new Timestamp(System.currentTimeMillis()));
				attach = attacheSV.newAttach(attach);
				
				log.debug(attach.getAttId());
				IBOPackageValue pack = new BOPackageBean();
				pack.setAttId(attach.getAttId());
				pack.setObjNo(attributes.get("OBJ_NO"));
				pack.setObjType(Long.valueOf(attributes.get("OBJ_TYPE")));
				attacheSV.saveNewPackage(new IBOPackageValue[]{pack});
				
			}
		
		}
		catch (Exception e) {
			log.error("error", e);
			if(e.getMessage().indexOf("相同文件名")>=0)
				response.setStatus(553);
			else
				response.setStatus(500);
			response.getWriter().write(e.getMessage());
			response.getWriter().flush();
		}
		
	}
}
