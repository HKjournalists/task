package com.asiainfo.csc.attach.web;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import com.ai.appframe2.common.DataContainerInterface;
import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.ai.appframe2.web.CustomProperty;
import com.ai.appframe2.web.DataContainerList;
import com.ai.appframe2.web.HttpUtil;
import com.ai.appframe2.web.action.BaseAction;
import com.ai.appframe2.web.fileupload.ApacheUploadTool;
import com.asiainfo.csc.attach.bo.BOAttachBean;
import com.asiainfo.csc.attach.bo.BODocTemplateBean;
import com.asiainfo.csc.attach.bo.BOPackageBean;
import com.asiainfo.csc.attach.bo.BOQueryAttachBean;
import com.asiainfo.csc.attach.dao.FTPAgent;
import com.asiainfo.csc.attach.ivalues.IBOAttachValue;
import com.asiainfo.csc.attach.ivalues.IBODocTempTreeValue;
import com.asiainfo.csc.attach.ivalues.IBOPackageValue;
import com.asiainfo.csc.attach.ivalues.IBOQueryAttPackValue;
import com.asiainfo.csc.attach.service.interfaces.IAttachService;
import com.asiainfo.csc.matrix.common.ConstDefine;

public class AttachAction extends BaseAction {

	private static boolean bInitial = false;
	private static String ATTACH_CONFIG = "AttachConfig.xml";
	private static String SYS_ATTACH_FTP_IP = null;
	private static int SYS_ATTACH_FTP_PORT = 21;
	private static String SYS_ATTACH_FTP_USERNAME = null;
	private static String SYS_ATTACH_FTP_PSW = null;
	private static String SYS_ATTACH_FTP_ROOT = null;
	private static String SYS_ATTACH_FORBID_TYPE = null;

	IAttachService iAttachService = (IAttachService) ServiceFactory
			.getService(IAttachService.class);

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

	public void getAttachForbidType(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		initial();
		CustomProperty cp = CustomProperty.getInstance();
		cp.set("attachForbidType", AttachAction.SYS_ATTACH_FORBID_TYPE);
		HttpUtil.showInfo(response, cp);
	}

	public void doDownload(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		CustomProperty aCp = CustomProperty.getInstance();
		try {

			initial();

			String aFileName = request.getParameter("attName");
			String aFilePath = request.getParameter("attPath");
			aFilePath = new String(aFilePath.getBytes("ISO8859_1"), "GBK");
			aFileName = new String(aFileName.getBytes("ISO8859_1"), "GBK");
			response.setContentType("application/x-msdownload");
			String fileName = "attachment;filename="
					+ URLEncoder.encode(aFileName, "UTF-8");
			response.setHeader("Content-Disposition", fileName); // ��������ļ�Ԫ��Ϣ�������ļ����������������
			ServletOutputStream out = response.getOutputStream();

			FTPAgent ftpagent = new FTPAgent(SYS_ATTACH_FTP_IP,
					SYS_ATTACH_FTP_PORT, SYS_ATTACH_FTP_USERNAME,
					SYS_ATTACH_FTP_PSW);
			ftpagent.download(SYS_ATTACH_FTP_ROOT + "/" + aFilePath + "/"
					+ aFileName, out);
			ftpagent.closeServer();

		} catch (Exception e) {

			// �趨ʧ�ܷ�����Ϣ
			aCp.set("IsOk", "FALSE");
			aCp.set("MESSAGE", e.getMessage());
			// ����ʧ����Ϣ��ע�⣺ֻ��ҪCustomProperty����ҪtoXmlString
			ApacheUploadTool.showFileUploadMsg(response, aCp);
		}

	}

	public void doUploadPackage(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		CustomProperty aCp = CustomProperty.getInstance();
		try {

			initial();
			String objNo = request.getParameter("objNo");
			String type = request.getParameter("type");

			BOAttachBean[] beansAttach = null;

			// ����apache�ؼ��ϴ��ļ�,��������,��һ������ļ�����,�ڶ�����Ų�������
			request.setCharacterEncoding("GBK");
			Object obj[] = ApacheUploadTool.getUploadFileInfo(request);
			// ȡ��xml����
			String xml = (String) ((Map) obj[1]).get("frmAttach");
			xml = new String(((String) xml).getBytes("ISO-8859-1"), HttpUtil
					.getEncoding()); // �ַ�ת��

			DataContainerList[] dcLists = HttpUtil.getDataContainerLists(xml,
					new Class[] { BOAttachBean.class });
			DataContainerInterface[] dcs = dcLists[0]
					.getColDataContainerInterface(0);
			beansAttach = (BOAttachBean[]) dcs;

			List fileList = (List) obj[0];
			// Map paras = (Map)obj[1];

			if (fileList == null || fileList.size() == 0) {
				throw new Exception("�Ҳ����ϴ����ļ�!");
			}

			FileItem item = (FileItem) fileList.get(0);
			String localfilename = item.getName();
			// String fileType =
			// localfilename.substring(localfilename.lastIndexOf(".")+1,localfilename.length());
			String filename = localfilename.substring(localfilename
					.lastIndexOf("\\") + 1, localfilename.length());
			String remotefilename = beansAttach[0].getAttPath() + "/"
					+ filename;

			FTPAgent ftpagent = new FTPAgent(SYS_ATTACH_FTP_IP,
					SYS_ATTACH_FTP_PORT, SYS_ATTACH_FTP_USERNAME,
					SYS_ATTACH_FTP_PSW);
			ftpagent.upload(beansAttach[0].getAttPath() + "/" + filename, item
					.getInputStream());
			ftpagent.closeServer();

			beansAttach[0].setAttName(filename);
			beansAttach[0].setSubmitTime(ServiceManager.getOpDateTime());
			iAttachService.newAttach(beansAttach[0]);

			BOPackageBean packBean = new BOPackageBean();
			packBean.setAttId(beansAttach[0].getAttId());

			packBean.setObjNo(objNo);
			packBean.setObjType(Long.parseLong(type));

			iAttachService.saveNewPackage(new BOPackageBean[] { packBean });

			// �趨�ɹ�������Ϣ
			aCp.set("IsOk", "TRUE");
			aCp.set("MESSAGE", "�����ϴ��ɹ���");
			// ���سɹ���Ϣ��ע�⣺ֻ��ҪCustomProperty����ҪtoXmlString
			ApacheUploadTool.showFileUploadMsg(response, aCp);
		} catch (Exception ex) {
			// �趨ʧ�ܷ�����Ϣ
			aCp.set("IsOk", "FALSE");
			aCp.set("MESSAGE", "�����ϴ�ʧ�ܣ�" + ex.getMessage());
			// ����ʧ����Ϣ��ע�⣺ֻ��ҪCustomProperty����ҪtoXmlString
			ApacheUploadTool.showFileUploadMsg(response, aCp);
		}
	}

	public void doUploadPackageCover(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		CustomProperty aCp = CustomProperty.getInstance();
		try {

			initial();

			String objNo = request.getParameter("objNo");
			String type = request.getParameter("type");
			String submitterTag = request.getParameter("submitterTag");
			BOAttachBean[] beansAttach = null;

			// ����apache�ؼ��ϴ��ļ�,��������,��һ������ļ�����,�ڶ�����Ų�������
			request.setCharacterEncoding("GBK");
			Object obj[] = ApacheUploadTool.getUploadFileInfo(request);
			// ȡ��xml����
			String xml = (String) ((Map) obj[1]).get("frmAttach");
			xml = new String(((String) xml).getBytes("ISO-8859-1"), HttpUtil
					.getEncoding()); // �ַ�ת��

			DataContainerList[] dcLists = HttpUtil.getDataContainerLists(xml,
					new Class[] { BOAttachBean.class });
			DataContainerInterface[] dcs = dcLists[0]
					.getColDataContainerInterface(0);
			beansAttach = (BOAttachBean[]) dcs;

			List fileList = (List) obj[0];
			// Map paras = (Map)obj[1];

			if (fileList == null || fileList.size() == 0) {
				throw new Exception("�Ҳ����ϴ����ļ�!");
			}

			FileItem item = (FileItem) fileList.get(0);
			String localfilename = item.getName();
			String filename = localfilename.substring(localfilename
					.lastIndexOf("\\") + 1, localfilename.length());
			String remotefilename = beansAttach[0].getAttPath() + "/"
					+ filename;

			FTPAgent ftpagent = new FTPAgent(SYS_ATTACH_FTP_IP,
					SYS_ATTACH_FTP_PORT, SYS_ATTACH_FTP_USERNAME,
					SYS_ATTACH_FTP_PSW);
			ftpagent.deleteFile(SYS_ATTACH_FTP_ROOT + "/" + remotefilename);
			ftpagent.upload(remotefilename, item.getInputStream());// -------------------------
			ftpagent.closeServer();
			// ��ѯ�����Ƿ��ϴ�������
			IBOQueryAttPackValue[] attPackValues = iAttachService
					.queryQueryAttPack(objNo, type);
			if (attPackValues == null) {// ����û���ϴ�������
				beansAttach[0].setAttName(filename);
				beansAttach[0].setSubmitTime(ServiceManager.getOpDateTime());
				iAttachService.newAttach(beansAttach[0]);

				BOPackageBean packBean = new BOPackageBean();
				packBean.setAttId(beansAttach[0].getAttId());
				packBean.setObjNo(objNo);
				packBean.setObjType(Long.parseLong(type));
				iAttachService.saveNewPackage(new BOPackageBean[] { packBean });

			} else {// �����ϴ�������
				String ids = "";
				StringBuffer sb = new StringBuffer();
				for (int i = 0; i < attPackValues.length; i++) {
					sb = sb.append(attPackValues[i].getAttId() + ",");
				}
				ids = sb.toString().substring(0, sb.length() - 1);
				IBOAttachValue[] attachValues = iAttachService
						.queryBOAttachByIds(ids);
				boolean isUpdate = false;
				// �����Ƿ��ϴ���ͬ������
				for (int i = 0; i < attachValues.length; i++) {
					if (attachValues[i].getAttName().equals(filename)) {// �ϴ���ͬ������
						attachValues[i].setSubmitTime(ServiceManager
								.getOpDateTime());
						attachValues[i].setAttDesc(beansAttach[0].getAttDesc());
						iAttachService.saveAttach(attachValues[i]);
						isUpdate = true;
					}
				}
				if (!isUpdate) {// û���ϴ���ͬ������
					beansAttach[0].setAttName(filename);
					beansAttach[0]
							.setSubmitTime(ServiceManager.getOpDateTime());
					iAttachService.newAttach(beansAttach[0]);

					BOPackageBean packBean = new BOPackageBean();
					packBean.setAttId(beansAttach[0].getAttId());
					packBean.setObjNo(objNo);
					packBean.setObjType(Long.parseLong(type));
					iAttachService
							.saveNewPackage(new BOPackageBean[] { packBean });
				}

			}
			// �趨�ɹ�������Ϣ
			aCp.set("IsOk", "TRUE");
			aCp.set("MESSAGE", "�����ϴ��ɹ���");
			// ���سɹ���Ϣ��ע�⣺ֻ��ҪCustomProperty����ҪtoXmlString
			ApacheUploadTool.showFileUploadMsg(response, aCp);
		} catch (Exception ex) {
			// �趨ʧ�ܷ�����Ϣ
			aCp.set("IsOk", "FALSE");
			aCp.set("MESSAGE", "�����ϴ�ʧ�ܣ�" + ex.getMessage());
			// ����ʧ����Ϣ��ע�⣺ֻ��ҪCustomProperty����ҪtoXmlString
			ApacheUploadTool.showFileUploadMsg(response, aCp);
		}
	}

	public void doDocTempUploadPackage(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		CustomProperty aCp = CustomProperty.getInstance();
		try {
			initial();
			String uploadPath = request.getParameter("uploadPath");

			// ����apache�ؼ��ϴ��ļ�,��������,��һ������ļ�����,�ڶ�����Ų�������
			request.setCharacterEncoding("GBK");
			Object obj[] = ApacheUploadTool.getUploadFileInfo(request);

			List fileList = (List) obj[0];

			if (fileList == null || fileList.size() == 0) {
				throw new Exception("�Ҳ����ϴ����ļ�!");
			}

			FileItem item = (FileItem) fileList.get(0);
			String localfilename = item.getName();
			// String fileType =
			// localfilename.substring(localfilename.lastIndexOf(".")+1,localfilename.length());
			String filename = localfilename.substring(localfilename
					.lastIndexOf("\\") + 1, localfilename.length());
			String remotefilename = uploadPath + "/" + filename;

			FTPAgent ftpagent = new FTPAgent(SYS_ATTACH_FTP_IP,
					SYS_ATTACH_FTP_PORT, SYS_ATTACH_FTP_USERNAME,
					SYS_ATTACH_FTP_PSW);
			ftpagent.upload(uploadPath + "/" + filename, item.getInputStream());
			ftpagent.closeServer();

			// �趨�ɹ�������Ϣ
			aCp.set("IsOk", "TRUE");
			aCp.set("MESSAGE", "ģ���ϴ��ɹ���");
			aCp.set("FileName", filename);
			// ���سɹ���Ϣ��ע�⣺ֻ��ҪCustomProperty����ҪtoXmlString
			ApacheUploadTool.showFileUploadMsg(response, aCp);
		} catch (Exception ex) {
			// �趨ʧ�ܷ�����Ϣ
			aCp.set("IsOk", "FALSE");
			aCp.set("MESSAGE", "ģ���ϴ�ʧ�ܣ�" + ex.getMessage());
			// ����ʧ����Ϣ��ע�⣺ֻ��ҪCustomProperty����ҪtoXmlString
			ApacheUploadTool.showFileUploadMsg(response, aCp);
		}
	}

	public void delPackage(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
			CustomProperty aCp = CustomProperty.getInstance();
		try {
			initial();
			String attPackId = request.getParameter("attPackId");
			IBOQueryAttPackValue[] valuesAttPack = iAttachService
					.queryQueryAttPackByIds(attPackId);
			ArrayList<IBOPackageValue> al = new ArrayList<IBOPackageValue>();
			for (int i = 0; i < valuesAttPack.length; i++) {
				BOPackageBean packBean = new BOPackageBean();
				packBean.setAttPackId(valuesAttPack[i].getAttPackId());
				packBean.setAttId(valuesAttPack[i].getAttId());
				al.add(packBean);
			}
			
			for(IBOQueryAttPackValue valuesAtt:valuesAttPack){
				IBOQueryAttPackValue[] val = iAttachService.queryPackageByAttId(String.valueOf(valuesAtt.getAttId()));
				FTPAgent ftpagent = new FTPAgent(SYS_ATTACH_FTP_IP,
						SYS_ATTACH_FTP_PORT, SYS_ATTACH_FTP_USERNAME,
						SYS_ATTACH_FTP_PSW);
				ftpagent.deleteFile(SYS_ATTACH_FTP_ROOT+ "/" +val[0].getAttPath()+"/"+val[0].getAttName());
				iAttachService.delPackage(al.toArray(new IBOPackageValue[al.size()]));
				IBOAttachValue[] attch = iAttachService.queryAttachById(String.valueOf(val[0].getAttId()));
				attch[0].delete();
				iAttachService.saveAttach(attch[0]);
				aCp.set("msg", "ɾ���ɹ�");
			}
		} catch (Exception e) {
			aCp.set("msg", "ɾ��ʧ��");
		}finally{
			HttpUtil.showInfo(response, aCp);
		}
	}

	public void newPackage(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		try {

			String objNo = request.getParameter("objNo");
			String type = request.getParameter("type");

			DataContainerList[] dcList = HttpUtil.getDataContainerLists(request
					.getInputStream(), new Class[] { BOQueryAttachBean.class });
			if (dcList == null || dcList.length == 0) {
				HttpUtil.showError(response, "δ����Ҫ���������!");
				return;
			}
			// ��������ĸ����Ǳ����Լ��ϴ����ģ����ٴ����µļ�¼
			BOQueryAttachBean[] beans = (BOQueryAttachBean[]) dcList[0]
					.getColDataContainerInterface(0);
			ArrayList<BOPackageBean> al = new ArrayList<BOPackageBean>();
			// ��ѯ�����Ѿ��ϴ����ĸ���
			IBOQueryAttPackValue[] attPackValues = iAttachService
					.queryQueryAttPack(objNo, type);
			IBOAttachValue[] attachValues = null;
			if(attPackValues==null||attPackValues.length==0){
				for (int i = 0; i < beans.length; i++) {
					if (beans[i].getStatus() == 1) {
						BOPackageBean packageBean = new BOPackageBean();
						packageBean.setAttId(beans[i].getAttId());
						packageBean.setObjNo(objNo);
						packageBean.setObjType(Long.parseLong(type));
						al.add(packageBean);
					}
				}
			}else
			{// �����ϴ�������
				String ids = "";
				StringBuffer sb = new StringBuffer();
				for (int i = 0; i < attPackValues.length; i++) {
					sb = sb.append(attPackValues[i].getAttId() + ",");
					ids = sb.toString().substring(0, sb.length() - 1);
				}
				// ��ѯ�������ϴ��ĸ�����Ϣ
				System.out.print("-------------" + sb + "--------------");
				System.out.print("SSSSSSSSSS" + ids + "AAAAAAAAAAA");
				attachValues = iAttachService.queryBOAttachByIds(ids);
				for (int i = 0; i < beans.length; i++) {
					if (beans[i].getStatus() == 1) {
						for (int j = 0; j < attachValues.length; j++) {
							if ((beans[i].getAttName().equals(attachValues[j]
									.getAttName()))
									&& (beans[i].getSubmitterTag()
											.equals(attachValues[j]
													.getSubmitterTag()))) {
							} else {
								BOPackageBean packageBean = new BOPackageBean();
								packageBean.setAttId(beans[i].getAttId());
								packageBean.setObjNo(objNo);
								packageBean.setObjType(Long.parseLong(type));
								al.add(packageBean);
								break;
							}
						}
					}
				}
			} 
			iAttachService.saveNewPackage(al.toArray(new IBOPackageValue[al
					.size()]));

			HttpUtil.showInfo(response, "��ӳɹ�");
		} catch (Exception e) {
			HttpUtil.showError(response, "���ʧ��!" + e.getMessage());
		}
	}
		
	// dxp-6.3 ���� �ļ�ģ�� ��Ϣ��
	public void saveDocTemp(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		try {
			// Ҫ��ӵ���Ŀ¼�� ά�� Doc_temp_Tree
			String parentNO = request.getParameter("parentNO");
			String parentName = request.getParameter("parentName");
			String oldFileName = request.getParameter("oldFileName");
			String oldFilePath = request.getParameter("oldFilePath");

			// ����oldFileName oldFilePath ��Ϊ�յĻ���ɾ�� FTP�ϵ� �ļ�
			if (!"".equals(oldFileName) && !"".equals(oldFilePath)) {
				FTPAgent ftpagent = new FTPAgent(SYS_ATTACH_FTP_IP,
						SYS_ATTACH_FTP_PORT, SYS_ATTACH_FTP_USERNAME,
						SYS_ATTACH_FTP_PSW);
				ftpagent.deleteFile(oldFilePath + "/" + oldFileName);
				ftpagent.closeServer();
			}

			BODocTemplateBean[] beansDocTemps = null;

			DataContainerList[] dcLists = HttpUtil.getDataContainerLists(
					request.getInputStream(),
					new Class[] { BODocTemplateBean.class });
			if (dcLists == null || dcLists.length == 0) {
				HttpUtil.showError(response, "δ����Ҫ���������!");
				return;
			}
			for (int i = 0; i < dcLists.length; i++) {
				Object[] obj = dcLists[i].getColDataContainerInterface(0);
				if (obj instanceof BODocTemplateBean[]) {
					beansDocTemps = (BODocTemplateBean[]) obj;
				}
			}
			// �����ĵ�ģ��
			iAttachService.saveDocTemp(beansDocTemps);
			// ά���ĵ�ģ���� ���ҵ�ɾ��������ӡ�
			String tempVerNO = beansDocTemps[0].getTempVersionNo();
			String tempName = beansDocTemps[0].getDocTempName();
			iAttachService.saveDocTempTree(tempVerNO, tempName, parentNO,
					parentName);

			HttpUtil.showInfo(response, "�ļ�ģ�屣��ɹ�");
		} catch (Exception e) {
			HttpUtil.showError(response, "�ļ�ģ�屣��ʧ��!" + e.getMessage());
		}
	}

	// dxp-6.12 ɾ�� �ļ�ģ�� ��Ϣ��
	public void delDocTemp(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		try {
			BODocTemplateBean[] beansDocTemps = null;

			DataContainerList[] dcLists = HttpUtil.getDataContainerLists(
					request.getInputStream(),
					new Class[] { BODocTemplateBean.class });
			if (dcLists == null || dcLists.length == 0) {
				HttpUtil.showError(response, "δ����Ҫ���������!");
				return;
			}
			for (int i = 0; i < dcLists.length; i++) {
				Object[] obj = dcLists[i].getColDataContainerInterface(0);
				if (obj instanceof BODocTemplateBean[]) {
					beansDocTemps = (BODocTemplateBean[]) obj;
				}
			}

			FTPAgent ftpagent = new FTPAgent(SYS_ATTACH_FTP_IP,
					SYS_ATTACH_FTP_PORT, SYS_ATTACH_FTP_USERNAME,
					SYS_ATTACH_FTP_PSW);
			// ftpagent.deleteFile(fileName);
			// ftpagent.closeServer();

			// ɾ��ģ�壬ɾ�� tree ��ɾ�� FTP
			iAttachService.delTempAndFileAndTree(beansDocTemps[0], ftpagent);

			HttpUtil.showInfo(response, "�ļ�ģ��ɾ���ɹ�");
		} catch (Exception e) {
			HttpUtil.showError(response, "�ļ�ģ��ɾ��ʧ��!" + e.getMessage());
		}
	}

	// dxp-6.11 ���� ģ�� �� ��Ϣ��
	public void saveTempTree(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		try {
			BODocTemplateBean[] beansDocTemps = null;

			// ά�� Doc_temp_Tree
			String sonTreeNO = request.getParameter("sonTreeNO");
			String sonTreeName = request.getParameter("sonTreeName");

			String parentTreeNO = request.getParameter("parentTreeNO");
			String parentTreeName = request.getParameter("parentTreeName");

			iAttachService.saveTempTreeData(sonTreeNO, sonTreeName,
					parentTreeNO, parentTreeName);

			HttpUtil.showInfo(response, "Ŀ¼����ɹ�");
		} catch (Exception e) {
			HttpUtil.showError(response, "Ŀ¼����ʧ��!" + e.getMessage());
		}
	}

	// dxp-6.11 ɾ�� ģ�� �� Ŀ¼��Ϣ�� �Ȳ� ��ɾ
	public void delTempTree(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		try {
			BODocTemplateBean[] beansDocTemps = null;

			// �Ȳ� Doc_temp_Tree
			String parentTreeNO = request.getParameter("parentTreeNO");
			String parentTreeName = request.getParameter("parentTreeName");

			IBODocTempTreeValue[] tempTrees = iAttachService
					.queryDocTempTree(parentTreeNO);
			if (tempTrees.length > 0) {
				HttpUtil.showInfo(response, parentTreeName
						+ "Ŀ¼������Ŀ¼�������ĵ�ģ�壬��ֹɾ����");
			}

			if (tempTrees.length == 0) {
				iAttachService.delDocTempTree(parentTreeNO);
				HttpUtil.showInfo(response, "Ŀ¼ɾ���ɹ�");
			}
		} catch (Exception e) {
			HttpUtil.showError(response, "Ŀ¼ɾ��ʧ��!" + e.getMessage());
		}
	}

	
	public static String getSYS_ATTACH_FTP_IP() {
		return SYS_ATTACH_FTP_IP;
	}

	public static int getSYS_ATTACH_FTP_PORT() {
		return SYS_ATTACH_FTP_PORT;
	}

	public static String getSYS_ATTACH_FTP_USERNAME() {
		return SYS_ATTACH_FTP_USERNAME;
	}

	public static String getSYS_ATTACH_FTP_PSW() {
		return SYS_ATTACH_FTP_PSW;
	}

	public static String getSYS_ATTACH_FTP_ROOT() {
		return SYS_ATTACH_FTP_ROOT;
	}

}
