package com.lb.app.automation.service;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lb.app.automation.dao.IAutoPlatformExecuteConfigDao;
import com.lb.app.automation.model.AutoPlatformExecuteConfig;

@Service
public class AutoPlatformExecuteConfigService {
	final private static Log log = LogFactory.getLog(AutoPlatformExecuteConfigService.class);
	
	@Autowired
	IAutoPlatformExecuteConfigDao configDao;
	
	public void saveConfig(String batchid, String platformid){
		
		AutoPlatformExecuteConfig config = new AutoPlatformExecuteConfig();
		config.setBatchid(batchid);
		config.setRuleversion("1");
		config.setKeywordversion("1");
		config.setScriptversion("1");
		config.setTestcaseversion("1");
		config.setTestcaselevel("1");
		config.setExecmode("0");
		config.setLoglevel("1");
		config.setRunstatus("OK");
		config.setPlatformid(platformid);
		
		configDao.create(config);
	}

}
