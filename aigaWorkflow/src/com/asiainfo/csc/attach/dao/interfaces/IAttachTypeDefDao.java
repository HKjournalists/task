package com.asiainfo.csc.attach.dao.interfaces;

import java.util.Map;

import com.asiainfo.csc.attach.ivalues.IBOAttachTypeDefValue;

public interface IAttachTypeDefDao {

	public IBOAttachTypeDefValue[] getAttachTypeDef(String condition,Map param)throws Exception;
	
	public void saveAttachTypeDef(IBOAttachTypeDefValue aValue)throws Exception;
}
