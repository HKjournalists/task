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
	 * ��ʼ��FTP����
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
					"û���ҵ��ļ��ϴ��������ļ�����ȷ�������ļ�AttachConfig.xml�Ƿ���config��Ŀ¼�£�");
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
					"û���ҵ��ļ��ϴ��������ļ�����ȷ�������ļ�AttachConfig.xml�Ƿ���config��Ŀ¼�£�");
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
			
			request.setCharacterEncoding("UTF-8"); // ���ñ���
			String encoding = request.getCharacterEncoding();

			// ��ô����ļ���Ŀ����
			
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// ��ˮƽ��API�ļ��ϴ�����
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setHeaderEncoding(encoding);
			
		
			// �����ϴ�����ļ�
			List<FileItem> list = (List<FileItem>) upload.parseRequest(request);
			
			//DiskFileItemFactory factory = new DiskFileItemFactory();
			// ��ȡ�ļ���Ҫ�ϴ�����·��
			//String path = request.getRealPath("/upload");
			String path_name = "";
			for (FileItem item : list) {
				// ��ȡ������������
				String name = item.getFieldName();
				if(name.equals("ATT_PATH")){
					path_name = item.getString(encoding);
				}
			}
			
			//String path = this.getPath() + File.separatorChar + path_name;
			//(new File(path)).mkdirs();
			//log.info(path);

			// ���û�����������õĻ����ϴ���� �ļ� ��ռ�� �ܶ��ڴ棬
			// ������ʱ��ŵ� �洢�� , ����洢�ң����Ժ� ���մ洢�ļ� ��Ŀ¼��ͬ
			/**
			 * ԭ�� �����ȴ浽 ��ʱ�洢�ң�Ȼ��������д�� ��ӦĿ¼��Ӳ���ϣ� ������˵ ���ϴ�һ���ļ�ʱ����ʵ���ϴ������ݣ���һ������
			 * .tem ��ʽ�� Ȼ���ٽ�������д�� ��ӦĿ¼��Ӳ����
			 */
			//factory.setRepository(new File(path));
			
			// ���� ����Ĵ�С�����ϴ��ļ������������û���ʱ��ֱ�ӷŵ� ��ʱ�洢��
			factory.setSizeThreshold(1024 * 1024);


			HashMap<String, String> attributes = new HashMap<String, String>();
			ArrayList<String> filenames = new ArrayList<String>();
			for (FileItem item : list) {
				// ��ȡ������������
				String name = item.getFieldName();

				// �����ȡ�� ����Ϣ����ͨ�� �ı� ��Ϣ
				if (item.isFormField()) {
					// ��ȡ�û�����������ַ��� ���������ͦ�ã���Ϊ���ύ�������� �ַ������͵�
					String value = item.getString(encoding);
					request.setAttribute(name, value);
					attributes.put(name, value);
					log.debug(name + " = " + value);
				}
				// �Դ���ķ� �򵥵��ַ������д��� ������˵�����Ƶ� ͼƬ����Ӱ��Щ
				else {
					/**
					 * ������������Ҫ��ȡ �ϴ��ļ�������
					 */
					// ��ȡ·����
					String value = item.getName();
					// ���������һ����б��
					int start = value.lastIndexOf("\\");
					// ��ȡ �ϴ��ļ��� �ַ������֣���1�� ȥ����б�ܣ�
					String filename = value.substring(start + 1);
					request.setAttribute(name, filename);

					// ����д��������
					// ���׳����쳣 ��exception ��׽

					// item.write( new File(path,filename) );//�������ṩ��

					
					
					
					// �ֶ�д��
					
//					OutputStream out = new FileOutputStream(new File(path,
//							filename));
//					InputStream in = item.getInputStream();
//					int length = 0;
//					byte[] buf = new byte[1024];
//					//System.out.println("�ϴ��ļ���Ϊ��" + item.getName());
//					System.out.println("��ȡ�ϴ��ļ����ܹ���������" + item.getSize());
//					// in.read(buf) ÿ�ζ��������ݴ���� buf ������
//					while ((length = in.read(buf)) != -1) {
//						// �� buf ������ ȡ������ д�� ���������������
//						out.write(buf, 0, length);
//					}
//
//					in.close();
//					out.close();
					
					//�ϴ�FTP
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
			if(e.getMessage().indexOf("��ͬ�ļ���")>=0)
				response.setStatus(553);
			else
				response.setStatus(500);
			response.getWriter().write(e.getMessage());
			response.getWriter().flush();
		}
		
	}
}
