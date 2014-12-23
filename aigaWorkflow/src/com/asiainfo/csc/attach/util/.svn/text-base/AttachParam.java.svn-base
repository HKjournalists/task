package com.asiainfo.csc.attach.util;

import java.util.List;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

public class AttachParam {
	
	private static boolean bInitial = false;
	private static String ATTACH_CONFIG = "AttachConfig.xml";
	private static String SYS_ATTACH_FTP_IP = null;
	private static int SYS_ATTACH_FTP_PORT = 21;
	private static String SYS_ATTACH_FTP_USERNAME = null;
	private static String SYS_ATTACH_FTP_PSW = null;
	private static String SYS_ATTACH_FTP_ROOT = null;
	private static String SYS_ATTACH_FORBID_TYPE = null;
	
	/**
	 * 初始化FTP参数
	 * @throws Exception
	 */
	public static void initial() throws Exception{
	
	    if (bInitial) {
	      return;
	    }
	    
	    bInitial = true;
	    
	    SAXBuilder builder = new SAXBuilder(false);
	    Document doc = null;
	    
	    try {
	      doc = builder.build(Thread.currentThread().getContextClassLoader().getResourceAsStream(ATTACH_CONFIG));
	    }
	    catch (Exception e) {
	    	bInitial = false;
	    	throw new Exception("没有找到文件上传的配置文件，请确认配置文件AttachConfig.xml是否在config根目录下！");
	    }
	    Element root = doc.getRootElement();

	    List childList = root.getChildren();
	    for (int i = 0; i < childList.size(); ++i) {
	    	Element childItem = (Element)childList.get(i);
	    	String name = childItem.getAttributeValue("name");
	    	String value = childItem.getTextTrim();

	    	if ("SYS_ATTACH_FTP_PORT".equals(name)) {
	    		if (value != null) {
	    			SYS_ATTACH_FTP_PORT = Integer.parseInt(value);
	    		}
	    	}
	    	else if ("SYS_ATTACH_FTP_ROOT".equals(name)){
	    		SYS_ATTACH_FTP_ROOT = value;
	    	}
	    	else if ("SYS_ATTACH_FTP_IP".equals(name)) {
	    		SYS_ATTACH_FTP_IP = value;
	    	}
	    	else if ("SYS_ATTACH_FORBID_TYPE".equals(name)) {
	    		SYS_ATTACH_FORBID_TYPE = value;
	    	}
	    	else if ("SYS_ATTACH_FTP_USERNAME".equals(name)) {
	    		SYS_ATTACH_FTP_USERNAME = value;
	    	} else {
	    		if ((!"SYS_ATTACH_FTP_PSW".equals(name)) || (value == null)){
	    			continue;
	    		}
	    		SYS_ATTACH_FTP_PSW = value;
	    	}

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

	public static String getSYS_ATTACH_FORBID_TYPE() {
		return SYS_ATTACH_FORBID_TYPE;
	}


}
