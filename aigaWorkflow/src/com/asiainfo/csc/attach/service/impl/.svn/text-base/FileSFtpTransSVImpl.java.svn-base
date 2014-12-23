package com.asiainfo.csc.attach.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.UUID;
import java.util.Vector;

import org.apache.commons.fileupload.FileItem;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

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
import com.asiainfo.csc.attach.service.interfaces.IFileSFtpTransSV;
import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;

public class FileSFtpTransSVImpl implements IFileSFtpTransSV{

	private static String ATTACH_CONFIG = "AttachConfig.xml";
	private static String SYS_ATTACH_FTP_IP;
	private static String SYS_ATTACH_FTP_USERNAME;
	private static String SYS_ATTACH_FTP_PSW;
	private static String SFTP_PRIVATE_KEY;
	private static String SFTP_KEY_PSW;
	private static int SYS_ATTACH_FTP_PORT = 22;
	private static String SYS_ATTACH_FTP_ROOT;
	private static String SYS_ATTACH_DOWN_TEMP;
	private static String SYS_ATTACH_RAR_TEMP;

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
			} else if ("SFTP_PRIVATE_KEY".equals(name)) {
				if (value != null) {
					SFTP_PRIVATE_KEY = value;
				}
			} else if ("SFTP_KEY_PSW".equals(name)) {
				SFTP_KEY_PSW = value;
			} else {
				if ((!"SYS_ATTACH_FTP_PSW".equals(name)) || (value == null)) {
					continue;
				}
				SYS_ATTACH_FTP_PSW = value;
			}

		}

	}

	/**
	 * 获取连接
	 * 
	 * @return channel
	 */
	private ChannelSftp connectSFTP() {
		JSch jsch = new JSch();
		Channel channel = null;
		try {
			if (SFTP_PRIVATE_KEY != null && !"".equals(SFTP_PRIVATE_KEY)) {
				
				if (SFTP_KEY_PSW != null && "".equals(SFTP_KEY_PSW)) {
					jsch.addIdentity(SFTP_PRIVATE_KEY, SFTP_KEY_PSW);
				} else {
					jsch.addIdentity(SFTP_PRIVATE_KEY);
				}
			}
			Session session = jsch.getSession(SYS_ATTACH_FTP_USERNAME,
					SYS_ATTACH_FTP_IP, SYS_ATTACH_FTP_PORT);
			if (SYS_ATTACH_FTP_PSW != null && !"".equals(SYS_ATTACH_FTP_PSW)) {
				session.setPassword(SYS_ATTACH_FTP_PSW);
			}
			Properties sshConfig = new Properties();
			sshConfig.put("StrictHostKeyChecking", "no");// do not verify
			
			session.setConfig(sshConfig);
			// session.setTimeout(timeout);
			session.setServerAliveInterval(92000);
			session.connect();
			
			channel = session.openChannel("sftp");
			channel.connect();
			System.out.println("sftp链接成功");
		} catch (JSchException e) {
			e.printStackTrace();
			System.out.println("sftp链接失败");
			throw new RuntimeException(e);
		}
		return (ChannelSftp) channel;
	}

	/**
	 * 上传文件
	 * 
	 * @param directory
	 *            上传的目录
	 * @param uploadFile
	 *            要上传的文件
	 * @param sftp
	 */
	private void upload(String directory, FileItem fileItem, ChannelSftp sftp) {
		try {
			this.createDir(directory, sftp);
			if (!fileItem.isFormField()) {
				String fileName = fileItem.getName();
				sftp.put(fileItem.getInputStream(),new String(fileName.getBytes("UTF-8"),"GBK"),ChannelSftp.OVERWRITE);
				System.out.println("sftp上传成功");
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("sftp上传失败");
			throw new RuntimeException(e);
		} finally {
			this.disconnected(sftp);
		}
	}
	
	private boolean createDir(String dir, ChannelSftp sftp){
		if (dir.equals("") || dir.equals("/")) {
			try {
				sftp.cd(new String(this.SYS_ATTACH_FTP_ROOT.getBytes("UTF-8"),"GBK"));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				throw new RuntimeException(e);
			}
			return true;
		} else {
			StringTokenizer s = new StringTokenizer(dir, "/");
			s.countTokens();
			try {
				sftp.cd(new String(this.SYS_ATTACH_FTP_ROOT.getBytes("UTF-8"),"GBK"));
				String pathName = "";

				while (s.hasMoreElements()) {
					String checkDir = (String) s.nextElement();
					System.out.println("pathName:"+pathName);
					boolean hasCreate = this.checkSftpFolderHasCreate(this.SYS_ATTACH_FTP_ROOT+pathName, checkDir, sftp);
					if(hasCreate==false){
						sftp.mkdir(new String(checkDir.getBytes("UTF-8"),"GBK"));
					}
					pathName = pathName + checkDir + "/";
					//System.out.println("pathName:"+pathName);
					sftp.cd(new String(checkDir.getBytes("UTF-8"),"GBK"));
				}
				return true;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				System.out.println("创建sftp服务器文件夹出错");
				this.disconnected(sftp);
				throw new RuntimeException(e);
			}
		}
	}
	
	private boolean checkSftpFolderHasCreate(String checkPath,String checkDir,ChannelSftp sftp){
		boolean hasCreate =false;
		try {
			if(checkDir!=null&&!checkDir.equals("")){
				System.out.println("checkPath:"+checkPath);
				System.out.println("checkDir:"+checkDir);
				Vector dir = sftp.ls(new String(checkPath.getBytes("UTF-8"),"GBK"));
				Iterator dirs = dir.iterator();
		    	while(dirs.hasNext()){
		    		String childAllInfo = dirs.next().toString();
		    		int dirChildIndex = childAllInfo.lastIndexOf(" ");
		    		String childDir = childAllInfo.substring(dirChildIndex+1,childAllInfo.length());
		    		childDir = new String(childDir.getBytes("GBK"),"UTF-8");
		    		System.out.println("childDir:"+childDir+"---------------");
		    		if(checkDir.equals(childDir)){
		    			hasCreate = true;
		    			break;
		    		}
		    	}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			this.disconnected(sftp);
			throw new RuntimeException(e);
		}
		return hasCreate;
	}

	/**
	 * 下载文件
	 * 
	 * @param directory
	 *            下载目录
	 * @param downloadFile
	 *            下载的文件
	 * @param saveFile
	 *            存在本地的路径
	 * @param sftp
	 */
	private File download(String directory, String downloadFile,
			String saveFile, ChannelSftp sftp) {
		FileOutputStream fileStream = null;
		File file = null;
		try {
			sftp.cd(new String((this.SYS_ATTACH_FTP_ROOT+directory).getBytes("UTF-8"),"GBK"));
			file = new File(saveFile+downloadFile);  
			fileStream = new FileOutputStream(file);
			sftp.get(new String(downloadFile.getBytes("UTF-8"),"GBK"),fileStream);  
			if (!file.exists()) {
				throw new Exception("未找到中转文件");
			}
			System.out.println("sftp下载成功");
			return file;
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("sftp下载失败");
			throw new RuntimeException(e);
		} finally {
			try {
				fileStream.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				throw new RuntimeException(e);
			}
		}
	}

	/**
	 * 删除文件
	 * 
	 * @param directory
	 *            要删除文件所在目录
	 * @param deleteFile
	 *            要删除的文件
	 * @param sftp
	 */
	private void delete(String directory, String deleteFile, ChannelSftp sftp) {
		try {
			sftp.cd(new String((this.SYS_ATTACH_FTP_ROOT+directory).getBytes("UTF-8"),"GBK"));
			sftp.rm(new String(deleteFile.getBytes("UTF-8"),"GBK"));
			System.out.println("sftp删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("sftp删除失败");
			throw new RuntimeException(e);
		} 
	}

	private void disconnected(ChannelSftp sftp) {
		if (sftp != null) {
			sftp.getSession().disconnect();
			System.out.println("sftp段开链接成功");
			sftp.disconnect();
		}
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

	
	public File downloadFile(List filePath) throws Exception {
		// TODO Auto-generated method stub
		initial();
		ChannelSftp sftp = this.connectSFTP();
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
				File fileOrDirectory = this.download(path.substring(0, path
						.lastIndexOf("/") + 1), path.substring(path
						.lastIndexOf("/") + 1), rarTpath, sftp);

				if (fileOrDirectory.isFile()) {
					zipFileOrDirectory(out, fileOrDirectory);
					fileOrDirectory.delete();
				} else
					throw new Exception("filePath参数需要全路径名以及扩展名");
			}

		} catch (IOException ex) {
			tempFile.delete();
			ex.printStackTrace();
			throw new RuntimeException(ex);
		} finally {
			out.close();
			dest.close();
			this.disconnected(sftp);
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
		ChannelSftp sftp = this.connectSFTP();

		if (!fileItem.isFormField()) {
			try {
				this.upload(remotePath, fileItem, sftp);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				throw new RuntimeException(e);
			}
			return true;
		}
		return false;
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
				attName = filePath.getName();
				uploadFile = filePath;
			} else {
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
					orgName = "/"+filePath.getString("UTF-8")+"/";
			}
		}
		boolean isUpdate = false;
		IAttachService attSV = (IAttachService) ServiceFactory.getService(IAttachService.class);
		Map<String, String> trv = attSV.checkHasFile(objNo, type, submitTag, attName);
		if(trv.get("isRepeat").equals("Y")){
			isUpdate = true;
			Criteria sql = new Criteria();
			sql.addEqual(BOQueryAttPackBean.S_ObjNo, objNo);
			sql.addEqual(BOQueryAttPackBean.S_ObjType, type);
			sql.addEqual(BOQueryAttPackBean.S_SubmitterTag, submitTag);
			sql.addEqual(BOQueryAttPackBean.S_AttName, attName);
			IBOQueryAttPackValue[] values = attSV.queryQueryAttPackByCon(sql.toString(), sql.getParameters());
			IBOAttachValue[] attachValue = attSV.queryAttachById(String.valueOf(values[0].getAttId()));
			attachValue[0].setAttType(attType);
			attachValue[0].setSubmitTime(ServiceManager.getOpDateTime());
			attSV.saveAttach(attachValue[0]);
		}else{
			isUpdate = false;
		}
		
		if(!isUpdate){
			IBOAttachValue bean = new BOAttachBean();
			bean.setAttName(attName);
			bean.setAttPath(objNo+orgName+submitTag+"/");
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
		this.uploadFile(uploadFile, objNo+orgName+submitTag+"/");
	}

	
	public void deleteAttach(String attPackIds) throws Exception {
		// TODO Auto-generated method stub
		initial();
		ChannelSftp sftp = this.connectSFTP();
		try {
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
					this.delete(attPath, attName,sftp);
					attachs[0].delete();
					attSV.saveAttach(attachs[0]);
				}
			}
			attSV.delPackage(packValues);
		} finally {
			this.disconnected(sftp);
		}
	}
}
