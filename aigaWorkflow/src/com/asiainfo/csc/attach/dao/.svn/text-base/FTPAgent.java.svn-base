package com.asiainfo.csc.attach.dao;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpATTRS;
import com.jcraft.jsch.SftpException;

public class FTPAgent{
	
	private static transient Log log = LogFactory.getLog(FTPAgent.class);

	protected Session session;
	protected Channel channel;
	/** 对外可访问 ChannelSftp对象提供的所有底层方法*/
	public ChannelSftp chnSftp;
	
	String host, username, password;
	int port;
	String remote_path;

	/**
	 * 构造服务
	 * @param host
	 * @param username
	 * @param password
	 * @throws Exception
	 */
	public FTPAgent(String host, String username, String password) throws Exception {
		this.host = host;
		this.port = 21;
		this.username = username;
		this.password = password;
		this.connect();
	}

	/**
	 * 构造服务
	 * @param host
	 * @param port
	 * @param username
	 * @param password
	 * @throws Exception
	 */
	public FTPAgent(String host, int port, String username, String password) throws Exception {
		this.host = host;
		this.port = port;
		this.username = username;
		this.password = password;
		this.connect();
	}

	/**
	 * 连接sftp
	 * @throws JSchException
	 */
	public void connect() throws JSchException{
		JSch jsch = new JSch();
		session = jsch.getSession(username, host, port);
		session.setPassword(password);
		
		Properties sshConfig = new Properties();
		sshConfig.put("StrictHostKeyChecking", "no");
		session.setConfig(sshConfig);
		
		session.connect();
		
		channel = session.openChannel("sftp");
		
		channel.connect();
		
		chnSftp = (ChannelSftp) channel;
	}

	/**
	 * 重新打开连接
	 * @throws Exception
	 */
	private void reOpen() throws Exception {
		this.connect();
	}

	/**
	 * 关闭服务
	 * @throws IOException
	 */
	public void closeServer() throws IOException {
		if (channel.isConnected()) {
			channel.disconnect();
			//System.out.println("Channel connect  disconnect!");

		}
		if (session.isConnected()) {
			session.disconnect();
			//System.out.println("Session connect disconnect!");
		}
	}

	/**
	 * 设置工作目录
	 * @param dir
	 * @throws Exception
	 */
	public void setWorkingFolder(String dir) throws Exception {
		this.remote_path = dir;
		chnSftp.cd(remote_path);
	}

	/**
	 * 创建目录
	 * @param dir
	 * @throws Exception
	 */
	public void makeDirs(String dir) throws Exception {
		if (dir == null) {
			return;
		}
		StringTokenizer st = new StringTokenizer(dir, "/");
		boolean result;
		if (dir.startsWith("/")) {
			this.chnSftp.cd("/");
		}
		
		int i = 0;
		while (st.hasMoreElements()) {
			String tmp = st.nextToken();

			if (tmp.equals(""))
				continue;
			try {
				if(!this.isDirExist(convertString(tmp)))
					this.chnSftp.mkdir(convertString(tmp));
			} catch (Exception e) {
				e.printStackTrace();
			}
			try{
				this.chnSftp.cd(convertString(tmp));
				++i;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		for (int k = 0; k < i; ++k) {
			this.chnSftp.cd("../");
		}
			
	}

	/**
	 * 删除目录
	 * @param folderName
	 * @throws Exception
	 */
	public void deleteFolder(String folderName) throws Exception {
		this.chnSftp.rmdir(convertString(folderName));
	}

	/**
	 * 改名
	 * @param oldFileName
	 * @param newFileName
	 * @return
	 * @throws Exception
	 */
	public boolean renameFile(String oldFileName, String newFileName) throws Exception {
		int index = newFileName.lastIndexOf("/");

		if (index > -1) {
			String folder = newFileName.substring(0, index);
			makeDirs(folder);
		}
		this.chnSftp.rename(convertString(oldFileName), convertString(newFileName));
		return true;
	}
	

	/**
	 * 删除文件
	 * @param fileName
	 * @throws Exception
	 */
	public void deleteFile(String fileName) throws Exception {
		this.chnSftp.rm(convertString(fileName));
	}
	
	/**
	 * 下载文件
	 * @param fullName
	 * @param out
	 * @throws Exception
	 */
	public void download(String fullName, OutputStream out) throws Exception {

		this.chnSftp.get(convertString(fullName), out);

	}

	
	/** 得到远程文件大小
	 * @see   返回文件大小
	 * @param srcSftpFilePath
	 * @return 返回文件大小，如返回-2 文件不存在，-1文件读取异常
	 * @throws SftpException
	 */
	public long getFileSize (String srcSftpFilePath) throws SftpException {
		long filesize = 0;//文件大于等于0则存在
		try {
			SftpATTRS sftpATTRS = chnSftp.lstat(srcSftpFilePath);
			filesize = sftpATTRS.getSize();
		} catch (Exception e) {
			filesize = -1;//获取文件大小异常
			if (e.getMessage().toLowerCase().equals("no such file")) {
				filesize = -2;//文件不存在
			}
		}
		return filesize;
	}

	/**
	 * 判断远程文件是否存在
	 * @param srcSftpFilePath
	 * @return
	 * @throws SftpException
	 */
	public boolean isFileExist (String srcSftpFilePath) throws SftpException {
		boolean isExitFlag = false;
		// 文件大于等于0则存在文件
		if (getFileSize(srcSftpFilePath) >= 0) {
			isExitFlag = true;
		}
		return isExitFlag;
	}
	
	/**
	 * 判断目录是否存在
	 * @param directory
	 * @return
	 * @throws SftpException
	 */
	public boolean isDirExist (String directory) throws SftpException {
		boolean isDirExistFlag = false;
		try {
			SftpATTRS sftpATTRS = chnSftp.lstat(directory);
			isDirExistFlag = true;
			return sftpATTRS.isDir();
		} catch (Exception e) {
			if (e.getMessage().toLowerCase().equals("no such file")) {
				isDirExistFlag = false;
			}
		}
		return isDirExistFlag;
	}
	/**
	 * inputStream类型转换为byte类型
	 * @param iStrm
	 * @return
	 * @throws IOException
	 */
	public byte[] inputStreamToByte (InputStream iStrm) throws IOException {
		ByteArrayOutputStream bytestream = new ByteArrayOutputStream();
		int ch;
		while ((ch = iStrm.read()) != -1) {
			bytestream.write(ch);
		}
		byte imgdata[] = bytestream.toByteArray();
		bytestream.close();
		return imgdata;
	}
	
	/**
	 * 下载文件后返回流文件
	 * @param sftpFilePath
	 * @return
	 * @throws SftpException
	 */
	public InputStream getFile (String sftpFilePath) throws SftpException {
		if (isFileExist(sftpFilePath)) {
			return chnSftp.get(sftpFilePath);
		}
		return null;
	}
	
	/** 
	 * 获取远程文件字节流
	 * @param sftpFilePath
	 * @return
	 * @throws SftpException
	 * @throws IOException
	 */
	public ByteArrayInputStream getByteArrayInputStreamFile (String sftpFilePath) throws SftpException,IOException {
		if (isFileExist(sftpFilePath)) {
			byte[] srcFtpFileByte = inputStreamToByte(getFile(sftpFilePath));
			ByteArrayInputStream srcFtpFileStreams = new ByteArrayInputStream(srcFtpFileByte);
			return srcFtpFileStreams;
		}
		return null;
	}
	
	/**
	 * 拷贝文件
	 * @param srcSftpFilePath
	 * @param distSftpFilePath
	 * @param fileName
	 * @return
	 * @throws Exception
	 */
	public String copyFile(String srcSftpFilePath, String distSftpFilePath, String fileName) throws Exception {
		String retInfo = "";
		boolean dirExist = false;
		boolean fileExist = false;
		fileExist = isFileExist(srcSftpFilePath);
		dirExist = isDirExist(distSftpFilePath);
		if (!fileExist) {
			//文件不存在直接反回.
			return "0:file not exist !";
		}
		if (!(dirExist)) {
			//1建立目录
			this.makeDirs(distSftpFilePath);
			//2设置dirExist为true
			dirExist = true;
		}
		if (dirExist && fileExist) {

			//String fileName = srcSftpFilePath.substring(srcSftpFilePath.lastIndexOf("/"), srcSftpFilePath.length());
			ByteArrayInputStream srcFtpFileStreams = getByteArrayInputStreamFile(srcSftpFilePath);
			//二进制流写文件
			this.chnSftp.put(srcFtpFileStreams, distSftpFilePath + fileName);
			retInfo = "1:copy file success!";
		}
		return retInfo;
	}
	
	/**
	 * 列出所有文件名
	 * @return
	 * @throws Exception
	 */
	public String[] listNames() throws Exception {
		List<String> fileList = new ArrayList<String>();
		String dir = chnSftp.pwd();
		if (isDirExist(dir)) {
			boolean itExist = false;
			Vector vector;
			vector = chnSftp.ls(dir);
			Iterator it = vector.iterator(); 
			while (it.hasNext()) {		
				ChannelSftp.LsEntry ls = (ChannelSftp.LsEntry) it.next(); 
				String strName=ls.getFilename();
				itExist = isDirExist(dir + "/" + strName);
				if (!(itExist)) {
					fileList.add(strName);
				}

			}
		}
		return fileList.toArray(new String[fileList.size()]);
	}

	/**
	 * 上传
	 * @param ftpFileName
	 * @param localFileName
	 * @throws Exception
	 */
	public void upload(String ftpFileName, String localFileName) throws Exception {
		FileInputStream sendfile = new FileInputStream(localFileName);
		upload(ftpFileName, sendfile);
	}

	/**
	 * 上传文件
	 * @param ftpFileName
	 * @param sendfile
	 * @throws Exception
	 */
	public void upload(String ftpFileName, InputStream sendfile) throws Exception {
		
		//ftpFileName = "/cygdrive/d/tmp/aaaa/a.vsd";
		String path = convertString(ftpFileName);
		
		log.debug(path);
		path = path.substring(0, path.lastIndexOf(convertString("/")));
		log.debug(path);
		this.makeDirs(path);
		if(this.isFileExist(convertString(ftpFileName)))
			throw new Exception("存在相同文件名的文件，重复上传。");
		chnSftp.put(sendfile, convertString(ftpFileName));

	}

	private String convertString(String str) throws Exception {
		if (str == null) return "";
		return str;
		//return new String(str.getBytes("GBK"), "iso-8859-1");//"iso-8859-1");
	}
	
	public void inputstreamtofile(InputStream ins,File file) throws Exception{
		OutputStream os = new FileOutputStream(file);
		int bytesRead = 0;
		byte[] buffer = new byte[8192];
		while ((bytesRead = ins.read(buffer, 0, 8192)) != -1) {
		os.write(buffer, 0, bytesRead);
		}
		os.close();
		ins.close();
	}
	
	

	/**
	 * 列出所有文件
	 * @param dir
	 * @param s
	 * @return
	 */
	public File[] getFiles(String dir,String s) {    
        //开始的文件夹    
        File file = new File(dir);    
  
        s = s.replace('.', '#');    
        s = s.replaceAll("#", "\\\\.");    
        s = s.replace('*', '#');    
        s = s.replaceAll("#", ".*");    
        s = s.replace('?', '#');    
        s = s.replaceAll("#", ".?");    
        s = "^" + s + "$";    
  
        System.out.println(s);    
        Pattern p = Pattern.compile(s);    
        ArrayList list = filePattern(file, p);    
        if(list == null){
        	return null;
        }
        File[] rtn = new File[list.size()];    
        list.toArray(rtn);    
        return rtn;    
      }    
	
	private ArrayList filePattern(File file, Pattern p) {    
        if (file == null) {    
          return null;    
        }    
        else if (file.isFile()) {    
          Matcher fMatcher = p.matcher(file.getName());    
          if (fMatcher.matches()) {    
            ArrayList list = new ArrayList();    
            list.add(file);    
            return list;    
          }    
        }    
        else if (file.isDirectory()) {    
          File[] files = file.listFiles();    
          if (files != null && files.length > 0) {    
            ArrayList list = new ArrayList();    
            for (int i = 0; i < files.length; i++) {    
              ArrayList rlist = filePattern(files[i], p);    
              if (rlist != null) {    
                list.addAll(rlist);    
              }    
            }    
            return list;    
          }    
        }    
        return null;    
      }    

	/**
	 * 拷贝文件
	 * @param filefrom
	 * @param fileto
	 * @param rewrite
	 * @return
	 */
	public boolean copyFile(java.io.File filefrom, java.io.File fileto, boolean rewrite) {
		
		if (!filefrom.exists()) {
			 System.out.println("文件不存在");
			 return false;
		}
		if (!filefrom.isFile()) {
			 System.out.println("不能够复制文件夹");
			 return false;
		}
		if (!filefrom.canRead()) {
			 System.out.println("不能够读取需要复制的文件");
			 return false;
		}
		if (!fileto.getParentFile().exists()) {
			 fileto.getParentFile().mkdirs();
		}
		if (fileto.exists() && rewrite) {
			 fileto.delete();
		}

		try {
			java.io.FileInputStream fosfrom = new java.io.FileInputStream(filefrom);
			java.io.FileOutputStream fosto = new FileOutputStream(fileto);
			byte bt[] = new byte[1024];
			int c;
			while ((c = fosfrom.read(bt)) > 0) {
			    fosto.write(bt, 0, c);
			}
			fosfrom.close();
			fosto.close();
			return true;
		} catch (Exception ex) {
			ex.printStackTrace();
			return false;
		}

	}

	/**
	 * 拷贝文件
	 * @param from
	 * @param to
	 * @return
	 */
	public boolean copyFile(String from, String to) {
		java.io.File filefrom = new java.io.File(from);
		java.io.File fileto = new java.io.File(to);
		System.out.println("The CopyFile is over!");
		System.out.println("您是从"+filefrom.getPath()+"复制文件到"+fileto.getPath());
		return copyFile(filefrom, fileto, true);
	}
	
	public static void main(String[] args){
		try {
			FTPAgent f=new FTPAgent("10.248.12.150",21,"Anonymous","");
			//f.upload("/pub/a.txt", "e:/test.txt");
			f.setWorkingFolder(f.convertString("pub"));
			f.setWorkingFolder(f.convertString("集团一级系统"));
			String[] ss=f.listNames();
			for(int i=0;i<ss.length;i++){
				System.out.println(ss[i]);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//f.upload(ftpFileName, localFileName)
		
		
	}

}