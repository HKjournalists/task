package com.asiainfo.csc.attach.dao.interfaces;

import java.util.Map;

import com.asiainfo.csc.attach.ivalues.IBOAttachTypeConfigValue;

public interface IAttachTypeConfigDao {

	public IBOAttachTypeConfigValue[] getAttachTypeConfig(String condtion,Map param)throws Exception;
}
