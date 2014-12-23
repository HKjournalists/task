package com.asiainfo.aiga.service.interfaces;

import java.util.Map;

import com.asiainfo.aiga.ivalues.IBOAigaLinkTimeConfigValue;

public interface IAigaLinkTimeConfigSV {
	public IBOAigaLinkTimeConfigValue[] getLinkTimeConfigByLinkMark(String linkNo,String mark) throws Exception;
	public IBOAigaLinkTimeConfigValue[] getLinkTimeConfigByCondition(String condition,Map param) throws Exception;
	
}
