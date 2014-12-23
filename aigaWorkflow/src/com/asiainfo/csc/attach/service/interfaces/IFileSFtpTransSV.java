package com.asiainfo.csc.attach.service.interfaces;

import java.io.File;
import java.util.List;

import org.apache.commons.fileupload.FileItem;

public interface IFileSFtpTransSV {

	public File downloadFile(List filePath) throws Exception;

	public boolean uploadFile(FileItem fileItem, String remotePath)throws Exception;
	
	public void saveAttach(List fileList) throws Exception;
	
	public void deleteAttach(String attPackIds) throws Exception;
}
