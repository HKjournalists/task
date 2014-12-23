package com.asiainfo.aiga.dao.interfaces;

import java.util.Map;

import com.asiainfo.aiga.ivalues.IBOAigaSpecialDayConfigValue;

public interface IAigaSpecialDayConfigDao {
	public IBOAigaSpecialDayConfigValue[] specialDayByCondition(String condition,Map param) throws Exception;

}
