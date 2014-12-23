package com.asiainfo.csc.attach.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.UUID;

import org.apache.commons.fileupload.FileItem;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import sun.net.TelnetInputStream;
import sun.net.TelnetOutputStream;
import sun.net.ftp.FtpClient;

import com.ai.appframe2.common.ServiceManager;
import com.ai.appframe2.service.ServiceFactory;
import com.ai.appframe2.util.criteria.Criteria;
import com.asiainfo.csc.attach.bo.BOAttachBean;
import com.asiainfo.csc.attach.bo.BOPackageBean;
import com.asiainfo.csc.attach.bo.BOQueryAttPackBean;
import com.asiainfo.csc.attach.ivalues.IBOAttachValue;
import com.asiainfo.csc.attach.ivalues.IBOPackageValue;
import com.asiainfo.csc.attach.ivalues.IBOQueryAttPackValue;
import com.asiainfo.csc.attach.service.interfaces.IAttachService;
import com.asiainfo.csc.attach.service.interfaces.IFileFtpTransSV;

public class FileFtpTransSVImpl implements IFileFtpTransSV {

	private FtpClient ftpClient;

	private static String ATTACH_CONFIG = "AttachConfig.xml";
	private static String SYS_ATTACH_FTP_IP = null;
	private static int SYS_ATTACH_FTP_PORT = 21;
	private static String SYS_ATTACH_FTP_USERNAME = null;
	private static String SYS_ATTACH_FTP_PSW = null;
	private static String SYS_ATTACH_FTP_ROOT = null;
	private static String SYS_ATTACH_DOWN_TEMP = null;
	private static String SYS_ATTACH_RAR_TEMP = null;

	
	public File downloadFile(List filePath) throws Exception {
		// TODO Auto-generated method stub\
		initial();
		this.connectServer(SYS_ATTACH_FTP_IP, SYS_ATTACH_FTP_PORT,
				SYS_ATTACH_FTP_USERNAME, SYS_ATTACH_FTP_PSW,
				SYS_ATTACH_FTP_ROOT);
		ZipOutputStream out = null;
		File tempFile = null;
		FileOutputStream dest = null;
		File uuidFile = null;
		String zipFileName = "";
		String tPath = SYS_ATTACH_DOWN_TEMP+new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())+"/";
		String rarTpath = SYS_ATTACH_RAR_TEMP+new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())+"/";
		try {
			File tempPath = new File(tPath);
			if (!tempPath.exists())
				tempPath.mkdirs();
			do {
				zipFileName = UUID.randomUUID().toString();
				uuidFile = new File(tPath + zipFileName + ".rar");
			} while (uuidFile.exists());

			dest = new FileOutputStream(tPath + zipFileName + ".rar");
			out = new ZipOutputStream(dest);

			Iterator filePaths = filePath.iterator();
			while (filePaths.hasNext()) {
				String path = filePaths.next().toString();
				File tempRarPath = new File(rarTpath);
				if (!tempRarPath.exists())
					tempRarPath.mkdirs();
				File fileOrDirectory = this.download(path, rarTpath
						+ path.substring(path.lastIndexOf("/") + 1));
				if(out == null) {
					throw new Exception("ZipOutputStream为空");
				}
				if (fileOrDirectory.isFile()) {
					zipFileOrDirectory(out, fileOrDirectory);
					fileOrDirectory.delete();
				} else
					throw new Exception("filePath参数需要全路径名以及扩展名");
			}

		} catch (IOException ex) {
			tempFile.delete();
			ex.printStackTrace();
		} finally {
			out.close();
			dest.close();
			this.closeConnect();
		}
		tempFile = new File(tPath + zipFileName + ".rar");
		if (!tempFile.exists())
			throw new Exception("文件获取出错");
		return tempFile;
	}

	
	public boolean uploadFile(FileItem fileItem, String remotePath)
			throws Exception {
		// TODO Auto-generated method stub
		initial();
		String name = "";
		if (!fileItem.isFormField()) {
			this.connectServer(SYS_ATTACH_FTP_IP, SYS_ATTACH_FTP_PORT,
					SYS_ATTACH_FTP_USERNAME, SYS_ATTACH_FTP_PSW,
					SYS_ATTACH_FTP_ROOT);
			name = URLDecoder.decode(fileItem.getName(),"UTF-8");;
			try {
				this.upload(fileItem.getInputStream(), remotePath + name);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			} finally {
				this.closeConnect();
			}
		}
		return true;
	}

	private static void zipFileOrDirectory(ZipOutputStream out,
			File fileOrDirectory) throws IOException {
		FileInputStream in = null;
		try {
			// 压缩文件
			byte[] buffer = new byte[4096];
			int bytes_read;
			in = new FileInputStream(fileOrDirectory);

			String fileName = fileOrDirectory.getName();

			ZipEntry entry = new ZipEntry(fileName);
			out.putNextEntry(entry);

			while ((bytes_read = in.read(buffer)) != -1) {
				out.write(buffer, 0, bytes_read);
			}
			out.closeEntry();

		} catch (IOException ex) {
			ex.printStackTrace();
			throw ex;
		} finally {
			in.close();
		}
	}

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

			if ("SYS_ATTACH_FTP_PORT".equals(name)) {
				if (value != null) {
					SYS_ATTACH_FTP_PORT = Integer.parseInt(value);
				}
			} else if ("SYS_ATTACH_FTP_ROOT".equals(name)) {
				SYS_ATTACH_FTP_ROOT = value;
			} else if ("SYS_ATTACH_FTP_IP".equals(name)) {
				SYS_ATTACH_FTP_IP = value;
			} else if ("SYS_ATTACH_FTP_USERNAME".equals(name)) {
				SYS_ATTACH_FTP_USERNAME = value;
			} else if ("SYS_ATTACH_DOWN_TEMP".equals(name)) {
				SYS_ATTACH_DOWN_TEMP = value;
			} else if ("SYS_ATTACH_RAR_TEMP".equals(name)) {
				SYS_ATTACH_RAR_TEMP = value;
			} else {
				if ((!"SYS_ATTACH_FTP_PSW".equals(name)) || (value == null)) {
					continue;
				}
				SYS_ATTACH_FTP_PSW = value;
			}

		}

	}

	private void connectServer(String ip, int port, String user,
			String password, String path) {
		try {
			ftpClient = new FtpClient();
			ftpClient.openServer(ip, port);
			
			if(user.equalsIgnoreCase("Anonymous") && "".equals(password)) {
				password = "1";
			}
			System.out.println("*******************ip:"+ip+"***************");
			System.out.println("*******************user:"+user+"***************");
			System.out.println("*******************password:"+password+"***************");
			System.out.println("*******************port:"+port+"***************");
			ftpClient.login(user, password);
			ftpClient.binary();
			System.out.println("login success!");
			if (path.length() != 0) {
				System.out.println("******************root:"+this.SYS_ATTACH_FTP_ROOT+"*************");
				ftpClient.cd(this.SYS_ATTACH_FTP_ROOT);
			}
		} catch (IOException ex) {
			ex.printStackTrace();
			throw new RuntimeException(ex);
		}
	}

	private void closeConnect() {
		try {
			ftpClient.closeServer();
			System.out.println("disconnect success");
		} catch (IOException ex) {
			System.out.println("not disconnect");
			ex.printStackTrace();
			throw new RuntimeException(ex);
		}
	}

	private void upload(InputStream fileStream, String remoteFile) {
		TelnetOutputStream os = null;
		try {
			this.createDir(remoteFile.substring(0,
					remoteFile.lastIndexOf("/") + 1));
			os = ftpClient.put(remoteFile
					.substring(remoteFile.lastIndexOf("/") + 1));
			byte[] bytes = new byte[1024];
			int c;
			while ((c = fileStream.read(bytes)) != -1) {
				os.write(bytes, 0, c);
			}
		} catch (IOException ex) {
			ex.printStackTrace();
			throw new RuntimeException(ex);
		} finally {
			try {
				if (fileStream != null) {
					fileStream.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					if (os != null) {
						os.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	private File download(String remoteFile, String localFile) {
		TelnetInputStream is = null;
		FileOutputStream os = null;
		try {
			is = ftpClient.get(remoteFile);
			File file_in = new File(localFile);
			os = new FileOutputStream(file_in);
			byte[] bytes = new byte[1024];
			int c;
			while ((c = is.read(bytes)) != -1) {
				os.write(bytes, 0, c);
			}
			System.out.println("download success");
			return file_in;
		} catch (IOException ex) {
			System.out.println("not download");
			ex.printStackTrace();
			throw new RuntimeException(ex);
		} finally {
			try {
				if (is != null) {
					is.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					if (os != null) {
						os.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	private boolean createDir(String dir) {

		StringTokenizer s = new StringTokenizer(dir, "/");
		s.countTokens();
		try {
			ftpClient.ascii();
			String pathName = "";

			while (s.hasMoreElements()) {
				pathName = pathName + (String) s.nextElement()+ "/";
				System.out.println("*********************pathName:"+pathName+"**********************");
				ftpClient.sendServer("XMKD " + pathName + "\r\n");
				int code = ftpClient.readServerResponse();
				System.out.println(code);
			}
			ftpClient.cd(dir);
			ftpClient.binary();
			return true;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("创建ftp服务器文件夹出错");
			this.closeConnect();
			throw new RuntimeException(e);
		}

	}

	private void deleteFile(String ftpPath, String ftpFileName) {
		try {
			ftpClient.sendServer("DELE " + ftpPath+ftpFileName + "\r\n");
			System.out.println("delete success" + ftpFileName);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("delete fail");
			throw new RuntimeException(e);
		}
	}

	
	public void saveAttach(List fileList) throws Exception {
		// TODO Auto-generated method stub
		String attType = "";
		String submitTag = "";
		String objNo = "";
		String type = "";
		String linkNo = "";
		String attName = "";
		String orgName = "";
		Iterator<FileItem> filePaths = fileList.iterator();
		FileItem uploadFile = null;
		while (filePaths.hasNext()) {
			FileItem filePath = filePaths.next();
			if (!filePath.isFormField()) {
				attName = URLDecoder.decode(filePath.getName(),"UTF-8");
				uploadFile = filePath;
			} else {
				String name = filePath.getFieldName();
				if (name.equals("type"))
					type = filePath.getString("GBK");
				else if (name.equals("attType"))
					attType = filePath.getString("GBK");
				else if (name.equals("submitUser"))
					submitTag = filePath.getString("GBK");
				else if (name.equals("objNo"))
					objNo = filePath.getString("GBK");
				else if (name.equals("linkNo"))
					linkNo = filePath.getString("GBK");
				else if (name.equals("orgName"))
					orgName = "/" + filePath.getString("GBK") + "/";
			}
		}
		boolean isUpdate = false;
		IAttachService attSV = (IAttachService) ServiceFactory
				.getService(IAttachService.class);
		Map<String, String> trv = attSV.checkHasFile(objNo, type, submitTag,
				attName);
		if (trv.get("isRepeat").equals("Y")) {
			isUpdate = true;
			Criteria sql = new Criteria();
			sql.addEqual(BOQueryAttPackBean.S_ObjNo, objNo);
			sql.addEqual(BOQueryAttPackBean.S_ObjType, type);
			sql.addEqual(BOQueryAttPackBean.S_SubmitterTag, submitTag);
			sql.addEqual(BOQueryAttPackBean.S_AttName, attName);
			IBOQueryAttPackValue[] values = attSV.queryQueryAttPackByCon(sql
					.toString(), sql.getParameters());
			IBOAttachValue[] attachValue = attSV.queryAttachById(String
					.valueOf(values[0].getAttId()));
			attachValue[0].setAttType(attType);
			attachValue[0].setSubmitTime(ServiceManager.getOpDateTime());
			attSV.saveAttach(attachValue[0]);
		} else {
			isUpdate = false;
		}

		if (!isUpdate) {
			IBOAttachValue bean = new BOAttachBean();
			bean.setAttName(attName);
			bean.setAttPath(objNo + orgName + submitTag + "/");
			bean.setAttType(attType);
			bean.setSubmitterTag(submitTag);
			bean.setSubmitLink(linkNo);
			bean.setSubmitTime(ServiceManager.getOpDateTime());

			attSV.newAttach(bean);

			BOPackageBean packBean = new BOPackageBean();
			packBean.setAttId(bean.getAttId());
			packBean.setObjNo(objNo);
			packBean.setObjType(Long.valueOf(type));
			attSV.saveNewPackage(new BOPackageBean[] { packBean });
		}
		this.uploadFile(uploadFile, objNo + orgName + submitTag + "/");
	}

	
	public void deleteAttach(String attPackIds) throws Exception {
		// TODO Auto-generated method stub
		try {
			initial();
			this.connectServer(SYS_ATTACH_FTP_IP, SYS_ATTACH_FTP_PORT,
					SYS_ATTACH_FTP_USERNAME, SYS_ATTACH_FTP_PSW,
					SYS_ATTACH_FTP_ROOT);
			if (attPackIds == null || attPackIds.trim().equals(""))
				throw new Exception("attPackIds为空");
			String condition = "ATT_PACK_ID in (" + attPackIds + ")";
			IAttachService attSV = (IAttachService) ServiceFactory
					.getService(IAttachService.class);
			IBOPackageValue[] packValues = attSV.getAttPackage(condition, null);
			for (IBOPackageValue packValue : packValues) {
				IBOAttachValue[] attachs = attSV.queryAttachById(String
						.valueOf(packValue.getAttId()));
				if (attachs.length > 1)
					throw new Exception("附件不为1");
				else if (attachs.length == 1) {
					String attName = attachs[0].getAttName();
					String attPath = attachs[0].getAttPath();
					this.deleteFile(attPath, attName);
					attachs[0].delete();
					attSV.saveAttach(attachs[0]);
				}
			}
			attSV.delPackage(packValues);
		} finally {
			this.closeConnect();
		}
	}
}
