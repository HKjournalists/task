package com.asiainfo.csc.attach.service.interfaces;

import java.util.Map;


public interface IAttachTypeConfigSV {

	public String getAttachTypeConfigHtml(String zone,String column) throws Exception;
	
	public Map<String, String> checkAttachTypeConfig(String zone,String xml,String hasSelectedTypeId)throws Exception;
}
